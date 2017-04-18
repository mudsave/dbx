#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
#include "lobject.h"
#include "lstate.h"
#include <sys/time.h>

#define _CDEBUG 
#define TableSize 1024

static struct timeval stv;
#define GetTimeTick() (gettimeofday(&stv,0),stv.tv_sec*1000 + stv.tv_usec/1000)	// millisecond 

static void *state_key = &state_key;
static void *what_key = &what_key;
static void *slot_key = &slot_key;

LUAI_FUNC void
luac_addrecord(lua_State *L,StkId v) {
	lua_pushlightuserdata(L,state_key);
	lua_rawget(L,LUA_REGISTRYINDEX);
	if(!lua_toboolean(L,-1)) {
		lua_pop(L,1);
		return;
	} else {
		#ifdef _CDEBUG
		int top = lua_gettop(L) - 1;
		#endif
		lua_pop(L,1);
		lua_assert(v->tt == LUA_TTABLE || v->tt == LUA_TUSERDATA);
		
		// push table
		lua_lock(L);
		//sethvalue(L, L->top,tb);
		*L->top = *v;
		{api_check(L, L->top < L->ci->top); L->top++;}
		lua_unlock(L);
		
		// get `what` table
		lua_pushlightuserdata(L,what_key);
		lua_rawget(L,LUA_REGISTRYINDEX); 
		
		lua_pushvalue(L,-2);

		// push call information
		do {
			int level=0;
			int str=0;
			lua_Debug ar;
			while(lua_getstack(L,level++,&ar) && str < 5) {
				lua_getinfo(L,"nSl",&ar);
				if(*ar.what == 'm')
					lua_pushliteral(L,"\tin main chunk");
				else if(*ar.what == 'C' || *ar.what == 't')
					continue;
				else
					lua_pushfstring(L,"\t%s:%d",ar.short_src,ar.currentline);
				str++;
			}
			lua_concat(L,str);
		} while(0);

		// what[table] = string
		lua_rawset(L,-3);

		// get `slot` table
		lua_pushlightuserdata(L,slot_key);
		lua_rawget(L,LUA_REGISTRYINDEX);
		
		lua_pushvalue(L,-3);
		lua_pushinteger(L,GetTimeTick());
		lua_rawset(L,-3);
		lua_pop(L,3);

		#ifdef _CDEBUG
		if(top != lua_gettop(L)) {
			fprintf(stderr,"stack unbalanced in  %s prev:%d now:%d\n",__FUNCTION__,top,lua_gettop(L));
		}
		#endif
	}
}

static int
start(lua_State *L) {
	lua_pushlightuserdata(L,state_key);
	lua_rawget(L,LUA_REGISTRYINDEX);
	if(lua_toboolean(L,-1)) {
		lua_pop(L,1);
		// push return value false
		lua_pushboolean(L,0);
	} else {
		#ifdef _CDEBUG
		int top = lua_gettop(L) - 1;
		#endif
		// pop state
		lua_pop(L,1);
		
		// this is an metatable of weak key
		lua_createtable(L,0,1);
		lua_pushstring(L,"k");
		lua_setfield(L,-2,"__mode");

		// create a weak key table to keep where a table got created
		lua_createtable(L,0,TableSize);
		lua_pushvalue(L,-2);
		lua_setmetatable(L,-2);

		// save that table in registry with this lud key
		lua_pushlightuserdata(L,what_key);
		lua_insert(L,-2);
		lua_rawset(L,LUA_REGISTRYINDEX);

		// create a weak key table to keep when a table got created
		lua_createtable(L,0,TableSize);
		lua_pushvalue(L,-2);
		lua_setmetatable(L,-2);

		// keep this table in registry
		lua_pushlightuserdata(L,slot_key);
		lua_insert(L,-2);
		lua_rawset(L,LUA_REGISTRYINDEX);

		// pop metatable
		lua_pop(L,1);

		lua_pushlightuserdata(L,state_key);
		lua_pushboolean(L,1);
		lua_rawset(L,LUA_REGISTRYINDEX);

		#ifdef _CDEBUG
		if(top != lua_gettop(L)) {
			fprintf(stderr,"stack unbalanced in  %s prev:%d now:%d\n",__FUNCTION__,top,lua_gettop(L));
		}
		#endif

		// push return value current time slot
		lua_pushinteger(L,GetTimeTick());
	}
	// it hints that this function got 1 return value
	return 1;
}

static int
stop(lua_State *L) {
	lua_pushlightuserdata(L,state_key);
	lua_rawget(L,LUA_REGISTRYINDEX);
	if(lua_isnil(L,-1)) {
		// not running
		lua_pop(L,1);
		// return false
		lua_pushboolean(L,0);
	} else {
		lua_pop(L,1);

		// make running = false
		lua_pushlightuserdata(L,state_key);
		lua_pushnil(L);
		lua_rawset(L,LUA_REGISTRYINDEX);

		// make what = nil
		lua_pushlightuserdata(L,what_key);
		lua_pushnil(L);
		lua_rawset(L,LUA_REGISTRYINDEX);
		
		// make slot = nil
		lua_pushlightuserdata(L,slot_key);
		lua_pushnil(L);
		lua_rawset(L,LUA_REGISTRYINDEX);
	
		// return true
		lua_pushboolean(L,1);
	}	
	return 1;
}

static int
pause(lua_State *L) {
	// is running?
	lua_pushlightuserdata(L,state_key);
	lua_rawget(L,LUA_REGISTRYINDEX);
	if(lua_toboolean(L,-1)) {
		// pop running
		lua_pop(L,1);
		
		// set running = false
		lua_pushlightuserdata(L,state_key);
		lua_pushboolean(L,0);
		lua_rawset(L,LUA_REGISTRYINDEX);

		// push return value present time slot
		lua_pushinteger(L,GetTimeTick());

		return 1;
	}
	// pop running and return false
	lua_pop(L,1);
	lua_pushboolean(L,0);
	return 1;
}

static int 
resume(lua_State *L) {
	lua_pushlightuserdata(L,state_key);
	lua_rawget(L,LUA_REGISTRYINDEX);
	if(!lua_isnil(L,-1) && !lua_toboolean(L,-1)) {
		lua_pushlightuserdata(L,state_key);
		lua_pushboolean(L,1);
		lua_rawset(L,LUA_REGISTRYINDEX);
	}
	lua_pop(L,1);
	lua_pushinteger(L,GetTimeTick());
	return 1;
}

static int 
get_result(lua_State *L) {
	lua_pushlightuserdata(L,what_key);
	lua_rawget(L,LUA_REGISTRYINDEX);
	lua_pushlightuserdata(L,slot_key);
	lua_rawget(L,LUA_REGISTRYINDEX);
	return 2;
}

static struct luaL_Reg libfuncs[] = {
	{"start",start},
	{"stop",stop},
	{"pause",pause},
	{"resume",resume},
	{"getresult",get_result},
	{NULL,NULL},
};

LUALIB_API int
luaopen_collect(lua_State *L) {
	luaL_register(L,"luacollect",libfuncs);
	return 1;
}
