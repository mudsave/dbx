# session.mak: session工程配置


# 工程名字
PROJECT_NAME = World

# 工程类型，可以是库(lib)或可执行程序(exe)
PROJECT_TYPE = exe

# 源代码目录
SRC_DIR = ../codes/world/src

# 工程宏
MACROS =

# 附加编译选项
CMPL_EX = -Wno-multichar -Wno-deprecated -DTOLUA_RELEASE

# 附加链接选项
LINK_EX =

# default.mak已包含了一些公用的目录，这里加上其他头文件目录
INCLUDE_DIR = -I../codes/world/inc -I../codes/lua/include -I../codes/tolua++/include -I../codes/dbClient/inc

# default.mak已包含了一些公用的库，这里加上其他所需的库及所在目录（exe工程才需要设置）
LIB_DIR = -L../codes/lua/lib -L../codes/tolua++/lib
LIBS = -llua -ltolua++ -ldl -ldbClient

# 工程目标
.PHONY: all pre_build target post_build print clean check

all :  pre_build target post_build

include ./default.mak
include ./common.mak

pre_build :
	mkdir -p $(INT_DIR)
	mkdir -p $(TARGET_DIR)
	@cd $(SRC_DIR)/../pkg; make -f tolua++.mak;

post_build :

check:
	@echo "check World"
	@export LD_LIBRARY_PATH=../sbin/linux; ldd -u -r ../sbin/linux/World; echo "ret = $$?"
