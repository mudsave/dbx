#-*- coding: utf-8 -*-

import time
import socket, select
from common import BytesIO

class Client:
	
	def __init__(self):
		self._serverAddr = ""
		self._connectPort = 0
		self._socket = None
		
		self._request = ""
		self._recvbuffer = b""
		self._sendbuffer = b""
		
	def connect(self, ip, port):
		if self.connected():
			print("Client has connected!")
		else:			
			self._serverAddr = ip
			self._connectPort = port
			print("Client connecting to %s on port %s ..." % (ip, port))
			
			self._socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
			#self._socket.setblocking( True )
			#self._socket.settimeout( 1.0 )
			self._socket.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 5 * 1024 * 1024)
			self._socket.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 5 * 1024 * 1024)
			self._socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
			self._socket.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, True)
			self._socket.connect( (ip, port) )
	
	def disconnect(self):
		if self.connected():
			self._socket.close()
			self._socket = None
	
	def connected(self):
		return self._socket is not None
	
	def message(self):
		return self._recvbuffer
	
	def socket(self):
		return self._socket
	
	def fileno(self):
		return self._socket.fileno()
		
	def send(self, message):
		if self.connected():
			self._request = message
			self._sendbuffer = BytesIO.ensureBytes(message)
			self._socket.sendall(BytesIO.ensureBytes(message))
	
	def parseMessage(self, bytes):
		self._recvbuffer += bytes
		return bytes
		
	def recvMessage(self, callbackFunc, timeout = 3.0):
		print("Client %s receiving message ..." % self._socket.fileno())
		
		self._recvbuffer = b""
		rl = [self._socket.fileno()]
		
		start = time.time()
		
		while True:
			rlist, wlist, xlist = select.select(rl, [], [], 1.0)
			if rlist:
				print("Client %s begin receive." % rlist)
				msg = self._socket.recv( 4096 )
				if len( msg ) == 0:
					print( "Receive 0 bytes, over! fileno '%s'" % self._socket.fileno() )
					return
			
				ms = self.parseMessage( msg )
				if ms:
					callbackFunc( ms )
				
				start = time.time()
				continue
			
			if timeout > 0 and time.time() - start  > timeout:
				print("Time out")
				break
	
	