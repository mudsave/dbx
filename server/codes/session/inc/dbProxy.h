/**
 * filename : dbProxy.h
 * desc : 处理存储过程回调
 */

#ifndef __DBANETEVENT_H___
#define __DBANETEVENT_H___

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "IDBAClient.h"
#include "Client.h"
#include "dbmsg.h"


enum _StoreType
{
	eStoreBase = 0,
	eStoreLogin,
	eStoreCreateAccount,
	eStoreCreateRole,
	eStoreDeleteRole,
	eStoreCheckRole,
};

extern IInitClient* g_pDBAClient;

class CDBProxy :
	public IDBANetEvent,
    public ITask
{
public:
	CDBProxy(void);

public:
	~CDBProxy(void);

public:
	void init(const char* dbIp, int dbPort);

public:
    void onExeDBProc(int id, IInitClient* pInitClient, bool result);
	
	void onConnected(bool result);
    virtual HRESULT Do(HANDLE hContext);

public:
	void doLogin(char* userName, char* password, handle hLink);
	
	void doCreateAccount(char* userName, char* password, handle hLink);

	void doCreateRole( handle hLink, int accountId, _MsgCS_CreateRoleInfo* roleInfo);

	void doDeleteRole(int accountId, int roleId, handle hLink);

	void doCheckRoleName(char* roleName, handle hLink);
public:
	struct _DBStoreContext
	{
		int storeType;
		handle hLink;
		std::string accountName;
		_DBStoreContext() : storeType(eStoreBase), hLink(0) ,accountName("")
		{}
	};

	typedef std::map<int, _DBStoreContext> DBSTOREMAP;
	DBSTOREMAP m_mapDBStore;

private:
    void onDBReturn(int operId, int errorCode);

    void doLoginResult(int operId, handle hLink);

    void doCreateAccountResult(int operId, handle hLink, std::string accountName);

    void doCreateRoleResult(int operId, handle hLink);

    void doDeleteRoleResult(int operId, handle hLink);

    void doCheckRoleNameResult(int operId, handle hLink);

    void PrintAttrInfo(PType p_ptype, char *p_name, void *p_attr, const char *p_description);

    DbxMessageBuilder<CSCResultMsg> m_msgBuilder;
};

extern CDBProxy g_DBProxy;

#endif
