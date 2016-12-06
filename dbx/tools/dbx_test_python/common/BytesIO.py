#-*- coding: utf-8 -*-
import sys

if sys.hexversion >= 0x02060000:
	import io
	def BytesIO(bytesData = "".encode("utf-8")):
		return io.BytesIO(bytesData)
else:
	import StringIO
	def BytesIO(bytesData = ""):
		return StringIO.StringIO(bytesData)

def ensureBytes(message, coding = "utf-8"):
	if type(message) is not bytes:
		return message.encode(coding)
	else:
		return message
