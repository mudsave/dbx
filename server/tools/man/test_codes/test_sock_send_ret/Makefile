# make for client and server

.PHONY : all clean

all : client server

client : client.cpp
	g++ -g3 -I../../../../codes/share -I../../../../codes/sock/inc -o client client.cpp

server : server.cpp
	g++ -g3 -I../../../../codes/share -I../../../../codes/sock/inc -o server server.cpp

clean :
	rm -rf client server
