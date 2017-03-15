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
    TRACE0_L0("CCommandClient::ParseMsg...\n");
	if (!CClient::getDBNetEvent())
	{
        TRACE0_L0("CCommandClient::ParseMsg...0000\n");
            return;
	}

	CSCResultMsg* pDataMsg=(CSCResultMsg*)malloc(pMsg->msgLen);
        if (pDataMsg == NULL)
        {
            TRACE0_L0("CCommandClient::ParseMsg...1111\n");
           return; 
        }
        memcpy(pDataMsg, pMsg, pMsg->msgLen);
        TRACE2_L0("CCommandClient::ParseMsg...pDataMsg->m_bEnd(%i),pMsg->msgId(%i)\n", pDataMsg->m_bEnd, pDataMsg->msgId);
	switch(pMsg->msgId){
	case S_DOACTION_RESULT:
		{
			//printf("S_DOACTION_RESULT %d\n",pDataMsg->m_nTempObjId);
			if(setResult(pDataMsg->m_nTempObjId,pDataMsg))
			{
                if (pDataMsg->m_bEnd)
                {
                    TRACE0_L0("CClient::getDBNetEvent()->onExeDBProc...\n");
                    CClient::getDBNetEvent()->onExeDBProc(pDataMsg->m_nTempObjId, CClient::InstancePtr(), true);
                }
			}
		}
		break;
	case S_SP_CPP_RESULT:
		{
			// printf("S_SP_CPP_RESULT %d\n",pDataMsg->m_nTempObjId);
			if(setResult(pDataMsg->m_nTempObjId,pDataMsg))
			{
				if(pDataMsg->m_bEnd){
					CClient::getDBNetEvent()->onExeDBProc(pDataMsg->m_nTempObjId, CClient::InstancePtr(), true);
                    TRACE0_L0("CClient::getDBNetEvent()->onExeDBProc_tocpp...\n");
					CClient::getDBNetEvent()->onExeDBProc_tocpp(pDataMsg->m_nTempObjId, CClient::InstancePtr(), true);
				}
			}
		}
		break;
	}

	if (pMsg!=NULL)
	{
		free(pMsg);
	}

}

CCommandClient* CCommandClient::getCommandClient()
{
	static CCommandClient s_CommandClient;
	return &s_CommandClient;
}

bool CCommandClient::setResult(int index,AppMsg* pMsg)
{
    TRACE1_L0("CCommandClient::setResult:index(%i).\n", index);
	CSCResultMsg* pDataMsg=(CSCResultMsg*)pMsg;
    if (!pDataMsg)
    {
        TRACE0_L0("CCommandClient::setResult:false....\n");
        return false;
    }
        
	pDataMsg->getInit();
	CClient::InstancePtr()->setAttributeSet(index,pDataMsg);
	//printf("CCommandClient::setResult:%d,%d\n",index,(int)(long)pDataMsg);
      	return true;
}
