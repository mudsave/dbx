
#ifndef __LUAUTILS_H
#define __LUAUTILS_H

#include "lua.hpp"
#include "admin.h"

int pushRequest(lua_State* L, MsgRequest* con, int id);
int onResponse(lua_State* L);
int pushFunc(lua_State* L);

#endif
