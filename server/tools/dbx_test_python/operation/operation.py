#-*- coding: utf-8 -*-

import re
fullname_pattern = re.compile("(.*(?=\[))")
shortcut_pattern = re.compile("((?<=\[or:).*(?=\]))")

operations = {}
operations_shortcut = {}

def resgisterOperation(name):
	def _reg(op):
		global operations, operations_shortcut, op_pattern
		
		shortcut_m = shortcut_pattern.search(name)
		
		if shortcut_m is not None: 
			shortcut = shortcut_m.group().strip()
			assert shortcut not in operations,\
				"Operation shortcut %s has been used by %s" % (shortcut, operations[shortcut])
			assert shortcut not in operations_shortcut,\
				"Operation shortcut %s has been used by %s" % (shortcut, operations_shortcut[shortcut])
			
			operations_shortcut[shortcut] = op
			fullname = fullname_pattern.search(name).group().strip()
		else:
			fullname = name
		
		assert fullname not in operations,\
			"Operation name %s has been used by %s" % (fullname, operations[fullname])			
		assert fullname not in operations_shortcut,\
			"Operation name %s has been used by %s" % (fullname, operations_shortcut[fullname])
		
		operations[fullname] = op
		
	return _reg


def findOperation(opid):
	if opid in operations:
		return operations[opid]
	else:
		return operations_shortcut.get(opid, None)
	

@resgisterOperation("help")
def help(opid):
	"""
	Usage: help opid
	"""
	op = findOperation(opid)
	if op is not None:
		print(op.__doc__)
	else:
		print("Operation %s not found." % opid)

@resgisterOperation("list")
def all():
	"""
	Usage: list
	"""
	ops = []
	
	shortcut_ops = {}
	for name, op in operations_shortcut.items():
		shortcut_ops[op] = name
	
	for name, op in operations.items():
		if op in shortcut_ops:
			ops.append("%s[or:%s]" % (name, shortcut_ops[op]))
		else:
			ops.append(name)
	
	ops.sort()
	print("全部操作:\n", " ".join(ops))

@resgisterOperation("registerAccount")
def registerAccount(num):
	"""
	Usage: registerAccount num
	"""
	raise NonImplement("xxx")

@resgisterOperation("newCharacter")
def newCharacter():
	"""
	Usage: newCharacter
	"""
	pass

@resgisterOperation("rawSql")	
def rawSql(sql, num):
	"""
	Usage: rawSql sql num
	"""
	pass

@resgisterOperation("callProcedure")
def callProcedure(id, num):
	"""
	Usage: callProcedure id num
	"""
	pass



