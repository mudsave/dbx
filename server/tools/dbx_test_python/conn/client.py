#-*- coding: utf-8 -*-

import time
import struct
import socket, select
from common import BytesIO, XDebug

STATUS_PENDING = 0
STATUS_SENDING = 1
STATUS_RECVING = 2
STATUS_PARSING = 3
STATUS_FINISH	= 4

class Client:
	
	def __init__(self):
		self._status = STATUS_PENDING
		
		self._serverAddr = ""
		self._connectPort = 0
		self._socket = None
		
		self._request = ""
		self._recvbuffer = b""
		self._sendbuffer = b""
		
		self._currentLen = 0
		self._currentBuff = b""
		
	def connect(self, ip, port):
		if self.connected():
			XDebug.DEBUG_MSG("Client has connected!")
		else:			
			self._serverAddr = ip
			self._connectPort = port
			XDebug.DEBUG_MSG("Client connecting to %s on port %s ..." % (ip, port))
			
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
	
	def status(self):
		return self._status
	
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
			self._status = STATUS_SENDING
			self._request = message
			self._sendbuffer = BytesIO.ensureBytes(message)
			self._socket.sendall(BytesIO.ensureBytes(message))
	
	def parseMessage(self, bytes):
		self._recvbuffer += bytes
		
		msgReady = []
		self._currentBuff += bytes
		
		lenSize = struct.calcsize("=H")
		
		while len(self._currentBuff) > lenSize:
			if self._currentLen == 0:
				self._currentLen = struct.unpack("=H", self._currentBuff[:lenSize])[0]
				if self._currentLen <= 0:
					XDebug.DEBUG_MSG("Invalid message length: ", self._currentLen)
					return []
			
			if len(self._currentBuff) >= self._currentLen:
				msgReady.append(self._currentBuff[:self._currentLen])
				self._currentBuff = self._currentBuff[self._currentLen:]
				self._currentLen = 0
			else:
				break
		
		return msgReady
		
	def recvMessage(self, callbackFunc, timeout = 3.0, blockTime = 2.0):
		XDebug.DEBUG_MSG("Client %s receiving message ..." % self._socket.fileno())
		
		self._recvbuffer = b""
		rl = [self._socket.fileno()]
		
		start = time.time()
		
		self._status = STATUS_RECVING
		while True:
			rlist, wlist, xlist = select.select(rl, [], [], blockTime)
			print("rlist, wlist, xlist", rlist, wlist, xlist)
			if rlist:
				XDebug.DEBUG_MSG("Client %s begin receive." % rlist)
				msg = self._socket.recv( 4096 )
				if len( msg ) == 0:
					XDebug.DEBUG_MSG( "Receive 0 bytes, over! fileno '%s'" % self._socket.fileno() )
					return
			
				ms = self.parseMessage( msg )
				#print("for m in ms:len(ms)", len(ms))
				for m in ms:
					callbackFunc( m )
				
				start = time.time()
				continue
			
			if timeout > 0 and time.time() - start  > timeout:
				XDebug.DEBUG_MSG("Time out, un-ready buff(%i bytes, need %i):%s" % (len(self._currentBuff), self._currentLen, self._currentBuff))
				if len(self._currentBuff) == 0:
					self._status = STATUS_FINISH
				else:
					self._status = STATUS_PARSING
				break
	
	