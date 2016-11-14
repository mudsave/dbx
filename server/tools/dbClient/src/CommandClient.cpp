#include "stdafx.h"
#include "CommandClient.h"
#include <algorithm>
#include "Client.h"

 
CCommandClient::CCommandClient(void):INIT_THREAD_SAFETY_MEMBER_FAST(MapMsg)
{
    #ifdef UseMutiThread
        createThread();
    #endif
}

CCommandClient::~CCommandClient(void)
{
	destroyThread();
}
void CCommandClient::doFunciton()
{

	while (this->getSemaphore()->Wait())
	{	
		ENTER_CRITICAL_SECTION_MEMBER(MapMsg);
		if(m_mapMsg.size()!=0)
		{
			
			MAPMSG::iterator iter = m_mapMsg.begin();
			for(; iter != m_mapMsg.end(); iter++){
				parseMsg(*iter);
			}
			m_mapMsg.clear();
		}
		LEAVE_CRITICAL_SECTION_MEMBER;	
	}

}




void CCommandClient::OnRecv(AppMsg* pMsg) {
#ifdef UseMutiThread
	CINT ci(0);
	ENTER_CRITICAL_SECTION_MEMBER(MapMsg);
	m_mapMsg.insert(std::make_pair(ci,pMsg));
	LEAVE_CRITICAL_SECTION_MEMBER;
	this->getSemaphore()->Post();
#else
        ParseMsg(pMsg);
#endif        
	return;
}

void CCommandClient::parseMsg(MAPMSGPAIR iter)
{
	ParseMsg(iter.second);
}

void CCommandClient::ParseMsg(AppMsg* pMsg)
{
    CSCResultMsg* pTempMsg=(CSCResultMsg*)pMsg;
	if (!CClient::getDBNetEvent())
	{
		return;
	}
	
	CSCResultMsg* pDataMsg=pTempMsg;
 	pTempMsg->getInit();
 	pDataMsg=(CSCResultMsg*)pTempMsg->uncompressData(NonCompress);
 	pDataMsg->getInit();
	switch(pMsg->msgId){
	case S_DOACTION_RESULT:
		{
			printf("S_DOACTION_RESULT %d\n",pDataMsg->m_nTempObjId);
			if(setResult(pDataMsg->m_nTempObjId,pDataMsg))
			{
				if(pDataMsg->m_bEnd)
					CClient::getDBNetEvent()->onExeDBProc(pDataMsg->m_nTempObjId,CClient::InstancePtr(),true);
			}
		}
		break;
	case S_SP_CPP_RESULT:
		{
			printf("S_SP_CPP_RESULT %d\n",pDataMsg->m_nTempObjId);
			if(setResult(pDataMsg->m_nTempObjId,pDataMsg))
			{
				if(pDataMsg->m_bEnd){
					CClient::getDBNetEvent()->onExeDBProc(pDataMsg->m_nTempObjId, CClient::InstancePtr(), true);
					CClient::getDBNetEvent()->onExeDBProc_tocpp(pDataMsg->m_nTempObjId, CClient::InstancePtr(), true);
				}
			}
		}
		break;
	}
 	
	if ((pDataMsg!=NULL)&&(pDataMsg!=pMsg)){
		free(pMsg);
		pDataMsg=NULL;
	}
	
}

bool CCommandClient::ValidateMsg(AppMsg* pMsg) {
	return true;
}
void CCommandClient::RepeatMsg(AppMsg* pMsg){}

CCommandClient* CCommandClient::getCommandClient()
{
	static CCommandClient s_CommandClient;
	return &s_CommandClient;
}

bool CCommandClient::setResult(int index,AppMsg* pMsg)
{
	CSCResultMsg* pDataMsg=(CSCResultMsg*)pMsg;
	if (!pDataMsg) return false;
	pDataMsg->getInit();
	CClient::InstancePtr()->setAttributeSet(index,pDataMsg);
	//printf("CCommandClient::setResult:%d,%d\n",index,(int)(long)pDataMsg);
      	return true;
}
