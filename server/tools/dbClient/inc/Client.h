#pragma once
#include "IDBAClient.h"
#include "CommandClient.h"
#include "Singleton.h"
//#include "stdafx.h"
#include <map>


#define	 PARAMMAX 10

struct AppMsg;
#define IID_IMsgLinksCD_L 0x01 //客户端到dbserver的链接

class CClient: public ITask, public IInitClient, public IMsgLinksImpl<IID_IMsgLinksCD_L>, public TSingleton<CClient>
{
public:
	DECLARE_THREAD_SAFETY_MEMBER(sock);
	CClient();
	~CClient(void);
	void ConnectDBX(std::string serverAddr,int iPort);
	int callDBProc(AppMsg *pMsg);
	int callDBSQL(AppMsg *pMsg);
	virtual int callSPFROMCPP(IDBCallback*);
	
	virtual HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int i_link_type);
        virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext);
        virtual void OnClosed(HANDLE hLinkContext, HRESULT reason);
	void doFunciton(void);
	static IDBANetEvent* getDBNetEvent();
	static void setDBNetEvent(IDBANetEvent* pNetEventHandle);
	static int generateOperationId();
	bool closeLink(DWORD dwFlags);

	void* getAttributeSet(int attriIndex,int index=0);
	void  setAttributeSet(int index,CSCResultMsg *pInfo);
	void  deleteAttributeSet(int index);

	HRESULT Do(HANDLE hContext);
private:
    void StartConnectDBX();
    void StopConnectDBX();

    bool		m_connected;
	ILinkCtrl*	m_pLinkCtrl;
	std::string m_strServerAddr;
	int		m_iPort;
	IThreadsPool* m_pThreads;
	handle          m_hLink;
	static IDBANetEvent* s_pNetEventHandle;	

	typedef std::multimap<int,CSCResultMsg*> MAPATTRSET;
	typedef std::pair<int,CSCResultMsg*> MAPATTRSETPAIR;
	DECLARE_THREAD_SAFETY_MEMBER(Attr);
	
	MAPATTRSET		m_MapAttrSet;
       
	IThreadsPool*	m_pThreadPool;
	
	DbxMessageBuilder<CCSResultMsg> m_msgBuilder;

    HANDLE m_connectDBXTimer;
public:
	virtual void buildQuery();
	virtual int addParam(const char*, const char*);
	virtual int addParam(const char*, int);

	typedef std::map<int, IDBCallback*> MAPCALLBAK;
	MAPCALLBAK m_callbacks;
};
