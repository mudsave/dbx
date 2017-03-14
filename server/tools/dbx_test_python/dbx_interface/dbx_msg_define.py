#-*- coding: utf-8 -*-

import struct
from common import MessageStream, BytesIO

class MSG_ID:
	C_DO_ACTION = 1
	C_DO_SQL = 2

class MSG_TYPE:
	APPMSG		= 0
	CSSRESMSG	= 1
	CSCRESMSG	= 2
	CCSRESMSG	= 3
	
class ACTION_RESULT:
	S_DO_ACTION_RES = 1001
	S_DO_SQL_RES = 1002
	
class ERROR_ID:
	S_ERROR = 2001
	C_ERROR = 3001

class DATA_TYPE:
	INT		=-1
	BOOL	=-2
	FLOAT	=-3
	END 	=-4 

TYPE_TO_SIZE = {
	DATA_TYPE.INT: struct.calcsize("=i"),
	DATA_TYPE.BOOL: struct.calcsize("=b"),
	DATA_TYPE.FLOAT: struct.calcsize("=f")
}

LOCATION_TAIL = None

class MessageBase:
	
	def __init__(self):
		pass
	
	def size(self):
		return 0
		
	def read(self, reader):
		pass
	
	def write(self, writer):
		pass
	
	def getIOBytes(self, writer = None):
		if writer is None:
			writer = MessageStream.MessageStreamWriter()
		self.write(writer)
		return writer.build()


class AppMsg(MessageBase):
	
	def __init__(self):
		MessageBase.__init__(self)
		self.msgLen = 0				# unsigned short
		self.msgFlags = 0			# unsigned char
		self.msgCls = 0				# unsigned char
		self.msgId = 0				# unsigned short
		self.context = 0			# int
	
	def size(self):
		return struct.calcsize("=HBBHi")
	
	def read(self, reader):
		MessageBase.read(self, reader)
		self.msgLen = reader.readUint16()
		self.msgFlags = reader.readUint8()
		self.msgCls = reader.readUint8()
		self.msgId = reader.readUint16()
		self.context = reader.readInt32()
	
	def write(self, writer):
		MessageBase.write(self, writer)
		writer.writeUint16(self.msgLen)
		writer.writeUint8(self.msgFlags)
		writer.writeUint8(self.msgCls)
		writer.writeUint16(self.msgId)
		writer.writeInt32(self.context)

		
class DbxMessage(AppMsg):
	
	def __init__(self):
		AppMsg.__init__(self)
		# 以下是仅在脚本使用的
		self.paramCount = 0			# int
		self.typeList = []			# int []
		self.dataList = []			# void * []
		
		# 以下是协议的数据
		self.attribute_cols = 0		# int
		self.attribute_count = 0	# int
		self.content_offset = 0		# int
	
	def size(self):
		return AppMsg.size(self) + struct.calcsize("=iii") + self.getParamSize()
	
	def getParamSize(self):
		if len(self.typeList) == 0:
			return 0
		
		typeSize = struct.calcsize("=i") * len(self.typeList)
		dataSize = sum(self.getTypeSize(t) for t in self.typeList)
		# 数据段前端存放参数数量
		return struct.calcsize("=i") + typeSize + dataSize
	
	def read(self, reader):
		AppMsg.read(self, reader)
		self.attribute_cols = reader.readInt32()
		self.attribute_count = reader.readInt32()
		self.content_offset = reader.readInt32()
		
	def readContent(self, reader):
		if self.content_offset == 0:
			return
		
		self.paramCount = reader.readInt32()
		
		for i in range(self.paramCount):
			t = reader.readInt32()
			self.typeList.append(t)
			
			if t == DATA_TYPE.INT:
				self.dataList.append(reader.readInt32())
			elif t == DATA_TYPE.BOOL:
				self.dataList.append(reader.readBool())
			elif t == DATA_TYPE.FLOAT:
				self.dataList.append(reader.readFloat())
			else:
				self.dataList.append(reader.readBlob(t).decode("latin1"))
	
	def write(self, writer):
		AppMsg.write(self, writer)
		writer.writeInt32(self.attribute_cols)
		writer.writeInt32(self.attribute_count)
		writer.writeInt32(self.content_offset)
	
	def writeContent(self, writer):
		if self.paramCount == 0:
			return
	
		writer.writeInt32(self.paramCount)
		
		for i in range(self.paramCount):
			t = self.typeList[i]
			writer.writeInt32(t)
			
			if t == DATA_TYPE.INT:
				writer.writeInt32(self.dataList[i])
			elif t == DATA_TYPE.BOOL:
				writer.writeBool(self.dataList[i])
			elif t == DATA_TYPE.FLOAT:
				writer.writeFloat(self.dataList[i])
			else:
				writer.writeBlob(BytesIO.ensureBytes(self.dataList[i]))
	
	def addData(self, type, value, location = LOCATION_TAIL):
		self.paramCount += 1
		if location == LOCATION_TAIL:
			self.typeList.append(type)
			self.dataList.append(value)
		else:
			self.typeList.insert(location, type)
			self.dataList.insert(location, value)
	
	def addAttr(self, name):
		assert name
		self.addData(len(name), name, self.attribute_cols)
		self.attribute_cols += 1
	
	def addValue(self, valueType, value):
		assert value is not None and valueType is not None
		self.addData(valueType, value, self.attribute_cols + self.attribute_count)
		self.attribute_count += 1

	def getTypeSize(self, type):
		if type >= 0:
			return type
		else:
			return TYPE_TO_SIZE[type]

	def getParam(self, index):
		return self.typeList[index], self.dataList[index]
	
	def getAttribute(self, col, row):
		if col < self.attribute_cols:
			return self.getAttributeByIndex(row * self.attribute_cols + col)
		return None

	def getAttributeByIndex(self, index):
		if index < self.attribute_count:
			return self.getParam(index)
		else:
			return None
	
	def getAttibuteByName(self, name, row):
		for col in range(self.attribute_cols):
			attr_tuple = self.getAttribute(col, row)
			if attr_tuple is not None and attr_tuple[1] == name:
				return attr_tuple
		return None
		
		
class DbxResultMessage(DbxMessage):
	
	def __init__(self):
		DbxMessage.__init__(self)
		self.m_nTempObjId = 0		# int	流水号
		self.m_nSessionId = 0		# int	sessionID
		self.m_spId = 0				# int	存储过程ID
		self.m_bEnd = True			# bool	
		self.m_bNeedCallback = True	# bool	
		self.m_nLevel = 0			# short	
	
	def size(self):
		return DbxMessage.size(self) + struct.calcsize("=iiibbh")
		
	def read(self, reader):
		DbxMessage.read(self, reader)
		self.m_nTempObjId = reader.readInt32()
		self.m_nSessionId = reader.readInt32()
		self.m_spId = reader.readInt32()
		self.m_bEnd = reader.readBool()
		self.m_bNeedCallback = reader.readBool()
		self.m_nLevel = reader.readInt16()
	
	def write(self, writer):
		DbxMessage.write(self, writer)
		writer.writeInt32(self.m_nTempObjId)
		writer.writeInt32(self.m_nSessionId)
		writer.writeInt32(self.m_spId)
		writer.writeBool(self.m_bEnd)
		writer.writeBool(self.m_bNeedCallback)
		writer.writeInt16(self.m_nLevel)
		
		
class CCSResultMsg(DbxResultMessage):
	
	def __init__(self):
		DbxResultMessage.__init__(self)
		
	def size(self):
		return DbxResultMessage.size(self)
	
	def read(self, reader):
		DbxResultMessage.read(self, reader)
		self.readContent(reader)
	
	def write(self, writer):
		DbxResultMessage.write(self, writer)
		self.writeContent(writer)


class CSCResultMsg(DbxResultMessage):
	
	def __init__(self):
		DbxResultMessage.__init__(self)
		
	def size(self):
		return DbxResultMessage.size(self)
	
	def read(self, reader):
		DbxResultMessage.read(self, reader)
		self.readContent(reader)
	
	def write(self, writer):
		DbxResultMessage.write(self, writer)
		self.writeContent(writer)

