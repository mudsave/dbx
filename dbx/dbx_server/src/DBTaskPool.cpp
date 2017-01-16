#include "DBTaskPool.h"

#include <algorithm>

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
m_totalTaskCount(0),
m_mutex()
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

bool DBTaskPool::AddIssue(DBIssueBase *p_issue)
{
    return true;
}

void DBTaskPool::OnIssueFinish(DBIssueBase *p_issue)
{
    TRACE0_L0("DBTaskPool::OnIssueFinish\n");
}

void DBTaskPool::AddFreeTask(ITask *p_task)
{
    m_mutex.Lock();

    std::list<ITask *>::iterator iter;
    iter = find(m_busyTaskList.begin(), m_busyTaskList.end(), p_task);
    if (iter == m_busyTaskList.end())
    {
        TRACE1_ERROR("DBTaskPool::AddFreeTask:Cant find task(%x) in Busy task List.\n", &p_task);
        return;
    }
    m_busyTaskList.erase(iter);
    m_freeTaskList.push_back(p_task);
    m_freeTaskCount++;

    m_mutex.Unlock();
}