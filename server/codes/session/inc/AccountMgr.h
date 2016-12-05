/**
 * filename : AccountMgr.h
 * desc : 账号管理
 */

#ifndef __ACCOUNT_MGR_H_
#define __ACCOUNT_MGR_H_

#include <map>

enum _AccountState
{
	ACCOUNT_STATE_LOGINED,
	ACCOUNT_STATE_LOADING,
	ACCOUNT_STATE_LOADING_1,
	ACCOUNT_STATE_LOADED,
	ACCOUNT_STATE_KICKING,
	ACCOUNT_STATE_OFFLINE,
};

enum _AccountStateIntervals
{
	eAccountLoginedInterval		= -1,
	eAccountLoadingInterval		= 5000 * 1,
	eAccountLoadingOneInterval	= 1000 * 1,
	eAccountLoadedInterval		= -1,
	eAccountKickingInterval		= 1000 * 1,
	eAccountOfflineInterval		= -1,
};

struct AccountInfo : public ITask
{
	int				accountId;
	int				roleId;
	short			gatewayId;
	short			worldId;
	int				status;
	HANDLE			hAccountTimer;
	handle			hLink;
	handle			hPendingLink;
	IThreadsPool*	pThreadsPool;

	AccountInfo();

	AccountInfo(int id, handle h);

	~AccountInfo();

	void _SwitchStatus(int s);

	virtual HRESULT Do(HANDLE hContext);
};

class AccountMgr
{
public:
	AccountMgr(){}
	~AccountMgr(){}

public:
	bool isRegistered(int id)
	{
		AccountMapIter iter = m_accounts.find(id);
		return iter != m_accounts.end();
	}

	AccountInfo& getAccount(int id)
	{
		bool ret = isRegistered(id); ASSERT_(ret);
		return m_accounts[id];
	}

	AccountInfo* getAccountPtr(int id)
	{
		AccountMapIter iter = m_accounts.find(id);
		if ( iter != m_accounts.end() )
			return &(iter->second);
		return NULL;
	}

public:
	bool regAccount(int id, handle h)
	{
		std::pair< AccountMapIter, bool > retPair = m_accounts.insert( AccountMap::value_type(id, AccountInfo(id, h)) );

		AccountMapIter iter		= retPair.first;
		bool bRet				= retPair.second;

		return bRet;
	}

	bool unregAccount(int id);

public:
	typedef std::map<int, AccountInfo> AccountMap;
	typedef AccountMap::iterator AccountMapIter;

private:
	AccountMap		m_accounts;
};

extern AccountMgr g_accountMgr;

#endif
