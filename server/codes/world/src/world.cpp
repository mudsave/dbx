/**
 * filename : world.cpp
 * desc :	处理world的网络事件
 *			处理world的定时器
 *			处理world的异步任务
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "LinkContext.h"
#include "world.h"
#include "RPCEngine.h"

TOLUA_API int tolua_api4lua_open(lua_State* tolua_S);
TOLUA_API int lua_PropertySet_open(lua_State* tolua_S);

CWorld::CWorld()
{
	TRACE0_L0("CWorld construct..\n");

	m_sessionSock				= -1;
	m_pSession					= NULL;

	m_hFastFrameTimer			= NULL;
	m_hSlowFrameTimer			= NULL;
	m_hReconnectSessionTimer	= NULL;
	m_hUpdateWorldStateTimer	= NULL;

	m_pLinkCtrl					= NULL;
	m_pThreadsPool				= NULL;

	m_worldId					= -1;
	m_playerCount				= 0;
	m_castedPlayerCount			= -1;

	m_pLuaEngine				= NULL;
}

CWorld::~CWorld()
{
	TRACE0_L0("CWorld destruct..\n");
}

void CWorld::Init( short worldId, const char* sessionIP, int sessionPort, char* dbIP, int dbPort )
{
	HRESULT hr;
	m_pLinkCtrl = CreateLinkCtrl();
	m_pThreadsPool = GlobalThreadsPool();

	m_worldId		= worldId;
	m_dbIP			= dbIP;
	m_dbPort		= dbPort;
	m_sessionIP		= sessionIP;
	m_sessionPort	= sessionPort;

	ILinkSink* pSessionSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksWS_C>* >(this);
	hr = m_pLinkCtrl->Connect(sessionIP, sessionPort, pSessionSink,	0); ASSERT_( SUCCEEDED(hr) );
	m_sessionSock	= hr;

	m_hFastFrameTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eFastFrameHandle, 0, eFastFrameInterval, eFastFrameInterval, "world fast frame timer");
	ASSERT_(m_hFastFrameTimer);

	m_hSlowFrameTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eSlowFrameHandle, 0, eSlowFrameInterval, eSlowFrameInterval, "world slow frame timer");
	ASSERT_(m_hSlowFrameTimer);

	m_hUpdateWorldStateTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eUpdateWorldStateHandle, 0, eUpdateWorldStateInterval, eUpdateWorldStateInterval, "world update state timer");
	ASSERT_(m_hUpdateWorldStateTimer);

	m_pLuaEngine = CLuaEngine::CreateLuaEngineProc();

	lua_State* pLuaState = m_pLuaEngine->GetLuaState();
	tolua_api4lua_open(pLuaState);

	if (IS_WORLD_SERVER(m_worldId))
	{
		lua_PropertySet_open(pLuaState);
		if ( !m_pLuaEngine->LoadLuaFile("../resource/script/appEntry.lua") )
		{
			TRACE1_L2("LoadLuaFile(\"*/appEntry.lua\") failed:%s\n",m_pLuaEngine->GetError());
			exit(-1);
		}

	}
	else if (IS_FIGHT_SERVER(m_worldId))
	{
		if ( !m_pLuaEngine->LoadLuaFile("../resource/fightScript/appEntry.lua") )
		{
			TRACE1_L2("LoadLuaFile(\"*/appEntry.lua\") failed:%s\n",m_pLuaEngine->GetError());
			exit(-1);
		}
	}
	else if (IS_SOCIAL_SERVER(m_worldId))
	{
		if ( !m_pLuaEngine->LoadLuaFile("../resource/socialScript/appEntry.lua") )
		{
			TRACE1_L2("LoadLuaFile(\"*/appEntry.lua\") failed:%s\n",m_pLuaEngine->GetError());
			exit(-1);
		}
	}
	//notice: the order is fixed!
	ScriptTimer::init(pLuaState);
	CDBProxy::init(dbIP, dbPort, pLuaState);
	luaStart(pLuaState);
	RPCEngine::init(pLuaState);
}

void CWorld::Close()
{
	int i = 0;
	GateMap::iterator iter = m_gates.begin();
	for( ; iter != m_gates.end(); i++, iter++ )
	{
		LinkContext_Gate* pGate = iter->second;
		delete pGate;
	}
	TRACE1_L2("CWorld::Close(), %i gate is no released\n", i);

	if ( m_sessionSock != -1 && m_pSession == NULL )
		close(m_sessionSock);
	if ( m_pSession )
		delete m_pSession;
	if ( m_hReconnectSessionTimer )
		m_pThreadsPool->UnregTimer(m_hReconnectSessionTimer);
	TRACE0_L2("CWorld::Close(), m_pSession has been deleted\n");

	m_pThreadsPool->UnregTimer(m_hFastFrameTimer);
	m_pThreadsPool->UnregTimer(m_hSlowFrameTimer);
	m_pThreadsPool->UnregTimer(m_hUpdateWorldStateTimer);

	IMsgLinksImpl<IID_IMsgLinksWS_C>::Clear();
	IMsgLinksImpl<IID_IMsgLinksWG_C>::Clear();

	m_pLinkCtrl->CloseCtrl();
	CDBProxy::release();
}

void CWorld::OnSessionMsg(AppMsg* pMsg, HANDLE hLinkContext)
{
	LinkContext_Session* pContext = (LinkContext_Session*)hLinkContext;

	int linkType        = pContext->linkType;		unused(linkType);
	handle hLink        = pContext->hLink;			unused(hLink);
	const char* addr    = pContext->addr.c_str();	unused(addr);
	int port            = pContext->port;			unused(port);
	int state           = pContext->state;			unused(state);

	int msgCls          = pMsg->msgCls;
	int msgId           = pMsg->msgId;

#if DEBUG_L >= 2
	ASSERT_( m_pSession == pContext );
#endif

	switch( msgCls )
	{
		case MSG_CLS_STARTUP:
			{
				if ( msgId == MSG_W_S_ACK_WORLD_INFO )
				{
					pContext->state = LINK_CONTEXT_CONNECTED;
					return;
				}

				if ( msgId == MSG_W_S_UPDATE_GATEWAY_LIST )
				{
					_MsgSW_UP_GatewayList* pGatewayList = static_cast<_MsgSW_UP_GatewayList*>(pMsg);
					int iCount						= pGatewayList->gatewayCount;
					_Gateway_Element* pElements		= pGatewayList->gateElements;

					for ( int i = 0; i < iCount; i++ )
					{
						_Gateway_Element& element = pElements[i];
						short id			= element.gatewayId;
						std::string addr	= element.addr;
						short port			= element.port;

						ASSERT_( id < MAX_GATEWAYS );

						GateConnection& conn = m_gateConns[id]; ASSERT_( conn.status == eConnEmpty );
						conn.id			= id;
						conn.addr		= addr;
						conn.port		= port;
						conn.status		= eConnInit;

						ILinkSink* pGatewaySink	= static_cast< IMsgLinksImpl<IID_IMsgLinksWG_C>* >(this);
						HRESULT	hr		= m_pLinkCtrl->Connect(addr.c_str(), port, pGatewaySink, 0); ASSERT_( SUCCEEDED(hr) );

						conn.sock		= hr;
						conn.status		= eConnConnecting;
					}

					return;
				}

				if ( msgId == MSG_S_W_FIGHT_SERVER_LOAD )
				{
					_MsgSW_FightServerLoad* pInfo = static_cast<_MsgSW_FightServerLoad*>(pMsg);
					int count = pInfo->count;
					m_fightServerNum = count;
					if (m_fightLoads)
						delete[] m_fightLoads;
					if (count == 0)
					{
						m_fightLoads = NULL;
					}
					else{
						m_fightLoads = new FightServerLoad[count];
						memcpy(m_fightLoads, pInfo->loads, sizeof(FightServerLoad) * count);
					}
					setFightServerLoads(getLuaState());
					return;
				}
			}
			break;
		case MSG_CLS_LOGIN:
			break;
		default:
			TRACE1_L2("CWorld::OnSessionMsg(), Invalid Msg for class %i\n", pMsg->msgCls);
			break;
	}
	return;
}

void CWorld::OnGatewayMsg(AppMsg* pMsg, HANDLE hLinkContext)
{
	LinkContext_Gate* pContext = (LinkContext_Gate*)hLinkContext;
	int linkType        = pContext->linkType;		unused(linkType);
	handle hLink        = pContext->hLink;			unused(hLink);
	const char* addr    = pContext->addr.c_str();	unused(addr);
	int port            = pContext->port;			unused(port);
	int state           = pContext->state;			unused(state);
	int msgCls          = pMsg->msgCls;
	int msgId           = pMsg->msgId;

#if DEBUG_L >= 2
	GateMap::iterator iter = m_gates.find(hLink);
	if ( iter == m_gates.end() )
	{
		TRACE0_L2("CWorld::OnGatewayMsg(), no linkContext in GateMap for Msg\n");
		TRACE1_L2("\tmsgCls = %i\n", msgCls);
		TRACE1_L2("\tmsgId = %i\n", msgId);
		ASSERT_(0);
	}
	ASSERT_(iter->second == pContext);
#endif

	switch( msgCls )
	{
		case MSG_CLS_STARTUP:
			{
				if ( msgId == MSG_W_G_SYN_GATEWAY_INFO )
				{
					_MsgGW_SYN_GatewayInfo* pInfo = (_MsgGW_SYN_GatewayInfo*)pMsg;
					pContext->gatewayId		= pInfo->gatewayId;
					pContext->state			= LINK_CONTEXT_CONNECTED;
					send_MsgWG_ACK_GatewayInfo(hLink);
					return;
				}
				TRACE0_L2("CWorld::OnGatewayMsg(), Invalid msgId for MSG_CLS_STARTUP..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		case MSG_CLS_LOGIN:
			{

				if ( msgId == MSG_W_G_PLAYER_LOGIN || msgId == MSG_W_G_PLAYER_LOGOUT )
				{
					static LuaFunctor<TypeNull, handle, TypeUser> playerMsgFunc(m_pLuaEngine->GetLuaState(), "ManagedApp.onPlayerMessage");
					if ( !playerMsgFunc( TypeNull::nil(), hLink, TypeUser(pMsg, "AppMsg") ) )
					{
						TRACE1_L1("[CWorld::OnGatewayMsg] ManagedApp.onPlayerMessage() failed, because of %s\n", playerMsgFunc.getLastError());
					}
					return;
				}
				TRACE0_L2("CWorld::OnGatewayMsg(), Invalid msgId for MSG_CLS_STARTUP..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);

			}
			break;
		case MSG_CLS_SCENE_RPC:
			{
				handle hClient = pMsg->context; unused(hClient);
				handle hGate = hLink; unused(hGate);
				short gatewayId = pContext->gatewayId; unused(gatewayId);
				RPCEngine::onReceive(pMsg);
			}
			break;
		case MSG_CLS_WORLD_RPC:
			{
				handle srcId_clientLink = pMsg->context; unused(srcId_clientLink);
				handle hGate = hLink; unused(hGate);
				short gatewayId = pContext->gatewayId; unused(gatewayId);
				RPCEngine::onWorldReceive(pMsg);
			}
			break;
		default:
			{
				TRACE0_L2("CWorld::OnGatewayMsg(), Invalid Msg..\n");
				TRACE1_L2("\tmsgCls = %i\n", msgCls);
				TRACE1_L2("\tmsgId = %i\n", msgId);
				ASSERT_(0);
			}
			break;
	}
}

void CWorld::OnSessionClosed(HANDLE hLinkContext, HRESULT reason)
{
	LinkContext_Session* pContext = (LinkContext_Session*)hLinkContext;
	int linkType = pContext->linkType; unused(linkType);
	handle hLink = pContext->hLink; unused(hLink);

	LinkContext_Session* pSession = m_pSession; ASSERT_( pContext == pSession );
	m_pSession = NULL;

	delete pSession;
}

void CWorld::OnGatewayClosed(HANDLE hLinkContext, HRESULT reason)
{
	LinkContext_Gate* pContext = (LinkContext_Gate*)hLinkContext;
	int linkType	= pContext->linkType;	unused(linkType);
	handle hLink	= pContext->hLink;		unused(hLink);
	short id		= pContext->gatewayId;	unused(id);

	ASSERT_( id < MAX_GATEWAYS );

	GateConnection& conn = m_gateConns[id];
	conn.context	= NULL;
	conn.status		= eConnClosed;

	GateMap::iterator iter = m_gates.find(hLink);
	if ( iter != m_gates.end() )
	{
		LinkContext_Gate* pGate = iter->second; ASSERT_( pContext == pGate );
		m_gates.erase(iter);
	}
	else
	{
		ASSERT_(0);
	}

	delete pContext;
}

void CWorld::handleFastFrame()
{
	ScriptTimer::OnTimeClick();
}

void CWorld::handleSlowFrame()
{

}

void CWorld::handleSessionReconnect()
{
	m_hReconnectSessionTimer = NULL;

	ILinkSink* pSessionSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksWS_C>* >(this);
	HRESULT hr = m_pLinkCtrl->Connect(m_sessionIP.c_str(), m_sessionPort, pSessionSink, 0); ASSERT_( SUCCEEDED(hr) );

	m_sessionSock = hr;

	return;
}

void CWorld::handleUpdateWorldState()
{
	if ( m_pSession == NULL )
		return;

	if ( m_pSession->state != LINK_CONTEXT_CONNECTED )
		return;

	bool flag = IsDirtyState();
	if ( flag )
	{
		m_castedPlayerCount = m_playerCount;
		if ( IS_WORLD_SERVER(m_worldId) || IS_FIGHT_SERVER(m_worldId))
		{
			send_MsgWS_UP_WorldState();
		}
	}
}

HRESULT CWorld::Do(HANDLE hContext)
{
	switch( (int)(long)hContext )
	{
		case eFastFrameHandle:
			handleFastFrame();
			break;
		case eSlowFrameHandle:
			handleSlowFrame();
			break;
		case eReconnSessionHandle:
			handleSessionReconnect();
			break;
		case eUpdateWorldStateHandle:
			handleUpdateWorldState();
			break;
		case eCleanUpHandle:
			handleCleanUp();
			break;
		default:
			ASSERT_(0);
			break;
	}

	return S_OK;
}

HANDLE CWorld::OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType)
{
	int iPort = 0;
	char strbuf[1024] = {0};
	pPort->GetRemoteAddr(strbuf, 1024, &iPort);

	TRACE4_L2("(%i)CWorld::OnConnects(), %s( %s:%d ) comes\n", operaterId, translateLinkType(iLinkType), strbuf, iPort);

	if ( iLinkType == IID_IMsgLinksWG_C )
	{
		if ( FAILED(result) )
		{
			TRACE0_L2("\tconnect failed\n");

			int i = 0;
			for ( ; i < MAX_GATEWAYS; i++ )
			{
				GateConnection& conn = m_gateConns[i];
				if ( conn.sock == operaterId )
				{
					conn.sock	= -1;
					conn.status	= eConnFailed;
					break;
				}
			}
			ASSERT_( i != MAX_GATEWAYS );

			return NULL;
		}

		LinkContext_Gate* pGate = new LinkContext_Gate(iLinkType, hLink);
		pGate->addr = strbuf;
		pGate->port = iPort;
		m_gates.insert( GateMap::value_type(hLink, pGate) );

		int i = 0;
		for ( ; i < MAX_GATEWAYS; i++ )
		{
			GateConnection& conn = m_gateConns[i];
			if ( conn.sock == operaterId )
			{
				conn.context	= pGate;
				conn.status		= eConnConnected;
				break;
			}
		}
		ASSERT_( i != MAX_GATEWAYS );

		send_MsgWG_SYN_WorldInfo(hLink);

		return pGate;
	}

	if ( iLinkType == IID_IMsgLinksWS_C )
	{
		if ( FAILED(result) )
		{
			TRACE0_L2("\tconnect failed\n");
			m_sessionSock = -1;
			m_hReconnectSessionTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eReconnSessionHandle, 0, eReconnSessionInterval, 0, "reconnect session timer");	ASSERT_(m_hReconnectSessionTimer);
			return NULL;
		}

		LinkContext_Session* pSession = new LinkContext_Session(iLinkType, hLink);
		pSession->addr = strbuf;
		pSession->port = iPort;

		m_pSession = pSession;

		send_MsgWS_SYN_WorldInfo(hLink);

		return pSession;
	}

	TRACE1_L2("--CWorld::OnConnects(), error LinkType( %s )\n", translateLinkType(iLinkType));

	return NULL;
}

void CWorld::DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext)
{
	_LinkContext* pContext = (_LinkContext*)hLinkContext;
	int linkType		= pContext->linkType;		unused(linkType);
	int hLink			= pContext->hLink;			unused(hLink);
	const char* addr	= pContext->addr.c_str();	unused(addr);
	int port			= pContext->port;			unused(port);
	int state			= pContext->state;			unused(state);

	TRACE0_L3("CWorld::DefaultMsgProc()\n");
	TRACE1_L3("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L3("\taddr = %s:%i\n", addr, port);

	if ( linkType == IID_IMsgLinksWS_C )
	{
		OnSessionMsg(pMsg, hLinkContext);
		return;
	}

	if ( linkType == IID_IMsgLinksWG_C )
	{
		OnGatewayMsg(pMsg, hLinkContext);
		return;
	}

	TRACE0_L2("--CWorld::DefaultMsgProc(), error\n");
	TRACE1_L2("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);
	return;
}

void CWorld::OnClosed(HANDLE hLinkContext, HRESULT reason)
{
	// eof		断开和PortSink的关系，并销毁PortSink，port自行管理自己（超时销毁）
	// error	断开和PortSink的关系，并销毁PortSink，port自行管理自己（异步销毁）
	// timeout	断开和PortSink的关系，并销毁PortSink，port自行管理自己（立刻销毁）
	// force	断开和PortSink的关系，并销毁PortSink，port自行管理自己（超时销毁）

	_LinkContext* pContext = (_LinkContext*)hLinkContext;
	int linkType		= pContext->linkType;		unused(linkType);
	int hLink			= pContext->hLink;			unused(hLink);
	const char* addr	= pContext->addr.c_str();	unused(addr);
	int port			= pContext->port;			unused(port);
	int state			= pContext->state;			unused(state);

	TRACE0_L2("CWorld::OnClosed()\n");
	TRACE1_L2("\tLinkType = %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);
	TRACE1_L2("\treason = %s\n", translateReason(reason));

	if ( linkType == IID_IMsgLinksWS_C )
	{
		OnSessionClosed(hLinkContext, reason);
		return;
	}

	if ( linkType == IID_IMsgLinksWG_C )
	{
		OnGatewayClosed(hLinkContext, reason);
		return;
	}

	TRACE0_L2("--CWorld::OnClosed(), error\n");
	TRACE1_L2("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);

	return;
}

void CWorld::handleCleanUp()
{
	IThreadsPool* pThreadsPool	= GlobalThreadsPool();
	pThreadsPool->Shutdown();
}

void CWorld::CleanUp()
{
	LuaFunctor<TypeNull, int> closeFunc(getLuaState(), "ManagedApp.close");
	if ( !closeFunc( TypeNull::nil(), m_worldId ) )
	{
		TRACE2_L1("[CWorld::Close] failed in worldID %d because of:%s\n", m_worldId, closeFunc.getLastError());
	}
	HANDLE hCleanupTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eCleanUpHandle, 0, eCleanUpInterval, 0, "world clean up timer!");
	ASSERT_(hCleanupTimer);
}

CWorld g_world;
