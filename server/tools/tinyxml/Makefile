# Utilities.
MKDIR = mkdir -p
AR = ar rc
RANLIB = ranlib

# What to install.
TO_INC= tinystr.h tinyxml.h
TO_LIB= libtinyxml.a

# How to install. If your install program does not support "-p", then you
# may have to run ranlib on the installed libtinyxml.a (do "make ranlib").
INSTALL= install -p
INSTALL_DATA= $(INSTALL) -m 0644

INSTALL_TOP= ../../codes/tinyxml
INSTALL_INC= $(INSTALL_TOP)/include
INSTALL_LIB= $(INSTALL_TOP)/lib

TINYXML_A = libtinyxml.a
SRC_O= tinystr.o tinyxml.o tinyxmlerror.o tinyxmlparser.o

$(TINYXML_A): $(SRC_O)
	$(AR) $@ $(SRC_O)
	$(RANLIB) $@

target: $(TINYXML_A)

install: 
	$(MKDIR) $(INSTALL_INC) $(INSTALL_LIB)
	$(INSTALL_DATA) $(TO_INC) $(INSTALL_INC)
	$(INSTALL_DATA) $(TO_LIB) $(INSTALL_LIB)

clean:
	$(RM) $(SRC_O) $(TINYXML_A)

.PHONY: install clean 
