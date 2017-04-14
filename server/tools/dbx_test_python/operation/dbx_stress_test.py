# -*- coding:utf-8 -*-

from . import operation
from conn import client
from common import MessageStream
from dbx_interface import dbx_msg_define
from dbx_interface import dbx_build_msg

import threading
import time


@operation.resgisterOperation("stress_test")
def stress_test(*args):
	print("stress_test args:", args)

	host = "172.16.2.230"
	port = 3002

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
		else:
			print("garbage arg:", arg)

	print("connect info:", host, port)


class DBXClient:
	def __init__(self, p_host, p_port):
		self.currentQueryOrder = 0
		self.host = p_host
		self.port = p_port
		self.message = ""
		self.connector = client.Client()
		#self.connector.connect(self.host, int(self.port))
		self.callbacks = []

		self.passTime = 0
		self.sendStartTime = 0
		self.sendHZ = 1
		self.timeInterval = 0
		self.hz = 0

	def run(self, p_timeInterval = 0, p_hz = 1):
		self.timeInterval = p_timeInterval
		self.sendHZ = p_hz
		self.startTime = time.time()
		self.connector.connect(self.host, int(self.port))

		while True:
			self.send()
			self.recv()
			if self.check() == False:
				break

	def getQueryOrder(self):
		self.currentQueryOrder = (self.currentQueryOrder + 1) % 0x7FFFFFFF
		return self.currentQueryOrder

	def send(self):
		message = dbx_build_msg.default_sp_message("sp_Login", sort="usn,pwd,offTime", others={"usn": "xxt", "pwd": "1", "offTime": 1})
		message.m_nTempObjId = self.getQueryOrder()
		self.callbacks[message.m_nTempObjId] = time.time()
		print( "DBXClient send %i at time(%f)." % ( message.m_nTempObjId, time.time()) )
		self.connector.send(message.getIOBytes())

	def recv(self):
		self.connector.recvMessage(self.callback, 3)

	def check(self):
		if time.time() - self.startTime <= self.timeInterval:
			self.connector.disconnect()
			return False
		return True

	def callback(self, stream):
		reader = MessageStream.MessageStreamReader(stream)
		message = dbx_msg_define.CSCResultMsg()
		message.read(reader)
		t = self.callbacks.pop(message.m_nTempObjId)
		print( "DBXClient receive callback:%i cost time:%f." % (message.m_nTempObjId, time.time() - t))

	def parseMessage(self, message):
		pass