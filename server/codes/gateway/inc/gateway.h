/**
 * filename : gateway.h
 * desc :	处理gateway的网络事件
 *			处理gateway的定时器
 *			处理gateway的异步任务
 */

#ifndef __GATEWAY_H_
#define __GATEWAY_H_

#include "LinkContext.h"
#include <map>

enum TaskHandles
{
	eFastFrameHandle,
	eSlowFrameHandle,
	eReconnSessionHandle,
	eUpdateGatewayStateHandle
};

enum TaskIntervals
{
	eFastFrameInterval			= 100,
	eSlowFrameInterval			= 10000,
	eReconnSessionInterval		= 1000 * 30,
	eUpdateGatewayStateInterval	= 1000
};

class CGateway :
	public ITask,
	public IMsgLinksImpl<IID_IMsgLinksCG_L>,
	public IMsgLinksImpl<IID_IMsgLinksWG_L>,
	public IMsgLinksImpl<IID_IMsgLinksGS_C>
{
public:
	CGateway();
	~CGateway();

public:
	void Init(	short gatewayId,
				const char* loginIP,	int loginPort,
				const char* worldIP,	int worldPort,
				const char* sessionIP,	int sessionPort	);

	void Close();

public:
	void OnClientMsg(AppMsg* pMsg, HANDLE hLinkContext);

	void OnWorldMsg(AppMsg* pMsg, HANDLE hLinkContext);

	void OnSessionMsg(AppMsg* pMsg, HANDLE hLinkContext);

public:
	void OnClientClosed(HANDLE hLinkContext, HRESULT reason);

	void OnWorldClosed(HANDLE hLinkContext, HRESULT reason);

	void OnSessionClosed(HANDLE hLinkContext, HRESULT reason);

public:
	void handleFastFrame();

	void handleSlowFrame();

	void handleSessionReconnect();

	void handleUpdateGatewayState();

public:
	virtual HRESULT Do(HANDLE hContext);

public: 
	virtual HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType);

	virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext);

	virtual void OnClosed(HANDLE hLinkContext, HRESULT reason);


private:
	bool isCastedState()
	{
		bool isUpdate = false;
		CastedState t_castedState;
		t_castedState.clientCount = m_clients.size();
		t_castedState.worldCount = 0;
		
		for ( WorldMap::iterator iter = m_worlds.begin(); iter != m_worlds.end(); iter++ )
		{
			LinkContext_World* pWorld = iter->second;
			if ( pWorld->state == LINK_CONTEXT_CONNECTED )
			{
				t_castedState.worldIds[pWorld->worldId] = 1;
				t_castedState.worldCount++;
			}
		}

		if( m_castedState.clientCount == -1 && m_castedState.worldCount == -1 )
		{
			isUpdate = true;
		}
		else if( t_castedState != m_castedState )
		{
			isUpdate = true;
		}

		if( isUpdate )
		{
			m_castedState = t_castedState;
			return true;
		}
		return false;
	}

public:
	void send_MsgGS_SYN_GatewayInfo(handle hLink)
	{
		_MsgGS_SYN_GatewayInfo msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_STARTUP;
		msg.msgId		= MSG_S_G_SYN_GATEWAY_INFO;
		msg.msgLen		= sizeof(msg);

		msg.gatewayId	= m_gatewayId;
		msg.port_client	= m_loginPort;
		msg.port_world	= m_worldPort;

		strcpy( msg.addr_client,	m_loginIP.c_str() );
		strcpy( msg.addr_world,		m_worldIP.c_str() );

		IMsgLinksImpl<IID_IMsgLinksGS_C>::SendMsg(hLink, &msg);
	}

	void send_MsgGS_UP_GatewayState()
	{
		char buf[1024 * 4] = {0};

		_MsgGS_UP_GatewayState* pMsg = (_MsgGS_UP_GatewayState*)buf;
		pMsg->msgFlags		= 0;
		pMsg->msgCls		= MSG_CLS_STARTUP;
		pMsg->msgId			= MSG_S_G_UPDATE_GATEWAY_STATE;
		pMsg->clientCount	= m_clients.size();

		int i = 0;
		for ( WorldMap::iterator iter = m_worlds.begin(); iter != m_worlds.end(); iter++ )
		{
			LinkContext_World* pWorld = iter->second;
			if ( pWorld->state == LINK_CONTEXT_CONNECTED )
			{
				pMsg->worldIds[i++] = pWorld->worldId;
			}
		}

		pMsg->worldCount	= i;

		pMsg->msgLen		= sizeof(_MsgGS_UP_GatewayState) + sizeof(pMsg->worldIds[0]) * i;

		IMsgLinksImpl<IID_IMsgLinksGS_C>::SendMsg(m_pSession->hLink, pMsg);
	}

	void send_MsgGW_SYN_GatewayInfo(handle hLink)
	{
		_MsgGW_SYN_GatewayInfo msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_STARTUP;
		msg.msgId		= MSG_W_G_SYN_GATEWAY_INFO;
		msg.gatewayId	= m_gatewayId;
		msg.msgLen		= sizeof(msg);

		IMsgLinksImpl<IID_IMsgLinksWG_L>::SendMsg(hLink, &msg);
	}

public:
	void send_MsgGW_PlayerLoginInfo(handle hLink, int roleId, handle hClientLink)
	{
		_MsgGW_PlayerLoginInfo msg;
		msg.msgFlags    = 0;
		msg.msgCls      = MSG_CLS_LOGIN;
		msg.msgId       = MSG_W_G_PLAYER_LOGIN;
		msg.roleId		= roleId;
		msg.gatewayId	= m_gatewayId;
		msg.hClientLink	= hClientLink;
		msg.msgLen      = sizeof(msg);
		IMsgLinksImpl<IID_IMsgLinksWG_L>::SendMsg(hLink, &msg);
	}

	void send_MsgGW_PlayerLogoutInfo(PlayerInfo* player, int reason)
	{
		player->logoutReason = reason;
		player->_SwitchStatus(PLAYER_STATUS_UNLOADING);

		if ( player->hWorldLink == 0 ) return;
		_MsgGW_PlayerLogoutInfo msg;
		msg.msgFlags    = 0;
		msg.msgCls      = MSG_CLS_LOGIN;
		msg.msgId       = MSG_W_G_PLAYER_LOGOUT;
		msg.roleId		= player->roleId;
		msg.reason		= player->logoutReason;
		IMsgLinksImpl<IID_IMsgLinksWG_L>::SendMsg(player->hWorldLink, &msg);
	}

public:
	void send_MsgGC_PlayerLogin_ResultInfo(PlayerInfo* player, int result)
	{
		if ( player->hLink == 0 ) return;
		_MsgGC_PlayerLogin_ResultInfo msg;
		msg.msgFlags    = 0;
		msg.msgCls      = MSG_CLS_LOGIN;
		msg.msgId		= MSG_C_G_ACK_PLAYER_LOGIN;
		msg.result		= result;
		IMsgLinksImpl<IID_IMsgLinksCG_L>::SendMsg(player->hLink, &msg);
	}

	void send_MsgGC_PlayerLogout_ResultInfo(PlayerInfo* player, int result, int reason)
	{
		if ( player->hLink == 0 ) return;

		_MsgGC_PlayerLogout_ResultInfo msg;
		msg.msgFlags    = 0;
		msg.msgCls      = MSG_CLS_LOGIN;
		msg.msgId		= MSG_C_G_ACK_PLAYER_LOGOUT;
		msg.roleId		= player->roleId;
		msg.result		= result;
		msg.reason		= reason;
		IMsgLinksImpl<IID_IMsgLinksCG_L>::SendMsg(player->hLink, &msg);

		LinkContext_Client* pClient = getClientLink(player->hLink); ASSERT_(pClient);
		pClient->_SwitchState(LINK_CONTEXT_DISCONNECTED);
	}

public:
	void send_MsgGS_UserLoginInfo(PlayerInfo* player, int result)
	{
		if ( !m_pSession ) return;
		_MsgGS_UserLoginInfo msg;
		msg.msgFlags    = 0;
		msg.msgCls      = MSG_CLS_LOGIN;
		msg.msgId		= MSG_S_G_USER_LOADED;
		msg.accountId	= player->accountId;
		msg.roleId		= player->roleId;
		msg.result		= result;
		IMsgLinksImpl<IID_IMsgLinksGS_C>::SendMsg(m_pSession->hLink, &msg);
	}

	void send_MsgGS_UserLogoutInfo(PlayerInfo* player, int result, int reason)
	{
		if ( !m_pSession ) return;
		_MsgGS_UserLogoutInfo msg;
		msg.msgFlags    = 0;
		msg.msgCls      = MSG_CLS_LOGIN;
		msg.msgId		= MSG_S_G_USER_LOGOUT;
		msg.accountId	= player->accountId;
		msg.roleId		= player->roleId;
		msg.result		= result;
		msg.reason		= reason;
		IMsgLinksImpl<IID_IMsgLinksGS_C>::SendMsg(m_pSession->hLink, &msg);
	}

	void send_MsgGS_UserVerifyInfo(_MsgCG_PlayerLoginInfo* pInfo)
	{
		if ( !m_pSession ) return;
		_MsgGS_UserVerifyInfo msg;
		msg.msgFlags    = 0;
		msg.msgCls      = MSG_CLS_LOGIN;
		msg.msgId		= MSG_S_G_USER_VERIFY;
		msg.hLink		= pInfo->hLink;
		msg.accountId	= pInfo->accountId;
		msg.roleId		= pInfo->roleId;
		msg.gatewayId	= pInfo->gatewayId;
		msg.worldId		= pInfo->worldId;
		msg.msgLen      = sizeof(msg);
		IMsgLinksImpl<IID_IMsgLinksGS_C>::SendMsg(m_pSession->hLink, &msg);
	}

private:
	const char* translateLinkType(int linkType)
	{
		if ( linkType == IID_IMsgLinksCG_L ) 
			return "Gateway<--Client";

		if ( linkType == IID_IMsgLinksWG_L )
			return "Gateway<--World";

		if ( linkType == IID_IMsgLinksGS_C )
			return "Gateway-->Session";

		return "Gateway<--error";
	}

	const char* translateReason(HRESULT reason)
	{
		if ( reason == S_OK )
			return "close for eof";

		if ( reason == S_FALSE)
			return "close for timeout";

		if ( reason == E_FAIL )
			return "close for error";

		if ( reason == E_ABORT )
			return "close for abort";

		return "close for unknow reason";
	}

public:
	LinkContext_Client* getClientLink(handle h)
	{
		/**
		ClientMap::iterator iter = m_clients.find(h);
		if ( iter != m_clients.end() )
		{
			return iter->second;
		}
		return NULL;
		*/
		HANDLE hContext = IMsgLinksImpl<IID_IMsgLinksCG_L>::GetLinkContext(h);
		return (LinkContext_Client*)hContext;
	}

	LinkContext_World* getWorldLink(handle h)
	{
		/**
		WorldMap::iterator iter = m_worlds.find(h);
		if ( iter != m_worlds.end() )
		{
			return iter->second;
		}
		return NULL;
		*/
		HANDLE hContext = IMsgLinksImpl<IID_IMsgLinksWG_L>::GetLinkContext(h);
		return (LinkContext_World*)hContext;
	}

	LinkContext_World* getWorldLinkById(short id)
	{
		for ( WorldMap::iterator iter = m_worlds.begin(); iter != m_worlds.end(); iter++ )
		{
			LinkContext_World* pWorld = iter->second;
			if ( pWorld->worldId == id ) return pWorld;
		}
		return NULL;
	}

public:
	typedef std::map<handle, LinkContext_Client*>	ClientMap;
	typedef std::map<handle, LinkContext_World*>	WorldMap;

private:
	ClientMap				m_clients;
	WorldMap				m_worlds;

private:
	std::string				m_loginIP;
	short					m_loginPort;

	std::string				m_worldIP;
	short					m_worldPort;

	std::string				m_sessionIP;
	short					m_sessionPort;

private:
	HRESULT					m_sessionSock;
	LinkContext_Session*	m_pSession;

public:
	struct CastedState
	{
		short clientCount;
		short worldCount;
		short worldIds[MAX_GATEWAYS];
		CastedState():clientCount(0),worldCount(0)
		{
			memset(worldIds, 0 , sizeof(worldIds));
		};
		bool operator != (const CastedState &castedState)
		{
			if( clientCount != castedState.clientCount || worldCount != castedState.worldCount )
				return true;

			for( int i = 0; i < MAX_GATEWAYS; i++ )
			{
				if( (worldIds[i] == 1 && castedState.worldIds[i] == 0)|| 
					(worldIds[i] == 0 && castedState.worldIds[i] == 1))
				{
					return true;
				}
			}
			return false;
		}
		CastedState& operator = (const CastedState &castedState)
		{
			clientCount = castedState.clientCount;
			worldCount = castedState.worldCount;
			memset((void*) worldIds, 0 , sizeof(worldIds));
			for( int worldId = 0; worldId < MAX_GATEWAYS; worldId++ )
			{   
			     if( castedState.worldIds[worldId] == 1 )
				 {
					 worldIds[worldId] = 1;
				 }
			}
			return *this;
		}
	};
	
	CastedState				m_castedState;

private:
	HANDLE					m_hFastFrameTimer;
	HANDLE					m_hSlowFrameTimer;
	HANDLE					m_hReconnectSessionTimer;
	HANDLE					m_hUpdateGateStateTimer;

private:
	ILinkCtrl*				m_pLinkCtrl;
	IThreadsPool*			m_pThreadsPool;

private:
	short					m_gatewayId;
};

extern CGateway g_gateway;

#endif
