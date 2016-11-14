# debug.mak：check variables for Makefile
# usage : make -f test.mak -f debug.mak CC (or d-CC)


% : 
	@echo '$* = ${$*}'

d-% :
	@echo '$* = ${$*}'
	@echo 'origin = $(origin $*)'
	@echo 'value = $(value $*)'
	@echo 'flavor = $(flavor $*)'
