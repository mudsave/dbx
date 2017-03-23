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
    static int sendToPeer(lua_State* pState);
    static int sendToWorld(lua_State* pState);
    static int bcToWorldPeers(lua_State* pState);
    static int sendToAround(lua_State* pState);
	static int sendToAdmin(lua_State* L);

public:
    static void onReceive(AppMsg* msg);
    static void onWorldReceive(AppMsg* msg);
	static void onAdminReceive(AppMsg* pMsg);

private:
    static int toluaRPCOpen(lua_State* pState);
    static AppMsg* genRPC(lua_State *L, int offset);
    static void parseRPC(lua_State *L, ByteBuffer& buffer, int index);
    static bool pushluafunction(lua_State* pLuaState, const char* szFunName);
    static void savemap(lua_State *L, ByteBuffer &buffer, int idx);
    static void resumemap(lua_State *L, ByteBuffer &buffer);

private:
    static int _rpc_ref;
    static int _wrpc_ref;
    static int _arpc_ref;
    static int _debug_ref;
    static ByteBuffer _s_buffer;
    static lua_State* m_pLuaState;
	static bool error;
};

#endif
