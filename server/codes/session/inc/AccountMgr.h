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
	ACCOUNT_STATE_LOADED,
	ACCOUNT_STATE_KICKING,
	ACCOUNT_STATE_OFFLINE,
	ACCOUNT_STATE_OFFLINE_IN_FIGHT,
	ACCOUNT_STATE_RECONNECTING_FIGHT,
};

enum _AccountStateIntervals
{
	eAccountLoginedInterval				= -1,
	eAccountLoadingInterval				= 1000 * 60 * 3,
	eAccountLoadedInterval				= -1,
	eAccountKickingInterval				= 1000 * 60 * 1,
	eAccountOfflineInterval				= -1,
	eAccountOfflineInFightInterval		= -1,
	eAccountReconnectingFightInterval 	= 1000 * 5,
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
	bool			isFight;
	bool			isOffline;
	int				version;

	AccountInfo();

	AccountInfo(int id, handle h);

	~AccountInfo();

	void _SwitchStatus(int s);

	virtual HRESULT Do(HANDLE hContext);

	bool getIsFight(){return isFight;}
	bool getIsOffline(){return isOffline;}
	void setIsFight(bool st) {isFight = st;}
	void setIsOffline(bool st) {isOffline = st;}
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

	bool saveAccountInfo(std::string _name, int _id, std::string _pass)
	{
		std::pair<SavedAccountInfoMap::iterator, bool> rt =
			m_savedAccounts.insert(make_pair(_name, SavedAccountInfo(_id, _pass)));
		return rt.second;
	}

	int getIdByName(std::string& userName)
	{
		SavedAccountInfoMap::iterator iter = m_savedAccounts.find(userName);
		if (iter == m_savedAccounts.end())
			return -1;
		return (iter->second).accountId;
	}

	bool updateNamePasswd(std::string& userName, std::string& passwd)
	{
		m_savedAccounts[userName].password = passwd;
		return true;
	}

	bool verifyPasswd(std::string& userName, std::string& passwd)
	{
		return (m_savedAccounts[userName].password == passwd);
	}

private:
	struct SavedAccountInfo{
		int accountId;
		std::string password;
		SavedAccountInfo(){}
		SavedAccountInfo(int _id, std::string _pass):
			accountId(_id), password(_pass){}
	};
public:
	typedef std::map<int, AccountInfo> AccountMap;
	typedef AccountMap::iterator AccountMapIter;
	typedef std::map<std::string, SavedAccountInfo> SavedAccountInfoMap;

private:
	AccountMap				m_accounts;
	SavedAccountInfoMap		m_savedAccounts;
};

extern AccountMgr g_accountMgr;

#endif
