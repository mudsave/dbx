

#ifndef _LuaApi_H
#define _LuaApi_H
extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}
#include <string.h>
#include "DBClient.h"
#include "DBShare.h"

// LUA_TNIL
// LUA_TNUMBER
// LUA_TBOOLEAN
// LUA_TSTRING
// LUA_TTABLE
// LUA_TFUNCTION
// LUA_TUSERDATA
// LUA_TTHREAD
// LUA_TLIGHTUSERDATA


int mysql_query(lua_State* pState);

class CLuaDB:public IDBCallback{
public:
	void do_return(DBResult*);
	int set_state(lua_State*);

	lua_State* m_lua_state;
};

extern CLuaDB g_luaDB;

#endif

