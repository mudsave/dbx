#-*- coding:utf-8 -*-
#
import time
import threading

from . import operation
from . import connect_dbx
from conn import client
from common import XDebug
from dbx_interface import dbx_msg_define
from dbx_interface import dbx_build_msg


class Test:
	def __init__(self, name, host, port, message, expectSuccess = True):
		self.name = name
		self.host = host
		self.port = port
		self.message = message
		self.expectSuccess = expectSuccess
		self.connector = client.Client()

	def test(self):
		self.connector.connect(self.host, int(self.port))
		self.connector.send(self.message.getIOBytes())
		self.connector.recvMessage(lambda m: None, 3)
	
	def success(self):
		if self.message.m_bNeedCallback:
			if self.connector.status() != client.STATUS_FINISH or len(self.connector.message()) == 0:
				return False
		else:
			if self.connector.status() != client.STATUS_RECVING:
				return False
		
		return True


class Tester:
	def __init__(self):
		self.tests = []
		self.remain = 0
		self.success = 0
		self.error = 0
		self.mutex = threading.Lock()
	
	def addTest(self, test):
		self.tests.append(test)
	
	def startTest(self):
		self.remain = len(self.tests)
		self.success = 0
		self.error = 0
		
		for test in self.tests:
			t = threading.Thread(target = self.runTest, args = (test,))
			t.start()
		
		# 等待所有测试完成
		while self.remain > 0:
			time.sleep(0.1)
		
		if self.error == 0:
			print("Test OK! Total %i" % len(self.tests))
		else:
			print("Test complete. total %i, success %i, error %i" %\
				(len(self.tests), self.success, self.error))
		
	def runTest(self, test):
		try:
			test.test()
		except:
			XDebug.EXCEHOOK_MSG("Run test %s error:" % test.name)
		
		self.mutex.acquire()
		if test.success() and test.expectSuccess:
			self.success += 1
		elif not test.success() and not test.expectSuccess:
			self.success += 1
		else:
			print("Test %s fail!" % test.name)
			self.error += 1
		self.remain -= 1
		self.mutex.release()
		

def makeTests(host, port):
	tester = Tester()
	tester.addTest(Test("sql:show_tables", host, port, dbx_build_msg.default_sql_message("show tables")))
	tester.addTest(Test("sql:select_1", host, port, dbx_build_msg.default_sql_message("select 1")))
	tester.addTest(Test("sql:select_account", host, port, dbx_build_msg.default_sql_message("select * from account limit 20")))
	tester.addTest(Test("sql:call sp_LoadAll", host, port, dbx_build_msg.default_sql_message("call sp_LoadAll(5)")))
	tester.addTest(Test("sp:sp_Login", host, port, dbx_build_msg.default_sp_message(
		"sp_Login", sort="usn,pwd,offTime", others={"usn": "xxt", "pwd": "1", "offTime": 1})))
	tester.addTest(Test("sp:sp_UpdatePlayer", host, port, dbx_build_msg.default_sp_message(
		"sp_UpdatePlayer", sort="name,nvalue,cvalue,fvalue,rId", others={"name": "Money", "nvalue": 0, "cvalue": "xx", "fvalue": 0, "rId": 5})))
	tester.addTest(Test("sp:sp_LoadAll", host, port, dbx_build_msg.default_sp_message(
		"sp_LoadAll", sort="rId", others={"rId": 5})))
	tester.addTest(Test("sp:sp_ItemRemove", host, port, dbx_build_msg.default_sp_message(
		"sp_ItemRemove", sort="_RoleID,_RemoveFlag", others={"_RoleID": 5, "_RemoveFlag": 1})))
	tester.addTest(Test("sp:sp_ItemRemove expect error", host, port, dbx_build_msg.default_sp_message(
		"sp_ItemRemove", sort="_RoleID,_RemoveFlag", others={"_RoleID": 5}), False))
	return tester


@operation.resgisterOperation("test_all")
def test_all(*args):
	"""
	Usage: test_all [-h 172.16.2.230] [-p 3010] 
	"""
	host = "172.16.2.230"
	port = 3010
	
	connect_args = []
	index = -1
	skip_next = False
	for arg in args:
		index += 1
		if skip_next:
			skip_next = False
			continue
		
		if arg == "-h":
			host = args[index + 1]
			skip_next = True
		elif arg == "-p":
			port = int(args[index + 1])
			skip_next = True
		else:
			connect_args.append(arg)
	
	print("connect_args =", connect_args)
	
	tester = makeTests(host, port)
	
	prev = XDebug.PRINT_DEBUG
	XDebug.PRINT_DEBUG = 0
	tester.startTest()
	XDebug.PRINT_DEBUG = prev
	
