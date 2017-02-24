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
    TRACE0_L0("DBIssueBase::Progress.\n");
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
    memcpy(m_pAppMsg, p_appMsg, p_appMsg->msgLen);
}

bool DBIssueCallSP::OnProgress()
{
    TRACE0_L0( "DBIssueCallSP::OnProgress.SPSPSPSPSPSPSPSPSPSPSPSPSPSPSP\n" );

    DBInterfaceMysql * pdbInterface = static_cast<DBInterfaceMysql *>(m_dbInterface);

    char * pszQueryBuffer = pdbInterface->GetQueryBuffer();
    int nQueryBufferLen = QUERYBUFFER_MAX_LEN;

    CCSResultMsg * pCSMsg = (CCSResultMsg *)(m_pAppMsg);
    DbxMessageBuilder<CCSResultMsg>::locateContent(pCSMsg);
    bool success = true;

    for (int row = 0; row < pCSMsg->getAttributeRows(); row++)
    {
        //把旧数据先清除
        m_outParams.clear();

        if (!build_sp_query_buffer(pdbInterface->GetMysql(), pCSMsg, row, pszQueryBuffer, nQueryBufferLen, m_outParams))
        {
            return false;
        }

        success &= pdbInterface->Query(pszQueryBuffer, strlen(pszQueryBuffer), this);
    }

    return success;

}

void DBIssueCallSP::MainProgress()
{
    TRACE0_L0("DBIssueCallSP::MainProgress.RESULT...RESULT...RESULT...\n");
    if (m_linkIndex > 0)
    {
        SAppMsgNode *dropped(NULL), *current(m_pResultHead);
        while (current != NULL)
        {
            TRACE1_L0("DBIssueCallSP::MainProgress. send result to client, end: %i\n", ((CCSResultMsg *)current->p_msg)->m_bEnd);
            DBManager::InstancePtr()->SendResult(m_linkIndex, current->p_msg);
            free(current->p_msg);
            dropped = current;
            current = current->next;
            free(dropped);
        }
        m_pResultHead = NULL;
        free(m_pAppMsg);
    }
}

void DBIssueCallSP::OnQueryReturn(AppMsg * p_appMsg)
{
    TRACE1_L0("DBIssueCallSP::OnQueryReturn. message length %i\n", p_appMsg->msgLen);

    CCSResultMsg * pQueryMsg = (CCSResultMsg *)(m_pAppMsg);
    CCSResultMsg * pResultMsg = (CCSResultMsg *)(p_appMsg);

    pResultMsg->msgId = S_DOACTION_RESULT;
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
        ((CCSResultMsg *)tail->p_msg)->m_bEnd = false;
        tail->next = new SAppMsgNode(p_appMsg);
    }
}


// -----------------------------------------------------------------------------------
DBIssueCallSQL::DBIssueCallSQL(AppMsg *p_appMsg, int p_queryID, handle p_linkIndex)
    :DBIssueBase(p_appMsg, p_queryID, p_linkIndex)
{
    m_pAppMsg = (AppMsg *)malloc(p_appMsg->msgLen);
    memcpy(m_pAppMsg, p_appMsg, p_appMsg->msgLen);
}

bool DBIssueCallSQL::OnProgress()
{
    TRACE0_L0("DBIssueCallSQL::OnProgress.SQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQL\n");
    const char *cmd = "select * from t1;insert into t1 (col) values(\"hahaha\");";
    bool success = m_dbInterface->Query(cmd, strlen(cmd), this);
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
            TRACE1_L0("DBIssueCallSQL::MainProgress. send result to client, end: %i\n", ((CCSResultMsg *)current->p_msg)->m_bEnd);
            DBManager::InstancePtr()->SendResult(m_linkIndex, current->p_msg);
            free(current->p_msg);
            dropped = current;
            current = current->next;
            free(dropped);
        }
        m_pResultHead = NULL;
    }
}

void DBIssueCallSQL::OnQueryReturn(AppMsg * p_appMsg)
{
    TRACE1_L0("DBIssueCallSQL::OnQueryReturn. message length %i\n", p_appMsg->msgLen);

    CCSResultMsg * pQueryMsg = (CCSResultMsg *)(m_pAppMsg);
    CCSResultMsg * pResultMsg = (CCSResultMsg *)(p_appMsg);

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
        ((CCSResultMsg *)tail->p_msg)->m_bEnd = false;
        tail->next = new SAppMsgNode(p_appMsg);
    }
}
