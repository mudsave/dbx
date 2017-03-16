#pragma once
#include "IDBAClient.h"
#include "CommandClient.h"
#include "Singleton.h"
#include "dbx_msgdef.h"

#include <map>

#define	 PARAMMAX 10

struct AppMsg;
class NetCtrl;


class CClient:public IInitClient, public TSingleton<CClient>
{
public:
	CClient();
	~CClient(void);
	void ConnectDBX(std::string serverAddr,int iPort);
	int callDBProc(AppMsg *pMsg);
	int callDBSQL(AppMsg *pMsg);
	virtual int callSPFROMCPP(IDBCallback*);

    static IDBANetEvent* getDBNetEvent();
	static void setDBNetEvent(IDBANetEvent* pNetEventHandle);
	static int generateOperationId();
	bool closeLink(DWORD dwFlags);

	void* getAttributeSet(int attriIndex,int index=0);
	void  setAttributeSet(int index,CSCResultMsg *pInfo);
	void  deleteAttributeSet(int index);

    void ConnectResult(HRESULT p_result);
    void Recv(AppMsg* p_appMsg);

private:
	IThreadsPool* m_pThreads;
	static IDBANetEvent* s_pNetEventHandle;	

	typedef std::multimap<int,CSCResultMsg*> MAPATTRSET;
	MAPATTRSET m_mapAttrSet;

	DbxMessageBuilder<CCSResultMsg> m_msgBuilder;

    NetCtrl *m_netCtrl;

public:
	virtual void buildQuery();
	virtual int addParam(const char*, const char*);
	virtual int addParam(const char*, int);

	typedef std::map<int, IDBCallback*> MAPCALLBAK;
	MAPCALLBAK m_callbacks;
};
