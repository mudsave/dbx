#include "lua.hpp"
#include "lindef.h"

#define absindex(L,index,offset) ((index>0||index<=LUA_REGISTRYINDEX)?index:lua_gettop(L)+index+1+offset)
#define lua_rawgetp(L,t,p) (lua_pushlightuserdata(L,p),lua_rawget(L,absindex(L,t,-1)))
#define lua_rawsetp(L,t,p) (lua_pushlightuserdata(L,p),lua_insert(L,-2),lua_rawset(L,absindex(L,t,-1)))
#define lua_append(L,t) (lua_rawseti(L,t,lua_objlen(L,t) + 1))
#define lua_popend(L,t) {int index=absindex(L,t,0);lua_pushnil(L);lua_rawseti(L,index,lua_objlen(L,index));}
#define lua_getend(L,t) (lua_rawgeti(L,t,lua_objlen(L,t)))

#define ProfileSpace "profile.0.1"

static struct timeval profile_tv;
#define GetTimeTick() (gettimeofday(&profile_tv,0),(profile_tv.tv_sec%(24*60*60))*1000000+profile_tv.tv_usec)

#define CALLFRAMES	1		// A stack that holds address of active functions
#define SLOTFRAMES	2		// A stack that holds time slot when a active function been called
#define CALLTIMES	3		// Total times count what a function got called
#define DURATION	4		// Total duration what a function consumed
#define MINC		5		// 
#define MAXC		6		// 
#define INFO		7		// Function basic information 

// I suppose all of this matters would come to their end one day

static int
profile_space(lua_State *L) {
	lua_pushliteral(L,ProfileSpace);
	lua_rawget(L,LUA_REGISTRYINDEX);
	if(!lua_istable(L,-1)) {
		lua_pop(L,1);
		lua_newtable(L);
		lua_pushliteral(L,ProfileSpace);
		lua_pushvalue(L,-2);
		lua_rawset(L,LUA_REGISTRYINDEX);
	}
	return lua_gettop(L);
}

static void
hook_func(lua_State *L,lua_Debug *ar) {
	int space = profile_space(L);

	if( LUA_HOOKCALL == ar->event ) {
		const void *pfunc = NULL;
		lua_getinfo(L,"fSn",ar);
		pfunc = lua_topointer(L,-1);

		// keep current's function'address in the stack top
		lua_rawgeti(L,space,CALLFRAMES);
		lua_pushlightuserdata(L,(void *)pfunc);
		lua_append(L,-2);
		lua_pop(L,1);

		// Keep this moment	
		lua_rawgeti(L,space,SLOTFRAMES);
		lua_pushinteger(L,GetTimeTick());
		lua_append(L,-2);
		lua_pop(L,1);

		// Perhaps I should keep its context for further use	

		// Keep something abount me 
		lua_rawgeti(L,space,INFO);
		lua_rawgetp(L,-1,(void *)pfunc);	
		if(lua_isnil(L,-1)) {
			lua_createtable(L,3,0);
			{
				lua_pushstring(L,ar->name);
				lua_rawseti(L,-2,1);
				lua_pushstring(L,ar->source);
				lua_rawseti(L,-2,2);
				lua_pushinteger(L,ar->linedefined);
				lua_rawseti(L,-2,3);
			}
			lua_rawsetp(L,-3,(void *)pfunc);
		}
		lua_pop(L,2);

		// Call times plus 1
		lua_rawgeti(L,space,CALLTIMES);
		lua_rawgetp(L,-1,(void *)pfunc);
		lua_pushinteger(L,lua_isnumber(L,-1)?lua_tointeger(L,-1)+1:1);
		lua_rawsetp(L,-3,(void *)pfunc);
		lua_pop(L,2);

		lua_pop(L,1);
	} else if(LUA_HOOKTAILRET == ar->event || LUA_HOOKRET == ar->event) {
		const void *pfunc;

		// what to identity myself
		lua_rawgeti(L,space,CALLFRAMES);
		lua_getend(L,-1);
		if(!lua_isuserdata(L,-1)) {
			lua_pop(L,2);
		} else {
			pfunc = lua_touserdata(L,-1);
			lua_popend(L,-2);
			lua_pop(L,2);
	
			lua_rawgeti(L,space,SLOTFRAMES);
			lua_getend(L,-1);
			{
				long duration = GetTimeTick() - lua_tointeger(L,-1);
	
				// Count it up that how long we moved
				lua_rawgeti(L,space,DURATION);
				lua_rawgetp(L,-1,(void *)pfunc);
				lua_pushinteger(L,lua_isnumber(L,-1)?lua_tointeger(L,-1)+duration:duration);
				lua_rawsetp(L,-3,(void *)pfunc);
				lua_pop(L,2);
	
				// Compare and choose the minumum
				lua_rawgeti(L,space,MINC);
				lua_rawgetp(L,-1,(void *)pfunc);
				if(lua_isnil(L,-1) || lua_tointeger(L,-1) > duration) {
					lua_pushinteger(L,duration);
					lua_rawsetp(L,-3,(void *)pfunc);
				}
				lua_pop(L,2);
	
				// Compare and choose the maximum
				lua_rawgeti(L,space,MAXC);
				lua_rawgetp(L,-1,(void *)pfunc);
				if(lua_isnil(L,-1) || lua_tointeger(L,-1) < duration) {
					lua_pushinteger(L,duration);
					lua_rawsetp(L,-3,(void *)pfunc);
				}
				lua_pop(L,2);
			}
			lua_popend(L,-2);
			lua_pop(L,2);
		}
	}
	if(space != lua_gettop(L)) {
		puts("堆栈泄漏");
	}
	lua_remove(L,space);
}

static int 
profile_start(lua_State *L) {
	int space = profile_space(L);

	do {
		int index;
		lua_getfield(L,space,"runngin");
		if(lua_toboolean(L,-1)) {
			lua_pop(L,1);	// you can but start one profile
			break;
		}
		lua_pop(L,1);
		lua_pushboolean(L,1);
		lua_setfield(L,space,"runngin");

		for(index=0;index<INFO;index++) {
			lua_newtable(L);
			lua_rawseti(L,space,index+1);
		}

		lua_sethook(L,hook_func,LUA_MASKCALL | LUA_MASKRET,0);
	} while(0);
	lua_remove(L,space);

	return 0;
}

static int
profile_stop(lua_State *L) {
	int space = profile_space(L);
	int runngin;

	lua_getfield(L,space,"runngin");
	runngin = lua_toboolean(L,-1);
	lua_pop(L,1);
	if(runngin) {
		int index = 0;
		int ret = (lua_newtable(L),lua_gettop(L));
		int info = (lua_rawgeti(L,space,INFO),lua_gettop(L));
		int calltimes = (lua_rawgeti(L,space,CALLTIMES),lua_gettop(L));
		int duration = (lua_rawgeti(L,space,DURATION),lua_gettop(L));
		int minc = (lua_rawgeti(L,space,MINC),lua_gettop(L));
		int maxc = (lua_rawgeti(L,space,MAXC),lua_gettop(L)); 

		lua_pushnil(L);
		while(lua_next(L,info)) {
			lua_createtable(L,7,0);

			lua_rawgeti(L,-2,1);
			lua_rawseti(L,-2,1);

			lua_rawgeti(L,-2,2);
			lua_rawseti(L,-2,2);

			lua_rawgeti(L,-2,3);
			lua_rawseti(L,-2,3);

			lua_pushvalue(L,-3);
			lua_rawget(L,calltimes);
			lua_rawseti(L,-2,4);

			lua_pushvalue(L,-3);
			lua_rawget(L,duration);
			lua_rawseti(L,-2,5);

			lua_pushvalue(L,-3);
			lua_rawget(L,minc);
			lua_rawseti(L,-2,6);

			lua_pushvalue(L,-3);
			lua_rawget(L,maxc);
			lua_rawseti(L,-2,7);

			lua_rawseti(L,ret,++index);
			lua_pop(L,1);
		}
		lua_pop(L,5);
	} else {
		lua_pushnil(L);
	}

	lua_remove(L,space);
	lua_sethook(L,NULL,0,0);
	return 1;
}


static int
profile_dump(lua_State *L) {
	if(!lua_istable(L,1)) {
		luaL_error(L,"#1 exepected a table,got an %s",lua_typename(L,lua_type(L,1)));
	}
	if(lua_isstring(L,2)) {
		FILE *file = fopen(lua_tostring(L,2),"w");
		if(!file) {
			luaL_error(L,"could not open file %s",lua_tostring(L,2));
		}
		fprintf(file,"%s,%s,%s,%s,%s,%s,%s,%s\n","Function","Source","LineDefine","Calls","Total","AVG","MIN","MAX");
		lua_pushnil(L);
		while(lua_next(L,1)) {
			int value = lua_gettop(L);
			const char *funcName = (lua_rawgeti(L,value,1),lua_tostring(L,-1));
			const char *source = (lua_rawgeti(L,value,2),lua_tostring(L,-1));
			int linedefined = (lua_rawgeti(L,value,3),lua_tointeger(L,-1));
			int calltimes = (lua_rawgeti(L,value,4),lua_tointeger(L,-1));
			int total = (lua_rawgeti(L,value,5),lua_tointeger(L,-1));
			int min = (lua_rawgeti(L,value,6),lua_tointeger(L,-1));
			int max = (lua_rawgeti(L,value,7),lua_tointeger(L,-1));
			int avg = (total) / calltimes;

			fprintf(file,"%s,\"%s\",%d,%d,%d,%d,%d,%d\n",funcName,source,linedefined,calltimes,total,avg,min,max);

			lua_settop(L,value - 1);
		}
		fclose(file);
	}
	return 0;
}

static const luaL_Reg profilelib[] = {
	{"start",profile_start},
	{"stop",profile_stop},
	{"dump",profile_dump},
	{NULL,NULL},
};

LUA_API int
luaopen_profile(lua_State *L) {
	luaL_register(L,"profile",profilelib);
	return 1;
}

