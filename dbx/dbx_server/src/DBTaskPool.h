#ifndef __DB_TASK_POOL_H_
#define __DB_TASK_POOL_H_

#include <list>

#include "lindef.h"
#include "Sock.h"

#include "DBIssue.h"


// DB线程池，负责管理线程，分配空闲线程，缓冲DB查询任务
// 线程有空闲、忙碌
class DBTaskPool
{
public:
    DBTaskPool(int p_dbInterfaceID);
    ~DBTaskPool();

    bool InitTasks(int p_taskNum);

    void Finalise();

    virtual ITask *CreateThread();

    bool AddIssue(DBIssueBase *p_issue);

    void OnIssueFinish(DBIssueBase *p_issue);

    void AddFreeTask(ITask *p_task);
protected:
    int m_dbInterfaceID;

    std::list<ITask *> m_freeTaskList;
    std::list<ITask *> m_busyTaskList;
    std::list<ITask *> m_totalTaskList;

    int m_freeTaskCount;
    int m_totalTaskCount;

    Mutex m_mutex;
};


#endif // end of __DB_TASK_POOL_H_