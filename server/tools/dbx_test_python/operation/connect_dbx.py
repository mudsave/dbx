#-*- coding: utf-8 -*-

from . import operation
from . import connect_analyze
from conn import client
from common import MessageStream
from dbx_interface import dbx_msg_define
from dbx_interface import dbx_build_msg


def showMessage(message, file = None):
	"""打印消息的内容"""
	print("message msgLen %i" % message.msgLen)
	print("message msgSize %i" % message.size())
	print("message msgFlags %i" % message.msgFlags)
	print("message msgCls %i" % message.msgCls)
	print("message msgId %i" % message.msgId)
	print("message context %i" % message.context)
	print("message m_nTempObjId %i" % message.m_nTempObjId)
	print("message m_nSessionId %i" % message.m_nSessionId)
	print("message m_spId %i" % message.m_spId)
	print("message m_bEnd %i" % message.m_bEnd)
	print("message m_bNeedCallback %i" % message.m_bNeedCallback)
	print("message m_nLevel %i" % message.m_nLevel)
	print("message paramCount %i" % message.paramCount)
	print("message attribute_cols %i" % message.attribute_cols)
	print("message attribute_count %i" % message.attribute_count)
	print("message content_offset %i" % message.content_offset)
	print("message typeList %s" % message.typeList)
	#print("message dataList %s" % message.dataList)
	
	#f.writelines(message.dataList)
	print("message dataList [", end = '')
	for d in message.dataList:
		try:
			print(str(d)+", ", end = '')
		except:
			print("<??>, ", end = '')
		
		if file:
			file.write(str(d) + "\n")
	
	print("]")


@operation.resgisterOperation("connect_test")
def connect_test(*args):
	"""
	Usage: connect_test [-h 172.16.2.230] [-p 3010] 
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
	
	message = dbx_build_msg.default_sql_message("show tables")
	c = client.Client()
	c.connect(host, int(port))
	c.send(message.getIOBytes())
	c.recvMessage(on_connect_test_recv, 3)

def on_connect_test_recv(stream):
	print("--->>> on recv message", stream)
	reader = MessageStream.MessageStreamReader(stream)
	message = dbx_msg_define.CSCResultMsg()
	message.read(reader)
	
	f = open("connect_test_data.txt", "w", encoding="latin1")
	showMessage(message, f)

	
@operation.resgisterOperation("message_test")
def message_test(type, *args):
	"""
	Usage: 
		message_test sp spName database(default 1) sort(default "") others(default {})
	or:
		message_test sql sqlString database(default 1) cmdID(default 0) queueIndex(default 0) level(default 20)
	"""
	if type == "sp":
		message = dbx_build_msg.default_sp_message(*(eval(i) for i in args))
	elif type == "sql":
		message = dbx_build_msg.default_sql_message(*(eval(i) for i in args))
	elif type == "esp":
		message = dbx_build_msg.call_sp_message({}, False, 20)
		message.m_spId = 0
		message.msgId = dbx_msg_define.MSG_ID.C_DO_SQL
		message.context = dbx_msg_define.MSG_TYPE.CCSRESMSG
	else:
		message = dbx_build_msg.call_sql_message({})
		message.m_spId = 0
		message.msgId = dbx_msg_define.MSG_ID.C_DO_ACTION
		message.context = dbx_msg_define.MSG_TYPE.CCSRESMSG
	
	#message.addAttr("testKey1")
	#message.addValue(dbx_msg_define.DATA_TYPE.FLOAT, 1.0)
	
	#message.addAttr("testKey2")
	#message.addValue(dbx_msg_define.DATA_TYPE.INT, 2)
	
	reader = MessageStream.MessageStreamReader(message.getIOBytes())
	newMessage = dbx_msg_define.CCSResultMsg()
	newMessage.read(reader)
	
	print("message.getParamSize() = %i" % message.getParamSize())
	showMessage(message)
	
	assert message.size() == newMessage.size()
	
	assert message.m_nTempObjId == newMessage.m_nTempObjId
	assert message.m_nSessionId == newMessage.m_nSessionId
	assert message.m_spId == newMessage.m_spId
	assert message.m_bEnd == newMessage.m_bEnd
	assert message.m_bNeedCallback == newMessage.m_bNeedCallback
	assert message.m_nLevel == newMessage.m_nLevel
	assert message.msgLen == newMessage.msgLen
	assert message.msgFlags == newMessage.msgFlags
	assert message.msgCls == newMessage.msgCls
	assert message.msgId == newMessage.msgId
	assert message.context == newMessage.context
	
	assert message.attribute_cols == newMessage.attribute_cols
	assert message.attribute_count == newMessage.attribute_count
	assert message.paramCount == newMessage.paramCount
	assert message.typeList == newMessage.typeList
	assert message.dataList == newMessage.dataList
	
	#assert newMessage.getAttibuteByName("testKey1", 0) != None
	#assert newMessage.getAttibuteByName("testKey2", 0) != None
	
	print("Test OK!")
	

@operation.resgisterOperation("exec_sql")
def exec_sql(*args):
	"""
	Usage: exec_sql [-h 172.16.2.230] [-p 3010] [-m](if show message) sql_format arg1 arg2 arg3 ...
	"""
	host = "172.16.2.230"
	port = 3010
	showMsg = False
	
	sql_args = []
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
		elif arg == "-m":
			showMsg = True
		else:
			sql_args.append(arg)
	
	print("sql_args =", sql_args)
	sql = sql_args[0] % tuple(eval(i) for i in sql_args[1:])
	print("sql =", sql)
	message = dbx_build_msg.default_sql_message(sql)
	
	if showMsg:
		showMessage(message)
	
	c = client.Client()
	c.connect(host, port)
	c.send(message.getIOBytes())
	c.recvMessage(on_exec_sql_recv, 3)


def on_exec_sql_recv(stream):
	on_connect_test_recv(stream)


@operation.resgisterOperation("exec_sp")
def exec_sp(*args):
	"""
	Usage: exec_sp [-h 172.16.2.230] [-p 3010] [-m](if show message) sp_name param1=value1 param2=value2 ...
			注意：param1=value1中间不要加空格，如果一定要空格，需要用双引号括起来。
	"""
	host = "172.16.2.230"
	port = 3010
	showMsg = False
	
	sp_args = []
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
		elif arg == "-m":
			showMsg = True
		else:
			sp_args.append(arg)
	
	print("sp_args =", sp_args)
	sp_name = sp_args[0]
	sort = ""
	database = 1
	
	params = {}
	for arg in sp_args[1:]:
		pair = tuple(i.strip() for i in arg.split("="))
		if len(pair) != 2:
			assert False, "Invalid argument %s" % arg
		elif pair[0] == "sort":
			sort = pair[1]
		elif pair[0] == "dataBase":
			database = pair[1]
		else:
			params[pair[0]] = eval(pair[1])
	
	print("params =", params)
	message = dbx_build_msg.default_sp_message(sp_name, database, sort, params)
	
	showMessage(message)
	
	c = client.Client()
	c.connect(host, port)
	print("message m_bNeedCallback %i" % message.m_bNeedCallback)
	c.send(message.getIOBytes())
	c.recvMessage(on_exec_sp_recv, 3)


def on_exec_sp_recv(stream):
	on_connect_test_recv(stream)


@operation.resgisterOperation("parallel_connect[or:pc]")
def parallel_connect_test(*args):
	"""
	并发连接测试
	Usage: parallel_connect [-h 172.16.2.230] [-p 3010] [-n 50]
			-n 表示并发连接的数量。
	"""
	host = "172.16.2.230"
	port = 3010
	count = 50
	
	cmd_args = []
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
		elif arg == "-n":
			count = int(args[index + 1])
			skip_next = True
		else:
			cmd_args.append(arg)
	
	print("cmd_args =", cmd_args)
	analyst = connect_analyze.g_AnalystSet.forceNew("parallel_connect_analyze")
	analyst.parallel_connect_analyze(host, port, count)
	

@operation.resgisterOperation("parallel_connect_monitor[or:pcm]")
def parallel_connect_monitor(*args):
	"""
	并发连接，并持续监控连接中断情况
	Usage: parallel_connect_monitor [-h 172.16.2.230] [-p 3010] [-n 50] [-d 0]
			-n 表示并发连接的数量;
			-d 表示监控持续时间（秒），小于等于0表示监控不会超时停止。
	"""
	host = "172.16.2.230"
	port = 3010
	count = 50
	duration = 0
	
	cmd_args = []
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
		elif arg == "-n":
			count = int(args[index + 1])
			skip_next = True
		elif arg == "-d":
			duration = int(args[index + 1])
			skip_next = True
		else:
			cmd_args.append(arg)
	
	print("cmd_args =", cmd_args)
	analyst = connect_analyze.g_AnalystSet.forceNew("parallel_connect_monitor")
	analyst.parallel_connect_monitor(host, port, count, duration)
	
	
@operation.resgisterOperation("parallel_io[or:pio]")
def parallel_io_test(*args):
	"""
	并发连接测试
	Usage: parallel_io [-h 172.16.2.230] [-p 3010] [-n 50]
			-n 表示并发连接的数量。
	"""
	host = "172.16.2.230"
	port = 3010
	count = 50
	
	cmd_args = []
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
		elif arg == "-n":
			count = int(args[index + 1])
			skip_next = True
		else:
			cmd_args.append(arg)
	
	print("cmd_args =", cmd_args)
	analyst = connect_analyze.g_AnalystSet.forceNew("parallel_io_analyze")
	analyst.parallel_io_analyze(host, port, count, connect_analyze.active_message)
	
	
	