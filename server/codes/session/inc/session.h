/**
 * filename : session.h
 * desc :	处理session的网络事件
 *			处理session的定时器
 *			处理session的异步任务
 */

#ifndef __SESSION_H_
#define __SESSION_H_

#include "dbmsg.h"
#include "dbProxy.h"
#include <map>
#include <vector>

enum TaskHandles
{
	eFastFrameHandle,
	eSlowFrameHandle
};

enum TaskIntervals
{
	eFastFrameInterval = 100,
	eSlowFrameInterval = 10000,
};

class CSession :
	public ITask,
	public IMsgLinksImpl<IID_IMsgLinksCS_L>,
	public IMsgLinksImpl<IID_IMsgLinksGS_L>,
	public IMsgLinksImpl<IID_IMsgLinksWS_L>
{
public:
	CSession();

	~CSession();

public:
	void Init(	const char* loginIP,	int loginPort,
				const char* gateIP,		int gatePort,
				const char* worldIP,	int worldPort,
				const char* dbIp,       int dbPort	);

	void Close();

public:
	void OnClientMsg(AppMsg* pMsg, HANDLE hLinkContext);

	void OnGateMsg(AppMsg* pMsg, HANDLE hLinkContext);

	void OnWorldMsg(AppMsg* pMsg, HANDLE hLinkContext);

public:
	void OnClientClosed(HANDLE hLinkContext, HRESULT reason);

	void OnGateClosed(HANDLE hLinkContext, HRESULT reason);

	void OnWorldClosed(HANDLE hLinkContext, HRESULT reason);

public:
	void OnDBReturn(_DBMsg* pMsg, handle hLink);

public:
	void handleFastFrame();

	void handleSlowFrame();

public:
	virtual HRESULT Do(HANDLE hContext);

public: 
	virtual HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType);

	virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext);

	virtual void OnClosed(HANDLE hLinkContext, HRESULT reason);

public:
	void send_MsgSG_ACK_GatewayInfo(handle hLink)
	{
		_MsgSG_ACK_GatewayInfo msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_STARTUP;
		msg.msgId		= MSG_G_S_ACK_GATEWAY_INFO;
		msg.msgLen		= sizeof(msg);

		IMsgLinksImpl<IID_IMsgLinksGS_L>::SendMsg(hLink, &msg);
	}

	void send_MsgSW_ACK_WorldInfo(handle hLink)
	{
		_MsgSW_ACK_WorldInfo msg;
		msg.msgFlags	= 0;
		msg.msgCls		= MSG_CLS_STARTUP;
		msg.msgId		= MSG_W_S_ACK_WORLD_INFO;
		msg.msgLen		= sizeof(msg);

		IMsgLinksImpl<IID_IMsgLinksWS_L>::SendMsg(hLink, &msg);
	}

	void send_MsgSW_UP_GatewayList(handle hLink)
	{
		char buf[1024 * 4] = {0};

		_MsgSW_UP_GatewayList* pMsg = (_MsgSW_UP_GatewayList*)buf;
		pMsg->msgFlags		= 0;
		pMsg->msgCls        = MSG_CLS_STARTUP;
		pMsg->msgId         = MSG_W_S_UPDATE_GATEWAY_LIST;

		int i = 0;
		_Gateway_Element* pElements = pMsg->gateElements;
		for ( GateMap::iterator iter = m_gates.begin(); iter != m_gates.end(); iter++ )
		{
			LinkContext_Gate* pGate = iter->second;
			if ( pGate->state == LINK_CONTEXT_CONNECTED )
			{
				_Gateway_Element& des	= pElements[i];
				des.gatewayId			= pGate->gatewayId;
				des.port				= pGate->port_world;
				memcpy( des.addr, pGate->addr_world, _IP_ADDR_LEN );
				i++;
			}
		}

		pMsg->gatewayCount	= i;
		pMsg->msgLen		= sizeof(_MsgSW_UP_GatewayList) + sizeof(_Gateway_Element) * i;

		IMsgLinksImpl<IID_IMsgLinksWS_L>::SendMsg(hLink, pMsg);
	}

	void send_MsgSW_UP_GatewayList(LinkContext_Gate* pGate)
	{
		char buf[1024 * 4] = {0};

		_MsgSW_UP_GatewayList* pMsg = (_MsgSW_UP_GatewayList*)buf;
		pMsg->msgFlags		= 0;
		pMsg->msgCls        = MSG_CLS_STARTUP;
		pMsg->msgId         = MSG_W_S_UPDATE_GATEWAY_LIST;

		_Gateway_Element* pElements = pMsg->gateElements;
		_Gateway_Element& des	= pElements[0];
		des.gatewayId			= pGate->gatewayId;
		des.port				= pGate->port_world;
		memcpy( des.addr, pGate->addr_world, _IP_ADDR_LEN );

		pMsg->gatewayCount	= 1;
		pMsg->msgLen		= sizeof(_MsgSW_UP_GatewayList) + sizeof(_Gateway_Element);

		for ( WorldMap::iterator iter = m_worlds.begin(); iter != m_worlds.end(); iter++ )
		{
			handle hLink = iter->first;
			LinkContext_World* pWorld = iter->second;
			if ( pWorld->state == LINK_CONTEXT_CONNECTED )
			{
				IMsgLinksImpl<IID_IMsgLinksWS_L>::SendMsg(hLink, pMsg);
			}
		}
	}

public:
	void send_MsgSC_WorldListInfo(handle hLink)
	{
		char buff[256] = {0};
		short worldCount = 0;
		_MsgSC_WorldListInfo* msg = (_MsgSC_WorldListInfo*)buff;
		for( WorldMap::iterator iter = m_worlds.begin(); iter != m_worlds.end(); iter++)
		{
			if ( iter->second->state == LINK_CONTEXT_CONNECTED )
			{
				msg->worldList[worldCount].worldId = iter->second->worldId;
				msg->worldList[worldCount].playerCount = iter->second->playerCount;
				worldCount++;
			}
		}
		msg->msgCls = MSG_CLS_LOGIN;
		msg->msgId = MSG_C_S_ACK_WORLD_LIST;
		msg->msgLen = sizeof(_MsgSC_WorldListInfo) + worldCount * (sizeof(_World_Element));
		msg->msgFlags = 0;
		msg->worldCount = worldCount;
		IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, msg);
	}

	void send_MsgSC_Login_ResultInfo(handle hLink, int reason, DBMsg_LoginResult* pRet )
	{
		if ( reason > 0 )
		{
			_MsgSC_Login_ResultInfo msg; 
			msg.msgCls =  MSG_CLS_LOGIN;
			msg.msgId = MSG_C_S_ACK_USER_LOGIN;
			msg.msgLen = sizeof(_MsgSC_Login_ResultInfo);
			msg.msgFlags = 0;
			msg.result = 1;	
			msg.reason = reason;
			IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, &msg);
			return;
		}

		char buff[512] = {0};
		_MsgSC_Login_ResultInfo* msg = (_MsgSC_Login_ResultInfo*)buff;
		msg->msgCls = MSG_CLS_LOGIN;
		msg->msgId = MSG_C_S_ACK_USER_LOGIN;
		msg->msgLen = sizeof(_MsgSC_Login_ResultInfo) + pRet->roleNum*(sizeof(_Role_Element));
		msg->msgFlags = 0;
		msg->result = 0;
		msg->reason = pRet->roleNum;
		for( int i = 0; i < pRet->roleNum; i++)
		{
		    msg->roleList[i].roleId = pRet->role[i].roleId;
		    msg->roleList[i].modelId = pRet->role[i].modelId;
		    msg->roleList[i].school = pRet->role[i].school;
		    msg->roleList[i].sex = pRet->role[i].sex;
		    msg->roleList[i].level = pRet->role[i].level;
		    strcpy(msg->roleList[i].showPart, pRet->role[i].showPart);
		    strcpy(msg->roleList[i].name, pRet->role[i].name);
		}
		IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, msg);
	}

	void send_MsgSC_ChooseRole_ResultInfo(handle hLink, int accountId, short gatewayId)
	{
		_MsgSC_ChooseRole_ResultInfo msg;
		msg.msgCls =  MSG_CLS_LOGIN;
		msg.msgId = MSG_C_S_ACK_CHOOSE_ROLE;
		msg.msgLen = sizeof(_MsgSC_ChooseRole_ResultInfo);
		msg.msgFlags = 0;
		msg.hLink = hLink;
		msg.accountId = accountId;
		bool isExit = false;
		for ( GateMap::iterator iter = m_gates.begin(); iter != m_gates.end(); iter++ )
		{
			if( iter->second->gatewayId == gatewayId )
			{
				strcpy(msg.addr, iter->second->addr_client);
				msg.port = iter->second->port_client;
				isExit = true;
				break;
			}
		}
		msg.gatewayId = gatewayId;
		if (!isExit)
			ASSERT_(0);
		IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, &msg);
	}

public:
	void send_MsgSC_AccountKickedInfo(handle hLink)
	{
		_MsgSC_AccountKickedInfo msg; 
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_C_S_ACCOUNT_KICKED;
		msg.msgLen = sizeof(_MsgSC_AccountKickedInfo);
		msg.msgFlags = 0;
		IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, &msg);
	}

	void send_MsgSG_KickAccountInfo(AccountInfo& account)
	{
		_MsgSG_KickAccountInfo msg;
		msg.msgCls =  MSG_CLS_LOGIN;
		msg.msgId = MSG_G_S_KICK_ACCOUNT;
		msg.msgLen = sizeof(_MsgSG_KickAccountInfo);
		msg.msgFlags = 0;
		msg.accountId = account.accountId;
		msg.roleId = account.roleId;
		LinkContext_Gate* pContext = getGatewayLink(account.gatewayId);
		IMsgLinksImpl<IID_IMsgLinksGS_L>::SendMsg(pContext->hLink, &msg);
	}

public:
	void send_MsgSC_CreateUser_ResultInfo(handle hLink, DBMsg_CreateAccountResult* pRet = NULL)
	{
		_MsgSC_CreateUser_ResultInfo msg;
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_C_S_ACK_USER_CREATE;
		msg.msgLen = sizeof(_MsgSC_CreateUser_ResultInfo);
		msg.msgFlags = 0;
		if ( pRet == NULL )
			msg.ret = 1;
		else
			msg.ret = pRet->result;
		IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, &msg);
	}

	void send_MsgSC_CreateRole_ResultInfo(handle hLink, DBMsg_CreateRoleResult* pRet)
	{
		_MsgSC_CreateRole_ResultInfo msg; 
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_C_S_ACK_ROLE_CREATE;
		msg.msgLen = sizeof(_MsgSC_CreateRole_ResultInfo);
		msg.msgFlags = 0;
		msg.ret = pRet->result;
		msg.roleId = pRet->roleId;
		IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, &msg);
	}

	void send_MsgSC_DeleteRole_ResultInfo(handle hLink, DBMsg_DeleteRoleResult* pRet)
	{
		_MsgSC_DeleteRole_ResultInfo msg; 
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_C_S_ACK_ROLE_DELETE;
		msg.msgLen = sizeof(_MsgSC_DeleteRole_ResultInfo);
		msg.msgFlags = 0;
		msg.roleId = pRet->roleId;
		msg.ret = pRet->result;	
		IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, &msg);
	}

	void send_MsgSC_CheckName_ResultInfo(handle hLink, bool result)
	{
		_MsgSC_CheckName_ResultInfo msg; 
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_C_S_ACK_ROLE_CHECK;
		msg.msgLen = sizeof(_MsgSC_CheckName_ResultInfo);
		msg.msgFlags = 0;
		msg.ret = result;	
		IMsgLinksImpl<IID_IMsgLinksCS_L>::SendMsg(hLink, &msg);
	}

	void send_MsgSG_UserVerify_ResultInfo(handle hLink, int roleId, int ret)
	{
		_MsgSG_UserVerify_ResultInfo msg;
		msg.msgCls = MSG_CLS_LOGIN;
		msg.msgId = MSG_G_S_ACK_USER_VERIFY;
		msg.msgLen = sizeof(_MsgSG_UserVerify_ResultInfo);
		msg.msgFlags = 0;
		msg.roleId = roleId;
		msg.result = ret;
		IMsgLinksImpl<IID_IMsgLinksGS_L>::SendMsg(hLink, &msg);
	}

private:
	bool IsValidGatewayId(short id)
	{
		if ( id < 0 )
			return false;

		if ( id >= MAX_GATEWAYS )
			return false;

		for ( IDPools::iterator iter = m_gateIds.begin(); iter != m_gateIds.end(); iter++ )
		{
			if ( *iter == id )
				return false;
		}

		return true;
	}

	bool IsValidWorldId(short id)
	{
		if ( id < 0 )
			return false;

		if ( id >= MAX_WORLDS )
			return false;

		for ( IDPools::iterator iter = m_worldIds.begin(); iter != m_worldIds.end(); iter++ )
		{
			if ( *iter == id )
				return false;
		}

		return true;
	}
private:
	void RegGatewayId(short id)
	{
		m_gateIds.push_back(id);
	}

	void RegWorldId(short id)
	{
		m_worldIds.push_back(id);
	}

private:
	const char* translateLinkType(int linkType)
	{
		if ( linkType == IID_IMsgLinksCS_L ) 
			return "Session<--Client";

		if ( linkType == IID_IMsgLinksGS_L )
			return "Session<--Gateway";

		if ( linkType == IID_IMsgLinksWS_L )
			return "Session<--World";

		return "Session<--error";
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
		ClientMap::iterator iter = m_clients.find(h);
		if ( iter != m_clients.end() )
		{
			return iter->second;
		}
		return NULL;
	}

	LinkContext_Gate* getGatewayLink(short id)
	{
		for ( GateMap::iterator iter = m_gates.begin(); iter != m_gates.end(); iter++ )
		{
			LinkContext_Gate* pGateInfo = iter->second;
			if ( pGateInfo->gatewayId == id )
				return pGateInfo;
		}
		return NULL; 
	}

public:
	short getRanGatewayId(short worldId)
	{
		int min = 9999;
		short id = -1;
		for ( GateMap::iterator iter = m_gates.begin(); iter != m_gates.end(); iter++ )
		{
			LinkContext_Gate* pGateInfo = iter->second;
			if ( pGateInfo->state != LINK_CONTEXT_CONNECTED )
			{
				continue;
			}

			if ( pGateInfo->worldList[worldId] == false )
			{
				continue;
			}

			int num = pGateInfo->clientCount;
			if ( num < min )
			{
				min = num;
				id = pGateInfo->gatewayId;
			}
		}
		return id;
	}

public:
	int IsValidPlayer(_MsgGS_UserVerifyInfo* pInfo)
	{
		if ( !g_accountMgr.isRegistered(pInfo->accountId) )
			return 1;
		AccountInfo& account = g_accountMgr.getAccount(pInfo->accountId);
		if ( account.hLink != pInfo->hLink )
			return 2;
		if ( account.accountId != pInfo->accountId )
			return 3;
		if ( account.roleId != pInfo->roleId )
			return 4;
		if ( account.gatewayId != pInfo->gatewayId )
			return 5;
		if ( account.worldId != pInfo->worldId )
			return 6;
		return 0;
	}

public:
	typedef std::vector<short>						IDPools;

public:
	typedef std::map<handle, LinkContext_Client*>	ClientMap;
	typedef std::map<handle, LinkContext_Gate*>		GateMap;
	typedef std::map<handle, LinkContext_World*>	WorldMap;

private:
	ClientMap		m_clients;
	GateMap			m_gates;
	WorldMap		m_worlds;

private:
	IDPools			m_gateIds;
	IDPools			m_worldIds;

private:
	HANDLE			m_hFastFrameTimer;
	HANDLE			m_hSlowFrameTimer;

private:
	ILinkCtrl*		m_pLinkCtrl;
	IThreadsPool*	m_pThreadsPool;
};

extern CSession g_session;

#endif
