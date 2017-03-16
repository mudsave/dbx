#include "stdafx.h"
#include "Client.h"

#include "NetCtrl.h"
#include "lindef.h"

#define DB_CLIENT_RECONNECT_INTERVAL 5000

struct _LinkContext_DB
{
	int linkType;
	handle hLink;
	int idx;
	_LinkContext_DB(int type, handle h): linkType(type), hLink(h), idx(-1){}
};

IDBANetEvent* CClient::s_pNetEventHandle=NULL;

CClient::CClient(): m_netCtrl(NULL)
{
	m_pThreads = ::GlobalThreadsPool(CLS_THREADS_POLL);
    m_netCtrl = new NetCtrl();

    CCommandClient* pCmd = CCommandClient::getCommandClient();//初始化CCommandClient
}

CClient::~CClient(void)
{
	closeLink(CLOSE_UNGRACEFUL);

    delete m_netCtrl;
    m_netCtrl = NULL;
}

void CClient::ConnectDBX(std::string serverAddr, int iPort)
{
    m_netCtrl->Connect(serverAddr, iPort);
}

void CClient::setAttributeSet(int index,CSCResultMsg *pInfo)
{
	m_MapAttrSet.insert(std::make_pair(index,pInfo));
}
void* CClient::getAttributeSet(int attriIndex,int index)
{
	MAPATTRSET::iterator iter=m_MapAttrSet.lower_bound(attriIndex);
	for(int i=0;iter!=m_MapAttrSet.upper_bound(attriIndex);i++,iter++) {
		if(i==index) {
			return iter->second;
		}
	}
    return NULL;
}

void CClient::deleteAttributeSet(int index) {
	MAPATTRSET::iterator iter=m_MapAttrSet.lower_bound(index);
	for (;iter!=m_MapAttrSet.upper_bound(index);) {
		//printf("deleteAttributeSet,p=%d\n",(int)(long)iter->second);
		if (iter->second) free (iter->second);
		m_MapAttrSet.erase(iter++);
	}
}

int CClient::callDBProc(AppMsg *pMsg) {
	CCSResultMsg* pDataMsg=(CCSResultMsg*)pMsg;
	int nOperationId=0;
	if (pMsg!=NULL)	{
		nOperationId=CClient::generateOperationId();
		pMsg->msgId=C_DOACTION;
		pMsg->context=CCSRESMSG;
		if(pDataMsg->m_nTempObjId==0) pDataMsg->m_nTempObjId=nOperationId;
		else
			nOperationId=pDataMsg->m_nTempObjId;

        m_netCtrl->Send(pMsg);
	}
	return nOperationId;
}

int CClient::callDBSQL(AppMsg *pMsg) 
{
	int nOperationId=0;
	if (pMsg!=NULL)	{
		nOperationId=CClient::generateOperationId();
		CCSResultMsg* pDataMsg=(CCSResultMsg*)pMsg;
		pMsg->msgId=C_DOSQL;
		pMsg->context=CCSRESMSG;
		if(pDataMsg->m_nTempObjId==0) pDataMsg->m_nTempObjId=nOperationId;
		else
			nOperationId=pDataMsg->m_nTempObjId;

        m_netCtrl->Send(pMsg);
	}
	return nOperationId;
}

IDBANetEvent* CClient::getDBNetEvent() 
{
	return s_pNetEventHandle;
}

void CClient::setDBNetEvent(IDBANetEvent* pNetEventHandle) 
{
	s_pNetEventHandle=pNetEventHandle;
}

int CClient::generateOperationId() 
{
	static int nOperationId=0;
	nOperationId++;
	return nOperationId;
}

bool CClient::closeLink(DWORD dwFlags) 
{
    m_netCtrl->Close(dwFlags);
    return true;
}

int CClient::addParam(const char* name, const char* value) 
{
	m_msgBuilder.addAttribute(name, value, strlen(value));
}

int CClient::addParam(const char* name, int value) 
{
	m_msgBuilder.addAttribute(name, &value, PARAMINT);
}

void CClient::buildQuery(){
	m_msgBuilder.beginMessage();
}

int CClient::callSPFROMCPP(IDBCallback* call_back) 
{
	CCSResultMsg* pMsg = m_msgBuilder.finishMessage();
	
	pMsg->m_spId = 0;
	pMsg->m_bNeedCallback = true;
	pMsg->m_nLevel = 20;
	pMsg->msgId = C_SP_FROM_CPP;
	pMsg->context = CCSRESMSG;
	pMsg->m_nTempObjId = CClient::generateOperationId();
	
	m_callbacks.insert(std::make_pair(pMsg->m_nTempObjId, call_back));
	
    m_netCtrl->Send(pMsg);

	return pMsg->m_nTempObjId;
}

void CClient::ConnectResult(HRESULT p_result)
{
    if (s_pNetEventHandle)
    {
        bool result = (p_result == S_OK ? true : false);
        s_pNetEventHandle->onConnected(result);
    }
}

void CClient::Recv(AppMsg* p_appMsg)
{
    CCommandClient::getCommandClient()->OnRecv(p_appMsg);
}