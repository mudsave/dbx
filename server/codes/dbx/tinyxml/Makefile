.PHONY : all 

all : tinyxml 

tinyxml:
	g++ -g3 -pthread ./*.cpp -fPIC -shared -o libtinyxml.so
	mv ./libtinyxml.so ../../../sbin/linux/libtinyxml.so
	