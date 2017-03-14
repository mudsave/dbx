#include "stdafx.h"
#include "Client.h"
#ifdef WIN32
#include "winnt.h"
#endif

//#define		CREATEPLAYER	1
//#define		LOADPLAYER		2
//#define		UPDATEPLAYER	3

struct _LinkContext_DB
{
	int linkType;
	handle hLink;
	int idx;
	_LinkContext_DB(int type, handle h): linkType(type), hLink(h), idx(-1){}
};

IDBANetEvent* CClient::s_pNetEventHandle=NULL;

CClient::CClient()
    :m_connected(false),
     INIT_THREAD_SAFETY_MEMBER_FAST(sock),
     INIT_THREAD_SAFETY_MEMBER_FAST(Attr)
{
        //sleep(30);
	m_pThreads = ::GlobalThreadsPool(CLS_THREADS_POLL);
	m_pLinkCtrl=static_cast<ILinkCtrl*>(::CreateLinkCtrl());
	if (m_pLinkCtrl==NULL)
	{
		CDBClientException e;
		e.m_nExceptionType = C_LOADSOCK_EXCEPTION;
		e.m_strDescription = "load sock.dll failed!";
		throw e;
	}
	createThread();
        CCommandClient* pCmd =  CCommandClient::getCommandClient();//初始化CCommandClient
}

CClient::~CClient(void)
{
	closeLink(CLOSE_UNGRACEFUL);
}

void CClient::setDBAServer(std::string serverAddr,int iPort)
{
	m_strServerAddr=serverAddr;
	m_iPort=iPort;
}


void CClient::doFunciton(void)
{
	while(true)
	{
		if(!m_connected)
		{
			if (m_pLinkCtrl) m_pLinkCtrl->Connect(m_strServerAddr.c_str(),m_iPort,this,0);//(IMsgLinksImpl<IID_IMsgLinksCS_L>*)
		}
		Sleep(5000);
	}
}
void CClient::OnClosed(HANDLE hLinkContext, HRESULT reason)
{
    if(!hLinkContext) return;
    _LinkContext_DB* pContext = (_LinkContext_DB*)hLinkContext;
     m_hLink = NULL;
     m_connected = false;
    delete pContext;
}



void CClient::DefaultMsgProc(AppMsg* pMsg, HANDLE hContext)
{
    AppMsg* pNewMsg = (AppMsg*)malloc(pMsg->msgLen);//TODO 优化用内存池
    memcpy(pNewMsg, pMsg, pMsg->msgLen);
    CCommandClient::getCommandClient()->OnRecv(pNewMsg);
}

HANDLE CClient::OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int i_link_type)
{

	if (result == S_OK)
	{
		m_connected=true;
                m_hLink = hLink;
		//s_pLinkPort=pPort;
		if (s_pNetEventHandle) s_pNetEventHandle->onConnected(true);
                _LinkContext_DB* pNew = new _LinkContext_DB(i_link_type, hLink);
                return pNew;
	}
	else
	{
		m_connected=false;
                m_hLink = NULL;
		if (s_pNetEventHandle) s_pNetEventHandle->onConnected(false);
		return NULL;
	}

	//return dynamic_cast<IPortSink*>(CCommandClient::getCommandClient());
}

void CClient::setAttributeSet(int index,CSCResultMsg *pInfo)
{

	ENTER_CRITICAL_SECTION_MEMBER(Attr);
	m_MapAttrSet.insert(std::make_pair(index,pInfo));
       	LEAVE_CRITICAL_SECTION_MEMBER;
}
void* CClient::getAttributeSet(int attriIndex,int index)
{
	ENTER_CRITICAL_SECTION_MEMBER(Attr);
	MAPATTRSET::iterator iter=m_MapAttrSet.lower_bound(attriIndex);
	for(int i=0;iter!=m_MapAttrSet.upper_bound(attriIndex);i++,iter++) {
		if(i==index) {
			return iter->second;
		}
	}

	LEAVE_CRITICAL_SECTION_MEMBER;
}

void CClient::deleteAttributeSet(int index) {
	ENTER_CRITICAL_SECTION_MEMBER(Attr);
	MAPATTRSET::iterator iter=m_MapAttrSet.lower_bound(index);
	for (;iter!=m_MapAttrSet.upper_bound(index);) {
		//printf("deleteAttributeSet,p=%d\n",(int)(long)iter->second);
		if (iter->second) free (iter->second);
		m_MapAttrSet.erase(iter++);
	}
	LEAVE_CRITICAL_SECTION_MEMBER;
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

		 if(m_hLink)
                {
                    //TRACE0_L0("begin callDBProc !\n");
					IMsgLinksImpl<IID_IMsgLinksCS_L>::SendData(m_hLink, (BYTE*)pMsg,pMsg->msgLen);
					//TRACE0_L0("callDBProc ed!\n");
                }
                else
                {
                    TRACE0_L1("[CClient::callDBProc] connect with dbserver failed!\n");
                }
	}
	return nOperationId;
}

int CClient::callDBSQL(AppMsg *pMsg) {
	int nOperationId=0;
	if (pMsg!=NULL)	{
		nOperationId=CClient::generateOperationId();
		CCSResultMsg* pDataMsg=(CCSResultMsg*)pMsg;
		pMsg->msgId=C_DOSQL;
		pMsg->context=CCSRESMSG;
		if(pDataMsg->m_nTempObjId==0) pDataMsg->m_nTempObjId=nOperationId;
		else
			nOperationId=pDataMsg->m_nTempObjId;

                if(m_hLink)
                {
                    IMsgLinksImpl<IID_IMsgLinksCS_L>::SendData(m_hLink, (BYTE*)pMsg,pMsg->msgLen);
                }
                else
                {
                    TRACE0_L1("[CClient::callDBSQL] connect with dbserver failed!\n");
                }
	}
	return nOperationId;
}



IDBANetEvent* CClient::getDBNetEvent() {
	return s_pNetEventHandle;
}


void CClient::setDBNetEvent(IDBANetEvent* pNetEventHandle) {
	s_pNetEventHandle=pNetEventHandle;
}

int CClient::generateOperationId() {
	static int nOperationId=0;
	nOperationId++;
	return nOperationId;
}

bool CClient::closeLink(DWORD dwFlags) {

	if (m_connected ) {
		IMsgLinksImpl<IID_IMsgLinksCS_L>::CloseLink(m_hLink,CLOSE_UNGRACEFUL);
                m_hLink = NULL;
                m_connected = false;
		return true;
	}else
		return false;

}

HRESULT CClient::Do(HANDLE hContext) {
	_doContext* pContext=(_doContext*) hContext;
	if (!pContext) return E_FAIL;
	HRESULT res=E_FAIL;
	switch (pContext->flag) {
	case eSend: {

		}
		break;
	case eThread: {
			res =CThread::Do(hContext);
		}
	}
	delete pContext;
	return res;
}


int CClient::addParam(const char* name, const char* value) {
	m_msgBuilder.addAttribute(name, value, strlen(value));
}

int CClient::addParam(const char* name, int value) {
	m_msgBuilder.addAttribute(name, &value, PARAMINT);
}

void CClient::buildQuery(){
	m_msgBuilder.beginMessage();
}

int CClient::callSPFROMCPP(IDBCallback* call_back) {
	CCSResultMsg* pMsg = m_msgBuilder.finishMessage();
	
	pMsg->m_spId = 0;
	pMsg->m_bNeedCallback = true;
	pMsg->m_nLevel = 20;
	pMsg->msgId = C_SP_FROM_CPP;
	pMsg->context = CCSRESMSG;
	pMsg->m_nTempObjId = CClient::generateOperationId();
	
	m_callbacks.insert(std::make_pair(pMsg->m_nTempObjId, call_back));
	
	if(m_hLink)
        {
            IMsgLinksImpl<IID_IMsgLinksCS_L>::SendData(m_hLink, (BYTE*)pMsg,pMsg->msgLen);
        }
        else
        {
            TRACE0_L1("[CClient::callSPFROMCPP] connect with dbserver failed!\n");
        }
	return pMsg->m_nTempObjId;
}
