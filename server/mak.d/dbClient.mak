# sock.mak: sock模块工程配置


# 工程名字
PROJECT_NAME = dbClient

# 工程类型，可以是库(lib)或可执行程序(exe)
PROJECT_TYPE = lib

# 源代码目录
SRC_DIR = ../codes/dbClient/src

# 工程宏
MACROS =

# 附加编译选项
CMPL_EX =

# 附加链接选项
LINK_EX =

# default.mak已包含了一些公用的目录，这里加上其他头文件目录
INCLUDE_DIR = -I../codes/dbClient/inc

# default.mak已包含了一些公用的库，这里加上其他所需的库及所在目录（exe工程才需要设置）
LIB_DIR =
LIBS =


# 工程目标
.PHONY: all pre_build target post_build print clean

all : pre_build target post_build

include ./default.mak
include ./common.mak

pre_build :
	mkdir -p $(INT_DIR)
	mkdir -p $(TARGET_DIR)

post_build :

check :
	@echo "check dbClient2"
	@export LD_LIBRARY_PATH=../sbin/linux; ldd -u -r ../sbin/linux/dbClient.so; echo "ret = $$?"
