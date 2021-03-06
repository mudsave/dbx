/**
 * filename : RPCEngine.h
 * desc : RPC
 */
#ifndef __REMOTINGENGINE_H
#define __REMOTINGENGINE_H

#include "vsdef.h"
#include "lua.hpp"
#include "bytebuffer.h"

class RPCEngine
{
public:
    static void init(lua_State* L);
public:
	static int sendToWorld(lua_State* pState);

public:
    static void onAdminReceive(AppMsg* msg);

private:
    static int toluaRPCOpen(lua_State* pState);
    static AppMsg* genRPC(lua_State *L, int offset);
    static void parseRPC(lua_State *L, ByteBuffer& buffer, int index);
    static bool pushluafunction(lua_State* pLuaState, const char* szFunName);
    static void savemap(lua_State *L, ByteBuffer &buffer, int idx);
    static void resumemap(lua_State *L, ByteBuffer &buffer);

private:
    static int _rpc_ref;
    static int _debug_ref;
    static ByteBuffer _s_buffer;
    static lua_State* m_pLuaState;
};

#endif
