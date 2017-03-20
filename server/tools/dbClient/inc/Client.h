#pragma once
#include "IDBAClient.h"
#include "Singleton.h"
#include "dbx_msgdef.h"

#include <map>

struct AppMsg;
class NetCtrl;


class CClient:public IInitClient, public TSingleton<CClient>
{
public:
	CClient();
	~CClient(void);

	void ConnectDBX(std::string p_serverAddr, int p_port);

    int callDBProc(CSCResultMsg *pMsg);
	int callDBSQL(AppMsg *pMsg);
	virtual int callSPFROMCPP();

    static IDBANetEvent* getDBNetEvent();
	static void setDBNetEvent(IDBANetEvent* pNetEventHandle);

	void* getAttributeSet(int attriIndex,int index=0);
	void  deleteAttributeSet(int index);

    void ConnectResult(HRESULT p_result);
    void Recv(AppMsg* p_appMsg);

    virtual void buildQuery();
    virtual int addParam(const char*, const char*);
    virtual int addParam(const char*, int);

private:
    static int GenerateOperationID();

    void AddQueryResult(CSCResultMsg* pMsg);

	IThreadsPool* m_pThreads;
	static IDBANetEvent* m_queryResultHandle;	

	typedef std::multimap<int,CSCResultMsg*> MAPATTRSET;
	MAPATTRSET m_mapResultSet;

	DbxMessageBuilder<CSCResultMsg> m_msgBuilder;

    NetCtrl *m_netCtrl;
};
