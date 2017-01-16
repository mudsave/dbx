#include "DBIssue.h"

#include "lindef.h"

DBIssueBase::DBIssueBase()
    :m_dbInterface(NULL)
{
}

void DBIssueBase::Progress()
{
    TRACE0_L0("DBIssueCallSP::Progress");
    OnProgress();
}

void DBIssueBase::SetDBInterface(DBInterface *p_dbInterface)
{
    m_dbInterface = p_dbInterface;
}


// -----------------------------------------------------------------------------------
void DBIssueCallSP::OnProgress()
{
    TRACE0_L0( "DBIssueCallSP::OnProgress" );
}

