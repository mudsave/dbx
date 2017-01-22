/**
 * filename : session.cpp
 * desc :	处理session的网络事件
 *			处理session的定时器
 *			处理session的异步任务
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "AccountMgr.h"
#include "LinkContext.h"
#include "session.h"

CSession::CSession()
{
	TRACE0_L0("CSession construct..\n");

	m_hFastFrameTimer	= NULL;
	m_hSlowFrameTimer	= NULL;

	m_pLinkCtrl			= NULL;
	m_pThreadsPool		= NULL;
}

CSession::~CSession()
{
	TRACE0_L0("CSession destruct..\n");
}

void CSession::Init(	const char* loginIP,	int loginPort,
						const char* gateIP,		int gatePort,
						const char* worldIP,	int worldPort,
						const char* dbIp,		int dbPort		)
{
	HRESULT hr;

	m_pLinkCtrl = CreateLinkCtrl();
	m_pThreadsPool = GlobalThreadsPool();

	ILinkSink* pClientSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksCS_L>* >(this);
	ILinkSink* pGateSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksGS_L>* >(this);
	ILinkSink* pWorldSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksWS_L>* >(this);

	hr = m_pLinkCtrl->Listen(loginIP,	&loginPort,	pClientSink,	0);	ASSERT_( SUCCEEDED(hr) );
	hr = m_pLinkCtrl->Listen(gateIP,	&gatePort,	pGateSink,		0);	ASSERT_( SUCCEEDED(hr) );
	hr = m_pLinkCtrl->Listen(worldIP,	&worldPort,	pWorldSink,		0);	ASSERT_( SUCCEEDED(hr) );

	g_DBProxy.init(dbIp, dbPort);
	InitClientVersion();

	m_hFastFrameTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eFastFrameHandle, 0, eFastFrameInterval, eFastFrameInterval, "session fast frame timer");	ASSERT_(m_hFastFrameTimer);
	m_hSlowFrameTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eSlowFrameHandle, 0, eSlowFrameInterval, eSlowFrameInterval, "session slow frame timer");	ASSERT_(m_hSlowFrameTimer);
}

void CSession::Close()
{
	// g_accountMgr.Close();

	int i;
	{
		ClientMap::iterator iter = m_clients.begin();
		for( i = 0 ; iter != m_clients.end(); i++, iter++ )
		{
			LinkContext_Client* pClient = iter->second;
			delete pClient;
		}
	}
	TRACE1_L2("CSession::Close(), %i client is no released\n", i);
	{
		GateMap::iterator iter = m_gates.begin();
		for( i = 0 ; iter != m_gates.end(); i++, iter++ )
		{
			LinkContext_Gate* pGate = iter->second;
			delete pGate;
		}
	}
	TRACE1_L2("CSession::Close(), %i gate is no released\n", i);
	{
		WorldMap::iterator iter = m_worlds.begin();
		for( i = 0 ; iter != m_worlds.end(); i++, iter++ )
		{
			LinkContext_World* pWorld = iter->second;
			delete pWorld;
		}
	}
	TRACE1_L2("CSession::Close(), %i world is no released\n", i);

	m_pThreadsPool->UnregTimer(m_hFastFrameTimer);
	m_pThreadsPool->UnregTimer(m_hSlowFrameTimer);

	// g_DBProxy.Close();

	IMsgLinksImpl<IID_IMsgLinksCS_L>::Clear();
	IMsgLinksImpl<IID_IMsgLinksGS_L>::Clear();
	IMsgLinksImpl<IID_IMsgLinksWS_L>::Clear();

	m_pLinkCtrl->CloseCtrl();
}

void CSession::InitClientVersion()
{
	FILE* file = fopen("version.txt","r+");
	char ch;
	if ( file != NULL && EOF != (ch=fgetc(file)) )
	{
		char cTmp[15];
		while(EOF != (ch=fgetc(file)))
		{
			if (ch ==' ')
			{
				fgets(cTmp, 15, file);
				break;
			}	
		}
		if (ch ==' ')
			m_version = atoi(cTmp);
		else
			m_version = -1;
		fclose(file);
		return;
	}
	m_version = -1;
}

void CSession::OnClientMsg(AppMsg* pMsg, HANDLE hLinkContext)
{
	LinkContext_Client* pContext = (LinkContext_Client*)hLinkContext;
	int linkType		= pContext->linkType;		unused(linkType);
	handle hLink		= pContext->hLink;			unused(hLink);
	const char* addr	= pContext->addr.c_str();	unused(addr);
	int port			= pContext->port;			unused(port);
	int state			= pContext->state;			unused(state);
	int msgCls			= pMsg->msgCls;
	int msgId			= pMsg->msgId;

#if DEBUG_L >= 2
	ClientMap::iterator iter = m_clients.find(hLink);
	if ( iter == m_clients.end() )
	{
		TRACE0_L2("CSession::OnClientMsg(), no linkContext in ClientMap for Msg\n");
		TRACE1_L2("\tmsgCls = %i\n", msgCls);
		TRACE1_L2("\tmsgId = %i\n", msgId);
		ASSERT_(0);
	}
	ASSERT_(iter->second == pContext);
#endif

	switch( msgCls )
	{
		case MSG_CLS_LOGIN:
			{
				pContext->OnNetMsg(pMsg);
			}
			break;
		default:
			{
				TRACE0_L2("CSession::OnClientMsg(), Invalid Msg..\n");
				TRACE1_L2("\tmsgCls	= %i\n", msgCls);
				TRACE1_L2("\tmsgId	= %i\n", msgId);
				ASSERT_(0);
			}
			break;
	}

	return;
}

void CSession::OnGateMsg(AppMsg* pMsg, HANDLE hLinkContext)
{
	LinkContext_Gate* pContext = (LinkContext_Gate*)hLinkContext;
	int linkType		= pContext->linkType;		unused(linkType);
	handle hLink		= pContext->hLink;			unused(hLink);
	const char* addr	= pContext->addr.c_str();	unused(addr);
	int port			= pContext->port;			unused(port);
	int state			= pContext->state;			unused(state);
	int msgCls			= pMsg->msgCls;
	int msgId			= pMsg->msgId;

#if DEBUG_L >= 2
	GateMap::iterator iter = m_gates.find(hLink);
	if ( iter == m_gates.end() )
	{
		TRACE0_L2("CSession::OnGateMsg(), no linkContext in GateMap for Msg\n");
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
				if ( msgId == MSG_S_G_SYN_GATEWAY_INFO )
				{
					_MsgGS_SYN_GatewayInfo* pInfo = static_cast<_MsgGS_SYN_GatewayInfo*>(pMsg);
					pContext->gatewayId = pInfo->gatewayId;
					memcpy( pContext->addr_client,	pInfo->addr_client,	_IP_ADDR_LEN );
					pContext->port_client = pInfo->port_client;
					memcpy( pContext->addr_world,	pInfo->addr_world,	_IP_ADDR_LEN );
					pContext->port_world = pInfo->port_world;
					pContext->state = LINK_CONTEXT_CONNECTED;
					bool ret = IsValidGatewayId(pInfo->gatewayId);
					if ( ret == false )
					{
						IMsgLinksImpl<IID_IMsgLinksGS_L>::CloseLink(hLink, CLOSE_RELEASE);
						return;
					}
					RegGatewayId(pInfo->gatewayId);
					send_MsgSG_ACK_GatewayInfo(hLink);
					send_MsgSW_UP_GatewayList(pContext);
					return;
				}

				if ( msgId == MSG_S_G_UPDATE_GATEWAY_STATE )
				{
					_MsgGS_UP_GatewayState* pState = static_cast<_MsgGS_UP_GatewayState*>(pMsg);
					int m			= pState->clientCount;
					int n			= pState->worldCount;
					short* pIds		= pState->worldIds;

					pContext->clientCount	= m;
					pContext->worldCount	= n;
					memset( (void*)(pContext->worldList), 0, sizeof(pContext->worldList) );
					for( int i = 0; i < n; i++ )
					{
						int id = pIds[i];	ASSERT_( id >= 0 );	ASSERT_( id < MAX_WORLDS );
						pContext->worldList[id] = 1;
					}
					return;
				}

				TRACE0_L2("CSession::OnGateMsg(), Invalid msgId for MSG_CLS_STARTUP..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		case MSG_CLS_LOGIN:
			{
				if ( msgId == MSG_S_G_USER_VERIFY )
				{
					_MsgGS_UserVerifyInfo* pInfo = (_MsgGS_UserVerifyInfo*)pMsg;
					if(!verifyVersion(pInfo->accountId, pInfo->version, "CSession::OnGateMsg(), MSG_S_G_USER_VERIFY"))
						return;
					int ret = IsValidPlayer(pInfo);
					send_MsgSG_UserVerify_ResultInfo(hLink, pInfo->roleId, pInfo->version, ret);
					return;
				}

				if ( msgId == MSG_S_G_USER_LOADED )
				{
					_MsgGS_UserLoginInfo* pInfo = (_MsgGS_UserLoginInfo*)pMsg;
					if(!verifyVersion(pInfo->accountId, pInfo->version, "CSession::OnGateMsg(), MSG_S_G_USER_LOADED"))
						return;
					g_accountMgr.unregOffFightAccount(pInfo->accountId);
					if ( pInfo->result == 0 )
					{
						AccountInfo* pAccount = g_accountMgr.getAccountPtr(pInfo->accountId);
						ASSERT_( pAccount );
						ASSERT_( pAccount->roleId == pInfo->roleId );
						ASSERT_( pAccount->status == ACCOUNT_STATE_LOADING
						 	|| pAccount->status == ACCOUNT_STATE_RECONNECTING_FIGHT);
						pAccount->_SwitchStatus(ACCOUNT_STATE_LOADED);
						return;
					}
					TRACE0_L2("CSession::OnGateMsg(), handle MSG_S_G_USER_LOADED error\n");
					TRACE1_L2("\taccountId = %i\n", pInfo->accountId);
					TRACE1_L2("\troleId = %i\n", pInfo->roleId);
					ASSERT_( g_accountMgr.unregAccount(pInfo->accountId) );
					return;
				}

				if ( msgId == MSG_S_G_USER_LOGOUT )
				{
					_MsgGS_UserLogoutInfo* pInfo = (_MsgGS_UserLogoutInfo*)pMsg;
					if(!verifyVersion(pInfo->accountId, pInfo->version, "CSession::OnGateMsg(), MSG_S_G_USER_LOGOUT"))
						return;
					int accountId	= pInfo->accountId;
					int roleId		= pInfo->roleId;
					int result		= pInfo->result;
					short reason	= pInfo->reason;

					if ( result != 0 )
					{
						TRACE0_L2("CSession::OnGateMsg(), gateway登出账户出现异常\n");
						TRACE1_L2("\taccountId = %i\n", accountId);
						TRACE1_L2("\troleId = %i\n", roleId);
						TRACE1_L2("\tresult = %i\n", result);
						TRACE1_L2("\treason = %i\n", reason);
						ASSERT_( g_accountMgr.unregAccount(accountId) );
						ASSERT_(0);
						return;
					}

					AccountInfo& account = g_accountMgr.getAccount(pInfo->accountId);
					if (pInfo->reason == 7)
					{
						account._SwitchStatus(ACCOUNT_STATE_LOGINED);
						TRACE0_L2("CSession::OnGateMsg(), 玩家小退\n");
						TRACE1_L2("\taccountId = %i\n", accountId);
						TRACE1_L2("\troleId = %i\n", roleId);
						return;
					}
					TRACE0_L2("CSession::OnGateMsg(), 玩家退出\n");
					TRACE1_L2("\taccount status = %i\n", account.status);
					TRACE1_L2("\taccountId = %i\n", accountId);
					TRACE1_L2("\troleId = %i\n", roleId);
					TRACE1_L2("\tresult = %i\n", result);
					TRACE1_L2("\treason = %i\n", reason);
					ASSERT_( g_accountMgr.unregAccount(accountId) );

					return;
				}

				TRACE0_L2("CSession::OnGateMsg(), Invalid msgId for MSG_CLS_LOGIN..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		case MSG_CLS_OFFLINE:
			{
				if ( msgId == MSG_G_S_OFFLINE_IN_FIGHT)
				{
					_MsgGS_OfflineInFight* pInfo = (_MsgGS_OfflineInFight*)pMsg;
					if(!verifyVersion(pInfo->accountId, pInfo->version, "CSession::OnGateMsg(), MSG_G_S_OFFLINE_IN_FIGHT"))
						return;
					int accountId	= pInfo->accountId;
					int roleId		= pInfo->roleId;
					AccountInfo& account = g_accountMgr.getAccount(pInfo->accountId);
					account.gatewayId = -1;
					account.hAccountTimer = NULL;
					account.hLink = 0;
					account.hPendingLink = 0;
					account._SwitchStatus(ACCOUNT_STATE_OFFLINE_IN_FIGHT);
					g_accountMgr.regOffFightAccount(accountId);
					TRACE0_L2("CSession::OnGateMsg(), player offline in fight\n");
					TRACE1_L2("\taccountId = %i\n", accountId);
					TRACE1_L2("\troleId = %i\n", roleId);
				}
			}
			break;
		default:
			{
				TRACE0_L2("CSession::OnGateMsg(), Invalid Msg..\n");
				TRACE1_L2("\tmsgCls = %i\n", msgCls);
				TRACE1_L2("\tmsgId = %i\n", msgId);
				ASSERT_(0);
			}
			break;
	}

	return;
}

void CSession::OnWorldMsg(AppMsg* pMsg, HANDLE hLinkContext)
{
	LinkContext_World* pContext = (LinkContext_World*)hLinkContext;
	int linkType		= pContext->linkType;		unused(linkType);
	handle hLink		= pContext->hLink;			unused(hLink);
	const char* addr	= pContext->addr.c_str();	unused(addr);
	int port			= pContext->port;			unused(port);
	int state			= pContext->state;			unused(state);
	int msgCls			= pMsg->msgCls;
	int msgId			= pMsg->msgId;

#if DEBUG_L >= 2
	WorldMap::iterator iter = m_worlds.find(hLink);
	if ( iter == m_worlds.end() )
	{
		TRACE0_L2("CSession::OnWorldMsg(), no linkContext in WorldMap for Msg\n");
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
				if ( msgId == MSG_S_W_SYN_WORLD_INFO )
				{
					_MsgWS_SYN_WorldInfo* pInfo = static_cast<_MsgWS_SYN_WorldInfo*>(pMsg);

					pContext->worldId		= pInfo->worldId;
					pContext->state			= LINK_CONTEXT_CONNECTED;
					short tmp_id 			= pInfo->worldId;

					bool ret = IsValidWorldId(tmp_id);
					if ( ret == false )
					{
						IMsgLinksImpl<IID_IMsgLinksWS_L>::CloseLink(hLink, CLOSE_RELEASE);
						return;
					}

					RegWorldId(tmp_id);

					if (IS_WORLD_SERVER(tmp_id))
						m_worldServers.insert(pContext->hLink);
					else if (IS_FIGHT_SERVER(tmp_id))
						m_fightServers.insert(pContext->hLink);
					else if (IS_SOCIAL_SERVER(tmp_id))
						m_socialServers.insert(pContext->hLink);

					send_MsgSW_ACK_WorldInfo(hLink);
					send_MsgSW_UP_GatewayList(hLink);

					return;
				}
				if ( msgId == MSG_S_W_UPDATE_WORLD_STATE )
				{
					_MsgWS_UP_WorldState* pState = static_cast<_MsgWS_UP_WorldState*>(pMsg);
					pContext->playerCount = pState->playerCount;
					return;
				}
				TRACE0_L2("CSession::OnWorldMsg(), Invalid msgId for MSG_CLS_STARTUP..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		case MSG_CLS_OFFLINE:
			{
				if (msgId == MSG_W_S_CLEAR_OFF_FIGHT)
				{
					_MsgWS_ClearOffFightInfo* pInfo = static_cast<_MsgWS_ClearOffFightInfo*>(pMsg);
					if(!verifyVersion(pInfo->accountId, pInfo->version, "CSession::OnWorldMsg(), MSG_W_S_CLEAR_OFF_FIGHT"))
						return;
					if (!g_accountMgr.isRegistered(pInfo->accountId))
						return;
					AccountInfo& account = g_accountMgr.getAccount(pInfo->accountId);
					ASSERT_(account.status == ACCOUNT_STATE_OFFLINE_IN_FIGHT || account.status == ACCOUNT_STATE_LOADED
						|| account.status == ACCOUNT_STATE_RECONNECTING_FIGHT);
					g_accountMgr.unregOffFightAccount(pInfo->accountId);
					if (account.status == ACCOUNT_STATE_OFFLINE_IN_FIGHT)
						g_accountMgr.unregAccount(pInfo->accountId);
					TRACE0_L2("CSession::OnWorldMsg(), clear fight offline info!\n");
					TRACE1_L2("Account: %d\n", pInfo->accountId);
					TRACE1_L2("Status: %d\n", account.status);
					return;
				}

				if (msgId == MSG_W_S_START_FIGHT)
				{
					_MsgWS_StartFight* pInfo = static_cast<_MsgWS_StartFight*>(pMsg);
					if(!verifyVersion(pInfo->accountId, pInfo->version, "CSession::OnWorldMsg(), MSG_W_S_START_FIGHT"))
						return;
					if (!g_accountMgr.isRegistered(pInfo->accountId))
						return;
					AccountInfo& account = g_accountMgr.getAccount(pInfo->accountId);
					account.inFight = true;
					TRACE1_L2("CSession::OnWorldMsg(), account:%d is in fight!\n", pInfo->accountId);
					return;
				}

				if (msgId == MSG_W_S_STOP_FIGHT)
				{
					_MsgWS_StopFight* pInfo = static_cast<_MsgWS_StopFight*>(pMsg);
					if(!verifyVersion(pInfo->accountId, pInfo->version, "CSession::OnWorldMsg(), MSG_W_S_STOP_FIGHT"))
						return;
					if (!g_accountMgr.isRegistered(pInfo->accountId))
						return;
					AccountInfo& account = g_accountMgr.getAccount(pInfo->accountId);
					account.inFight = false;
					TRACE1_L2("CSession::OnWorldMsg(), account:%d is out fight!\n", pInfo->accountId);
					return;
				}
			}
			break;
		default:
			{
				TRACE0_L2("CSession::OnWorldMsg(), Invalid Msg..\n");
				TRACE1_L2("\tmsgCls	= %i\n", msgCls);
				TRACE1_L2("\tmsgId	= %i\n", msgId);
				ASSERT_(0);
			}
			break;
	}
	return;
}

void CSession::OnClientClosed(HANDLE hLinkContext, HRESULT reason)
{
	LinkContext_Client* pContext = (LinkContext_Client*)hLinkContext;
	int linkType = pContext->linkType;		unused(linkType);
	handle hLink = pContext->hLink;			unused(hLink);
	ClientMap::iterator iter = m_clients.find(hLink);
	if ( iter != m_clients.end() )
	{
		LinkContext_Client* pClient = iter->second; ASSERT_( pContext == pClient );
		if ( pClient->hStateTimer )
		{
			m_pThreadsPool->UnregTimer( pClient->hStateTimer );
			pClient->hStateTimer = NULL;
		}
		if ( pClient->state == LINK_CONTEXT_LOGINED || pClient->state == LINK_CONTEXT_ROLE_CREATEING
			|| pClient->state == LINK_CONTEXT_ROLE_DELETEING )
		{
			g_accountMgr.unregAccount(pClient->accountId);
		}
		m_clients.erase(iter);
	}
	else
	{
		ASSERT_(0);
	}

	delete pContext;
}

void CSession::OnGateClosed(HANDLE hLinkContext, HRESULT reason)
{
	LinkContext_Gate* pContext = (LinkContext_Gate*)hLinkContext;
	int linkType = pContext->linkType;		unused(linkType);
	handle hLink = pContext->hLink;			unused(hLink);

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

void CSession::OnWorldClosed(HANDLE hLinkContext, HRESULT reason)
{
	LinkContext_World* pContext = (LinkContext_World*)hLinkContext;
	int linkType = pContext->linkType;		unused(linkType);
	handle hLink = pContext->hLink;			unused(hLink);

	WorldMap::iterator iter = m_worlds.find(hLink);
	if ( iter != m_worlds.end() )
	{
		LinkContext_World* pWorld = iter->second; ASSERT_( pContext == pWorld );
		int worldId = pWorld->worldId;
		if(IS_WORLD_SERVER(worldId))
			m_worldServers.erase(hLink);
		else if(IS_FIGHT_SERVER(worldId))
			m_fightServers.erase(hLink);
		else if(IS_SOCIAL_SERVER(worldId))
			m_socialServers.erase(hLink);
		m_worlds.erase(iter);
	}
	else
	{
		ASSERT_(0);
	}

	delete pContext;
}

void CSession::OnDBReturn(_DBMsg* pMsg, handle hLink)
{
	if (!IMsgLinksImpl<IID_IMsgLinksCS_L>::IsValidLink(hLink))
	{
		if( pMsg->actionType == DB_MSG_LOGIN )
		{
			DBMsg_LoginResult* pLoginResult = ( DBMsg_LoginResult* ) pMsg;
			pLoginResult->Release();
		}
		TRACE0_L0("client link has been closed\n");
		return;
	}
	ClientMap::iterator iter = m_clients.find(hLink);
	if( iter == m_clients.end() )
		ASSERT_(0);
	iter->second->OnDBMsg(pMsg);
}

void CSession::handleFastFrame()
{
}

void CSession::handleSlowFrame()
{
	send_MSG_S_W_FIGHT_SERVER_LOAD();
}

HRESULT CSession::Do(HANDLE hContext)
{
	switch( (int)(long)hContext )
	{
		case eFastFrameHandle:
			handleFastFrame();
			break;
		case eSlowFrameHandle:
			handleSlowFrame();
			break;
		default:
			ASSERT_(0);
			break;
	}

	return S_OK;
}

HANDLE CSession::OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType)
{
	int iPort = 0;
	char strbuf[64] = {0};
	pPort->GetRemoteAddr(strbuf, 64, &iPort);
	TRACE4_L2("(%i)CSession::OnConnects(), %s( %s:%d ) comes\n", operaterId, translateLinkType(iLinkType), strbuf, iPort);

	if ( iLinkType == IID_IMsgLinksCS_L )
	{
		LinkContext_Client* pClient = new LinkContext_Client(iLinkType, hLink);
		pClient->addr			= strbuf;
		pClient->port			= iPort;
		pClient->pThreadsPool	= m_pThreadsPool;
		pClient->_SwitchState(LINK_CONTEXT_CONNECTED);
		TRACE0_L0("connect client ok\n");
		m_clients.insert( ClientMap::value_type(hLink, pClient) );
		return pClient;
	}

	if ( iLinkType == IID_IMsgLinksGS_L )
	{
		LinkContext_Gate* pGate = new LinkContext_Gate(iLinkType, hLink);
		pGate->addr = strbuf;
		pGate->port = iPort;
		TRACE0_L0("connect gateway ok\n");
		m_gates.insert( GateMap::value_type(hLink, pGate) );
		return pGate;
	}

	if ( iLinkType == IID_IMsgLinksWS_L )
	{
		LinkContext_World* pWorld = new LinkContext_World(iLinkType, hLink);
		pWorld->addr = strbuf;
		pWorld->port = iPort;
		TRACE0_L0("connect world ok\n");
		m_worlds.insert( WorldMap::value_type(hLink, pWorld) );
		return pWorld;
	}

	TRACE1_L2("--CSession::OnConnects(), error LinkType( %s )\n", translateLinkType(iLinkType));

	return NULL;
}

void CSession::DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext)
{
	_LinkContext* pContext = (_LinkContext*)hLinkContext;
	int linkType		= pContext->linkType;
	handle hLink		= pContext->hLink; unused(hLink);
	const char* addr	= pContext->addr.c_str();
	int port			= pContext->port;
	int state			= pContext->state; unused(state);

	TRACE0_L3("CSession::DefaultMsgProc()\n");
	TRACE1_L3("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L3("\taddr = %s:%i\n", addr, port);

	if ( linkType == IID_IMsgLinksCS_L )
	{
		OnClientMsg(pMsg, hLinkContext);
		return;
	}

	if ( linkType == IID_IMsgLinksGS_L )
	{
		OnGateMsg(pMsg, hLinkContext);
		return;
	}

	if ( linkType == IID_IMsgLinksWS_L )
	{
		OnWorldMsg(pMsg, hLinkContext);
		return;
	}

	TRACE0_L2("--CSession::DefaultMsgProc(), error\n");
	TRACE1_L2("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);

	return;
}

void CSession::OnClosed(HANDLE hLinkContext, HRESULT reason)
{
	// eof		断开和PortSink的关系，并销毁PortSink，port自行管理自己（超时销毁）
	// error	断开和PortSink的关系，并销毁PortSink，port自行管理自己（异步销毁）
	// timeout	断开和PortSink的关系，并销毁PortSink，port自行管理自己（立刻销毁）
	// force	断开和PortSink的关系，并销毁PortSink，port自行管理自己（超时销毁）

	_LinkContext* pContext = (_LinkContext*)hLinkContext;
	int linkType		= pContext->linkType;
	handle hLink		= pContext->hLink; unused(hLink);
	const char* addr	= pContext->addr.c_str();
	int port			= pContext->port;

	TRACE0_L2("CSession::OnClosed()\n");
	TRACE1_L2("\tLinkType = %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);
	TRACE1_L2("\treason = %s\n", translateReason(reason));

	if ( linkType == IID_IMsgLinksCS_L )
	{
		OnClientClosed(hLinkContext, reason);
		return;
	}

	if ( linkType == IID_IMsgLinksGS_L )
	{
		OnGateClosed(hLinkContext, reason);
		return;
	}

	if ( linkType == IID_IMsgLinksWS_L )
	{
		OnWorldClosed(hLinkContext, reason);
		return;
	}

	TRACE0_L2("--CSession::OnClosed(), error\n");
	TRACE1_L2("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);

	return;
}

CSession g_session;
