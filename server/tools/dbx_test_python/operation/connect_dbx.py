#-*- coding: utf-8 -*-

from . import operation
from conn import client
from common import MessageStream
from dbx_interface import dbx_msg_define
from dbx_interface import dbx_build_msg

@operation.resgisterOperation("connect_test")
def connect_test(ip = "127.0.0.1", port = 3000):
	"""
	Usage: connect_test ip(default 127.0.0.1) port(default 3000)
	"""
	c = client.Client()
	c.connect(ip, port)
	
	message = dbx_build_msg.default_sql_message("show tables")
	
	print("Size of message %i" % message.size())
	print("Size of ObjDoMsg %i" % message.m_objDoMsg.size())
	
	print("message msgLen %i" % message.msgLen)
	print("message msgFlags %i" % message.msgFlags)
	print("message msgCls %i" % message.msgCls)
	print("message msgId %i" % message.msgId)
	print("message context %i" % message.context)
	print("message m_nAttriIndex %i" % message.m_nAttriIndex)
	print("message m_nAttriNameCount %i" % message.m_nAttriNameCount)
	print("message m_nAttriCount %i" % message.m_nAttriCount)
	print("message m_nTempObjId %i" % message.m_nTempObjId)
	print("message m_nSessionId %i" % message.m_nSessionId)
	print("message m_spId %i" % message.m_spId)
	print("message m_bEnd %i" % message.m_bEnd)
	print("message m_bNeedCallback %i" % message.m_bNeedCallback)
	print("message m_nLevel %i" % message.m_nLevel)
	print("message m_objDoMsg.object_id %i" % message.m_objDoMsg.object_id)
	print("message m_objDoMsg.paramCount %i" % message.m_objDoMsg.paramCount)
	print("message m_objDoMsg.typeList %s" % message.m_objDoMsg.typeList)
	print("message m_objDoMsg.dataList %s" % message.m_objDoMsg.dataList)
	
	c.send(message.getIOBytes())
	c.recvMessage(on_connect_test_recv, 3)

def on_connect_test_recv(stream):
	print("--->>> on recv message", stream)
	reader = MessageStream.MessageStreamReader(stream)
	message = dbx_msg_define.CSCResultMsg()
	message.read(reader)
	
	print("message msgLen %i" % message.msgLen)
	print("message msgFlags %i" % message.msgFlags)
	print("message msgCls %i" % message.msgCls)
	print("message msgId %i" % message.msgId)
	print("message context %i" % message.context)
	print("message m_nAttriIndex %i" % message.m_nAttriIndex)
	print("message m_nAttriNameCount %i" % message.m_nAttriNameCount)
	print("message m_nAttriCount %i" % message.m_nAttriCount)
	print("message m_nTempObjId %i" % message.m_nTempObjId)
	print("message m_nSessionId %i" % message.m_nSessionId)
	print("message m_spId %i" % message.m_spId)
	print("message m_bEnd %i" % message.m_bEnd)
	print("message m_bNeedCallback %i" % message.m_bNeedCallback)
	print("message m_nLevel %i" % message.m_nLevel)
	print("message m_objDoMsg.object_id %i" % message.m_objDoMsg.object_id)
	print("message m_objDoMsg.paramCount %i" % message.m_objDoMsg.paramCount)
	print("message m_objDoMsg.typeList %s" % message.m_objDoMsg.typeList)
	#print("message m_objDoMsg.dataList %s" % message.m_objDoMsg.dataList)
	f = open("connect_test_data.txt", "w", encoding="latin1")
	#f.writelines(message.m_objDoMsg.dataList)
	for d in message.m_objDoMsg.dataList:
		if type(d) is str:
			f.write(d + "\n")
		else:
			f.write(str(d) + "\n")

	
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
	
	reader = MessageStream.MessageStreamReader(message.getIOBytes())
	newMessage = dbx_msg_define.CCSResultMsg()
	newMessage.read(reader)
	
	print("Size of message %i" % message.size())
	print("Size of ObjDoMsg %i" % message.m_objDoMsg.size())
	print("message msgLen %i" % message.msgLen)
	print("message msgFlags %i" % message.msgFlags)
	print("message msgCls %i" % message.msgCls)
	print("message msgId %i" % message.msgId)
	print("message context %i" % message.context)
	print("message m_nAttriIndex %i" % message.m_nAttriIndex)
	print("message m_nAttriNameCount %i" % message.m_nAttriNameCount)
	print("message m_nAttriCount %i" % message.m_nAttriCount)
	print("message m_nTempObjId %i" % message.m_nTempObjId)
	print("message m_nSessionId %i" % message.m_nSessionId)
	print("message m_spId %i" % message.m_spId)
	print("message m_bEnd %i" % message.m_bEnd)
	print("message m_bNeedCallback %i" % message.m_bNeedCallback)
	print("message m_nLevel %i" % message.m_nLevel)
	print("message m_objDoMsg.object_id %i" % message.m_objDoMsg.object_id)
	print("message m_objDoMsg.paramCount %i" % message.m_objDoMsg.paramCount)
	print("message m_objDoMsg.typeList %s" % message.m_objDoMsg.typeList)
	print("message m_objDoMsg.dataList %s" % message.m_objDoMsg.dataList)
	
	assert message.size() == newMessage.size()
	assert message.m_objDoMsg.size() == newMessage.m_objDoMsg.size()
	
	assert message.m_nAttriIndex == newMessage.m_nAttriIndex
	assert message.m_nAttriNameCount == newMessage.m_nAttriNameCount
	assert message.m_nAttriCount == newMessage.m_nAttriCount
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
	
	assert message.m_objDoMsg.object_id == newMessage.m_objDoMsg.object_id
	assert message.m_objDoMsg.paramCount == newMessage.m_objDoMsg.paramCount
	assert message.m_objDoMsg.typeList == newMessage.m_objDoMsg.typeList
	assert message.m_objDoMsg.dataList == newMessage.m_objDoMsg.dataList
	
	print("Test OK!")
	

@operation.resgisterOperation("exec_sql")
def exec_sql(*args):
	"""
	Usage: exec_sql [-h 127.0.0.1] [-p 3000] sql_format arg1 arg2 arg3 ...
	"""
	host = "127.0.0.1"
	port = 3000
	
	sql_args = []
	index = 0
	skip_next = False
	for arg in args:
		if skip_next:
			skip_next = False
			continue
		
		if arg == "-h":
			host = args[index + 1]
			skip_next = True
		elif arg == "-p":
			port = args[index + 1]
			skip_next = True
		else:
			sql_args.append(arg)
		index += 1
	
	print("sql_args =", sql_args)
	sql = sql_args[0] % tuple(eval(i) for i in sql_args[1:])
	print("sql =", sql)
	message = dbx_build_msg.default_sql_message(sql)
	
	c = client.Client()
	c.connect(host, port)
	c.send(message.getIOBytes())
	c.recvMessage(on_exec_sql_recv, 3)


def on_exec_sql_recv(stream):
	on_connect_test_recv(stream)


@operation.resgisterOperation("exec_sp")
def exec_sp(*args):
	"""
	Usage: exec_sp [-h 127.0.0.1] [-p 3000] sp_name param1=value1 param2=value2 ...
			注意：param1=value1中间不要加空格，如果一定要空格，需要用双引号括起来。
	"""
	host = "127.0.0.1"
	port = 3000
	
	sp_args = []
	index = 0
	skip_next = False
	for arg in args:
		if skip_next:
			skip_next = False
			continue
			
		if arg == "-h":
			host = args[index + 1]
			skip_next = True
		elif arg == "-p":
			port = args[index + 1]
			skip_next = True
		else:
			sp_args.append(arg)
		index += 1
	
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
	c = client.Client()
	c.connect(host, port)
	c.send(message.getIOBytes())
	c.recvMessage(on_exec_sp_recv, 3)


def on_exec_sp_recv(stream):
	on_connect_test_recv(stream)

