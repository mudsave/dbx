/**
 * filename : RPCEngine.cpp
 * desc : RPC
 */
#include "lindef.h"
#include "RPCEngine.h"
#include "world.h"
#include "Entity.h"

int RPCEngine::_rpc_ref;
int RPCEngine::_wrpc_ref;
ByteBuffer RPCEngine::_s_buffer;
lua_State* RPCEngine::m_pLuaState;

void RPCEngine::init(lua_State* L)
{
    m_pLuaState = L;
    _rpc_ref = 0;
    _wrpc_ref = 0;
    ASSERT_(pushluafunction(L, "RemoteEventProxy.receive"));
    _rpc_ref = luaL_ref(L, LUA_REGISTRYINDEX);
    ASSERT_(pushluafunction(L, "RemoteEventProxy.wreceive"));
    _wrpc_ref = luaL_ref(L, LUA_REGISTRYINDEX);
    toluaRPCOpen(L);
}

int RPCEngine::sendToPeer(lua_State* L)
{
    handle playerID = (handle)luaL_checknumber(L, 2);
    CoEntity* entity = _EntityFromHandle(playerID);
    AppMsg* msg = genRPC(L);
    g_world.sendMsgToPeer(entity->m_gatewayLink, entity->m_clientLink, msg);
    return 0;
}

int RPCEngine::sendToWorld(lua_State* L)
{
    short worldID = (short)luaL_checknumber(L, 2);
    AppMsg* msg = genRPC(L);
    g_world.sendMsgToWorld(worldID, msg);
    return 0;
}

int RPCEngine::bcToWorldPeers(lua_State* L)
{
    //short worldID = (short)luaL_checknumber(L, 1);
    return 0;
}
int RPCEngine::sendToAround(lua_State* L)
{
    //handle playerID = (handle)luaL_checknumber(L, 1);
    return 0;
}

void RPCEngine::onReceive(AppMsg* pMsg)
{
    lua_State* L = m_pLuaState;
    int _head_size = sizeof(AppMsg);
    _s_buffer.clear();
    _s_buffer.append((char*)pMsg + _head_size, pMsg->msgLen - _head_size);
    parseRPC(L, _s_buffer, _rpc_ref);
}

void RPCEngine::onWorldReceive(AppMsg* pMsg)
{
    lua_State* L = m_pLuaState;
    int _head_size = sizeof(AppMsg);
    _s_buffer.clear();
    _s_buffer.append((char*)pMsg + _head_size, pMsg->msgLen - _head_size);
    parseRPC(L, _s_buffer, _wrpc_ref);

}

int RPCEngine::toluaRPCOpen(lua_State* pState)
{
    tolua_open(pState);
	tolua_usertype(pState,"RPCEngine");
	tolua_module(pState, NULL, 0);
	tolua_beginmodule(pState, NULL);
	tolua_cclass(pState,"RPCEngine", "RPCEngine", "", NULL);
	tolua_beginmodule(pState, "RPCEngine");
	tolua_function(pState, "sendToPeer", sendToPeer);
	tolua_function(pState, "sendToWorld", sendToWorld);
	tolua_function(pState, "bcToWorldPeers", bcToWorldPeers);
	tolua_function(pState, "sendToAround", sendToAround);
	tolua_endmodule(pState);
	tolua_endmodule(pState);
	return 1;
}

AppMsg* RPCEngine::genRPC(lua_State *L)
{
    ByteBuffer& buffer = _s_buffer;
	buffer.clear();
	static AppMsg rpcHead;
	buffer.append((char*)&rpcHead, sizeof(rpcHead));

    int top = lua_gettop(L);
	int nEventID = (int) luaL_checknumber(L, 3);
	int nSrcID = (int) luaL_checknumber(L, 4);
	buffer << nEventID << nSrcID;
	buffer << top - 4;

    lua_Number nValue;
	size_t sLen;
	const char *sValue;
	for(int i = 5; i <= top ; i++)
    {
		switch(lua_type(L, i))
        {
			case LUA_TBOOLEAN:
				buffer << (char)LUA_TBOOLEAN;
				buffer << (char)lua_toboolean(L, i);
				break;
			case LUA_TNUMBER:
				buffer << (char)LUA_TNUMBER;
				nValue = lua_tonumber(L, i);
				buffer << (long long)nValue;
				break;
			case LUA_TSTRING:
				sValue = lua_tolstring(L, i, &sLen);
				buffer << (char)LUA_TSTRING;
				buffer << (int)sLen;
				buffer.append(sValue, sLen);
				break;
			case LUA_TTABLE:
				buffer << (char)LUA_TTABLE;
				savemap(L, buffer, i);
				break;
			default:
				buffer << (char)LUA_TNIL;
				break;
		}
	}
    AppMsg* pMsg = (AppMsg*)buffer.contents();
    pMsg->msgCls = MSG_CLS_SCENE_RPC;
    pMsg->msgFlags = 0;
    pMsg->msgId = 0;
    pMsg->context = g_world.getWorldId();
	pMsg->msgLen = buffer.size();
    return pMsg;
}

void RPCEngine::parseRPC(lua_State *L, ByteBuffer& buffer, int index)
{
    int top = lua_gettop(L);
    lua_rawgeti(L, LUA_REGISTRYINDEX, index);
    int nEventID = 0;
    int nSrcID = 0;
    int nCount = 0;
    buffer >> nEventID >> nSrcID >> nCount;
    lua_pushnumber(L, nEventID);
    lua_pushnumber(L, nSrcID);

    int idx = 0;
    char type = 0;
    char bValue = 0;
    long long numValue = 0;
    int strLen = 0;
    int strPos = 0;
    const char* startPos = (const char*)buffer.contents();
    for(; idx < nCount; idx++)
    {
        buffer >> type;
        switch (type) {
            case LUA_TBOOLEAN:
                buffer >> bValue;
                lua_pushboolean(L, bValue);
                break;
            case LUA_TNUMBER:
                buffer >> numValue;
                lua_pushnumber(L, (lua_Number)numValue);
                break;
            case LUA_TSTRING:
                buffer >> strLen;
                strPos = buffer.rpos();
                lua_pushlstring(L, (const char*)(startPos + strPos), strLen);
                buffer.rpos(strPos + strLen);
                break;
            case LUA_TTABLE:
                resumemap(L, buffer);
                break;
            default:
                lua_pushnil(L);
                break;
        }
    }
    int rt = lua_pcall(L, nCount + 2, 0, 0);
    if (rt)
    {
        const char* errMsg = luaL_checkstring(L, -1);
        TRACE2_L0("[RPCEngine::parseRPC] RPC PARSE ERROR error No:%d, error Msg:%s\n",
        rt, errMsg);
    }
    lua_settop(L, top);
}

bool RPCEngine::pushluafunction(lua_State* pLuaState, const char* szFunName)
{
	int top = lua_gettop(pLuaState);
	std::string handler_name(szFunName);
	std::string::size_type i = handler_name.find_first_of('.');
	if (i == std::string::npos) {
		lua_getglobal(pLuaState, szFunName);
	} else {
		std::vector<std::string> parts;
		std::string::size_type start = 0;
		do {
			parts.push_back(handler_name.substr(start,i-start));
			start = i+1;
			i = handler_name.find_first_of('.', start);
		} while (i!=std::string::npos);

		parts.push_back(handler_name.substr(start));
		lua_getglobal(pLuaState, parts[0].c_str());
		if (!lua_istable(pLuaState, -1)) {
			lua_settop(pLuaState, top);
			TRACE1_L0("[RPCEngine] ' %s ' invalid function name\n", szFunName);
			return false;
		}
		std::vector<std::string>::size_type visz = parts.size();
		if (visz-- > 2) {
			std::vector<std::string>::size_type vi = 1;
			while (vi<visz) {
				lua_pushstring(pLuaState,parts[vi].c_str());
				lua_gettable(pLuaState, -2);
				if (!lua_istable(pLuaState, -1)) {
					lua_settop(pLuaState, top);
					TRACE1_L0("[RPCEngine] ' %s ' invalid function name\n", szFunName);
					return false;
				}
				lua_remove(pLuaState, -2);
				vi++;
			}
		}
		lua_pushstring(pLuaState,parts[visz].c_str());
		lua_gettable(pLuaState, -2);
		lua_remove(pLuaState, -2);
	}
	if (!lua_isfunction(pLuaState, -1)) {
		lua_settop(pLuaState, top);
		TRACE1_L0("[RPCEngine] ' %s ' invalid function name\n", szFunName);
		return false;
	}
    return true;
}

void RPCEngine::savemap(lua_State *L, ByteBuffer &buffer, int idx)
{
	int count = 0;
	int nPosCount = buffer.wpos();
	buffer << count;
	lua_pushvalue(L, idx);
	lua_pushnil(L);

	while(lua_next(L, -2)){
		lua_Number nValue;
		const char *sValue;
		size_t sLen;
		int kType = lua_type(L, -2);
		if(kType == LUA_TNUMBER){
			nValue = lua_tonumber(L, -2);
			buffer << (char)LUA_TNUMBER;
			buffer << (long long)nValue;
		}else if(kType == LUA_TSTRING){
			sValue = lua_tolstring(L, -2, &sLen);
			buffer << (char)LUA_TSTRING;
			buffer << (int)sLen;
			buffer.append((const char*)sValue, sLen);
		}else{
			lua_pop(L, 1);
			continue;
		}
		switch(lua_type(L, -1)){
			case LUA_TBOOLEAN:
				buffer << (char)LUA_TBOOLEAN;
				buffer << (char)lua_toboolean(L, -1);
				break;
			case LUA_TNUMBER:
				nValue = lua_tonumber(L, -1);
				buffer << (char)LUA_TNUMBER;
				buffer << (long long)nValue;
				break;
			case LUA_TSTRING:
				sValue = lua_tolstring(L, -1, &sLen);
				buffer << (char)LUA_TSTRING;
				buffer << (int)sLen;
				buffer.append((const char*)sValue, sLen);
				break;
			case LUA_TTABLE:
				buffer << (char)LUA_TTABLE;
				savemap(L, buffer, -1);
				break;
			default:
				buffer << (char)LUA_TNIL;
				break;
		}
		lua_pop(L,1);
		count ++;
	}
	lua_pop(L,1);
	int *pCount = (int *)(nPosCount + buffer.contents());
	*pCount = count;
}

void RPCEngine::resumemap(lua_State *L, ByteBuffer &buffer)
{
	int nTSize;
	buffer >> nTSize;
	lua_createtable(L, 0, nTSize);
	for(int i = 0; i < nTSize; i++){
		char nType;
		char bValue;
		int nStrLen;
		int nStrStart;
		long long nKey;
		long long nValue;
		buffer >> nType;
		switch(nType){
			case LUA_TNUMBER:
				buffer >> nKey;
				lua_pushinteger(L, nKey);
				break;
			case LUA_TSTRING:
				buffer >> nStrLen;
				nStrStart = buffer.rpos();
				buffer.rpos(nStrStart + nStrLen);
				lua_pushlstring(L, (const char *)(buffer.contents() + nStrStart), nStrLen);
				break;
			default:
				break;
		}
		buffer >> nType;
		switch(nType){
			case LUA_TBOOLEAN:
				buffer >> bValue;
				lua_pushboolean(L, bValue);
				break;
			case LUA_TNUMBER:
				buffer >> nValue;
				lua_pushnumber(L, (lua_Number)nValue);
				break;
			case LUA_TSTRING:
				buffer >> nStrLen;
				nStrStart = buffer.rpos();
				buffer.rpos(nStrStart + nStrLen);
				lua_pushlstring(L, (const char *)(buffer.contents() + nStrStart), nStrLen);
				break;
			case LUA_TTABLE:
				resumemap(L, buffer);
				break;
			default:
				lua_pop(L, 1);
				break;
		}
		lua_rawset(L, -3);
	}
}
