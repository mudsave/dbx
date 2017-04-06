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

def main():
	if len(sys.argv) > 1:
		opid = sys.argv[1]
	else:
		print("使用方式：\n\tpython main.py operation arg1 arg2 ...")
		print("显示操作帮助：\n\tpython main.py help operation")
		opid = "list"
	
	op = operation.operation.findOperation(opid)
	
	if op is None or not callable(op):
		print("Operation %s invalid!" % opid)
		return
	
	print("\n[当前操作: %s]" % " ".join([opid] + sys.argv[2:]))
	try:
		op(*sys.argv[2:])
	except:
		sys.excepthook( *sys.exc_info() )
		operation.operation.findOperation("help")(opid)

def _setSysArgv(*argv):
	sys.argv = sys.argv[0:1]
	sys.argv.extend(argv)

def idleMain(*argv):
	print("idleMain::argv:",*(argv))
	print()
	_setSysArgv(*argv)
	main()

if __name__ == '__main__':
	main()
