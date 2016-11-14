# default.mak: 工程默认配置


CXX = gcc

# 工程名字
# PROJECT_NAME = 工程模块自己设置

# 工程类型
# PROJECT_TYPE = 工程模块自己设置（lib 或者 exe）

# 源代码目录
# SRC_DIR = 工程模块自己设置

# 工程宏
# MACROS = 工程模块自己设置

# 附加编译选项
# CMPL_EX = 工程模块自己设置

# 附加链接选项
# LINK_EX = 工程模块自己设置

# 目标目录
TARGET_DIR = ../sbin/linux

# 目标名
TARGET_NAME = $(PROJECT_NAME)

# 临时目录
INT_DIR = ../sbin/temp/$(PROJECT_NAME)

# 头文件包含目录
INCLUDE_DIR += -I../../share -I../codes/share -I../codes/sock/inc

# 共享库链接目录
LIB_DIR += -L$(TARGET_DIR)

# 共享库（exe链接需要的库，对于so则直接定义链接项，不使用该定义）
LIBS +=-lrt -lstdc++ -pthread -lSock


# 定义编译选项变量
_C_OP = -c
_C_OP += -g3
_C_OP += -Wall 
_C_OP += -pthread

ifeq ($(PROJECT_TYPE), lib)
	_C_OP += -fPIC
endif

ifdef MACROS
	_C_OP += $(MACROS)
endif

ifdef INCLUDE_DIR
	_C_OP += $(INCLUDE_DIR)
endif

ifdef CMPL_EX
	_C_OP += $(CMPL_EX)
endif


# 定义链接选项变量
ifeq ($(PROJECT_TYPE), lib)
	_L_OP += -shared -lstdc++ -pthread
else
	ifdef LIB_DIR
		_L_OP += $(LIB_DIR)
	endif
	ifdef LIBS
		_L_OP += $(LIBS)
	endif
endif

ifdef LINK_EX
	_L_OP += $(LINK_EX)
endif
