

.PHONY: main clean

all: main lua

INCLUDE = -I./ -I../ -I../event2/
#LD_OPT = -g3 -lrt -pthread -L/opt/libevent/lib/ -Wl, -Bdynamic -levent -Wl,
LD_OPT = -g3 -lrt -pthread -L/opt/libevent/lib/ -levent -llua

clean: 
	rm -fr *.o *.h.gch *.out

main: client.o DBClient.o ClientSock.o LuaApi.o
	g++ $^ $(LD_OPT) -o client.out

lua: lua_client.o DBClient.o ClientSock.o LuaApi.o
	g++ $^ $(LD_OPT) -o lua.out

%.o : %.cpp
	g++ $(INCLUDE) -g3 -c -o $@ $<