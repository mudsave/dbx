# make for client and server

.PHONY : all clean

all : single multiple

single : single.cpp
	g++ -g3 -I../../../../codes/share -I../../../../codes/sock/inc -o single single.cpp

multiple: multiple.cpp
	g++ -g3 -pthread -I../../../../codes/share -I../../../../codes/sock/inc -o multiple multiple.cpp

clean :
	rm -rf single multiple 
