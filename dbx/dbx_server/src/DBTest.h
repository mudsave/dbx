/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#ifndef __DB_TEST_H_
#define __DB_TEST_H_

#include "lindef.h"
#include "Sock.h"

#include "DBFactory.h"
#include "DBIssue.h"
#include "DBTaskPool.h"


class DBIssueTest : public DBIssueBase
{
public:
    DBIssueTest(AppMsg *p_appMsg, int p_queryID)
        :DBIssueBase(p_appMsg, p_queryID)
    {}

    virtual void OnProgress()
    {}
};

class DBIssueTestSql : public DBIssueTest
{
public:
    DBIssueTestSql(AppMsg *p_appMsg, int p_queryID)
        :DBIssueTest(p_appMsg, p_queryID)
    {}

    virtual void OnProgress()
    {
        const char *cmd = "select * from t1;";
        bool success = m_dbInterface->Query(cmd, strlen(cmd), this);
    }

    virtual void MainProgress()
    {
        TRACE1_L0("DBIssueTestSql::MainProgress:Send data to client(queryID:%i).\n", GetQueryID());
    }
};

class DBTest :public ITask
{
public:
    virtual HRESULT Do(HANDLE hContext)
    {
        while (true)
        {
            Sleep(50);
            DBTaskPool *taskPool = DBFactory::InstancePtr()->GetTaskPool(1);
            taskPool->AddIssue(new DBIssueTestSql(NULL, 10));
        }
    }

    void Run()
    {
        IThreadsPool* pThreadsPool = GlobalThreadsPool();
        if (pThreadsPool->QueueTask(this, NULL, TASK_LONG_TIME) != S_OK)
        {
            TRACE0_ERROR( "DBTest::Run:QueueTask failed...\n" );
        }
    }
};


#endif // end of __DB_TEST_H_