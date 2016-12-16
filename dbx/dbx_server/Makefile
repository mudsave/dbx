
# 工程名字
PROJECT_NAME = dbx

# 源代码目录
SRC_DIR = ./src

# default.mak已包含了一些公用的目录，这里加上项目本身文件目录
INCLUDE_DIR = -I../codes/dbx/inc

# 编译选项
CFLAGS = $(INCLUDE_DIR) -L../../server/sbin/linux -export-dynamic

# --------------- default.mak start -------------------------------------------------------
# 这里使用gcc，gcc -lstdc++ 等同于 g++
CXX = gcc

# 头文件包含目录
INCLUDE_DIR += -I../../share -I../../server/codes/share -I../../server/codes/sock/inc

# 共享库（exe链接需要的库，对于so则直接定义链接项，不使用该定义），Sock库是项目生成的库
LIBS +=-lrt -lstdc++ -pthread -lSock

# --------------- default.mak end ---------------------------------------------------------

target: $(wildcard *.cpp)
	$(CXX) $(CFLAGS) $(SRC_DIR)/*.cpp $(LIBS) -o $(PROJECT_NAME)

test:
	@echo "wsf makefile test."

.PHONY: clean
clean:
	rm *.o



