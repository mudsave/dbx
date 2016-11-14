#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "LinkContext.h"
#include "world.h"
#include "dbProxy.h"


lua_State* CDBProxy::s_pLuaState = NULL;
IInitClient* CDBProxy::s_pDBAClient = NULL;
CDBProxy* CDBProxy::s_pDBProxy = NULL;

int CDBProxy::init(const char* dbIp, int dbPort, lua_State* pState)
{
	s_pDBProxy = new CDBProxy();
	s_pDBAClient = CreateClient(s_pDBProxy, dbIp, dbPort);
	s_pLuaState = pState;
	toluaCDBProxyOpen(s_pLuaState);
	CLuaArray::tolua_CLuaArray_open(s_pLuaState);
	return 0;
}

bool CDBProxy::release()
{
	delete s_pDBProxy;
	s_pDBProxy = NULL;
	return true;
}

int CDBProxy::callSP(lua_State* pState)
{
	CDBProxy* self = (CDBProxy*) tolua_tousertype(pState, 1, 0); unused(self);
	CLuaArray* pData = (CLuaArray*)tolua_tousertype(pState,2, 0);
	bool bNonNeedCallback = tolua_toboolean(pState, 3, 0);
	int nLevel = tolua_tonumber(pState, 4, 0);
	if ((pData) && (s_pDBAClient) && pData->getResMsg())
	{
		pData->getResMsg()->m_bNeedCallback = !bNonNeedCallback;
		pData->getResMsg()->m_nLevel = nLevel;
		int operationId = s_pDBAClient->callDBProc(pData->getResMsg());
		tolua_pushnumber(pState, operationId); 
	}
	else
	{
		tolua_pushnumber(pState, 0); 
	}
	return 1;
}

int CDBProxy::toluaCDBProxyOpen(lua_State* pState)
{
	tolua_open(pState);
	tolua_usertype(pState,"CDBProxy");
	tolua_module(pState, NULL, 0);
	tolua_beginmodule(pState, NULL);
	tolua_cclass(pState,"CDBProxy", "CDBProxy", "", NULL);
	tolua_beginmodule(pState, "CDBProxy");
	tolua_function(pState, "callSP", callSP);
	tolua_endmodule(pState);
	tolua_endmodule(pState);
	return 1;
}

void CDBProxy::onExeDBProc(int id, IInitClient* pInitClient, bool result)
{
	if (!pInitClient)
	{
		TRACE0_L0("ERROR: onExeDBProc!");
		ASSERT_(pInitClient);
		return;
	}
	int ErrorCode = 0;
	if (!result) ErrorCode = -1;
	CLuaArray* LuaArray[MAXRESNUM] = {};
	memset(LuaArray, 0, MAXRESNUM * sizeof(CLuaArray*));
	for (int j=0; j<MAXRESNUM-1; j++)
	{
		CSCResultMsg* pTemp = static_cast<CSCResultMsg*> (pInitClient->getAttributeSet(id, j));
		if (!pTemp) break;
		CLuaArray* pData = new CLuaArray(pTemp);
		LuaArray[j] = pData;
	}

	static LuaFunctor<TypeNull, int, TypeUser, int> DBReturnToLua(s_pLuaState, "ManagedApp.onExeSP");
	TypeNull _null;
	bool rt = DBReturnToLua(_null, id, TypeUser(LuaArray, "CLuaArray"), ErrorCode);
	if (!rt)
		TRACE1_L0("%s\n", DBReturnToLua.getLastError());

	pInitClient->deleteAttributeSet(id);
	for (int i=0; i<MAXRESNUM; i++)
	{
		if (LuaArray[i])
		{
			delete LuaArray[i];
			LuaArray[i] = NULL;
		}
	}
}