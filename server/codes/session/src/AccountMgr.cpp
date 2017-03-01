/**
 * filename : AccountMgr.cpp
 * desc : 账号管理
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "AccountMgr.h"
#include "LinkContext.h"
#include "session.h"

AccountInfo::AccountInfo() : accountId(-1), roleId(-1), gatewayId(-1), worldId(-1),
	status(-1), hAccountTimer(NULL), hLink(0), hPendingLink(0), isFight(false),
	isOffline(false), version(0)
{
	pThreadsPool = GlobalThreadsPool();
}

AccountInfo::AccountInfo(int id, handle h) : accountId(id), roleId(-1), gatewayId(-1),
	worldId(-1), status(ACCOUNT_STATE_LOGINED), hAccountTimer(NULL), hLink(h),
	hPendingLink(0), isFight(false), isOffline(false), version(0)
{
	pThreadsPool = GlobalThreadsPool();
}

AccountInfo::~AccountInfo()
{
	if ( hAccountTimer != NULL )
	{
		pThreadsPool->UnregTimer(hAccountTimer);
		hAccountTimer = NULL;
	}
}

void AccountInfo::_SwitchStatus(int s)
{
	if ( status == s )
		return;

	if ( hAccountTimer != NULL )
	{
		pThreadsPool->UnregTimer(hAccountTimer);
		hAccountTimer = NULL;
	}

	int interval = -1;
	if ( s == ACCOUNT_STATE_LOGINED ) interval = eAccountLoginedInterval;
	else if ( s == ACCOUNT_STATE_LOADING ) interval = eAccountLoadingInterval;
	else if ( s == ACCOUNT_STATE_LOADED ) interval = eAccountLoadedInterval;
	else if ( s == ACCOUNT_STATE_KICKING ) interval = eAccountKickingInterval;
	else if ( s == ACCOUNT_STATE_RECONNECTING_FIGHT ) interval = eAccountReconnectingFightInterval;

	if ( interval != -1 )
		hAccountTimer = pThreadsPool->RegTimer( this, (HANDLE)s, 0, interval, 0, "Account Info state timer" );

	status = s;
	return;
}

HRESULT AccountInfo::Do(HANDLE hContext)
{
	hAccountTimer = NULL;
	int state = (int)(long)(hContext);
	switch ( state )
	{
		case ACCOUNT_STATE_LOADING:
			{
				g_accountMgr.unregAccount(accountId);
				TRACE1_L2("timeout(state ACCOUNT_STATE_LOADING) of Account(%i) comes..\n", accountId);
			}
			break;
		case ACCOUNT_STATE_KICKING:
			{
				g_accountMgr.unregAccount(accountId);
				TRACE1_L2("timeout(state ACCOUNT_STATE_KICKING) of Account(%i) comes..\n", accountId);
			}
			break;
		case ACCOUNT_STATE_RECONNECTING_FIGHT:
			{
				g_accountMgr.unregAccount(accountId);
				TRACE1_L2("timeout(state ACCOUNT_STATE_RECONNECTING_FIGHT) of Account(%i) comes..\n", accountId);
			}
			break;
		default:
			{
				TRACE2_L2("timeout(error state %i) of Account(%i) comes..\n", state, accountId);
			}
			break;
	}
	return S_OK;
}


bool AccountMgr::unregAccount(int id)
{
	AccountMapIter iter = m_accounts.find(id);
	if ( iter != m_accounts.end() )
	{
		AccountInfo& info = iter->second;
		handle hPending = info.hPendingLink;
		m_accounts.erase(iter);
		LinkContext_Client* pOtherClient = g_session.getClientLink(hPending);
		if ( pOtherClient ) pOtherClient->OnPendingOver();
		return true;
	}

	return false;
}

AccountMgr g_accountMgr;
