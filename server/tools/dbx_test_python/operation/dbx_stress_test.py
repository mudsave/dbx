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
			startTime = time.time()
			self.send()
			self.recv()
			if self.check() == False:
				break
			print("%s run---------------------------------------passtime(%f)." % (os.getpid(), time.time() - startTime))

	def getQueryNum(self):
		self.currentQueryOrder = (self.currentQueryOrder + 1) % 0x7FFFFFFF
		return self.currentQueryOrder

	def send(self):
		for i in range(self.sendHZ):
			for message in offlineSPMessages():
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

def offlineSPMessages():
	"""
	做任务获得物品装备武器学习技能加点，然后下线
	call sp_UpdatePlayerAttrBatch(5128, '11,0,12,18,14,12,43,1028,44,361,118,201,119,3480,147,3', 8);
	call sp_UpdatePlayerBatch(5128, 8, 94, 177, 7, 8, 100000, 19112, 0, 0, 0, '{1,1}', 3, 6);
	call sp_DeleteTreasure(5128);
	call sp_EquipSave(5128, 5, '2001091-1-1-3-1-3-0-5000-nil-{{60, 10}, {46, 69}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-2001092-1-1-3-1-4-0-5000-nil-{{63, 10}, {49, 69}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-2001093-1-1-3-1-5-0-5000-nil-{{60, 9}, {63, 9}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-2001094-1-1-3-1-6-0-5000-nil-{{60, 7}, {46, 103}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-2001090-1-1-3-1-7-0-5000-nil-{{52, 17}}-{{17, 1, 0}, {18, 1, 0}, {20, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-');
	call sp_ItemSaveEx(5128, 4, '3011001-20-1-1-1-7-0-0-0-nil-3012001-20-1-1-1-8-0-0-0-nil-3025001-5-1-1-1-9-0-0-0-nil-1026021-1-10-1-1-10-0-0-0-nil-');
	call sp_EquipSave(5128, 1, '2001095-1-1-3-1-8-0-5000-nil-{{80, 3}, {63, 7}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-');
	call sp_DeleteItem(5128, 1, '0-');
	call sp_SaveNewRewards(5128, 0, 0);
	call sp_UpdateRoleAttrSetting(5128, 1, 3, 0, 2, 0, 0, 1, 0, 0, 0, 0);
	call sp_UpdateNormalTask(5128, 1028, 1, '{9}', 0);
	call sp_UpdatePlayer('AutoHideChatWin', 0, '', 0, 5128);
	call sp_Login('wsf1', '1', 5);
	call sp_UpdatePlayer('LastWeekFactionContribute', 0, '', 0, 5128);
	call sp_UpdatePlayer('OfflineDate', 0, '2017-04-19 17:01:25', 0, 5128);
	"""
	msgs = []
	msgs.append(dbx_build_msg.default_sp_message("sp_UpdatePlayerAttrBatch", sort="roleId,buff,num", 
		others={"roleId": 5128, "buff": '11,0,12,18,14,12,43,1028,44,361,118,201,119,3480,147,3', "num": 8})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_UpdatePlayerBatch", sort="rId,MapID,PosX,PosY,Level,ModelID,Money,SMoney,DMoney,DCap,Cash,Parts,Cap,Bar", 
		others={"rId": 5128, "MapID": 8, "PosX": 94, "PosY":177, "Level":7, "ModelID":8, "Money":100000, "SMoney":19112, "DMoney":0, "DCap":0, "Cash":0, "Parts":'{1,1}', "Cap":3, "Bar":6})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_DeleteTreasure", sort="_RoleID", 
		others={"_RoleID": 5128})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_EquipSave", sort="_RoleID,_EquipsNum,_EquipsBuffer", 
		others={"_RoleID": 5128, "_EquipsNum":5,"_EquipsBuffer":'2001091-1-1-3-1-3-0-5000-nil-{{60, 10}, {46, 69}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-2001092-1-1-3-1-4-0-5000-nil-{{63, 10}, {49, 69}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-2001093-1-1-3-1-5-0-5000-nil-{{60, 9}, {63, 9}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-2001094-1-1-3-1-6-0-5000-nil-{{60, 7}, {46, 103}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-2001090-1-1-3-1-7-0-5000-nil-{{52, 17}}-{{17, 1, 0}, {18, 1, 0}, {20, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-'})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_ItemSaveEx", sort="_RoleID,_ItemsNum,_ItemsBuffer", 
		others={"_RoleID": 5128, "_ItemsNum":4,"_ItemsBuffer":'3011001-20-1-1-1-7-0-0-0-nil-3012001-20-1-1-1-8-0-0-0-nil-3025001-5-1-1-1-9-0-0-0-nil-1026021-1-10-1-1-10-0-0-0-nil-'})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_EquipSave", sort="_RoleID,_EquipsNum,_EquipsBuffer", 
		others={"_RoleID": 5128, "_EquipsNum":1,"_EquipsBuffer":'2001095-1-1-3-1-8-0-5000-nil-{{80, 3}, {63, 7}}-{{17, 1, 0}, {18, 1, 0}, {19, 1, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0}}-{{46, 50}, {49, 50}}-nil-1-'})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_DeleteItem", sort="_RoleID,_ItemsNum,_ItemsBuffer", 
		others={"_RoleID": 5128, "_ItemsNum":1,"_ItemsBuffer":'0-'})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_SaveNewRewards", sort="_RoleID,_Times,_BetweenTime", 
		others={"_RoleID": 5128, "_Times":0,"_BetweenTime":0})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_UpdateRoleAttrSetting", sort="rid,autoattr,str,int,sta,spi,dex,plan,autophase,phaseOne,phaseTwo,phaseThree", 
		others={"rid": 5128, "autoattr": 1,"str": 3,"int": 0,"sta": 2,"spi": 0,"dex": 0,"plan": 1,"autophase": 0,"phaseOne": 0,"phaseTwo": 0,"phaseThree": 0})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_UpdateNormalTask", sort="_RoleID,_TaskID,_State,_TargetState,_EndTime", 
		others={"_RoleID": 5128, "_TaskID":1028,"_State":1,"_TargetState":'{9}',"_EndTime":0})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_UpdatePlayer", sort="name,nvalue,cvalue,fvalue,rId", 
		others={"name": 'AutoHideChatWin', "nvalue":0,"cvalue":'',"fvalue":'0',"rId":5128})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_Login", sort="usn,pwd,offTime", 
		others={"usn": "xxt", "pwd": "1", "offTime": 1})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_UpdatePlayer", sort="name,nvalue,cvalue,fvalue,rId", 
		others={"name": 'LastWeekFactionContribute', "nvalue":0,"cvalue":'',"fvalue":'0',"rId":5128})
	)
	msgs.append(dbx_build_msg.default_sp_message("sp_UpdatePlayer", sort="name,nvalue,cvalue,fvalue,rId", 
		others={"name": 'OfflineDate', "nvalue":0,"cvalue":'2017-04-19 17:01:25',"fvalue":'0',"rId":5128})
	)

	return msgs

def loginSPMessages():
	msgs = []
	message = dbx_build_msg.default_sp_message("sp_Login", sort="usn,pwd,offTime", others={"usn": "xxt", "pwd": "1", "offTime": 1})
	msgs.append(message)
	return msgs

	""" wsf1账号第一个角色登陆调用的sp
	call sp_Login('wsf1', '1', 5);
	call sp_LoadAll(5128);
	call sp_UpdatePlayer('IntradayFactionContribute', 0, '', 0, 5128);
	call sp_LoadRoleFriends(5128);
	call sp_LoadRoleGroups(5128);
	call sp_LoadRoleFactionInfos(5128);
	call sp_LoadMind(5128);
	call sp_GetFriendChatOfflineMsg(5128);
	"""