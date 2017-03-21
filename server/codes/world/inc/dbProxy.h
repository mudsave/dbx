#ifndef __DBPROXY_H_
#define __DBPROXY_H_

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "IDBAClient.h"
#include "Client.h"
#include "lua.hpp"
#include "tolua++.h"
#include "LuaEngine.h"
#include "LuaFunctor.h"
#include "LuaArray.h"

#define	 MAXRESNUM 100

class CDBProxy :public IDBANetEvent
{
public:
	static int init(const char* dbIp, int dbPort, lua_State* pState);
	static bool release();
	static int callSP(lua_State* pState);
	static int toluaCDBProxyOpen(lua_State* pState);
public:
	void onExeDBProc(int id,IInitClient* pInitClient,bool result);
private:
	static IInitClient* s_pDBAClient;
	static CDBProxy* s_pDBProxy;
	static lua_State* s_pLuaState;
	CDBProxy(){};
};


#endif
