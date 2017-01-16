#include "DBTask.h"

#include "lindef.h"

#include "DBFactory.h"
#include "DBIssue.h"

DBTask::DBTask(int p_dbInterfaceID, DBTaskPool *p_dbTaskPool):
    m_dbInterfaceID(p_dbInterfaceID),
    m_taskPool(p_dbTaskPool),
    m_dbInterface(NULL),
    m_currentIssue(NULL),
    m_semaphore()
{
}

DBTask::~DBTask()
{
}

HRESULT DBTask::Do(HANDLE hContext)
{
    TRACE1_L0("DBTask::Do:db InterfaceID(%i).\n", m_dbInterfaceID);
    m_dbInterface = DBFactory::InstancePtr()->CreateDBInterface(m_dbInterfaceID);
    if (m_dbInterface == NULL)
    {
        TRACE1_ERROR("DBTask::Do:cant create db InterfaceID(%i).\n", m_dbInterfaceID);
        return S_FALSE;
    }
    
    bool running = true;
    while (running)
    {
        if (GetCurrIssue() == NULL)
        {
            Wait();
        }

        DBIssueBase *issue = GetCurrIssue();
        while (issue)
        {
            ProgressIssue(issue);
            DBIssueBase *nextIssue = GetNextIssue();
            if (!nextIssue)
            {
                ProgressEnd();
            }
            else
            {
                GetTaskPool()->OnIssueFinish(issue);
                issue = nextIssue;
                SetIssue(issue);
            }
        }
        //// todo：
        //// 1. 尝试从TaskPool获得新的issue并执行，注意使用线程锁
        //// 2. 如果没有新的issue，那么通知TaskPool空闲状态，并进入等待wait
        //// 3. TaskPool分配新的任务时会Post通知
        //// 4. 检查退出条件：例如pool是否已经被销毁，线程运行的条件是否还满足，不满足则退出
    }

    DoEnd();
    return S_OK;
}

void DBTask::SetIssue(DBIssueBase *p_issue)
{
    m_currentIssue = p_issue;
}

DBIssueBase *DBTask::GetCurrIssue()
{
    return m_currentIssue;
}

DBIssueBase *DBTask::GetNextIssue()
{
    return NULL;
}

DBTaskPool *DBTask::GetTaskPool()
{
    return m_taskPool;
}

void DBTask::Wait()
{
    m_semaphore.Wait();
}

void DBTask::Start()
{
    m_semaphore.Post();
}

void DBTask::ProgressIssue(DBIssueBase *p_issue)
{
    p_issue->SetDBInterface(m_dbInterface);
    p_issue->Progress();
}

void DBTask::ProgressEnd()
{
    GetTaskPool()->OnIssueFinish(m_currentIssue);
    SetIssue(NULL);
    GetTaskPool()->AddFreeTask(this);
}

void DBTask::DoEnd()
{
    TRACE1_L0("DBTask::DoEnd:cancel for DBInterface(id:%i)...\n", m_dbInterfaceID);
}