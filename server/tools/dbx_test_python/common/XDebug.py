#-*- coding: utf-8 -*-
#
import os
import sys
import traceback

PRINT_ERROR		 = 1		# 是否打印错误信息
PRINT_WARNING	 = 1		# 是否打印警告信息
PRINT_DEBUG		 = 1		# 是否打印调试信息
PRINT_INFO		 = 1		# 是否打印一般日志

TRACE_SOURCE = 1			# 对于错误信息和调试信息，是否追踪日志位置
TRACE_ERROR_STACK = 1		# 对错误消息，是否打印调用堆栈（优先级较高）

TRACE_SHORT	= 1				# 只打印精简信息


def DEBUG_MSG(*args):
	if PRINT_DEBUG:
		if TRACE_SOURCE:
			if TRACE_SHORT:
				source = getSource(1)
				file = os.path.basename(source[0])
				print_message("[DEBUG(%s:%s)]:" % (file, source[1]), *args)
			else:
				print_message("[DEBUG(", "file %s, line %s, in %s)]:" % getSource(1), *args)
		else:
			print_message("[DEBUG]:", *args)

def WARNING_MSG(*args):
	if PRINT_WARNING:
		if TRACE_SOURCE:
			if TRACE_SHORT:
				source = getSource(1)
				file = os.path.basename(source[0])
				print_message("[WARNING(%s:%s)]:" % (file, source[1]), *args)
			else:
				print_message("[WARNING(", "file %s, line %s, in %s)]:" % getSource(1), *args)
		else:
			print_message("[WARNING]:", *args)
			
def ERROR_MSG(*args):
	if PRINT_ERROR:
		if TRACE_ERROR_STACK:
			format = "[ERROR_MSG(", "file %s, line %s, in %s)]:" + "".join(args) + "\n"
			print_stack(format, 2)
		elif TRACE_SOURCE:
			if TRACE_SHORT:
				source = getSource(1)
				file = os.path.basename(source[0])
				print_message("[ERROR(%s:%s)]:" % (file, source[1]), *args)
			else:
				print_message("[ERROR(", "file %s, line %s, in %s)]:" % getSource(1), *args)
		else:
			print_message("[ERROR]:", *args)

def INFO_MSG(*args):
	if PRINT_INFO:
		print_message("[INFO]:", *args)

def EXCEHOOK_MSG( *args ) :
	"""
	输出当前栈帧错误信息，常用于输出异常信息
	@param 			args : 输出的信息
	@type 			args : 可变参数列表
	@return				 : None
	"""
	exceInfo = sys.exc_info()
	if exceInfo is None or exceInfo == ( None, None, None ) :
		INFO_MSG( "No exception in stack!" )
	else :
		source = getSource(1)
		file = os.path.basename(source[0])
		print_message("[EXCEHOOK(%s:%s)]:" % (file, source[1]), 
			"".join(str(i) for i in args), "\n", "".join(traceback.format_exception(*exceInfo)))


# ---------------------------------------- #
# functions
# ---------------------------------------- #
def print_message(*args):
	print("".join(str(i) for i in args))

def getFrame(backOffset = 0):
	"""取得源代码信息
	@param backOffset: 栈帧偏移数（回溯帧数，以调用点所在帧为回溯基数）
	"""
	backOffset += 1
	frame = sys._getframe()
	
	while backOffset > 0 and frame.f_back:
		frame = frame.f_back
		backOffset -= 1
	
	# 无法回溯指定帧数
	if backOffset != 0:
		return None
	
	return frame

def getSource(backOffset = 0):
	"""取得源代码信息
	@param backOffset: 栈帧偏移数（回溯帧数，以调用点所在帧为回溯基数）
	"""
	# 这里加1，是考虑到调用的时候，是以调用点所在帧为回溯基数
	frame = getFrame(backOffset + 1)
	if frame is None:
		return None
	
	return traceback.extract_stack(frame, 1)[0][:3]

def print_stack(titleFormat ="<Debug> Stack trace:\n(From file %s, line %s, in %s)\n", backOffset = 0):
	"""打印堆栈调用信息
	@param titleFormat: 信息标题格式化字符串（文件，行，方法）
	@param backOffset: 栈帧偏移数（回溯帧数，以调用点所在帧为回溯基数）
	"""
	# 这里加1，是考虑到调用的时候，是以调用点所在帧为回溯基数
	frame = getFrame(backOffset + 1)
	if frame is None:
		print_message("No stack trace to back offset %i." % backOffset)
	else:
		message = titleFormat % traceback.extract_stack(frame, 1)[0][:3]
		
		for trace in traceback.format_stack(frame):
			message += trace
		
		print_message(message)

