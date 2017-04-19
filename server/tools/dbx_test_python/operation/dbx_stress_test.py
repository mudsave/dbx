# -*- coding:utf-8 -*-

from . import operation
from .import connect_dbx

from conn import client
from common import MessageStream
from dbx_interface import dbx_msg_define
from dbx_interface import dbx_build_msg

import multiprocessing
from multiprocessing import Process
from multiprocessing import Pool
import threading
import time
import os


@operation.resgisterOperation("stress_test")
def stress_test(*args):
	"""
	use case: python main.py stress_test [-h 172.16.2.230] [-p 3002] [-t 10] [-z 10]
	"""
	print("stress_test args:", args)

	host = "172.16.2.230"
	port = 3002
	interval = 0
	hz = 10

	skip_next = False
	index = -1
	for arg in args:
		index += 1

		if skip_next:
			skip_next = False
			continue

		if arg == "-h":
			host = args[index+1]
			skip_next = True
		elif arg == "-p":
			port = args[index+1]
			skip_next = True
		elif arg == "-t":
			interval = int(args[index+1])
			skip_next = True
		elif arg == "-z":
			hz = int(args[index+1])
			skip_next = True
		else:
			print("stress_test command::garbage arg:", arg)

	print("connect info:", host, port)

	pool = Pool()
	for i in range(multiprocessing.cpu_count()):
		c = DBXClient(host, port)
		pool.apply_async(c.run, args=(interval, hz))
	print('Waiting for all subprocesses done...')

	while True:
		cmd = input("Input q to stop: ")
		if cmd.lower() == "q":
			break
	t = 1
	print("stress_test close after %s seconds." % t )
	time.sleep(t)
	pool.close()
	pool.terminate()
	print("child processing end...")

class DBXClient:
	def __init__(self, p_host, p_port):
		self.currentQueryOrder = 0
		self.host = p_host
		self.port = p_port
		self.connector = client.Client()
		#self.connector.connect(self.host, int(self.port))
		self.callbacks = {}
		self.sendHZ = 1					# 频率（select会阻塞1s），一次发送多少个查询请求
		self.timeInterval = 0
		self.startTime = 0
		self.isDestroyed = False

	def setDestroyed(self):
		print("%s setDestroyed..." % os.getpid())
		self.isDestroyed = True

	def run(self, p_timeInterval = 0, p_hz = 1):
		print("%s start..." % os.getpid())
		self.timeInterval = p_timeInterval
		self.sendHZ = p_hz
		self.startTime = time.time()
		self.connector.connect(self.host, int(self.port))
		while self.isDestroyed != True:
			self.send()
			self.recv()
			if self.check() == False:
				break

	def getQueryNum(self):
		self.currentQueryOrder = (self.currentQueryOrder + 1) % 0x7FFFFFFF
		return self.currentQueryOrder

	def send(self):
		for i in range(self.sendHZ):
			message = dbx_build_msg.default_sp_message("sp_Login", sort="usn,pwd,offTime", others={"usn": "xxt", "pwd": "1", "offTime": 1})
			message.m_nTempObjId = self.getQueryNum()
			self.callbacks[message.m_nTempObjId] = QueryResult(time.time(), message.m_nTempObjId)
			#print( "DBXClient send %i." % ( message.m_nTempObjId ) )
			self.connector.send(message.getIOBytes())

	def recv(self):
		self.connector.recvMessage(self.onRecv, 0.1)

	def check(self):
		if self.timeInterval > 0 and time.time() - self.startTime > self.timeInterval:
			self.close()
			return False
		return True

	def reset(self):
		pass

	def close(self):
		print("%s close..." % os.getpid())
		self.connector.disconnect()
		self.reset()

	def onRecv(self, stream):
		reader = MessageStream.MessageStreamReader(stream)
		message = dbx_msg_define.CSCResultMsg()
		message.read(reader)
		try:
			self.callbacks[message.m_nTempObjId].addResult(message)
			if message.m_bEnd == True:
				self.parseMessage(message.m_nTempObjId)
		except IndexError as e:
			print("Error:cant find queryID:%i." % message.m_nTempObjId)

	def parseMessage(self, m_nTempObjId):
		result = self.callbacks.pop(m_nTempObjId)
		#for msg in result.GetResults():
		#	connect_dbx.showMessage(msg)
		result.done()

class QueryResult:
	def __init__(self, p_queryTime, p_queryID):
		self.queryTime = p_queryTime
		self.queryID = p_queryID
		self.results = []

	def addResult(self, p_message):
		self.results.append(p_message)

	def GetResults(self):
		return self.results

	def done(self):
		print( "QueryResult::done:DBXClient receive callback:query(%i) cost time:%f." % (self.queryID, time.time() - self.queryTime))
