#include "DBTaskPool.h"

#include <algorithm>
#include <list>

#include "lindef.h"
#include "Sock.h"

#include "DBTask.h"
#include "DBXContextDefine.h"

DBTaskPool::DBTaskPool(int p_dbInterfaceID)
    :m_dbInterfaceID(p_dbInterfaceID),
    m_freeTaskList(),
    m_busyTaskList(),
    m_totalTaskList(),
    m_issueBufferList(),
    m_finishIssueList(),
    m_freeTaskCount(0),
    m_totalTaskCount(0),
    m_freeBusyListMutex(),
    m_bufferListMutex(),
    m_finishIssueMutex()
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
        DBTask *task = CreateThread();
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

DBTask *DBTaskPool::CreateThread()
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
    m_freeBusyListMutex.Lock();
    if (m_freeTaskCount > 0)
    {
        std::list<DBTask *>::iterator iter = m_freeTaskList.begin();
        DBTask *task = *iter;
        m_freeTaskList.remove(task);
        m_freeTaskCount--;
        m_busyTaskList.push_back(task);
        task->SetIssue(p_issue);
        task->Start();

        m_freeBusyListMutex.Unlock();
        return true;
    }
    m_freeBusyListMutex.Unlock();

    m_bufferListMutex.Lock();
    m_issueBufferList.push(p_issue);
    if (m_issueBufferList.size() > DBX_TASK_BUSY_SIZE)
        TRACE1_WARNING("DBTaskPool::AddIssue:There are too much(%i) DBIssues in buffer.\n", m_issueBufferList.size());
    m_bufferListMutex.Unlock();
    
    return true;
}

void DBTaskPool::OnIssueFinish(DBIssueBase *p_issue)
{
    TRACE0_L0("DBTaskPool::OnIssueFinish.\n");

    m_finishIssueMutex.Lock();
    m_finishIssueList.push_back(p_issue);
    m_finishIssueMutex.Unlock();
}

DBIssueBase *DBTaskPool::PopBufferIssue()
{
    DBIssueBase *dbIssue = NULL;

    m_bufferListMutex.Lock();
    if (m_issueBufferList.size() > 0)
    {
        dbIssue = m_issueBufferList.front();
        m_issueBufferList.pop();
        if (m_issueBufferList.size() > DBX_TASK_BUSY_SIZE)
            TRACE1_WARNING("DBTaskPool::PopBufferIssue:There are too much(%i) DBIssues in buffer.\n", m_issueBufferList.size());
    }
    m_bufferListMutex.Unlock();

    return dbIssue;
}

void DBTaskPool::AddFreeTask(DBTask *p_task)
{
    m_freeBusyListMutex.Lock();

    std::list<DBTask *>::iterator iter;
    iter = find(m_busyTaskList.begin(), m_busyTaskList.end(), p_task);
    if (iter == m_busyTaskList.end())
    {
        TRACE1_ERROR("DBTaskPool::AddFreeTask:Cant find task(%x) in Busy task List.\n", &p_task);
        return;
    }
    m_busyTaskList.erase(iter);
    m_freeTaskList.push_back(p_task);
    m_freeTaskCount++;

    m_freeBusyListMutex.Unlock();
}