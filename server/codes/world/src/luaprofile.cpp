#include "lua.hpp"

#define ProfileSpace "profile.0.1"

#include "lindef.h"
#define GetTick() (times(NULL))
#define PERSECOND (1000 / sysconf(_SC_CLK_TCK))

#define CALLFRAMES	1
#define SLOTFRAMES	2
#define CALLTIMES	3
#define DURATION	4
#define INFO		5

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
	if( !lua_getinfo(L,"f",ar) ) {
		// 严重错误
		return;
	}

	if( LUA_HOOKCALL == ar->event ) {
		const void *pfunc = lua_topointer(L,-1);
		int index;

		// 将函数指针压入调用堆栈
		lua_rawgeti(L,space,CALLFRAMES);
		index = lua_objlen(L,-1) + 1;
		lua_pushlightuserdata(L,(void *)pfunc);
		lua_rawseti(L,-2,index);
		lua_pop(L,1);

		// 将调用时间戳压入时间堆栈
		lua_rawgeti(L,space,SLOTFRAMES);
		index = lua_objlen(L,-1) + 1;
		lua_pushinteger(L,GetTick());
		lua_rawseti(L,-2,index);
		lua_pop(L,1);

		// 取得函数的信息
		lua_rawgeti(L,space,INFO);
		lua_pushlightuserdata(L,(void *)pfunc);
		lua_rawget(L,-2);
		if(lua_isnil(L,-1)) {
			lua_pop(L,1);
			if( !lua_getinfo(L,"Sn",ar)) {
				// 严重错误
				return;
			}
			lua_pushlightuserdata(L,(void *)pfunc);
			lua_createtable(L,3,0);
			{
				lua_pushstring(L,ar->name);
				lua_rawseti(L,-2,1);
				lua_pushstring(L,ar->source);
				lua_rawseti(L,-2,2);
				lua_pushinteger(L,ar->linedefined);
				lua_rawseti(L,-2,3);
			}
			lua_rawset(L,-3);
		} else {
			lua_pop(L,1);
		}
		lua_pop(L,1);

		// 调用次数 + 1
		lua_rawgeti(L,space,CALLTIMES);
		lua_pushlightuserdata(L,(void *)pfunc);
		lua_rawget(L,-2);
		lua_pushlightuserdata(L,(void *)pfunc);
		lua_pushinteger(L,lua_tointeger(L,-2)+1);
		lua_rawset(L,-4);
		lua_pop(L,2);
	} else if(LUA_HOOKTAILRET == ar->event) {
		int index;
		const void *pfunc;
		long duration;

		lua_rawgeti(L,space,CALLFRAMES);
		index = lua_objlen(L,-1);
		lua_rawgeti(L,-1,index);
		pfunc = lua_touserdata(L,-1);
		lua_pop(L,1);
		// 从栈顶移除函数指针
		lua_pushnil(L);
		lua_rawseti(L,-2,index);
		lua_pop(L,1);

		lua_rawgeti(L,space,SLOTFRAMES);
		// 计算用时
		index = lua_objlen(L,-1);
		lua_rawgeti(L,-1,index);
		duration = GetTick() - lua_tointeger(L,-1);
		lua_pop(L,1);
		// 从时间戳栈顶移除记录
		lua_pushnil(L);
		lua_rawseti(L,-2,index);
		lua_pop(L,1);

		// 将总时间加上
		lua_rawgeti(L,space,DURATION);
		lua_pushlightuserdata(L,(void *)pfunc);
		lua_rawget(L,-2);
		lua_pushlightuserdata(L,(void *)pfunc);
		lua_pushinteger(L,lua_tointeger(L,-2) + duration);
		lua_rawset(L,-4);
		lua_pop(L,2);
	} else if(LUA_HOOKRET == ar->event) {
		const void *pfunc;
		long duration;
		int index;

		lua_rawgeti(L,space,CALLFRAMES);
		// 从调用堆栈栈顶取得函数指针
		index = lua_objlen(L,-1);
		if(index) {
			lua_rawgeti(L,-1,index);
			pfunc = lua_touserdata(L,-1);
			lua_pop(L,1);

			lua_pushnil(L);
			lua_rawseti(L,-2,index);

			lua_rawgeti(L,space,SLOTFRAMES);
			index = lua_objlen(L,-1);
			lua_rawgeti(L,-1,index);
			duration = GetTick() - lua_tointeger(L,-1);
			lua_pop(L,1);
			lua_pushnil(L);
			lua_rawseti(L,-2,index);
			lua_pop(L,1);

			lua_rawgeti(L,space,DURATION);
			lua_pushlightuserdata(L,(void *)pfunc);
			lua_rawget(L,-2);
			lua_pushlightuserdata(L,(void *)pfunc);
			lua_pushinteger(L,lua_tointeger(L,-2) + duration);
			lua_rawset(L,-4);
			lua_pop(L,1);
		}
		lua_pop(L,1);
	}
	lua_pop(L,1);
	lua_remove(L,space);
}

static int 
profile_start(lua_State *L) {
	int space = profile_space(L);

	do {
		int index;
		lua_pushliteral(L,"running");
		lua_rawget(L,space);
		if(lua_toboolean(L,-1)) {
			lua_pop(L,1);	// 只能开启一个监听
			break;
		}
		lua_pop(L,1);
		lua_pushliteral(L,"running");
		lua_pushboolean(L,1);
		lua_rawset(L,space);

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
	int runnging;

	lua_pushliteral(L,"running");
	lua_rawget(L,space);
	runnging = lua_toboolean(L,-1);
	lua_pop(L,1);
	if(runnging) {
		int index = 0;
		int ret = (lua_newtable(L),lua_gettop(L));
		int info = (lua_rawgeti(L,space,INFO),lua_gettop(L));
		int calltimes = (lua_rawgeti(L,space,CALLTIMES),lua_gettop(L));
		int duration = (lua_rawgeti(L,space,DURATION),lua_gettop(L));

		lua_pushnil(L);
		while(lua_next(L,info)) {
			lua_createtable(L,3,0);

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

			lua_rawseti(L,ret,++index);

			lua_pop(L,1);
		}
		lua_pop(L,3);
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
			return 0;
		}
		fprintf(file,"%s,%s,%s,%s,%s,%s\n","函数名称","来源","定义行","调用次数","总时间","平均用时");
		lua_pushnil(L);
		while(lua_next(L,1)) {
			int value = lua_gettop(L);
			const char *funcName = (lua_rawgeti(L,value,1),lua_tostring(L,-1));
			const char *source = (lua_rawgeti(L,value,2),lua_tostring(L,-1));
			int linedefined = (lua_rawgeti(L,value,3),lua_tointeger(L,-1));
			int calltimes = (lua_rawgeti(L,value,4),lua_tointeger(L,-1));
			long total = (lua_rawgeti(L,value,5),lua_tointeger(L,-1));
			long avg = (total) / calltimes;

			fprintf(file,"%s,\"%s\",%d,%d,%d,%d\n",funcName,source,linedefined,calltimes,total,avg);

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

