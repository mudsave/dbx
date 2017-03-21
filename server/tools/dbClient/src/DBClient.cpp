#include "DBClient.h"

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


DBClient::DBClient()
    :m_netCtrl(NULL),
     m_queryResultHandle(NULL)

{
    m_pThreads = GlobalThreadsPool();
    m_netCtrl = new NetCtrl();
}

DBClient::~DBClient()
{
    disconnectDBX();
}

void DBClient::connectDBX(std::string p_serverAddr, int p_port)
{
    m_netCtrl->Connect(p_serverAddr, p_port);
}

void DBClient::disconnectDBX()
{
    m_netCtrl->Close(CLOSE_UNGRACEFUL);
    delete m_netCtrl;
}

void* DBClient::getAttributeSet(int attriIndex,int index)
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

void DBClient::deleteAttributeSet(int index) 
{
	MAPATTRSET::iterator iter=m_mapResultSet.lower_bound(index);
	for (;iter!=m_mapResultSet.upper_bound(index);) 
    {
		if (iter->second) 
            free (iter->second);

		m_mapResultSet.erase(iter++);
	}
}

int DBClient::callDBProc(CSCResultMsg *pMsg)
{

	pMsg->msgId = C_DOACTION;
	pMsg->context = CCSRESMSG;
    pMsg->m_nTempObjId = DBClient::generateOperationID();
    m_netCtrl->Send(pMsg);

    return pMsg->m_nTempObjId;
}

int DBClient::callDBSQL(AppMsg *pMsg) 
{
	int nOperationId = 0;
	if (pMsg != NULL)	
    {
		nOperationId = DBClient::generateOperationID();
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

DBClientCB* DBClient::getDBClientCB() 
{
	return m_queryResultHandle;
}

void DBClient::setDBClientCB(DBClientCB* pNetEventHandle) 
{
	m_queryResultHandle = pNetEventHandle;
}

int DBClient::generateOperationID() 
{
	static int nOperationId = 0;
	nOperationId++;
	return nOperationId;
}

void DBClient::connectResult(HRESULT p_result)
{
    if (m_queryResultHandle)
    {
        bool result = (p_result == S_OK ? true : false);
        m_queryResultHandle->onConnected(result);
    }
}

void DBClient::onRecv(AppMsg* p_appMsg)
{
    CSCResultMsg *pDataMsg = (CSCResultMsg *)p_appMsg;
    addQueryResult(pDataMsg);
    if (pDataMsg->m_bEnd)
        getDBClientCB()->onExeDBProc(pDataMsg->m_nTempObjId, true);
}

void DBClient::addQueryResult(CSCResultMsg* pMsg)
{
    pMsg->getInit();
    m_mapResultSet.insert(std::make_pair(pMsg->m_nTempObjId, pMsg));
}

DBClient* CreateClient(DBClientCB* p_dbClientCB, std::string serverAddr, int port)
{
    DBClient* pClient = DBClient::InstancePtr();
    pClient->setDBClientCB(p_dbClientCB);
    pClient->connectDBX(serverAddr, port);
    return pClient;
}