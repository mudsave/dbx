/**
 * filename : LinkContext.cpp
 * desc : gateway中的各种连接上下文
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "PlayerMgr.h"
#include "LinkContext.h"
#include "gateway.h"

LinkContext_Client::~LinkContext_Client()
{
	if ( hStateTimer != NULL )
	{
		pThreadsPool->UnregTimer(hStateTimer);
		hStateTimer = NULL;
	}
}

void LinkContext_Client::_Close(int opt)
{
	bool ret = g_gateway.IMsgLinksImpl<IID_IMsgLinksCG_L>::IsValidLink(hLink); ASSERT_(ret);

	if ( ret )
	{
		g_gateway.IMsgLinksImpl<IID_IMsgLinksCG_L>::CloseLink(hLink, opt);
	}
}

void LinkContext_Client::_SwitchState(int s)
{
	if ( state == s )
	{
		return;
	}

	if ( hStateTimer != NULL )
	{
		pThreadsPool->UnregTimer(hStateTimer);
		hStateTimer = NULL;
	}

	int interval = -1;
	if ( s == LINK_CONTEXT_CONNECTED ) interval = eClientConnectedInterval;
	else if ( s == LINK_CONTEXT_RUNNING ) interval = eClientRunningInterval;
	else if ( s == LINK_CONTEXT_DISCONNECTED ) interval = eClientDisconnectedInterval;

	if ( interval != -1 )
		hStateTimer = pThreadsPool->RegTimer( this, (HANDLE)s, 0, interval, 0, "gateway client state timer" );

	state = s;
}

HRESULT LinkContext_Client::Do(HANDLE hContext)
{
	int state = (int)(long)(hContext);
	switch ( state )
	{
		case LINK_CONTEXT_CONNECTED:
		case LINK_CONTEXT_DISCONNECTED:
			_Close(CLOSE_RELEASE);
			break;
		default:
			ASSERT_(0);
			break;
	}

	return S_OK;
}
