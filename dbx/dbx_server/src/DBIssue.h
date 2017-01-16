#ifndef __DB_ISSUE_H_
#define __DB_ISSUE_H_

#include "DBInterface.h"

class DBIssueBase
{
public:
    DBIssueBase();

    virtual void Progress();
    virtual void OnProgress() = 0;

    void SetDBInterface(DBInterface *p_dbInterface);

protected:
    DBInterface *m_dbInterface;
};


class DBIssueCallSP :public DBIssueBase
{
public:
    virtual void OnProgress();
};


#endif // end of __DB_ISSUE_H_