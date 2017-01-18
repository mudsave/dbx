#ifndef __DB_ISSUE_H_
#define __DB_ISSUE_H_

#include "lindef.h"
#include "DBInterface.h"

class DBIssueBase
{
public:
    DBIssueBase(AppMsg *p_appMsg);

    virtual void Progress();
    virtual void OnProgress() = 0;
    virtual void MainProgress();

    void SetDBInterface(DBInterface *p_dbInterface);

protected:
    DBInterface *m_dbInterface;
};


class DBIssueCallSP :public DBIssueBase
{
public:
    DBIssueCallSP(AppMsg *p_appMsg);

    virtual void OnProgress();
    virtual void MainProgress();
};


class DBIssueCallSQL :public DBIssueBase
{
public:
    DBIssueCallSQL(AppMsg *p_appMsg);

    virtual void OnProgress();
    virtual void MainProgress();
};

#endif // end of __DB_ISSUE_H_