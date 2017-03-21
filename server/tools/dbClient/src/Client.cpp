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

IDBANetEvent* CClient::m_queryResultHandle = NULL;

CClient::CClient(): m_netCtrl(NULL)
{
    m_pThreads = GlobalThreadsPool();
    m_netCtrl = new NetCtrl();
}

CClient::~CClient(void)
{
    m_netCtrl->Close(CLOSE_UNGRACEFUL);
    delete m_netCtrl;
}

void CClient::ConnectDBX(std::string p_serverAddr, int p_port)
{
    m_netCtrl->Connect(p_serverAddr, p_port);
}

void* CClient::getAttributeSet(int attriIndex,int index)
{
	MAPATTRSET::iterator iter = m_mapResultSet.lower_bound(attriIndex);
	for(int i = 0; iter != m_mapResultSet.upper_bound(attriIndex); i++, iter++) 
    {
		if(i == index) 
        {
			return iter->second;
		}
	}
    return NULL;
}

void CClient::deleteAttributeSet(int index) 
{
	MAPATTRSET::iterator iter=m_mapResultSet.lower_bound(index);
	for (;iter!=m_mapResultSet.upper_bound(index);) 
    {
		if (iter->second) 
            free (iter->second);

		m_mapResultSet.erase(iter++);
	}
}

int CClient::callDBProc(CSCResultMsg *pMsg)
{

	pMsg->msgId = C_DOACTION;
	pMsg->context = CCSRESMSG;
    pMsg->m_nTempObjId = CClient::GenerateOperationID();
    m_netCtrl->Send(pMsg);

    return pMsg->m_nTempObjId;
}

int CClient::callDBSQL(AppMsg *pMsg) 
{
	int nOperationId = 0;
	if (pMsg != NULL)	
    {
		nOperationId = CClient::GenerateOperationID();
		CCSResultMsg* pDataMsg = (CCSResultMsg*)pMsg;
		pMsg->msgId = C_DOSQL;
		pMsg->context = CCSRESMSG;
		if(pDataMsg->m_nTempObjId == 0) 
            pDataMsg->m_nTempObjId = nOperationId;
		else
			nOperationId = pDataMsg->m_nTempObjId;

        m_netCtrl->Send(pMsg);
	}
	return nOperationId;
}

IDBANetEvent* CClient::getDBNetEvent() 
{
	return m_queryResultHandle;
}

void CClient::setDBNetEvent(IDBANetEvent* pNetEventHandle) 
{
	m_queryResultHandle = pNetEventHandle;
}

int CClient::GenerateOperationID() 
{
	static int nOperationId = 0;
	nOperationId++;
	return nOperationId;
}

void CClient::ConnectResult(HRESULT p_result)
{
    if (m_queryResultHandle)
    {
        bool result = (p_result == S_OK ? true : false);
        m_queryResultHandle->onConnected(result);
    }
}

void CClient::Recv(AppMsg* p_appMsg)
{
    CSCResultMsg *pDataMsg = (CSCResultMsg *)p_appMsg;
    AddQueryResult(pDataMsg);
    if (pDataMsg->m_bEnd)
        getDBNetEvent()->onExeDBProc(pDataMsg->m_nTempObjId, this, true);
}

void CClient::AddQueryResult(CSCResultMsg* pMsg)
{
    pMsg->getInit();
    m_mapResultSet.insert(std::make_pair(pMsg->m_nTempObjId, pMsg));
}
