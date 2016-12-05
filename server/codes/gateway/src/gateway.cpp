/**
 * filename : gateway.cpp
 * desc :	处理gateway的网络事件
 *			处理gateway的定时器
 *			处理gateway的异步任务
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "PlayerMgr.h"
#include "LinkContext.h"
#include "gateway.h"

CGateway::CGateway()
{
	TRACE0_L0("CGateway construct..\n");

	m_sessionSock				= -1;
	m_pSession					= NULL;

	m_hFastFrameTimer			= NULL;
	m_hSlowFrameTimer			= NULL;
	m_hReconnectSessionTimer	= NULL;
	m_hUpdateGateStateTimer		= NULL;

	m_pLinkCtrl					= NULL;
	m_pThreadsPool				= NULL;

	m_gatewayId					= -1;
}

CGateway::~CGateway()
{
	TRACE0_L0("CGateway destruct..\n");
}

void CGateway::Init(	short gatewayId,
						const char* loginIP,	int loginPort,
						const char* worldIP,	int worldPort,
						const char* sessionIP,	int sessionPort	)
{
	HRESULT hr;

	m_pLinkCtrl = CreateLinkCtrl();
	m_pThreadsPool = GlobalThreadsPool();

	ILinkSink* pClientSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksCG_L>* >(this);
	ILinkSink* pWorldSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksWG_L>* >(this);
	ILinkSink* pSessionSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksGS_C>* >(this);

	hr = m_pLinkCtrl->Listen(loginIP,		&loginPort,		pClientSink,	0);	ASSERT_( SUCCEEDED(hr) );
	hr = m_pLinkCtrl->Listen(worldIP,		&worldPort,		pWorldSink,		0);	ASSERT_( SUCCEEDED(hr) );
	hr = m_pLinkCtrl->Connect(sessionIP,	sessionPort,	pSessionSink,	0); ASSERT_( SUCCEEDED(hr) );

	m_sessionSock	= hr;
	m_sessionIP		= sessionIP;
	m_sessionPort	= sessionPort;

	m_loginIP		= loginIP;
	m_loginPort		= loginPort;

	m_worldIP		= worldIP;
	m_worldPort		= worldPort;

	m_gatewayId		= gatewayId;

	m_hFastFrameTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eFastFrameHandle, 0, eFastFrameInterval, eFastFrameInterval, "gateway fast frame timer");	ASSERT_(m_hFastFrameTimer);

	m_hSlowFrameTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eSlowFrameHandle, 0, eSlowFrameInterval, eSlowFrameInterval, "gateway slow frame timer");	ASSERT_(m_hSlowFrameTimer);

	m_hUpdateGateStateTimer = m_pThreadsPool->RegTimer(this, (HANDLE)eUpdateGatewayStateHandle, 0, eUpdateGatewayStateInterval, eUpdateGatewayStateInterval, "gateway update state timer");	ASSERT_(m_hUpdateGateStateTimer);
}

void CGateway::Close()
{
	int i = 0;

	{
		ClientMap::iterator iter = m_clients.begin();
		for( i = 0 ; iter != m_clients.end(); i++, iter++ )
		{
			LinkContext_Client* pClient = iter->second;
			delete pClient;
		}
	}
	TRACE1_L2("CGateway::Close(), %i client is no released\n", i);

	{
		WorldMap::iterator iter = m_worlds.begin();
		for( i = 0 ; iter != m_worlds.end(); i++, iter++ )
		{
			LinkContext_World* pWorld = iter->second;
			delete pWorld;
		}
	}
	TRACE1_L2("CGateway::Close(), %i world is no released\n", i);

	if ( m_sessionSock != -1 && m_pSession == NULL )
		close(m_sessionSock);
	if ( m_pSession )
		delete m_pSession;
	if ( m_hReconnectSessionTimer )
		m_pThreadsPool->UnregTimer(m_hReconnectSessionTimer);
	TRACE0_L2("CGateway::Close(), m_pSession has been deleted\n");

	m_pThreadsPool->UnregTimer(m_hFastFrameTimer);
	m_pThreadsPool->UnregTimer(m_hSlowFrameTimer);
	m_pThreadsPool->UnregTimer(m_hUpdateGateStateTimer);

	IMsgLinksImpl<IID_IMsgLinksCG_L>::Clear();
	IMsgLinksImpl<IID_IMsgLinksWG_L>::Clear();
	IMsgLinksImpl<IID_IMsgLinksGS_C>::Clear();

	m_pLinkCtrl->CloseCtrl();
}

void CGateway::OnClientMsg(AppMsg* pMsg, HANDLE hLinkContext)
{
	LinkContext_Client* pContext = (LinkContext_Client*)hLinkContext;
	int linkType        = pContext->linkType;		unused(linkType);
	handle hLink        = pContext->hLink;			unused(hLink);
	const char* addr    = pContext->addr.c_str();	unused(addr);
	int port            = pContext->port;			unused(port);
	int state           = pContext->state;			unused(state);
	int msgCls          = pMsg->msgCls;
	int msgId           = pMsg->msgId;

#if DEBUG_L >= 2
	ClientMap::iterator iter = m_clients.find(hLink);
	if ( iter == m_clients.end() )
	{
		TRACE0_L2("CGateway::OnClientMsg(), no linkContext in ClientMap for Msg\n");
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
				if ( msgId == MSG_G_C_PLAYER_LOGIN )
				{
					if ( pContext->state != LINK_CONTEXT_CONNECTED )
					{
						TRACE0_L2("CGateway::OnClientMsg(), MSG_G_C_PLAYER_LOGIN is not the state(LINK_CONTEXT_CONNECTED)\n");
						TRACE1_L2("\thLink = %i\n", pContext->hLink);
						TRACE1_L2("\tstate = %i\n", pContext->state);
						TRACE1_L2("\taddr  = %s\n", pContext->addr.c_str());
						TRACE1_L2("\tport  = %i\n", pContext->port);
						ASSERT_(0);
						return;
					}
					_MsgCG_PlayerLoginInfo* pInfo = (_MsgCG_PlayerLoginInfo*)pMsg;
					PlayerInfo* player = g_playerMgr.regPlayer(pInfo->roleId);
					if ( !player )
					{
						TRACE1_L2("regPlayer faild, roleId = %i\n", pInfo->roleId);
						pContext->_Close(CLOSE_RELEASE);
						return;
					}
					player->accountId = pInfo->accountId;
					player->gatewayId = pInfo->gatewayId;
					player->worldId = pInfo->worldId;
					player->hLink = hLink;
					player->_SwitchStatus(PLAYER_STATUS_VERIFYING);
					pContext->pPlayer = player;
					pContext->_SwitchState(LINK_CONTEXT_RUNNING);
					send_MsgGS_UserVerifyInfo(pInfo);
					return;
				}

				if ( msgId == MSG_G_C_PLAYER_LOGOUT )
				{
					if ( pContext->state != LINK_CONTEXT_RUNNING )
					{
						TRACE0_L2("CGateway::OnClientMsg(), MSG_G_C_PLAYER_LOGOUT is not the state(LINK_CONTEXT_RUNNING)\n");
						TRACE1_L2("\thLink = %i\n", pContext->hLink);
						TRACE1_L2("\tstate = %i\n", pContext->state);
						TRACE1_L2("\taddr  = %s\n", pContext->addr.c_str());
						TRACE1_L2("\tport  = %i\n", pContext->port);
						ASSERT_(0);
						return;
					}
					_MsgCG_PlayerLogoutInfo* pInfo = (_MsgCG_PlayerLogoutInfo*)pMsg;
					PlayerInfo* player = pContext->pPlayer;
					if ( !player )
					{
						TRACE0_L2("CGateway::OnClientMsg(), MSG_G_C_PLAYER_LOGOUT throw exception\n");
						pContext->_Close(CLOSE_RELEASE);
						return;
					}
					if ( player->roleId != pInfo->roleId )
					{
						TRACE0_L2("CGateway::OnClientMsg(), MSG_G_C_PLAYER_LOGOUT, the wrong roleId from client\n");
						return;
					}
					if ( player->status != PLAYER_STATUS_LOADED )
					{
						TRACE0_L2("CGateway::OnClientMsg(), MSG_G_C_PLAYER_LOGOUT, the wrong status from player\n");
						TRACE1_L2("\troleId = %i\t", player->roleId);
						TRACE1_L2("\tstatus = %i\t", player->status);
						TRACE1_L2("\tlogout = %i\t", player->logoutReason);
						return;
					}

					TRACE1_L2("CGateway::OnClientMsg(), MSG_G_C_PLAYER_LOGOUT, the player[%i] normal logout\n", player->roleId);
					send_MsgGW_PlayerLogoutInfo(player, LOGOUT_REASON_CLIENT_NORMAL);
					return;
				}

				TRACE0_L2("CGateway::OnClientMsg(), Invalid msgId for MSG_CLS_LOGIN..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
				TRACE1_L2("\thLink = %i\n", pContext->hLink);
				TRACE1_L2("\tstate = %i\n", pContext->state);
				TRACE1_L2("\taddr  = %s\n", pContext->addr.c_str());
				TRACE1_L2("\tport  = %i\n", pContext->port);
			}
			break;
		case MSG_CLS_SCENE_RPC:
			{
				if ( pContext->state != LINK_CONTEXT_RUNNING ) return;
				PlayerInfo* player = pContext->pPlayer;
				if ( !player )
				{
					TRACE0_L2("CGateway::OnClientMsg(), MSG_CLS_SCENE_RPC throw exception\n");
					pContext->_Close(CLOSE_RELEASE);
					return;
				}
				pMsg->context = hLink;
				IMsgLinksImpl<IID_IMsgLinksWG_L>::SendMsg(player->hWorldLink, pMsg);
			}
			break;
		default:
			{
				TRACE0_L2("CGateway::OnClientMsg(), Invalid Msg..\n");
				TRACE1_L2("\tmsgCls = %i\n", msgCls);
				TRACE1_L2("\tmsgId = %i\n", msgId);
				TRACE1_L2("\thLink = %i\n", pContext->hLink);
				TRACE1_L2("\tstate = %i\n", pContext->state);
				TRACE1_L2("\taddr  = %s\n", pContext->addr.c_str());
				TRACE1_L2("\tport  = %i\n", pContext->port);
				ASSERT_(0);
			}
			break;
	}
}

void CGateway::OnWorldMsg(AppMsg* pMsg, HANDLE hLinkContext)
{
	LinkContext_World* pContext = (LinkContext_World*)hLinkContext;
	int linkType        = pContext->linkType;		unused(linkType);
	handle hLink        = pContext->hLink;			unused(hLink);
	const char* addr    = pContext->addr.c_str();	unused(addr);
	int port            = pContext->port;			unused(port);
	int state           = pContext->state;			unused(state);
	int msgCls          = pMsg->msgCls;
	int msgId           = pMsg->msgId;

#if DEBUG_L >= 2
	WorldMap::iterator iter = m_worlds.find(hLink);
	if ( iter == m_worlds.end() )
	{
		TRACE0_L2("CGateway::OnWorldMsg(), no linkContext in WorldMap for Msg\n");
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
				if ( msgId == MSG_G_W_SYN_WORLD_INFO )
				{
					_MsgWG_SYN_WorldInfo* pInfo = static_cast<_MsgWG_SYN_WorldInfo*>(pMsg);
					pContext->worldId	= pInfo->worldId;
					pContext->state		= LINK_CONTEXT_INIT_2;
					send_MsgGW_SYN_GatewayInfo(hLink);
					return;
				}

				if ( msgId == MSG_G_W_ACK_GATEWAY_INFO )
				{
					pContext->state = LINK_CONTEXT_CONNECTED;
					return;
				}
				TRACE0_L2("CGateway::OnWorldMsg(), Invalid msgId for MSG_CLS_STARTUP..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		case MSG_CLS_LOGIN:
			{
				if ( msgId == MSG_G_W_ACK_PLAYER_LOGIN )
				{
					_MsgWG_PlayerLogin_ResultInfo* pInfo = (_MsgWG_PlayerLogin_ResultInfo*)(pMsg);
					PlayerInfo* player = g_playerMgr.getPlayerInfo(pInfo->roleId);
					if ( !player )
					{
						TRACE1_L2("Gateway::OnWorldMsg(), login timeout, roleId = %i\n", pInfo->roleId);
						return;
					}
					if ( player->status != PLAYER_STATUS_LOADING )
					{
						ASSERT_(0);
						return;
					}
					send_MsgGS_UserLoginInfo(player, pInfo->result);
					send_MsgGC_PlayerLogin_ResultInfo(player, pInfo->result);

					if ( pInfo->result != 0 )
					{
						if ( player->hLink != 0 )
						{
							LinkContext_Client* pClient = getClientLink(player->hLink);
							pClient->_SwitchState(LINK_CONTEXT_DISCONNECTED);
						}
						g_playerMgr.unregPlayer(pInfo->roleId);
						return;
					}

					player->hWorldLink = hLink;
					player->_SwitchStatus(PLAYER_STATUS_LOADED);
					if ( player->hLink == 0 )
					{
						send_MsgGW_PlayerLogoutInfo(player, LOGOUT_REASON_CLIENT_FORCE);
					}
					return;
				}

				if ( msgId == MSG_G_W_ACK_PLAYER_LOGOUT )
				{
					_MsgWG_PlayerLogout_ResultInfo* pInfo = (_MsgWG_PlayerLogout_ResultInfo*)pMsg;
					PlayerInfo* player = g_playerMgr.getPlayerInfo(pInfo->roleId);
					if ( !player )
					{
						TRACE1_L2("Gateway::OnWorldMsg(), logout timeout, roleId = %i\n", pInfo->roleId);
						return;
					}
					if ( player->status != PLAYER_STATUS_UNLOADING && player->status != PLAYER_STATUS_LOADED )
					{
						TRACE0_L2("CGateway::OnWorldMsg(), player logout error\t");
						TRACE1_L2("\troleId = %i\n", pInfo->roleId);
						TRACE1_L2("\tclient = %u\n", player->hLink);
						TRACE1_L2("\tresult = %u\n", pInfo->result);
						TRACE1_L2("\tsrc reason = %i\n", player->logoutReason);
						TRACE1_L2("\tdes reason = %i\n", pInfo->reason);
						ASSERT_(0);
						return;
					}
					send_MsgGS_UserLogoutInfo(player, pInfo->result, pInfo->reason);
					send_MsgGC_PlayerLogout_ResultInfo(player, pInfo->result, pInfo->reason);
					player->_SwitchStatus(PLAYER_STATUS_UNLOADED);
					TRACE0_L2("CGateway::OnWorldMsg(), player logout\t");
					TRACE1_L2("\troleId = %i\n", pInfo->roleId);
					TRACE1_L2("\tclient = %u\n", player->hLink);
					TRACE1_L2("\tresult = %u\n", pInfo->result);
					TRACE1_L2("\tsrc reason = %i\n", player->logoutReason);
					TRACE1_L2("\tdes reason = %i\n", pInfo->reason);
					if ( pInfo->result == 0 ) g_playerMgr.unregPlayer(pInfo->roleId);
					return;
				}

				if ( msgId == MSG_W_G_WORLD_PLAYERS_LOGOUT )
				{
					_MsgWG_WorldPlayersLogout_ResultInfo* pInfo = (_MsgWG_WorldPlayersLogout_ResultInfo*)pMsg;
					short worldId = pInfo->worldId;
					PlayerMgr::PlayerMapIter iter = g_playerMgr.begin();
					PlayerMgr::PlayerMapIter iterEnd = g_playerMgr.end();
					TRACE1_L2("CGateway::OnWorldMsg(), world [%i] kick players!\n", worldId);
					for( ; iter != iterEnd; iter++ )
					{
						PlayerInfo& player = iter->second;
						if ( player.worldId!= worldId )
							continue;
						if ( player.status == PLAYER_STATUS_LOADING || player.status == PLAYER_STATUS_LOADED
							|| player.status == PLAYER_STATUS_UNLOADING)
						{
							send_MsgGS_UserLogoutInfo(&player, 0, LOGOUT_REASON_WORLD_KICK);
						}
						send_MsgGC_PlayerLogout_ResultInfo(&player, 0, LOGOUT_REASON_WORLD_KICK);
						player._SwitchStatus(PLAYER_STATUS_UNLOADED);
						TRACE1_L2("\troleId = %i is kicked out!\n", player.roleId);
						g_playerMgr.unregPlayer(player.roleId);
					}
					return;
				}

				TRACE0_L2("CGateway::OnWorldMsg(), Invalid msgId for MSG_CLS_LOGIN..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		case MSG_CLS_DEFAULT:
			{
				if ( msgId == MSG_G_W_SINK_PEER )
				{
					_MsgWG_SinkPeer* pSinkMsg = (_MsgWG_SinkPeer*)(pMsg);
					handle hClient = pSinkMsg->hClient;
					LinkContext_Client* pClient = getClientLink(hClient);
					if ( !pClient)
					{
						TRACE1_L2("CGateway::OnWorldMsg(), MSG_G_W_SINK_PEER, no client[%u]\n", hClient);
						return;
					}
					if ( !pClient->pPlayer )
					{
						TRACE1_L2("CGateway::OnWorldMsg(), MSG_G_W_SINK_PEER, no client->player[%u]\n", hClient);
						return;
					}
					if ( pClient->state != LINK_CONTEXT_RUNNING )
					{
						TRACE2_L2("CGateway::OnWorldMsg(), MSG_G_W_SINK_PEER, client[%u] is not the state of LINK_CONTEXT_RUNNING\n", hClient, pClient->state);
						return;
					}
					int offset = sizeof(_MsgWG_SinkPeer);
					IMsgLinksImpl<IID_IMsgLinksCG_L>::SendData(hClient, (BYTE*)pSinkMsg + offset, pSinkMsg->msgLen - offset);
					return;
				}

				if ( msgId == MSG_G_W_SINK_PEERS )
				{
					_MsgWG_SinkPeers* pSinkMsg = (_MsgWG_SinkPeers*)(pMsg);
					for ( int i = 0; i < pSinkMsg->count; i++ )
					{
						PeerHandle& peer = pSinkMsg->hPeers[i];
						if ( m_gatewayId != peer.gatewayId ) continue;
						LinkContext_Client* pClient = getClientLink(peer.hClient);
						if ( !pClient ) continue;
						int offset = sizeof(_MsgWG_SinkPeers) + sizeof(PeerHandle) * pSinkMsg->count;
						IMsgLinksImpl<IID_IMsgLinksCG_L>::SendData( peer.hClient, (BYTE*)pSinkMsg + offset, pSinkMsg->msgLen - offset );
					}
					return;
				}

				if ( msgId == MSG_G_W_SINK_WORLD_PEERS )
				{
					_MsgWG_SinkWorldPeers* pSinkMsg = (_MsgWG_SinkWorldPeers*)(pMsg);
					short worldId = pSinkMsg->worldId;
					PlayerMgr::PlayerMapIter iter = g_playerMgr.begin();
					PlayerMgr::PlayerMapIter iterEnd = g_playerMgr.end();
					for( ; iter != iterEnd; iter++ )
					{
						PlayerInfo& player = iter->second;
						if ( player.status != PLAYER_STATUS_LOADED ) continue;
						if ( player.worldId!= worldId ) continue;
						if ( player.hLink == (handle)INVALID_HANDLE ) continue;
						int offset = sizeof(_MsgWG_SinkWorldPeers);
						IMsgLinksImpl<IID_IMsgLinksCG_L>::SendData( player.hLink, (BYTE*)pSinkMsg + offset, pSinkMsg->msgLen - offset );
					}
					return;
				}

				if ( msgId == MSG_G_W_SINK_WORLD )
				{
					_MsgWG_SinkWorld* pSinkMsg = (_MsgWG_SinkWorld*)(pMsg);
					int offset = sizeof(_MsgWG_SinkWorld);
					short worldId = pSinkMsg->worldId;
					if ( worldId == -1 )
					{
						IMsgLinksImpl<IID_IMsgLinksWG_L>::SendData( (handle)INVALID_HANDLE, (BYTE*)pSinkMsg + offset, pSinkMsg->msgLen - offset );
						return;
					}

					LinkContext_World* pWorld = getWorldLinkById(worldId);
					if ( !pWorld ) return;
					IMsgLinksImpl<IID_IMsgLinksWG_L>::SendData( pWorld->hLink, (BYTE*)pSinkMsg + offset, pSinkMsg->msgLen - offset );
					return;
				}
				TRACE0_L2("CGateway::OnWorldMsg(), Invalid msgId for MSG_CLS_DEFAULT..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		default:
			{
				TRACE0_L2("CGateway::OnWorldMsg(), Invalid Msg..\n");
				TRACE1_L2("\tmsgCls = %i\n", msgCls);
				TRACE1_L2("\tmsgId = %i\n", msgId);
				ASSERT_(0);
			}
			break;
	}

	return;
}

void CGateway::OnSessionMsg(AppMsg* pMsg, HANDLE hLinkContext)
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
				if ( msgId == MSG_G_S_ACK_GATEWAY_INFO )
				{
					pContext->state = LINK_CONTEXT_CONNECTED;
					return;
				}

				TRACE0_L2("CGateway::OnSessionMsg(), Invalid msgId for MSG_CLS_STARTUP..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		case MSG_CLS_LOGIN:
			{
				if ( msgId == MSG_G_S_KICK_ACCOUNT )
				{
					_MsgSG_KickAccountInfo* pInfo = (_MsgSG_KickAccountInfo*)pMsg;
					PlayerInfo* player = g_playerMgr.getPlayerInfo(pInfo->roleId);
					if ( !player )
					{
						TRACE0_L2("CGateway::OnSessionMsg(), MSG_G_S_ACK_USER_VERIFY(player has been logout)\n");
						TRACE1_L2("\troleId = %i\n", pInfo->roleId);
						return;
					}
					if ( player->status != PLAYER_STATUS_LOADED )
					{
						TRACE0_L2("CGateway::OnSessionMsg(), MSG_G_S_KICK_ACCOUNT, the wrong status from player\n");
						TRACE1_L2("\troleId = %i\t", player->roleId);
						TRACE1_L2("\tstatus = %i\t", player->status);
						TRACE1_L2("\tlogout = %i\t", player->logoutReason);
						return;
					}
					send_MsgGW_PlayerLogoutInfo(player ,LOGOUT_REASON_SESSION_KICK);
					return;
				}

				if ( msgId == MSG_G_S_ACK_USER_VERIFY )
				{
					_MsgSG_UserVerify_ResultInfo* pInfo = (_MsgSG_UserVerify_ResultInfo*)pMsg;
					PlayerInfo* player = g_playerMgr.getPlayerInfo(pInfo->roleId);
					if ( !player )
					{
						TRACE0_L2("CGateway::OnSessionMsg(), warning for MSG_G_S_ACK_USER_VERIFY(timeout)\n");
						TRACE1_L2("\troleId = %i\n", pInfo->roleId);
						return;
					}
					if ( player->hLink == 0 )
					{
						g_playerMgr.unregPlayer(pInfo->roleId);
						return;
					}
					if ( pInfo->result != 0 )
					{
						g_playerMgr.unregPlayer(pInfo->roleId);
						LinkContext_Client* pClient = getClientLink(player->hLink); ASSERT_(pClient);
						pClient->_Close(CLOSE_RELEASE);
						return;
					}
					LinkContext_World* pWorld = getWorldLinkById(player->worldId);
					ASSERT_(pWorld);
					if ( !pWorld )
					{
						g_playerMgr.unregPlayer(pInfo->roleId);
						LinkContext_Client* pClient = getClientLink(player->hLink); ASSERT_(pClient);
						pClient->_Close(CLOSE_RELEASE);
						return;
					}
					send_MsgGW_PlayerLoginInfo(pWorld->hLink, player->roleId, player->hLink);
					player->_SwitchStatus(PLAYER_STATUS_LOADING);
					return;
				}

				TRACE0_L2("CGateway::OnSessionMsg(), Invalid msgId for MSG_CLS_LOGIN..\n");
				TRACE1_L2("\tmsgId = %i\n", msgId);
			}
			break;
		default:
			{
				TRACE0_L2("CGateway::OnSessionMsg(), Invalid Msg..\n");
				TRACE1_L2("\tmsgCls = %i\n", msgCls);
				TRACE1_L2("\tmsgId = %i\n", msgId);
				ASSERT_(0);
			}
			break;
	}

	return;
}

void CGateway::OnClientClosed(HANDLE hLinkContext, HRESULT reason)
{
	LinkContext_Client* pContext = (LinkContext_Client*)hLinkContext;
	int linkType = pContext->linkType;	unused(linkType);
	handle hLink = pContext->hLink;		unused(hLink);

	ClientMap::iterator iter = m_clients.find(hLink);
	if ( iter != m_clients.end() )
	{
		LinkContext_Client* pClient = iter->second; ASSERT_( pContext == pClient );
		g_playerMgr.onLinkClosed(pClient->pPlayer);
		m_clients.erase(iter);
	}
	else
	{
		ASSERT_(0);
	}

	delete pContext;
}

void CGateway::OnWorldClosed(HANDLE hLinkContext, HRESULT reason)
{
	LinkContext_World* pContext = (LinkContext_World*)hLinkContext;
	int linkType = pContext->linkType;	unused(linkType);
	handle hLink = pContext->hLink;		unused(hLink);

	WorldMap::iterator iter = m_worlds.find(hLink);
	if ( iter != m_worlds.end() )
	{
		LinkContext_World* pWorld = iter->second; ASSERT_( pContext == pWorld );
		m_worlds.erase(iter);
	}
	else
	{
		ASSERT_(0);
	}

	delete pContext;
}

void CGateway::OnSessionClosed(HANDLE hLinkContext, HRESULT reason)
{
	LinkContext_Session* pContext = (LinkContext_Session*)hLinkContext;
	int linkType = pContext->linkType; unused(linkType);
	handle hLink = pContext->hLink; unused(hLink);

	LinkContext_Session* pSession = m_pSession; ASSERT_( pContext == pSession );
	m_pSession = NULL;

	delete pSession;
}

void CGateway::handleFastFrame()
{

}

void CGateway::handleSlowFrame()
{

}

void CGateway::handleSessionReconnect()
{
	m_hReconnectSessionTimer = NULL;

	ILinkSink* pSessionSink	= static_cast< IMsgLinksImpl<IID_IMsgLinksGS_C>* >(this);
	HRESULT hr = m_pLinkCtrl->Connect(m_sessionIP.c_str(), m_sessionPort, pSessionSink, 0); ASSERT_( SUCCEEDED(hr) );

	m_sessionSock = hr;

	return;
}

void CGateway::handleUpdateGatewayState()
{
	if ( m_pSession == NULL )
		return;

	if ( m_pSession->state != LINK_CONTEXT_CONNECTED )
		return;

	if( isCastedState() )
		send_MsgGS_UP_GatewayState();
}

HRESULT CGateway::Do(HANDLE hContext)
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
		case eUpdateGatewayStateHandle:
			handleUpdateGatewayState();
			break;
		default:
			ASSERT_(0);
			break;
	}

	return S_OK;
}

HANDLE CGateway::OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType)
{
	int iPort = 0;
	char strbuf[1024] = {0};
	pPort->GetRemoteAddr(strbuf, 1024, &iPort);

	TRACE4_L2("(%i)CGateway::OnConnects(), %s( %s:%d ) comes\n", operaterId, translateLinkType(iLinkType), strbuf, iPort);

	if ( iLinkType == IID_IMsgLinksCG_L )
	{
		LinkContext_Client* pClient = new LinkContext_Client(iLinkType, hLink);
		pClient->addr = strbuf;
		pClient->port = iPort;
		pClient->pThreadsPool = GlobalThreadsPool();
		pClient->_SwitchState(LINK_CONTEXT_CONNECTED);
		m_clients.insert( ClientMap::value_type(hLink, pClient) );
		return pClient;
	}

	if ( iLinkType == IID_IMsgLinksWG_L)
	{
		LinkContext_World* pWorld = new LinkContext_World(iLinkType, hLink);
		pWorld->addr = strbuf;
		pWorld->port = iPort;
		m_worlds.insert( WorldMap::value_type(hLink, pWorld) );
		return pWorld;
	}

	if ( iLinkType == IID_IMsgLinksGS_C )
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

		send_MsgGS_SYN_GatewayInfo(hLink);

		return pSession;
	}

	TRACE1_L2("--CGateway::OnConnects(), error LinkType( %s )\n", translateLinkType(iLinkType));

	return NULL;
}

void CGateway::DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext)
{
	_LinkContext* pContext = (_LinkContext*)hLinkContext;
	int linkType		= pContext->linkType;		unused(linkType);
	int hLink			= pContext->hLink;			unused(hLink);
	const char* addr	= pContext->addr.c_str();	unused(addr);
	int port			= pContext->port;			unused(port);
	int state			= pContext->state;			unused(state);

	TRACE0_L3("CGateway::DefaultMsgProc()\n");
	TRACE1_L3("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L3("\taddr = %s:%i\n", addr, port);

	if ( linkType == IID_IMsgLinksCG_L )
	{
		OnClientMsg(pMsg, hLinkContext);
		return;
	}

	if ( linkType == IID_IMsgLinksWG_L )
	{
		OnWorldMsg(pMsg, hLinkContext);
		return;
	}

	if ( linkType == IID_IMsgLinksGS_C )
	{
		OnSessionMsg(pMsg, hLinkContext);
		return;
	}

	TRACE0_L2("--CGateway::DefaultMsgProc(), error\n");
	TRACE1_L2("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);
	return;
}

void CGateway::OnClosed(HANDLE hLinkContext, HRESULT reason)
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

	TRACE0_L2("CGateway::OnClosed()\n");
	TRACE1_L2("\tLinkType = %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);
	TRACE1_L2("\treason = %s\n", translateReason(reason));

	if ( linkType == IID_IMsgLinksCG_L )
	{
		OnClientClosed(hLinkContext, reason);
		return;
	}

	if ( linkType == IID_IMsgLinksWG_L )
	{
		OnWorldClosed(hLinkContext, reason);
		return;
	}

	if ( linkType == IID_IMsgLinksGS_C )
	{
		OnSessionClosed(hLinkContext, reason);
		return;
	}

	TRACE0_L2("--CGateway::OnClosed(), error\n");
	TRACE1_L2("\tLinkType	= %s\n", translateLinkType(linkType));
	TRACE2_L2("\taddr = %s:%i\n", addr, port);

	return;
}

CGateway g_gateway;
