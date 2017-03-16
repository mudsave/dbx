#include "stdafx.h"
#include "CommandClient.h"
#include <algorithm>
#include "Client.h"


void CCommandClient::OnRecv(AppMsg* pMsg) 
{
    ParseMsg(pMsg);
}

void CCommandClient::ParseMsg(AppMsg* pMsg)
{
    TRACE0_L0("CCommandClient::ParseMsg...\n");
	if (!CClient::getDBNetEvent())
	{
        TRACE0_L0("CCommandClient::ParseMsg...0000\n");
        return;
	}

	CSCResultMsg* pDataMsg=(CSCResultMsg*)pMsg;
    switch (pDataMsg->msgId)
    {
	    case S_DOACTION_RESULT:
		{
			if(setResult(pDataMsg->m_nTempObjId,pDataMsg))
			{
                if (pDataMsg->m_bEnd)
                {
                    TRACE0_L0("CClient::getDBNetEvent()->onExeDBProc...\n");
                    CClient::getDBNetEvent()->onExeDBProc(pDataMsg->m_nTempObjId, CClient::InstancePtr(), true);
                }
			}
            break;
		}
	    case S_SP_CPP_RESULT:
		{
			if(setResult(pDataMsg->m_nTempObjId,pDataMsg))
			{
				if(pDataMsg->m_bEnd){
					CClient::getDBNetEvent()->onExeDBProc(pDataMsg->m_nTempObjId, CClient::InstancePtr(), true);
                    TRACE0_L0("CClient::getDBNetEvent()->onExeDBProc_tocpp...\n");
					CClient::getDBNetEvent()->onExeDBProc_tocpp(pDataMsg->m_nTempObjId, CClient::InstancePtr(), true);
				}
			}
            break;
		}
        default:
        {
            TRACE1_ERROR("CCommandClient::ParseMsg:undef msgID(%i)\n", pDataMsg->msgId);
        }
	}
}

CCommandClient* CCommandClient::getCommandClient()
{
	static CCommandClient s_CommandClient;
	return &s_CommandClient;
}

bool CCommandClient::setResult(int index, CSCResultMsg* pMsg)
{
    TRACE1_L0("CCommandClient::setResult:index(%i).\n", index);
    if (!pMsg)
    {
        return false;
    }
        
    pMsg->getInit();
    CClient::InstancePtr()->setAttributeSet(index, pMsg);
   	return true;
}
