#-*- coding: utf-8 -*-

from . import dbx_msg_define

def writeMessage(message, params):
	for key, table in params.items():
		for attr, value in table.items():
			if key == 1:
				message.addAttr(attr)
				
			valueType = type(value)
			if valueType is bool:
				message.addValue(dbx_msg_define.DATA_TYPE.BOOL, value)
			elif valueType is int:
				message.addValue(dbx_msg_define.DATA_TYPE.INT, value)
			elif valueType is float:
				message.addValue(dbx_msg_define.DATA_TYPE.FLOAT, value)
			elif valueType is str:
				message.addValue(len(value), value)
			else:
				print("Write message error: params[%s][%s] : %s" % (key, attr, value))
				return False
	
	message.msgLen = message.size()
	
	return True


#消息参数：
#params[1]["spName"] = "sp_XXX"	基础字段
#params[1]["dataBase"] = 1		基础字段
#params[1]["sort"] = "XX,XX,XX"	基础字段
#params[1]["param1"] = XX		字段加入输出集
#params[1]["param2"] = XX		字段加入输出集
#params[1]["paramN"] = XX		字段加入输出集
#params[1]["@XXX"] = XX			字段加入输出集
def call_sp_message(params, noCallback, level, spId = 0):
	message = dbx_msg_define.CCSResultMsg()
	if writeMessage(message, params):
		message.m_spId = spId
		message.m_bNeedCallback = not noCallback
		message.m_nLevel = level
		message.msgId = dbx_msg_define.MSG_ID.C_DO_ACTION
		message.context = dbx_msg_define.MSG_TYPE.CCSRESMSG
		return message
	else:
		return None
		

#消息参数：
#params[1]["sql"] = "select * from table_XXX where XXX"
#params[1]["dataBase"] = 1
#params[1]["cmdID"] = 1
#params[1]["queueIndex"] = 1
#params[1]["level"] = 1
def call_sql_message(params, spId = 0, noCallback = False):
	message = dbx_msg_define.CCSResultMsg()
	if writeMessage(message, params):
		message.m_spId = spId
		message.m_bNeedCallback = not noCallback
		message.msgId = dbx_msg_define.MSG_ID.C_DO_SQL
		message.context = dbx_msg_define.MSG_TYPE.CCSRESMSG
		message.m_nTempObjId = 1
		return message
	else:
		return None
	

def default_sp_message(spName, database = 1, sort = "", others = {}, noCallback = False):
	params = {1:{}}
	params[1]["spName"] = spName
	params[1]["dataBase"] = database
	params[1]["sort"] = sort
	params[1].update(others)
	return call_sp_message(params, noCallback, 20)
	
	
def default_sql_message(sql, database = 1, cmdID = 0, queueIndex = -1, level = 20, noCallback = False):
	params = {1:{}}
	params[1]["sql"] = sql
	params[1]["dataBase"] = database
	params[1]["cmdID"] = cmdID
	params[1]["queueIndex"] = queueIndex
	params[1]["level"] = level
	return call_sql_message(params, 0, noCallback)
	