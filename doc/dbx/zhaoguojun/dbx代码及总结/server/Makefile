

.PHONY: main clean

all: main

INCLUDE = -I/usr/include/mysql/ -I../event2/ -I../ -I./
#LD_OPT = -g3 -lrt -pthread -L/usr/lib64/mysql/ -L/opt/libevent/lib/ -Wl, -Bdynamic -levent -lmysqlclient_r -Wl,
LD_OPT = -g3 -lrt -pthread -L/usr/lib64/mysql/ -L/opt/libevent/lib/ -levent -lmysqlclient_r

main: DBQueue.o DBObject.o SqlOuter.o DBEngine.o ServerSock.o server.o DBServer.o
	g++ $^ $(LD_OPT) -o server.out

clean: 
	rm -fr *.o *.h.gch *.out

%.o : %.cpp
	g++ $(INCLUDE) -g3 -c -o $@ $<