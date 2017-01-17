#ifndef __DB_TASK_POOL_H_
#define __DB_TASK_POOL_H_

#include <list>
#include <queue>

#include "lindef.h"
#include "Sock.h"

#include "DBIssue.h"
#include "DBTask.h"


// DB线程池，负责管理线程，分配空闲线程，缓冲DB查询任务
// 线程有空闲、忙碌
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
protected:
    int m_dbInterfaceID;

    std::list<DBTask *> m_freeTaskList;
    std::list<DBTask *> m_busyTaskList;
    std::list<DBTask *> m_totalTaskList;
    int m_freeTaskCount;
    int m_totalTaskCount;

    std::queue<DBIssueBase *> m_issueBufferList;
    std::list<DBIssueBase *> m_finishIssueList;

    Mutex m_freeBusyListMutex;
    Mutex m_bufferListMutex;
    Mutex m_finishIssueMutex;
};


#endif // end of __DB_TASK_POOL_H_