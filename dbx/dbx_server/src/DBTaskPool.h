#ifndef __DB_TASK_POOL_H
#define __DB_TASK_POOL_H

#include <list>

#include "lindef.h"
#include "Sock.h"


class DBTask;
// DB线程池，负责管理线程，分配空闲线程，缓冲DB查询任务
// 线程有空闲、忙碌
class DBTaskPool
{
public:
    DBTaskPool();
    ~DBTaskPool();

    bool InitTasks(int p_taskNum);

    virtual ITask *CreateThread();
protected:
    std::list<DBTask *> m_freeTaskList;
    std::list<DBTask *> m_busyTaskList;
    std::list<DBTask *> m_totalTaskList;
};


#endif // end of __DB_TASK_POOL_H