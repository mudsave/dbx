/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#include "DBIssue.h"

#include "lindef.h"
#include "vsdef.h"

#include "DBInterfaceMysql.h"

// -----------------------------------------------------------------------------------
DBIssueBase::DBIssueBase(AppMsg *p_appMsg, int p_queryID)
    :m_dbInterface(NULL),
    m_queryID(p_queryID),
    m_resultAppMsg(),
    m_errnum(0),
    m_errstr("")
{
}

void DBIssueBase::Progress()
{
    TRACE0_L0("DBIssueBase::Progress.\n");
    OnProgress();
}

void DBIssueBase::SetDBInterface(DBInterface *p_dbInterface)
{
    m_dbInterface = p_dbInterface;
}

void DBIssueBase::MainProgress()
{
    TRACE0_L0("DBIssueBase::MainProgress.\n");
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
DBIssueCallSP::DBIssueCallSP(AppMsg *p_appMsg, int p_queryID)
    :DBIssueBase(p_appMsg, p_queryID)
{
	m_pAppMsg = (AppMsg *)malloc(p_appMsg->msgLen);
	memcpy(m_pAppMsg, p_appMsg, p_appMsg->msgLen);
}

void DBIssueCallSP::OnProgress()
{
    TRACE0_L0( "DBIssueCallSP::OnProgress.SPSPSPSPSPSPSPSPSPSPSPSPSPSPSP\n" );

	DBInterfaceMysql * pdbInterface = static_cast<DBInterfaceMysql *>(m_dbInterface);

	char * pszQueryBuffer = pdbInterface->GetQueryBuffer();
	int nQueryBufferLen = QUERYBUFFER_MAX_LEN;

	//把旧数据先清除
	m_outParams.clear();

	if (!build_sp_query_buffer(pdbInterface->GetMysql(), (CCSResultMsg *)(m_pAppMsg), pszQueryBuffer, nQueryBufferLen, m_outParams))
	{
		return;
	}

	if (!pdbInterface->Query(pszQueryBuffer, strlen(pszQueryBuffer), this))
	{
		return;
	}
}

void DBIssueCallSP::MainProgress()
{
    TRACE0_L0("DBIssueCallSP::MainProgress.RESULT...RESULT...RESULT...\n");
}



// -----------------------------------------------------------------------------------
DBIssueCallSQL::DBIssueCallSQL(AppMsg *p_appMsg, int p_queryID)
    :DBIssueBase(p_appMsg, p_queryID)
{
	m_pAppMsg = (AppMsg *)malloc(p_appMsg->msgLen);
	memcpy(m_pAppMsg, p_appMsg, p_appMsg->msgLen);
}

void DBIssueCallSQL::OnProgress()
{
    TRACE0_L0("DBIssueCallSQL::OnProgress.SQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQL\n");
    const char *cmd = "select * from t1;insert into t1 (col) values(\"hahaha\");";
    bool success = m_dbInterface->Query(cmd, strlen(cmd), this);
    if (!success)
    {
        // todo:处理错误
    }
}

void DBIssueCallSQL::MainProgress()
{
    TRACE0_L0("DBIssueCallSQL::MainProgress.RESULT...RESULT...RESULT...\n");
}

