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
	ACCOUNT_STATE_OFFLINE_IN_FIGHT,
	ACCOUNT_STATE_RECONNECTING_FIGHT,
};

enum _AccountStateIntervals
{
	eAccountLoginedInterval			= -1,
	eAccountLoadingInterval			= 1000 * 60 * 4,
	eAccountLoadingOneInterval		= 1000 * 1,
	eAccountLoadedInterval			= -1,
	eAccountKickingInterval			= 1000 * 60 * 1,
	eAccountOfflineInterval			= -1,
	eAccountOfflineInFightInterval	= -1,
	eAccountReconnectingFightInterval = 1000 * 5,
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
	std::string		m_accountName;
	bool			inFight;

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

	bool regAccount(int id, handle h)
	{
		std::pair< AccountMapIter, bool > retPair = m_accounts.insert( AccountMap::value_type(id, AccountInfo(id, h)) );

		AccountMapIter iter		= retPair.first;
		bool bRet				= retPair.second;

		return bRet;
	}

	bool unregAccount(int id);

public:

	bool hasUserName(std::string& userName)
	{
		PasswordMap::iterator iter = m_passwds.find(userName);
		if(iter != m_passwds.end())
			return true;
		return false;
	}

	bool addUserNamePasswd(std::string& userName, std::string& passwd)
	{
		std::pair<PasswordMap::iterator, bool> rt = m_passwds.insert(
			PasswordMap::value_type(userName, passwd));
		return rt.second;
	}

	bool updateNamePasswd(std::string& userName, std::string& passwd)
	{
		if (hasUserName(userName))
			m_passwds[userName] = passwd;
		else
			addUserNamePasswd(userName, passwd);
		return true;
	}

	bool verifyPasswd(std::string& userName, std::string& passwd)
	{
		return (m_passwds[userName] == passwd);
	}

public:
	void regOffFightAccount(int accountId)
	{
		m_offFightAccounts.insert(OffFightAccountMap::value_type
			(getAccount(accountId).m_accountName, accountId));
	}

	void unregOffFightAccount(int accountId)
	{
		m_offFightAccounts.erase(getAccount(accountId).m_accountName);
	}

	int isOfflineInFight(std::string& userName)
	{
		OffFightAccountMap::iterator iter = m_offFightAccounts.find(userName);
		if(iter != m_offFightAccounts.end())
			return iter->second;
		return -1;
	}

public:
	typedef std::map<int, AccountInfo> AccountMap;
	typedef AccountMap::iterator AccountMapIter;
	typedef std::map<std::string, int> OffFightAccountMap;
	typedef std::map<std::string, std::string> PasswordMap;

private:
	AccountMap				m_accounts;
	OffFightAccountMap 		m_offFightAccounts;
	PasswordMap 			m_passwds;
};

extern AccountMgr g_accountMgr;

#endif
