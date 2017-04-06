
export LD_LIBRARY_PATH = ../../server/sbin/linux

.PHONY: clean all start test test_run

INCLUDE = -I./inc -I../../server/codes/share -I../../server/codes/sock/inc -I../../server/codes/lua/include -I../../server/codes/tolua++/include -I../../share

LIB_PATH = -L../../server/sbin/linux -L../../server/codes/lua/lib -L../../server/codes/tolua++/lib

LIB_OPTS = -llua -ldl -lSock -lmicrohttpd -ltolua++

CPP_FILES = src/main.cpp src/admin.cpp src/client.cpp src/luaUtils.cpp src/RPCEngine.cpp

all: $(CPP_FILES)
	g++ $^ $(INCLUDE) $(LIB_PATH) $(LIB_OPTS) -o admin -g3

test: test.cpp
	g++ $^ $(INCLUDE) $(LIB_PATH) $(LIB_OPTS) -o test -g3

test_run:
	@set -e; ulimit -c unlimited; \
	./test

start:
	@set -e; ulimit -c unlimited; \
	./admin

clean:
	rm admin

