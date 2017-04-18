#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int lua_main(lua_State *L);

int main() {
	lua_State *L = lua_open();
	luaL_openlibs(L);
	
	lua_checkstack(L,1024);
	lua_pushcfunction(L,lua_main);
	if(lua_pcall(L,0,0,0)) {
		fprintf(stderr,"lua_main failed:%s\n",lua_tostring(L,-1));
		lua_pop(L,1);
	}

	printf("Press Enter to continue");
	getchar();
	lua_close(L);
	return 0;
}

static int
lua_main(lua_State *L) {
	luaL_loadfile(L,"run.lua"),lua_call(L,0,0);
	return 0;
}
