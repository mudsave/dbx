#-*- coding: utf-8 -*-

operations = {}
def resgisterOperation(name):
	def _reg(op):
		global operations
		operations[name] = op
	return _reg

@resgisterOperation("help")
def help(opid):
	"""
	Usage: help opid
	"""
	if opid in operations:
		print(operations[opid].__doc__)
	else:
		print("Operation %s not found." % opid)

@resgisterOperation("list")
def all():
	"""
	Usage: list
	"""
	ops = list(operations.keys())
	ops.sort()
	print("All operations:", " ".join(ops))

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



