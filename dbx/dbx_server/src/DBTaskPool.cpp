#include "DBTaskPool.h"

#include "lindef.h"
#include "Sock.h"

#include "DBTask.h"
#include "DBXContextDefine.h"

DBTaskPool::DBTaskPool(int p_dbInterfaceID):
m_dbInterfaceID(p_dbInterfaceID),
m_freeTaskList(),
m_busyTaskList(),
m_totalTaskList(),
m_freeTaskCount(0),
m_totalTaskCount(0)
{
}

DBTaskPool::~DBTaskPool()
{
}

void DBTaskPool::Finalise()
{
    TRACE1_L0("DBTaskPool::finalise:%i.\n", m_dbInterfaceID );
    // todo:清理线程，清理new对象。
}

// 根据p_taskNum创建线程池
bool DBTaskPool::InitTasks(int p_taskNum)
{
    TRACE2_L0("DBTaskPool::InitTasks:DB(%i),task count:%i.\n", m_dbInterfaceID, p_taskNum);
    for (int i = 0; i < p_taskNum; ++i)
    {
        ITask *task = CreateThread();
        if (task == NULL)
        {
            return false;
        }

        m_freeTaskList.push_back(task);
        m_totalTaskList.push_back(task);
        m_freeTaskCount++;
        m_totalTaskCount++;
    }
    return true;
}

ITask *DBTaskPool::CreateThread()
{
    DBTaskContext *taskContext = new DBTaskContext(this);
    DBTask *task = new DBTask(m_dbInterfaceID, this);
    if (GlobalThreadsPool()->QueueTask(task, taskContext, TASK_LONG_TIME) != S_OK)
    {
        TRACE1_ERROR( "DBTaskPool::CreateThread:Cant create task fro db interface(id:%i).\n", m_dbInterfaceID );
        return NULL;
    }
    return task;
}

bool DBTaskPool::AddIssue(DBIssue *p_issue)
{
    return true;
}