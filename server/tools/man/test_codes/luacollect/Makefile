LUA_HOME=lua
LUA_LIB=$(LUA_HOME)/liblua.a
MY_LIBS=-L$(LUA_HOME) -llua -ldl -lm
MY_INCS=-I$(LUA_HOME)
MY_TAGS=-g 

temp=temp
main=$(temp)/main
tool=$(temp)/tool.so

all:$(temp) $(main)

$(temp):
	mkdir -p $@

$(LUA_LIB):
	cd $(LUA_HOME) && make linux;

$(tool):tool.c
	gcc $< -o $@ -shared -fPIC -llua $(MY_INCS) $(MY_TAGS)

$(main):main.c $(LUA_LIB) $(tool)
	gcc $< -o $@ $(MY_LIBS) $(MY_INCS) $(MY_TAGS) $(tool)

run:$(temp) $(main) 
	@$(main)

clean:
	rm -rf $(temp);cd lua;make clean

.PHONY:all run clean 
