/**
 * filename : LinkContext.h
 * desc : gateway中的各种连接上下文
 */

#ifndef __LINK_CONTEXT_H_
#define __LINK_CONTEXT_H_

#include <string>

enum _LinkContextState
{
	LINK_CONTEXT_INIT,
	LINK_CONTEXT_INIT_2,
	LINK_CONTEXT_CONNECTED,
	LINK_CONTEXT_RUNNING,
	LINK_CONTEXT_DISCONNECTED
};

enum _ClientStateIntervals
{
	eClientConnectedInterval		= 1000 * 2,
	eClientRunningInterval			= -1,
	eClientDisconnectedInterval		= 1000 * 10
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

struct LinkContext_Session: public _LinkContext
{
	LinkContext_Session(int type, handle h) : _LinkContext(type, h){}
};

struct LinkContext_World : public _LinkContext
{
	short worldId;

	LinkContext_World(int type, handle h) : _LinkContext(type, h)
	{
		worldId = -1;
	}
};

struct LinkContext_Client : public _LinkContext, public ITask
{
	PlayerInfo*				pPlayer;
	HANDLE					hStateTimer;
	IThreadsPool*			pThreadsPool;

public:
	LinkContext_Client(int type, handle h) : _LinkContext(type, h), pPlayer(NULL), hStateTimer(NULL), pThreadsPool(NULL)
	{
		pThreadsPool = GlobalThreadsPool();
	}

	~LinkContext_Client();

public:
	void _Close(int opt = 0);

	void _SwitchState(int s);

public:
	virtual HRESULT Do(HANDLE hContext);
};

#endif
