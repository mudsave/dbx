# -*- coding:utf-8 -*-

from . import operation
from conn import client

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
	def __init__( self, p_host, p_port ):
		self.host = p_host
		self.port = p_port
		self.connector = client.Client()
		self.connector.connect(self.host, int(self.port))

	def run(self):
		#self.connector.send(self.message.getIOBytes())
		#self.connector.recvMessage(lambda m: None, 3)
