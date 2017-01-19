#include "DBIssue.h"

#include "lindef.h"
#include "vsdef.h"

// -----------------------------------------------------------------------------------
DBIssueBase::DBIssueBase(AppMsg *p_appMsg, int p_queryID)
    :m_dbInterface(NULL),
    m_queryID(p_queryID)
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


// -----------------------------------------------------------------------------------
DBIssueCallSP::DBIssueCallSP(AppMsg *p_appMsg, int p_queryID)
    :DBIssueBase(p_appMsg, p_queryID)
{
}

void DBIssueCallSP::OnProgress()
{
    TRACE0_L0( "DBIssueCallSP::OnProgress.SPSPSPSPSPSPSPSPSPSPSPSPSPSPSP\n" );
    Sleep(50);
}

void DBIssueCallSP::MainProgress()
{
    TRACE0_L0("DBIssueCallSP::MainProgress.SPSPSPSPSPSPSPSPSPSPSPSPSPSPSPSP\n");
}



// -----------------------------------------------------------------------------------
DBIssueCallSQL::DBIssueCallSQL(AppMsg *p_appMsg, int p_queryID)
    :DBIssueBase(p_appMsg, p_queryID)
{
}

void DBIssueCallSQL::OnProgress()
{
    TRACE0_L0("DBIssueCallSQL::OnProgress.SQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQL\n");
    Sleep(50);
}

void DBIssueCallSQL::MainProgress()
{
    TRACE0_L0("DBIssueCallSQL::MainProgress.SQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQLSQL\n");
}

