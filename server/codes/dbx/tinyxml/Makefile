.PHONY : all 

all : tinyxml 

tinyxml:
	g++ -g3 -pthread -I../../../share -I../../codes/share -I../../codes/dbx/tinyxml -I./inc ./src/*.cpp -fPIC -shared -o libtinyxml.so
	mv ./libtinyxml.so ../../../sbin/linux/libtinyxml.so
	