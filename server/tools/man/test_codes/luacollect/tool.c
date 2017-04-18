#include "lua.h"
#include "lauxlib.h"

struct Color {
	unsigned char r,b,g,a;
};

struct Size {
	int x,y;
};

static int 
newcolor(lua_State *L) {
	int r = luaL_optint(L,1,0);
	int g = luaL_optint(L,2,0);
	int b = luaL_optint(L,3,0);
	int a = luaL_optint(L,4,255);
	struct Color *color = (struct Color *)lua_newuserdata(L,sizeof(struct Color));
	color->r = r;
	color->g = g;
	color->b = b;
	color->a = a;
	luaL_getmetatable(L,"Color");
	lua_setmetatable(L,-2);
	return 1;	
}

static int 
newsize(lua_State *L) {
	int x = luaL_optint(L,1,0);
	int y = luaL_optint(L,2,0);
	struct Size *size = (struct Size *)lua_newuserdata(L,sizeof(struct Size));
	size->x = x;
	size->y = y;
	luaL_getmetatable(L,"Size");
	lua_setmetatable(L,-2);
	return 1;
}

static int
colortostring(lua_State *L) {
	struct Color *color = (struct Color *)luaL_checkudata(L,1,"Color");
	lua_pushfstring(L,"Color:{%d,%d,%d}",color->r,color->g,color->b);
	return 1;
}

LUA_API int 
luaopen_tool(lua_State *L) {
	if(!luaL_newmetatable(L,"Color")) 
		luaL_error(L,"metatable Color register failed!");
	lua_pushcfunction(L,colortostring);
	lua_setfield(L,-2,"__tostring");
	
	if(!luaL_newmetatable(L,"Size"))
		luaL_error(L,"metatable Size register failed!");
	
	lua_pop(L,2);
	
	lua_register(L,"Color",newcolor);
	lua_register(L,"Size",newsize);
	return 0;
}
