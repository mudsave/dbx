/**
 * filename : LinkContext.h
 * desc : session中的各种连接上下文
 */

#ifndef __LINK_CONTEXT_H_
#define __LINK_CONTEXT_H_

#include "dbmsg.h"
#include <string>
#include <map>

enum _LinkContextState
{
	LINK_CONTEXT_INIT,
	LINK_CONTEXT_CONNECTED,
	LINK_CONTEXT_LOGINING,
	LINK_CONTEXT_LOGINING_PENDING,
	LINK_CONTEXT_LOGINED,
	LINK_CONTEXT_ROLE_CREATEING,
	LINK_CONTEXT_ROLE_DELETEING,
	LINK_CONTEXT_DISCONNECTED
};

enum _ClientStateIntervals
{
	eClientInitInterval				= -1,
	eClientConnectedInterval		= 1000 * 60 * 1,
	eClientLoginingInterval			= 1000,
	eClientLoginingPendingInterval	= 1000,
	eClientLoginedInterval			= 1000 * 60 * 2,
	eClientRoleCreateingInterval	= -1,
	eClientRoleDeleteingInterval	= -1,
	eClientDisconnectedInterval		= 10000
};

struct _LinkContext
{
	int linkType;
	handle hLink;
	std::string addr;
	int port;
	int state;

	_LinkContext(int type, handle h) : linkType(type), hLink(h), port(0), state(LINK_CONTEXT_INIT){}

	virtual int getLinkType()
	{
		return linkType;
	}
};

struct LinkContext_Client : public _LinkContext, public ITask
{
	std::string				accountName;
	std::string				passwd;
	int						accountId;
	int						roleId;
	short					gatewayId;
	short					worldId;
	DBMsg_LoginResult*		roleList;
	HANDLE					hStateTimer;
	IThreadsPool*			pThreadsPool;

public:
	std::map<std::string, int>	m_creatingList;

public:
	LinkContext_Client(int type, handle h) : _LinkContext(type, h),
		accountId(-1), roleId(-1),
		gatewayId(-1), worldId(-1),
		roleList(NULL), hStateTimer(NULL), pThreadsPool(NULL) {}

	~LinkContext_Client();

public:
	void doLoginAccount(DBMsg_LoginResult* pRet = NULL);

	void doKickAccount(AccountInfo& account);

	void doKickAccount(AccountInfo& account, DBMsg_LoginResult* pRet);

	void onLoginError(int reason, DBMsg_LoginResult* pRet);

public:
	void _Close(int opt = 0);

	void _SwitchState(int s);

public:
	void OnPendingOver();

	void OnNetMsg(AppMsg* pMsg);

	void OnDBMsg(_DBMsg* pMsg);

public:
	virtual HRESULT Do(HANDLE hContext);

public:
	bool IsValidRole(int roleId)
	{
		for (int num = 0; num < roleList->roleNum; num++)
		{
			if( roleId == roleList->role[num].roleId)
				return false;
		}
		return true;
	}
};

struct LinkContext_Gate : public _LinkContext
{
	short		gatewayId;
	char		addr_client[_IP_ADDR_LEN];
	short		port_client;
	char		addr_world[_IP_ADDR_LEN];
	short		port_world;
	short		clientCount;
	short		worldCount;
	short		worldList[MAX_WORLDS];

	LinkContext_Gate(int type, handle h) : _LinkContext(type, h)
	{
		gatewayId		= -1;
		port_client		= 0;
		port_world		= 0;
		clientCount		= 0;
		worldCount		= 0;
		memset( (void*)addr_client,	0,	_IP_ADDR_LEN );
		memset( (void*)addr_world,	0,	_IP_ADDR_LEN );
		memset( (void*)worldList,	0,	_IP_ADDR_LEN );
	}
};

struct LinkContext_World : public _LinkContext
{
	short		worldId;
	short		playerCount;

	LinkContext_World(int type, handle h) : _LinkContext(type, h)
	{
		worldId			= -1;
		playerCount		= 0;
	}
};

#endif
