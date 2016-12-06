#-*- coding: utf-8 -*-

import os
import sys

def initRootPath():
	"""
	初始化root目录，以加载其它的脚本
	"""
	appdir = os.path.dirname( os.path.abspath( __file__ ) )
	parentDir = os.path.dirname( appdir )
	if parentDir not in sys.path:
		sys.path.append( parentDir )

initRootPath()

# 所有的操作都在这里
# 使用：
#	python main.py operation arg1 arg2 ...
# 显示所有操作（默认）：
#	python main.py list
# 显示操作帮助：
#	python main.py help operation
import operation
operations = operation.operation.operations

def main():
	if len(sys.argv) > 1:
		opid = sys.argv[1]
	else:
		opid = "list"
	
	op = operations.get(opid, None)
	
	if op is None or not callable(op):
		print("Operation %s invalid!" % opid)
		return
	
	print("%s:" % opid)
	try:
		op(*sys.argv[2:])
	except:
		sys.excepthook( *sys.exc_info() )
		operations["help"](opid)
	

if __name__ == '__main__':
	main()
