#include "DBTaskPool.h"

#include "lindef.h"
#include "Sock.h"

#include "DBTask.h"
#include "DBXContextDefine.h"

DBTaskPool::DBTaskPool(int p_dbInterfaceID):
m_dbInterfaceID(p_dbInterfaceID),
m_freeTaskList(),
m_busyTaskList(),
m_totalTaskList()
{
}

DBTaskPool::~DBTaskPool()
{
}

void DBTaskPool::Finalise()
{
    TRACE1_L0("DBTaskPool::finalise:%i.\n", m_dbInterfaceID );
}

// 根据p_taskNum创建线程池
bool DBTaskPool::InitTasks(int p_taskNum)
{
    TRACE2_L0("DBTaskPool::InitTasks:DB(%i),task count:%i.\n", m_dbInterfaceID, p_taskNum);
    for (int i = 0; i < p_taskNum; ++i)
    {
    }
    return true;
}

ITask *DBTaskPool::CreateThread()
{
    DBTaskContext *taskContext = new DBTaskContext(this);
    DBTask *task = new DBTask(m_dbInterfaceID, this);
    GlobalThreadsPool()->QueueTask(task, taskContext, TASK_LONG_TIME);
    return NULL;
}

bool DBTaskPool::AddIssue(DBIssue *p_issue)
{
    return true;
}