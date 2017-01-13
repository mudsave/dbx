#include "DBIssue.h"

#include "lindef.h"


void DBIssueBase::Progress()
{
    TRACE0_L0("DBIssueCallSP::Progress");
    OnProgress();
}


// -----------------------------------------------------------------------------------
void DBIssueCallSP::OnProgress()
{
    TRACE0_L0( "DBIssueCallSP::OnProgress" );
}
