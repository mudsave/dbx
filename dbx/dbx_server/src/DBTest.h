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


const char *TEST_CMD_INIT = "Create table if not EXISTS t1(id BIGINT primary key auto_increment, col varchar(50) ) ENGINE=InnoDB charset=utf8; \
                            drop procedure if exists sp1; \
                            drop procedure if exists sp2; \
                            insert into t1(col) values(\"a1\"); \
                            insert into t1(col) values(\"b22\"); \
                            insert into t1(col) values(\"c333\"); \
                            insert into t1(col) values(\"d4\");";

const char *TEST_CMD_SP1 = "create procedure sp1() \
                     begin \
                     insert into t1(col) values(\"a1\"); \
                     insert into t1(col) values(\"b22\"); \
                     insert into t1(col) values(\"c333\"); \
                     insert into t1(col) values(\"d4\"); \
                     select * from t1; \
                     end; ";

const char *TEST_CMD_SP2 = "create procedure sp2() \
                            begin \
                            select * from t1; \
                            end; ";

const char *TEST_CMD_ERROR = "WSF_MYSQL_ERROR_CMD";


class DBIssueTest : public DBIssueBase
{
public:
    DBIssueTest(AppMsg *p_appMsg, int p_queryID)
        :DBIssueBase(p_appMsg, p_queryID),
        m_cmd(NULL)
    {}
    
    DBIssueTest(const char *p_cmd, int p_queryID)
        :DBIssueBase(NULL, p_queryID),
        m_cmd(p_cmd)
    {}

    virtual void OnProgress()
    {
        bool success = m_dbInterface->Query(m_cmd, strlen(m_cmd), this);
    }

    virtual void MainProgress()
    {
        TRACE2_L0("DBIssueTest::MainProgress:queryID:%i for cmd:%s.\n", GetQueryID(), m_cmd);
    }

protected:
    const char *m_cmd;
};

class DBIssueTestCreateT1 : public DBIssueTest
{
public:
    DBIssueTestCreateT1(const char *p_cmd, int p_queryID)
        :DBIssueTest(p_cmd, p_queryID)
    {}

    virtual void OnProgress()
    {
        m_cmd = "Create table if not EXISTS t1(id BIGINT primary key auto_increment, col varchar(50) ) ENGINE=InnoDB charset=utf8;";
        bool success = m_dbInterface->Query(m_cmd, strlen(m_cmd), this);
    }
};

class DBIssueTestSql : public DBIssueTest
{
public:
    DBIssueTestSql(const char *p_cmd, int p_queryID)
        :DBIssueTest(p_cmd, p_queryID)
    {}

    virtual void OnProgress()
    {
        m_cmd = "select * from t1;insert into t1 (col) values(\"hahaha\");";
        bool success = m_dbInterface->Query(m_cmd, strlen(m_cmd), this);
    }
};

class DBTest :public ITask
{
public:
    virtual HRESULT Do(HANDLE hContext)
    {
        DBTaskPool *taskPool = DBFactory::InstancePtr()->GetTaskPool(1);
        taskPool->AddIssue(new DBIssueTest(TEST_CMD_INIT, 20013));
        taskPool->AddIssue(new DBIssueTest(TEST_CMD_SP2, 20013));
        while (true)
        {
            taskPool->AddIssue(new DBIssueTest("call sp2()", 3000));
            Sleep(1000);
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