#include "DBIssue.h"

#include "lindef.h"
#include "vsdef.h"

// -----------------------------------------------------------------------------------
DBIssueBase::DBIssueBase(AppMsg *p_appMsg)
    :m_dbInterface(NULL)
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



// -----------------------------------------------------------------------------------
DBIssueCallSP::DBIssueCallSP(AppMsg *p_appMsg)
    :DBIssueBase(p_appMsg)
{
}

void DBIssueCallSP::OnProgress()
{
    TRACE0_L0( "DBIssueCallSP::OnProgress.\n" );
}

void DBIssueCallSP::MainProgress()
{
    TRACE0_L0("DBIssueCallSP::MainProgress.\n");
}



// -----------------------------------------------------------------------------------
DBIssueCallSQL::DBIssueCallSQL(AppMsg *p_appMsg)
    :DBIssueBase(p_appMsg)
{
}

void DBIssueCallSQL::OnProgress()
{
    TRACE0_L0("DBIssueCallSQL::OnProgress.\n");
}

void DBIssueCallSQL::MainProgress()
{
    TRACE0_L0("DBIssueCallSQL::MainProgress.\n");
}

