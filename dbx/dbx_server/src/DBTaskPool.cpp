#include "DBTaskPool.h"

#include <algorithm>
#include <list>
#include <vector>

#include "lindef.h"
#include "Sock.h"

#include "DBTask.h"
#include "DBXContextDefine.h"

#define DB_TASK_DESTROY_TIME 300

DBTaskPool::DBTaskPool(int p_dbInterfaceID)
    :m_dbInterfaceID(p_dbInterfaceID),
    m_freeTaskList(),
    m_busyTaskList(),
    m_totalTaskList(),
    m_issueBufferList(),
    m_finishIssueList(),
    m_orderQueryIssueMap(),
    m_freeBusyListMutex(),
    m_bufferListMutex(),
    m_finishIssueMutex(),
    m_orderQueryMutex(),
    m_isDestroyed(false)
{
}

DBTaskPool::~DBTaskPool()
{
}

void DBTaskPool::Finalise()
{
    TRACE1_L0("DBTaskPool::Finalise:%i.\n", m_dbInterfaceID );
    
    m_isDestroyed = true;
    m_freeBusyListMutex.Lock();
    std::list<DBTask *>::iterator taskIter = m_totalTaskList.begin();
    for (; taskIter != m_totalTaskList.end(); ++taskIter)
        (*taskIter)->Destroy();
    
    taskIter = m_freeTaskList.begin();
    for (; taskIter != m_freeTaskList.end(); ++taskIter)
        (*taskIter)->Start();

    m_freeBusyListMutex.Unlock();

    Sleep(DB_TASK_DESTROY_TIME);     // 等待全部线程销毁

    m_freeBusyListMutex.Lock();
    taskIter = m_totalTaskList.begin();
    for (; taskIter != m_totalTaskList.end(); ++taskIter)
        delete (*taskIter);
    m_totalTaskList.clear();
    m_freeTaskList.clear();
    m_busyTaskList.clear();
    m_freeBusyListMutex.Unlock();

    m_bufferListMutex.Lock();
    if (m_issueBufferList.size() > 0)
    {
        DBIssueBase *issue = m_issueBufferList.front();
        m_issueBufferList.pop();
        delete issue;
    }
    m_bufferListMutex.Unlock();
}

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

bool DBTaskPool::HasOrderIssue(int p_queryID)
{
    std::pair<ORDER_ISSUE_MAP::iterator, ORDER_ISSUE_MAP::iterator> range =
        m_orderQueryIssueMap.equal_range(p_queryID);

    if (range.first == range.second)
        return false;
    return true;
}

void DBTaskPool::AddOrderIssue(DBIssueBase *p_issue)
{
    TRACE1_L0("DBTaskPool::AddOrderIssue:add issue(queryID:%i) to order.\n", p_issue->GetQueryID());
    m_orderQueryMutex.Lock();

    if (HasOrderIssue(p_issue->GetQueryID()))
    {
        m_orderQueryIssueMap.insert(std::make_pair(p_issue->GetQueryID(), p_issue));
        m_orderQueryMutex.Unlock();
        return;
    }
    m_orderQueryIssueMap.insert(std::make_pair(p_issue->GetQueryID(), (DBIssueBase *)NULL));    // 占位，表明此queryID正在处理中，以便顺序处理后来者
    AddRandomIssue(p_issue);

    m_orderQueryMutex.Unlock();
}

bool DBTaskPool::TaskIssue(DBIssueBase *p_issue)
{
    m_freeBusyListMutex.Lock();
    if (m_freeTaskList.size() > 0)
    {
        TRACE0_L0("DBTaskPool::ExcuteIssue:Has free task.\n");
        std::list<DBTask *>::iterator iter = m_freeTaskList.begin();
        DBTask *task = *iter;
        m_freeTaskList.remove(task);
        m_busyTaskList.push_back(task);
        task->SetIssue(p_issue);
        task->Start();

        m_freeBusyListMutex.Unlock();
        return true;
    }
    m_freeBusyListMutex.Unlock();
    return false;
}

void DBTaskPool::BufferIssue(DBIssueBase *p_issue)
{
    TRACE0_L0("DBTaskPool::AddIssue:add to Buffer.\n");
    m_bufferListMutex.Lock();
    m_issueBufferList.push(p_issue);
    if (m_issueBufferList.size() > DBX_TASK_BUSY_SIZE)
        TRACE1_WARNING("DBTaskPool::AddIssue:There are too much(%i) DBIssues in buffer.\n", m_issueBufferList.size());
    m_bufferListMutex.Unlock();
}

void DBTaskPool::AddRandomIssue(DBIssueBase *p_issue)
{
    if (TaskIssue(p_issue))
        return;

    BufferIssue(p_issue);
}

bool DBTaskPool::AddIssue(DBIssueBase *p_issue)
{
    if (p_issue->GetQueryID() > 0)
    {
        AddOrderIssue(p_issue);
        return true;
    }

    AddRandomIssue(p_issue);
    return true;
}

DBIssueBase *DBTaskPool::TryGetOrderIssue(int p_queryID)
{
    DBIssueBase *nextIssue = NULL;

    m_orderQueryMutex.Lock();

    std::pair<ORDER_ISSUE_MAP::iterator, ORDER_ISSUE_MAP::iterator> range =
        m_orderQueryIssueMap.equal_range(p_queryID);
    if (range.first != range.second)
    {
        ORDER_ISSUE_MAP::iterator nextIter = range.first;
        nextIter++;     // first只是占位用。
        if (nextIter != range.second)
            nextIssue = nextIter->second;
        m_orderQueryIssueMap.erase(range.first);
    }

    m_orderQueryMutex.Unlock();

    return nextIssue;
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
    TRACE0_L0("DBTaskPool::PopBufferIssue.\n");
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
    TRACE0_L0("DBTaskPool::AddFreeTask.\n");
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

    m_freeBusyListMutex.Unlock();
}

void DBTaskPool::MainTick()
{
    TRACE1_L0("DBTaskPool::MainTick:%i.\n", m_dbInterfaceID);
    m_finishIssueMutex.Lock();

    if (m_finishIssueList.size() == 0)
    {
        TRACE0_L0("DBTaskPool::MainTick:Has no finished issue.\n");
        m_finishIssueMutex.Unlock();
        return;
    }

    std::vector<DBIssueBase *> issueList;
    std::copy(m_finishIssueList.begin(), m_finishIssueList.end(), std::back_inserter(issueList));
    m_finishIssueList.clear();
    m_finishIssueMutex.Unlock();

    std::vector<DBIssueBase *>::iterator iter = issueList.begin();
    for (; iter != issueList.end();)
    {
        (*iter)->MainProgress();
        delete (*iter);
        iter = issueList.erase(iter);
    }
}

void DBTaskPool::OnTaskQuit(DBTask *p_task)
{
    TRACE0_L0("DBTaskPool::OnTaskQuit.\n");
}

bool DBTaskPool::IsDestroyed()
{
    return m_isDestroyed;
}
