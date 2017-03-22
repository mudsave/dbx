/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#include "DBIssue.h"

#include "lindef.h"
#include "vsdef.h"

#include "DBInterfaceMysql.h"
#include "DBManager.h"

// -----------------------------------------------------------------------------------
DBIssueBase::DBIssueBase(AppMsg *p_appMsg, int p_queryID, handle p_linkIndex)
    :m_dbInterface(NULL),
    m_queryID(p_queryID),
    m_linkIndex(p_linkIndex),
    m_pResultHead(NULL),
    m_errnum(0),
    m_errstr("")
{
}

bool DBIssueBase::Progress()
{
    //TRACE0_L0("DBIssueBase::Progress.\n");
    return OnProgress();
}

void DBIssueBase::SetDBInterface(DBInterface *p_dbInterface)
{
    m_dbInterface = p_dbInterface;
}

void DBIssueBase::MainProgress()
{
    TRACE0_L0("DBIssueBase::MainProgress.\n");
}

void DBIssueBase::OnQueryReturn(AppMsg * p_appMsg)
{
    TRACE0_L0("DBIssueBase::OnQueryReturn.\n");
}

int DBIssueBase::GetQueryID()
{
    return m_queryID;
}

bool DBIssueBase::HasError()
{
    return m_errnum != 0;
}

std::string &DBIssueBase::GetErrorStr()
{
    return m_errstr;
}

void DBIssueBase::ProcessError()
{
    m_errnum = 0;
    m_errstr = "";
}

void DBIssueBase::SetError(int p_errnum, std::string p_errstr)
{
    m_errnum = p_errnum;
    m_errstr = p_errstr;
}


// -----------------------------------------------------------------------------------
DBIssueCallSP::DBIssueCallSP(AppMsg *p_appMsg, int p_queryID, handle p_linkIndex)
    :DBIssueBase(p_appMsg, p_queryID, p_linkIndex)
{
    m_pAppMsg = (AppMsg *)malloc(p_appMsg->msgLen);
    if (m_pAppMsg != NULL)
    {
        memcpy(m_pAppMsg, p_appMsg, p_appMsg->msgLen);
    }
}

bool DBIssueCallSP::OnProgress()
{
    if (m_pAppMsg == NULL)
        return false;

    DbxMessage * pCSMsg = (DbxMessage *)(m_pAppMsg);
    DbxMessageBuilder<DbxMessage>::locateContent(pCSMsg);

    DBInterfaceMysql * pdbInterface = static_cast<DBInterfaceMysql *>(m_dbInterface);

    char * pszQueryBuffer = pdbInterface->GetQueryBuffer();
    int nQueryBufferLen = QUERYBUFFER_MAX_LEN;

    //把旧数据先清除
    m_outParams.clear();

    if (!build_sp_query_buffer(pdbInterface->GetMysql(), pCSMsg, 0, pszQueryBuffer, nQueryBufferLen, m_outParams))
    {
        return false;
    }

    return pdbInterface->Query(pszQueryBuffer, strlen(pszQueryBuffer), this);

}

void DBIssueCallSP::MainProgress()
{
    if (m_linkIndex > 0)
    {
        SAppMsgNode *dropped(NULL), *current(m_pResultHead);
        while (current != NULL)
        {
            //TRACE1_L0("DBIssueCallSP::MainProgress. send result to client, end: %i\n", ((DbxMessage *)current->p_msg)->m_bEnd);
            DBManager::InstancePtr()->SendResult(m_linkIndex, current->p_msg);
            free(current->p_msg);
            dropped = current;
            current = current->next;
            delete dropped;
        }
        m_pResultHead = NULL;
    }

    if (m_pAppMsg != NULL)
    {
        free(m_pAppMsg);
    }

    if (m_pResultHead != NULL)
    {
        SAppMsgNode *dropped(NULL), *current(m_pResultHead);
        while (current != NULL)
        {
            free(current->p_msg);
            dropped = current;
            current = current->next;
            delete dropped;
        }
        m_pResultHead = NULL;
    }
}

void DBIssueCallSP::OnQueryReturn(AppMsg * p_appMsg)
{
    //TRACE1_L0("DBIssueCallSP::OnQueryReturn. message length %i\n", p_appMsg->msgLen);

    DbxMessage * pQueryMsg = (DbxMessage *)(m_pAppMsg);
    DbxMessage * pResultMsg = (DbxMessage *)(p_appMsg);

    if (!pQueryMsg->m_bNeedCallback)
    {
        free(p_appMsg);
        return;
    }

    if (m_pAppMsg->msgId == C_SP_FROM_CPP)
    {
        pResultMsg->msgId = S_SP_CPP_RESULT;
    }
    else
    {
        pResultMsg->msgId = S_DOACTION_RESULT;
    }

    pResultMsg->m_spId = pQueryMsg->m_spId;
    pResultMsg->msgCls = pQueryMsg->msgCls;
    pResultMsg->m_nTempObjId = pQueryMsg->m_nTempObjId;
    pResultMsg->m_bEnd = true;

    if (m_pResultHead == NULL)
    {
        m_pResultHead = new SAppMsgNode(p_appMsg);
    }
    else
    {
        SAppMsgNode * tail = m_pResultHead->tail();
        ((DbxMessage *)tail->p_msg)->m_bEnd = false;
        tail->next = new SAppMsgNode(p_appMsg);
    }
}


// -----------------------------------------------------------------------------------
DBIssueCallSQL::DBIssueCallSQL(AppMsg *p_appMsg, int p_queryID, handle p_linkIndex)
    :DBIssueBase(p_appMsg, p_queryID, p_linkIndex)
{
    m_pAppMsg = (AppMsg *)malloc(p_appMsg->msgLen);
    if (m_pAppMsg != NULL)
    {
        memcpy(m_pAppMsg, p_appMsg, p_appMsg->msgLen);
    }
}

bool DBIssueCallSQL::OnProgress()
{
    if (m_pAppMsg == NULL)
        return false;

    DbxMessage * pCSMsg = (DbxMessage *)(m_pAppMsg);
    DbxMessageBuilder<DbxMessage>::locateContent(pCSMsg);

    DBInterfaceMysql * pdbInterface = static_cast<DBInterfaceMysql *>(m_dbInterface);

    const void * pValue = NULL;
    PType nBufferLen = 0;

    if (!pCSMsg->getAttibuteByName("sql", 0, nBufferLen, pValue) || nBufferLen <= 0)
    {
        TRACE2_ERROR("DBIssueCallSQL::OnProgress: get sql error, value addr %d, type %d\n", pValue, nBufferLen);
        return false;
    }

    char * pszQueryBuffer = (char *)malloc(nBufferLen + 1);
    if (pszQueryBuffer == NULL)
    {
        TRACE0_ERROR("DBIssueCallSQL::OnProgress: mem alloc fail!\n");
        return false;
    }
    memcpy(pszQueryBuffer, pValue, nBufferLen);
    pszQueryBuffer[nBufferLen] = '\0';

    bool success = pdbInterface->Query(pszQueryBuffer, strlen(pszQueryBuffer), this);
    free(pszQueryBuffer);

    return success;
}


void DBIssueCallSQL::MainProgress()
{
    TRACE0_L0("DBIssueCallSP::MainProgress.RESULT...RESULT...RESULT...\n");
    if (m_linkIndex > 0)
    {
        SAppMsgNode *dropped(NULL), *current(m_pResultHead);
        while (current != NULL)
        {
            TRACE1_L0("DBIssueCallSQL::MainProgress. send result to client, end: %i\n", ((DbxMessage *)current->p_msg)->m_bEnd);
            DBManager::InstancePtr()->SendResult(m_linkIndex, current->p_msg);
            free(current->p_msg);
            dropped = current;
            current = current->next;
            free(dropped);
        }
        m_pResultHead = NULL;
    }

    if (m_pAppMsg != NULL)
    {
        free(m_pAppMsg);
    }

    if (m_pResultHead != NULL)
    {
        SAppMsgNode *dropped(NULL), *current(m_pResultHead);
        while (current != NULL)
        {
            free(current->p_msg);
            dropped = current;
            current = current->next;
            delete dropped;
        }
        m_pResultHead = NULL;
    }
}

void DBIssueCallSQL::OnQueryReturn(AppMsg * p_appMsg)
{
    //TRACE1_L0("DBIssueCallSQL::OnQueryReturn. message length %i\n", p_appMsg->msgLen);

    DbxMessage * pQueryMsg = (DbxMessage *)(m_pAppMsg);
    DbxMessage * pResultMsg = (DbxMessage *)(p_appMsg);

    if (!pQueryMsg->m_bNeedCallback)
    {
        free(p_appMsg);
        return;
    }

    pResultMsg->msgId = S_DOSQL_RESULT;
    pResultMsg->m_spId = pQueryMsg->m_spId;
    pResultMsg->msgCls = pQueryMsg->msgCls;
    pResultMsg->m_nTempObjId = pQueryMsg->m_nTempObjId;
    pResultMsg->m_bEnd = true;

    if (m_pResultHead == NULL)
    {
        m_pResultHead = new SAppMsgNode(p_appMsg);
    }
    else
    {
        SAppMsgNode * tail = m_pResultHead->tail();
        ((DbxMessage *)tail->p_msg)->m_bEnd = false;
        tail->next = new SAppMsgNode(p_appMsg);
    }
}
