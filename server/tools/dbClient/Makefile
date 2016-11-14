# make for dbclient 

.PHONY : all 

all : dbclient 

dbclient:
	g++ -g3 -pthread -I../../../share -I../../codes/share -I../../codes/sock/inc -I./inc ./src/*.cpp -fPIC -shared -o libdbClient.so
	mv ./libdbClient.so ../../sbin/linux/libdbClient.so
	

 
