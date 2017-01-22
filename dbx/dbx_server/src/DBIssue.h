/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#ifndef __DB_ISSUE_H_
#define __DB_ISSUE_H_

#include "lindef.h"
#include "DBInterface.h"

class DBIssueBase
{
public:
    DBIssueBase(AppMsg *p_appMsg, int p_queryID);

    virtual void Progress();
    virtual void OnProgress() = 0;
    virtual void MainProgress();

    void SetDBInterface(DBInterface *p_dbInterface);

    int GetQueryID();

protected:
    DBInterface *m_dbInterface;
    int m_queryID;      // 查询的序号id，有效的同序号须按顺序处理查询
};


class DBIssueCallSP :public DBIssueBase
{
public:
    DBIssueCallSP(AppMsg *p_appMsg, int p_queryID);

    virtual void OnProgress();
    virtual void MainProgress();
};


class DBIssueCallSQL :public DBIssueBase
{
public:
    DBIssueCallSQL(AppMsg *p_appMsg, int p_queryID);

    virtual void OnProgress();
    virtual void MainProgress();
};

#endif // end of __DB_ISSUE_H_