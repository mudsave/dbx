#-*- coding: utf-8 -*-
#
import time
import select
import threading
from conn import client
from common import ThreadTool
from dbx_interface import dbx_build_msg

# 定义一个心跳消息
active_message = dbx_build_msg.default_sp_message("XX")
active_message.m_bNeedCallback = False
active_message_bytes = active_message.getIOBytes()

class Analyst:
	
	def __init__(self):
		self.clients = {}
	
	def parallel_connect(self, ip, port, total):
		end_event = threading.Event()
		
		def _connect(end_event, ip, port, total):
			failure = 0
			count = total
			while count > 0:
				count -= 1
				c = client.Client()
				try:
					c.connect(ip, port)
					self.clients[c.fileno()] = c
				except Exception as e:
					print("Connect fail: ", e)
					failure += 1
			
			print("Parallel connect to %s %s:" % (ip, port))
			print("Total %i, failure %i" % (total, failure))
			end_event.set()
		
		connect_thread = threading.Thread(target=_connect, args = (end_event, ip, port, total))
		#connect_thread.setDaemon(True)
		connect_thread.setName("Connect thread")
		connect_thread.start()
		
		#主动退出监测
		def _input_to_stop(end_event):
			while 1:
				cmd = input("Input q to stop: ")
				if cmd.lower() == "q":
					break
			print("Require to stop.")
			end_event.set()
		
		input_thread = threading.Thread(target=_input_to_stop, args = (end_event,))
		#input_thread.setDaemon(True)
		input_thread.setName("Input thread")
		input_thread.start()
		
		end_event.wait()
		
		#终止两个线程
		try:
			ThreadTool.stop_thread(connect_thread)
		except ValueError:
			pass
		
		try:
			ThreadTool.stop_thread(input_thread)
		except ValueError:
			pass
		
		print("Connect end.")
	
	def parallel_connect_analyze(self, ip, port, total):
		self.parallel_connect(ip, port, total)
		self.clean()
	
	def parallel_connect_monitor(self, ip, port, total, duration):
		self.parallel_connect(ip, port, total)
		monitor_stop = threading.Event()
		
		#连接监测（将在子线程中执行）
		def _connect_monitor(monitor_stop, duration):
			print("Connect monitor begin...")
			start = time.time()
			remain = len(self.clients)
			
			while remain:
				rl = [c.fileno() for c in self.clients.values()]
				rlist, wlist, xlist = select.select(rl, [], [], 0)
				if rlist:
					closed = []
					for fileno in rlist:
						c = self.clients.get(fileno)
						try:
							c.socket().recv(1024)
						except:
							closed.append(fileno)
				
					for fileno in closed:
						del self.clients[fileno]
				
				prev_remain = remain
				remain = len(self.clients)
				if remain != prev_remain:
					close = prev_remain - remain
					print("%s client%s closed, remain %i" %\
						(close, "s" if close > 1 else "", remain))
				
				if duration > 0 and time.time() - start > duration:
					print("Duration end.")
					break
				
				time.sleep(1.0)
				
			print("Connect monitor end.")
			monitor_stop.set()
		
		monitor_thread = threading.Thread(target=_connect_monitor, args = (monitor_stop, duration))
		#monitor_thread.setDaemon(True)
		monitor_thread.setName("Monitor thread")
		monitor_thread.start()
		
		#主动退出监测
		def _input_to_stop(monitor_stop):
			while 1:
				cmd = input("Input q to stop: ")
				if cmd.lower() == "q":
					break
			print("Require to stop.")
			monitor_stop.set()
		
		input_thread = threading.Thread(target=_input_to_stop, args = (monitor_stop,))
		#input_thread.setDaemon(True)
		input_thread.setName("Input thread")
		input_thread.start()
		
		monitor_stop.wait()
		
		#终止两个线程
		try:
			ThreadTool.stop_thread(monitor_thread)
		except ValueError:
			pass
		
		try:
			ThreadTool.stop_thread(input_thread)
		except ValueError:
			pass
		
		print("Monitor over.")
		self.clean()
	
	def parallel_io_analyze(self, ip, port, total, message):
		self.parallel_connect(ip, port, total)
		io_stop = threading.Event()
		
		#连接监测（将在子线程中执行）
		def _io_loop(io_stop, message):
			print("IO loop begin...")
			remain = len(self.clients)
			message_bytes = message.getIOBytes()
			counter = 0
			
			while remain:
				wl = rl = [c.fileno() for c in self.clients.values()]
				rlist, wlist, xlist = select.select(rl, wl, [], 0)
				if rlist:
					closed = []
					for fileno in rlist:
						c = self.clients.get(fileno)
						try:
							c.socket().recv(1024)
						except:
							closed.append(fileno)
				
					for fileno in closed:
						del self.clients[fileno]
				
				prev_remain = remain
				remain = len(self.clients)
				if remain != prev_remain:
					close = prev_remain - remain
					print("%s client%s closed, remain %i" %\
						(close, "s" if close > 1 else "", remain))
				
				send_client = 0
				if wlist:
					for fileno in wlist:
						c = self.clients.get(fileno)
						if c is not None:
							send_client += 1
							c.send(message_bytes)
				
				counter += 1
				print("The %i send." % counter, "\nSend client count:", send_client, 
					"\nSend bytes:", send_client * message.size())
				
				time.sleep(1.0)
				
			print("IO loop end.")
			io_stop.set()
		
		io_thread = threading.Thread(target=_io_loop, args = (io_stop, message))
		#io_thread.setDaemon(True)
		io_thread.setName("IO thread")
		io_thread.start()
		
		#主动退出监测
		def _input_to_stop(io_stop):
			while 1:
				cmd = input("Input q to stop: ")
				if cmd.lower() == "q":
					break
			print("Require to stop.")
			io_stop.set()
		
		input_thread = threading.Thread(target=_input_to_stop, args = (io_stop,))
		#input_thread.setDaemon(True)
		input_thread.setName("Input thread")
		input_thread.start()
		
		io_stop.wait()
		
		#终止两个线程
		try:
			ThreadTool.stop_thread(io_thread)
		except ValueError:
			pass
		
		try:
			ThreadTool.stop_thread(input_thread)
		except ValueError:
			pass
		
		print("IO analyze over.")
		self.clean()
	
	def clean(self):
		if len(self.clients) == 0:
			return
		for c in self.clients.values():
			c.disconnect()
		self.clients.clear()
	

class AnalystSet:
	
	_instance = None
	
	def __init__(self):
		assert AnalystSet._instance is None
		self._analysts = {}
	
	@staticmethod
	def Instance():
		if AnalystSet._instance is None:
			AnalystSet._instance = AnalystSet()
		return AnalystSet._instance
	
	def new(self, id):
		if id in self._analysts:
			return None
		analyst = Analyst()
		self._analysts[id] = analyst
		return analyst
	
	def forceNew(self, id):
		if id in self._analysts:
			self._analysts.clean()
		analyst = Analyst()
		self._analysts[id] = analyst
		return analyst
	
	def get(self, id):
		return self._analysts.get(id)
	
	def add(self, id, analyst):
		assert id not in self._analysts
		self._analysts[id] = analyst
	
	def remove(self, id):
		if id in self._analysts:
			self._analysts[id].clean()
			del self._analysts[id]
	
	def clear(self):
		for analyst in self._analysts.values():
			analyst.clean()
		self._analysts.clear()
	

g_AnalystSet = AnalystSet.Instance()
