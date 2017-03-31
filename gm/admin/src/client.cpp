
#include "lindef.h"
#include "Sock.h"
#include "RPCEngine.h"
#include "luaUtils.h"
#include "client.h"

int CClient::Init()
{
	m_pLuaState = lua_open();
	luaL_openlibs(m_pLuaState);
	if(luaL_dofile(m_pLuaState, "script/main.lua"))
	{
		printf("Load script failed! %s\n", lua_tostring(m_pLuaState, -1));
		return -1;
	}
	lua_getglobal(m_pLuaState, "AppStart");
	lua_pcall(m_pLuaState, 0, 0, 0);
	HRESULT hr;
	m_pLinkCtrl = CreateLinkCtrl();
	m_pThreadsPool = GlobalThreadsPool();
	
	ILinkSink* pAdminSink = static_cast<IMsgLinksImpl<IID_IMsgLinksAW_C>*>(this);
	hr = m_pLinkCtrl->Connect("172.16.2.218", 30005, pAdminSink, 0);
	ASSERT_( SUCCEEDED(hr) );

	RPCEngine::init(m_pLuaState);
	pushFunc(m_pLuaState);
	return 0;
}

int CClient::Close()
{
	if(m_pLuaState)
		lua_close(m_pLuaState);
	m_pLuaState = 0;
	delete m_pAdmin;
	IMsgLinksImpl<IID_IMsgLinksAW_C>::Clear();
}

HANDLE CClient::OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType)
{
	int iPort = 0;
	char strbuf[1024] = {0};
	pPort->GetRemoteAddr(strbuf, 1024, &iPort);

	TRACE4_L2("(%i)CWorld::OnConnects(), %s( %s:%d ) comes\n", operaterId, translateLinkType(iLinkType), strbuf, iPort);

	if(iLinkType == IID_IMsgLinksAW_C)
	{
		LinkContext_Admin* pAdmin = new LinkContext_Admin(iLinkType, hLink);
		pAdmin->addr = strbuf;
		pAdmin->port = iPort;
		m_pAdmin = pAdmin;
		return pAdmin;
	}
	TRACE1_L2("--CWorld::OnConnects(), error LinkType( %s )\n", translateLinkType(iLinkType));
	return NULL;
}

void CClient::DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext)
{
	_LinkContext* pContext = (_LinkContext*)hLinkContext;
	int linkType = pContext->linkType;
	unused(linkType);
	int hLink = pContext->hLink;
	unused(hLink);
	const char* addr = pContext->addr.c_str();
	unused(addr);
	int port = pContext->port;
	unused(port);

	TRACE0_L3("CClient::DefaultMsgProc()\n");
	TRACE1_L3("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L3("\taddr = %s:%i\n", addr, port);

	if ( linkType == IID_IMsgLinksAW_C )
	{
		if(pMsg->msgCls == MSG_CLS_ADMIN_RPC)
		{
			RPCEngine::onAdminReceive(pMsg);
		}
		return;
	}
	TRACE0_L2("--CClient::DefaultMsgProc(), error\n");
	TRACE1_L2("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);
	return;
}

void CClient::OnClosed(HANDLE hLinkContext, HRESULT reason)
{
	_LinkContext* pContext = (_LinkContext*)hLinkContext;
	int linkType		= pContext->linkType;		unused(linkType);
	int hLink			= pContext->hLink;			unused(hLink);
	const char* addr	= pContext->addr.c_str();	unused(addr);
	int port			= pContext->port;			unused(port);

	TRACE0_L2("CClient::OnClosed()\n");
	TRACE1_L2("\tLinkType = %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);
	TRACE1_L2("\treason = %s\n", translateReason(reason));

	if ( linkType == IID_IMsgLinksAW_C )
	{
		LinkContext_Admin* pAdmin= (LinkContext_Admin*)hLinkContext;
		delete pAdmin;
		return;
	}

	TRACE0_L2("--CClient::OnClosed(), error\n");
	TRACE1_L2("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);

	return;
}

CClient g_client;
