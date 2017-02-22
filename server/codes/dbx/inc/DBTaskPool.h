/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#ifndef __DB_TASK_POOL_H_
#define __DB_TASK_POOL_H_

#include <list>
#include <queue>
#include <map>

#include "lindef.h"
#include "Sock.h"

#include "DBIssue.h"
#include "DBTask.h"


class DBTaskPool
{
public:
    DBTaskPool(int p_dbInterfaceID);
    ~DBTaskPool();

    bool InitTasks(int p_taskNum);
    void Finalise();
    void MainTick();

    virtual DBTask *CreateThread();

    bool AddIssue(DBIssueBase *p_issue);

    DBIssueBase *PopBufferIssue();

    void OnIssueFinish(DBIssueBase *p_issue);

    void AddFreeTask(DBTask *p_task);

    void OnTaskQuit(DBTask *p_task);

    bool IsDestroyed();

    DBIssueBase *TryGetOrderIssue(int p_queryID);
protected:
    bool HasOrderIssue(int p_queryID);

    void AddOrderIssue(DBIssueBase *p_issue);
    void AddRandomIssue(DBIssueBase *p_issue);
    bool TaskIssue(DBIssueBase *p_issue);
    void BufferIssue(DBIssueBase *p_issue);

protected:
    int m_dbInterfaceID;

    std::list<DBTask *> m_freeTaskList;
    std::list<DBTask *> m_busyTaskList;
    std::list<DBTask *> m_totalTaskList;

    std::queue<DBIssueBase *> m_issueBufferList;
    std::list<DBIssueBase *> m_finishIssueList;

    typedef std::multimap<int, DBIssueBase *> ORDER_ISSUE_MAP;
    ORDER_ISSUE_MAP m_orderQueryIssueMap;

    Mutex m_freeBusyListMutex;
    Mutex m_bufferListMutex;
    Mutex m_finishIssueMutex;
    Mutex m_orderQueryMutex;

    bool m_isDestroyed;
};


#endif // __DB_TASK_POOL_H_