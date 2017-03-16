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
		self.context = 0			# long
	
	def size(self):
		return struct.calcsize("=HBBHl")
	
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


class ObjDoMsg(MessageBase):
	
	def __init__(self):
		MessageBase.__init__(self)
		self.object_id = 0			# int
		#self.param = 0				# int Param[1]
		
		self.paramCount = 0			# int
		self.typeList = []			# int []
		self.dataList = []			# void * []
		
	def size(self):
		typeSize = struct.calcsize("=i") * len(self.typeList)
		dataSize = sum(self.getTypeSize(t) for t in self.typeList)
		return struct.calcsize("=iI") + typeSize + dataSize
	
	def read(self, reader):
		MessageBase.read(self, reader)
		self.object_id = reader.readInt32()
		self.paramCount = reader.readInt32()
		
		for i in range(self.paramCount):
			self.typeList.append(reader.readInt32())
		
		for t in self.typeList:
			if t == DATA_TYPE.INT:
				self.dataList.append(reader.readInt32())
			elif t == DATA_TYPE.BOOL:
				self.dataList.append(reader.readBool())
			elif t == DATA_TYPE.FLOAT:
				self.dataList.append(reader.readFloat())
			else:
				self.dataList.append(reader.readBlob(t).decode("latin1"))
	
	def write(self, writer):
		MessageBase.write(self, writer)
		writer.writeInt32(self.object_id)
		writer.writeInt32(self.paramCount)
		
		for i in self.typeList:
			writer.writeInt32(i)
		
		for t, d in zip(self.typeList, self.dataList):
			if t == DATA_TYPE.INT:
				writer.writeInt32(d)
			elif t == DATA_TYPE.BOOL:
				writer.writeBool(d)
			elif t == DATA_TYPE.FLOAT:
				writer.writeFloat(d)
			else:
				writer.writeBlob(BytesIO.ensureBytes(d))
	
	def addData(self, type, value):
		self.paramCount += 1
		self.typeList.append(type)
		self.dataList.append(value)
		
	def getTypeSize(self, type):
		if type >= 0:
			return type
		else:
			return TYPE_TO_SIZE[type]

	def getParam(self, index):
		return self.typeList[index], self.dataList[index]
		
		
class CResultMsg(AppMsg):
	
	def __init__(self):
		AppMsg.__init__(self)
		self.m_nAttriIndex = 0		# int
		self.m_nAttriNameCount = 0	# int
		self.m_nAttriCount = 0		# int
		self.m_nTempObjId = 0		# int	流水号
		self.m_nSessionId = 0		# int	sessionID
		self.m_spId = 0				# int	存储过程ID
		self.m_bEnd = True			# bool	
		self.m_bNeedCallback = True	# bool	
		self.m_nLevel = 0			# short	
		self.m_pObjDoMsg = None		# unsigned int	指针
	
	def size(self):
		# 考虑c++内存对齐为8，这里插入对齐后空出来的空间
		return AppMsg.size(self) + 2 + struct.calcsize("=iiiiiibbhI")
		
	def read(self, reader):
		AppMsg.read(self, reader)
		reader.readInt16()			# 内存对齐的空隙，2个字节
		self.m_nAttriIndex = reader.readInt32()
		self.m_nAttriNameCount = reader.readInt32()
		self.m_nAttriCount = reader.readInt32()
		self.m_nTempObjId = reader.readInt32()
		self.m_nSessionId = reader.readInt32()
		self.m_spId = reader.readInt32()
		self.m_bEnd = reader.readBool()
		self.m_bNeedCallback = reader.readBool()
		self.m_nLevel = reader.readInt16()
		reader.readUint32()			# self.m_pObjDoMsg
	
	def write(self, writer):
		AppMsg.write(self, writer)
		writer.writeInt16(0)		# 内存对齐的空隙，2个字节
		writer.writeInt32(self.m_nAttriIndex)
		writer.writeInt32(self.m_nAttriNameCount)
		writer.writeInt32(self.m_nAttriCount)
		writer.writeInt32(self.m_nTempObjId)
		writer.writeInt32(self.m_nSessionId)
		writer.writeInt32(self.m_spId)
		writer.writeBool(self.m_bEnd)
		writer.writeBool(self.m_bNeedCallback)
		writer.writeInt16(self.m_nLevel)
		writer.writeUint32(0)		# self.m_pObjDoMsg
	
	def addAttr(self, name):
		assert name
		self.m_pObjDoMsg.addData(len(name), name)
		self.m_nAttriNameCount += 1
	
	def addValue(self, valueType, value):
		assert value is not None and valueType is not None
		self.m_pObjDoMsg.addData(valueType, value)
		self.m_nAttriCount += 1

		
class CCSResultMsg(CResultMsg):
	
	def __init__(self):
		CResultMsg.__init__(self)
		self.m_objDoMsg = ObjDoMsg()
		self.m_pObjDoMsg = self.m_objDoMsg
		
	def size(self):
		return CResultMsg.size(self) + self.m_objDoMsg.size()
	
	def read(self, reader):
		CResultMsg.read(self, reader)
		self.m_objDoMsg.read(reader)
	
	def write(self, writer):
		CResultMsg.write(self, writer)
		self.m_objDoMsg.write(writer)


class CSCResultMsg(CResultMsg):
	
	def __init__(self):
		CResultMsg.__init__(self)
		self.m_objDoMsg = ObjDoMsg()
		self.m_pObjDoMsg = self.m_objDoMsg
		
	def size(self):
		return CResultMsg.size(self) + self.m_objDoMsg.size()
	
	def read(self, reader):
		CResultMsg.read(self, reader)
		self.m_objDoMsg.read(reader)
	
	def write(self, writer):
		CResultMsg.write(self, writer)
		self.m_objDoMsg.write(writer)
