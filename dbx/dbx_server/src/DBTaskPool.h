#ifndef __DB_TASK_POOL_H_
#define __DB_TASK_POOL_H_

#include <list>

#include "lindef.h"
#include "Sock.h"

class DBIssue;

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

    bool AddIssue(DBIssue *p_issue);
protected:
    int m_dbInterfaceID;

    std::list<ITask *> m_freeTaskList;
    std::list<ITask *> m_busyTaskList;
    std::list<ITask *> m_totalTaskList;

    int m_freeTaskCount;
    int m_totalTaskCount;
};


#endif // end of __DB_TASK_POOL_H_