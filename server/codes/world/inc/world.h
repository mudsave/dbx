/**
 * filename : world.h
 * desc :	处理world的网络事件
 *			处理world的定时器
 *			处理gateway的异步任务
 */

#ifndef __WORLD_H_
#define __WORLD_H_

#include "LuaFunctor.h"
#include "LuaEngine.h"
#include "LuaArray.h"
#include "dbProxy.h"
#include "ScriptTimer.h"
#include "LinkContext.h"
#include <map>

enum TaskHandles
{
	eFastFrameHandle,
	eSlowFrameHandle,
	eReconnSessionHandle,
	eUpdateWorldStateHandle,
	eCleanUpHandle
};

enum TaskIntervals
{
	eFastFrameInterval			= 100,
	eSlowFrameInterval			= 10000,
	eReconnSessionInterval		= 1000 * 30,
	eUpdateWorldStateInterval	= 1000,
	eCleanUpInterval			= 3000
};


class CWorld :
	public ITask,
	public IMsgLinksImpl<IID_IMsgLinksWS_C>,
	public IMsgLinksImpl<IID_IMsgLinksWG_C>
{
public:
	CWorld();

	~CWorld();

public:
	void Init( short worldId, const char* sessionIP, int sessionPort, char* dbIP, int dbPort );

	void Close();

	void CleanUp();

public:
	void OnSessionMsg(AppMsg* pMsg, HANDLE hLinkContext);

	void OnGatewayMsg(AppMsg* pMsg, HANDLE hLinkContext);

public:
	void OnSessionClosed(HANDLE hLinkContext, HRESULT reason);

	void OnGatewayClosed(HANDLE hLinkContext, HRESULT reason);

public:
	void handleFastFrame();

	void handleSlowFrame();

	void handleSessionReconnect();

	void handleUpdateWorldState();

	void handleCleanUp();

public:
	virtual HRESULT Do(HANDLE hContext);

public:
	virtual HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType);

	virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext);

	virtual void OnClosed(HANDLE hLinkContext, HRESULT reason);

private:
	bool IsDirtyState()
	{
		if ( m_castedPlayerCount == -1 )
			return true;

		if ( m_playerCount != m_castedPlayerCount )
			return true;

		return false;
	}

private:
	void send_MsgWS_SYN_WorldInfo(handle hLink)
	{
		_MsgWS_SYN_WorldInfo msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_STARTUP;
		msg.msgId		= MSG_S_W_SYN_WORLD_INFO;
		msg.worldId		= m_worldId;
		msg.msgLen		= sizeof(msg);

		IMsgLinksImpl<IID_IMsgLinksWS_C>::SendMsg(hLink, &msg);
	}

	void send_MsgWS_UP_WorldState()
	{
		_MsgWS_UP_WorldState msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_STARTUP;
		msg.msgId		= MSG_S_W_UPDATE_WORLD_STATE;
		msg.playerCount	= m_playerCount;
		msg.msgLen		= sizeof(msg);

		IMsgLinksImpl<IID_IMsgLinksWS_C>::SendMsg(m_pSession->hLink, &msg);
	}

	void send_MsgWG_SYN_WorldInfo(handle hLink)
	{
		_MsgWG_SYN_WorldInfo msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_STARTUP;
		msg.msgId		= MSG_G_W_SYN_WORLD_INFO;
		msg.worldId		= m_worldId;
		msg.msgLen		= sizeof(msg);

		IMsgLinksImpl<IID_IMsgLinksWG_C>::SendMsg(hLink, &msg);
	}

	void send_MsgWG_ACK_GatewayInfo(handle hLink)
	{
		_MsgWG_ACK_GatewayInfo msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_STARTUP;
		msg.msgId		= MSG_G_W_ACK_GATEWAY_INFO;
		msg.msgLen		= sizeof(msg);

		IMsgLinksImpl<IID_IMsgLinksWG_C>::SendMsg(hLink, &msg);
	}

public:
	int send_MsgWG_PlayerLogin_ResultInfo(handle hLink, int roleId, int result)
	{
		ASSERT_(hLink > 0);
		ASSERT_(roleId > 0);
		_MsgWG_PlayerLogin_ResultInfo msg;
		msg.msgFlags = 0;
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_G_W_ACK_PLAYER_LOGIN;
		msg.roleId = roleId;
		msg.result = result;
		msg.context	= 0;
		msg.msgLen = sizeof(msg);
		IMsgLinksImpl<IID_IMsgLinksWG_C>::SendMsg(hLink, &msg);
		return 0;
	}

	int send_MsgWG_PlayerLogout_ResultInfo(handle hLink, int roleId, int result, int reason)
	{
		ASSERT_(hLink > 0);
		ASSERT_(roleId > 0);
		_MsgWG_PlayerLogout_ResultInfo msg;
		msg.msgFlags = 0;
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_G_W_ACK_PLAYER_LOGOUT;
		msg.roleId = roleId;
		msg.result = result;
		msg.reason = reason;
		msg.context	= 0;
		msg.msgLen = sizeof(msg);
		IMsgLinksImpl<IID_IMsgLinksWG_C>::SendMsg(hLink, &msg);
		return 0;
	}

	int send_MsgWG_WorldPlayersLogout_ResultInfo(short worldId)
	{
		_MsgWG_WorldPlayersLogout_ResultInfo msg;
		msg.msgFlags = 0;
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_W_G_WORLD_PLAYERS_LOGOUT;
		msg.worldId = worldId;
		msg.context	= 0;
		msg.msgLen = sizeof(msg);
		HRESULT hr = S_OK;
		hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData( (handle)INVALID_HANDLE, (BYTE*)&msg, sizeof(msg) );
		ASSERT_( SUCCEEDED(hr) );
		return 0;
	}

	int send_MsgWG_OfflineInFight(handle hLink, int roleId)
	{
		_MsgWG_OfflineInFight msg;
		msg.msgFlags = 0;
		msg.msgCls = MSG_CLS_OFFLINE;
		msg.msgId = MSG_W_G_OFFLINE_IN_FIGHT;
		msg.roleId = roleId;
		msg.context	= 0;
		msg.msgLen = sizeof(msg);
		IMsgLinksImpl<IID_IMsgLinksWG_C>::SendMsg(hLink, &msg);
		return 0;
	}

public:
	int send_MsgWS_ClearOffFightInfo(int accountId)
	{
		_MsgWS_ClearOffFightInfo msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_OFFLINE;
		msg.msgId		= MSG_W_S_CLEAR_OFF_FIGHT;
		msg.accountId	= accountId;
		msg.context		= 0;
		msg.msgLen		= sizeof(msg);
		IMsgLinksImpl<IID_IMsgLinksWS_C>::SendMsg(m_pSession->hLink, &msg);
		return 0;
	}

	int send_MsgWS_StartFight(int accountId)
	{
		_MsgWS_StartFight msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_OFFLINE;
		msg.msgId		= MSG_W_S_START_FIGHT;
		msg.accountId	= accountId;
		msg.context		= 0;
		msg.msgLen		= sizeof(msg);
		IMsgLinksImpl<IID_IMsgLinksWS_C>::SendMsg(m_pSession->hLink, &msg);
		return 0;
	}

	int send_MsgWS_StopFight(int accountId)
	{
		_MsgWS_StopFight msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_OFFLINE;
		msg.msgId		= MSG_W_S_STOP_FIGHT;
		msg.accountId	= accountId;
		msg.context		= 0;
		msg.msgLen		= sizeof(msg);
		IMsgLinksImpl<IID_IMsgLinksWS_C>::SendMsg(m_pSession->hLink, &msg);
		return 0;
	}

public:
	void sendMsgToPeer(handle hGate, handle hClient, const AppMsg* pMsg)
	{
		if ( IMsgLinksImpl<IID_IMsgLinksWG_C>::IsValidLink(hGate) )
		{
			_MsgWG_SinkPeer msg;
			msg.msgFlags	= 0;
			msg.msgCls		= MSG_CLS_DEFAULT;
			msg.msgId		= MSG_G_W_SINK_PEER;
			msg.context		= 0;
			msg.msgLen		= sizeof(msg) + pMsg->msgLen;
			msg.hClient		= hClient;
			HRESULT hr = S_OK;
			hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData(hGate, (BYTE*)&msg, sizeof(msg)); ASSERT_( SUCCEEDED(hr) );
			hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData(hGate, (BYTE*)pMsg, pMsg->msgLen); ASSERT_( SUCCEEDED(hr) );
		}
		else
		{
			TRACE1_L2("CWorld::sendMsgToPeer(), error for hGate(%u)\n", hGate);
		}
	}

	void sendMsgToPeers(PeerHandle* pPeers, int count, const AppMsg* pMsg)
	{
		ASSERT_( pPeers );
		ASSERT_( count > 0 || count < 500 );

		if ( !pPeers ) return;
		if ( count <= 0 || count >= 500 ) return;

		static char buff[_MaxMsgLength] = {0};
		_MsgWG_SinkPeers* msg = (_MsgWG_SinkPeers*)buff;
		msg->msgFlags	= 0;
		msg->msgCls		= MSG_CLS_DEFAULT;
		msg->msgId		= MSG_G_W_SINK_PEERS;
		msg->context	= 0;
		msg->count		= count;
		msg->msgLen		= sizeof(_MsgWG_SinkPeers) + sizeof(PeerHandle) * count + pMsg->msgLen;
		memcpy(msg->hPeers, pPeers, sizeof(PeerHandle) * count);

		HRESULT hr = S_OK;
		hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData( (handle)INVALID_HANDLE, (BYTE*)msg, sizeof(_MsgWG_SinkPeers) + sizeof(PeerHandle) * count ); ASSERT_( SUCCEEDED(hr) );
		hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData( (handle)INVALID_HANDLE, (BYTE*)pMsg, pMsg->msgLen ); ASSERT_( SUCCEEDED(hr) );
	}

	void sendMsgToWorldPeers(short worldId, AppMsg* pMsg)
	{
		_MsgWG_SinkWorldPeers msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_DEFAULT;
		msg.msgId		= MSG_G_W_SINK_WORLD_PEERS;
		msg.context		= 0;
		msg.msgLen		= sizeof(msg) + pMsg->msgLen;
		msg.worldId		= worldId;

		HRESULT hr = S_OK;
		hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData( (handle)INVALID_HANDLE, (BYTE*)&msg, sizeof(msg)); ASSERT_( SUCCEEDED(hr) );
		hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData( (handle)INVALID_HANDLE, (BYTE*)pMsg, pMsg->msgLen); ASSERT_( SUCCEEDED(hr) );
	}

	void sendMsgToWorld(short worldId, AppMsg* pMsg)
	{
		_MsgWG_SinkWorld msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_DEFAULT;
		msg.msgId		= MSG_G_W_SINK_WORLD;
		msg.context		= 0;
		msg.msgLen		= sizeof(msg) + pMsg->msgLen;
		msg.worldId		= worldId < 0 ? -1 : worldId;

		handle hLink = IMsgLinksImpl<IID_IMsgLinksWG_C>::RandomGetLink();
		if ( hLink != (handle)INVALID_HANDLE )
		{
			HRESULT hr = S_OK;
			hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData(hLink, (BYTE*)&msg, sizeof(msg)); ASSERT_( SUCCEEDED(hr) );
			hr = IMsgLinksImpl<IID_IMsgLinksWG_C>::SendData(hLink, (BYTE*)pMsg, pMsg->msgLen); ASSERT_( SUCCEEDED(hr) );
		}
		else
		{
			TRACE1_L2("CWorld::sendMsgToWorld(), error for hLink(%u)\n", hLink);
		}
	}

private:
	bool luaStart(lua_State* pLuaState)
	{
		LuaFunctor<TypeNull, int> startFunc(pLuaState, "ManagedApp.start");
		if ( !startFunc( TypeNull::nil(), m_worldId ) )
		{
			TRACE2_L1("[CWorld::luaStart] failed in worldID %d because of:%s\n", m_worldId, startFunc.getLastError());
			return false;
		}

		return true;
	}

	void setFightServerLoads(lua_State* pLuaState)
	{
		static int ref = LUA_NOREF;
		if (ref == LUA_NOREF)
			ref = PushMethod(pLuaState, "FightServerLoad.setLoad");
		ASSERT_(ref != LUA_NOREF);
		lua_rawgeti(pLuaState, LUA_REGISTRYINDEX, ref);
		lua_newtable(pLuaState);
		for(int i = 0; i < m_fightServerNum; i++)
		{
			lua_pushinteger(pLuaState, m_fightLoads[i].serverId);
			lua_pushinteger(pLuaState, m_fightLoads[i].load);
			lua_rawset(pLuaState, -3);
		}
		int rt = lua_pcall(pLuaState, 1, 0, 0);
		if (rt)
		{
			const char* errMsg = luaL_checkstring(pLuaState, -1);
			TRACE2_L0("[world::setFightServerLoads] error No:%d, error Msg:%s\n",
			rt, errMsg);
		}
	}

public:
	short getWorldId()
	{
		return m_worldId;
	}

    lua_State* getLuaState()
    {
    	return m_pLuaEngine->GetLuaState();
    }

	handle getGateLinkById(short id)
	{
		GateMap::iterator iter = m_gates.begin();
		for(; iter != m_gates.end(); iter++)
		{
			if(iter->second->gatewayId == id)
				return iter->first;
		}
		return 0;
	}

private:
	const char* translateLinkType(int linkType)
	{
		if ( linkType == IID_IMsgLinksWS_C )
			return "World-->Session";

		if ( linkType == IID_IMsgLinksWG_C )
			return "World->Gateway";

		return "Gateway->error";
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
	typedef std::map<handle, LinkContext_Gate*>	GateMap;

public:
	enum _ConnStatus
	{
		eConnEmpty,
		eConnInit,
		eConnConnecting,
		eConnConnected,
		eConnFailed,
		eConnClosed
	};

	struct GateConnection
	{
		short				id;
		std::string			addr;
		short				port;
		_ConnStatus			status;
		HRESULT				sock;
		LinkContext_Gate*	context;

		GateConnection() : id(-1), port(0), status(eConnEmpty), sock(-1), context(NULL){}
	};

private:
	GateConnection			m_gateConns[MAX_GATEWAYS];

private:
	GateMap					m_gates;

private:
	int 					m_fightServerNum;
	FightServerLoad*		m_fightLoads;

private:
	std::string				m_sessionIP;
	short					m_sessionPort;
	std::string				m_dbIP;
	short					m_dbPort;

private:
	HRESULT					m_sessionSock;
	LinkContext_Session*	m_pSession;

private:
	HANDLE					m_hFastFrameTimer;
	HANDLE					m_hSlowFrameTimer;
	HANDLE					m_hReconnectSessionTimer;
	HANDLE					m_hUpdateWorldStateTimer;

private:
	ILinkCtrl*				m_pLinkCtrl;
	IThreadsPool*			m_pThreadsPool;

private:
	CLuaEngine*				m_pLuaEngine;

private:
	short					m_worldId;

private:
	short					m_playerCount;
	short					m_castedPlayerCount;
};


extern CWorld g_world;

#endif
