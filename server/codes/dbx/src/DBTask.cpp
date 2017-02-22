/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#include "DBTask.h"

#include "lindef.h"

#include "DBFactory.h"
#include "DBIssue.h"

DBTask::DBTask(int p_dbInterfaceID, DBTaskPool *p_dbTaskPool):
    m_dbInterfaceID(p_dbInterfaceID),
    m_taskPool(p_dbTaskPool),
    m_dbInterface(NULL),
    m_currentIssue(NULL),
    m_semaphore(),
    m_isDestroyed(false)
{
}

DBTask::~DBTask()
{
}

HRESULT DBTask::Do(HANDLE hContext)
{
    TRACE0_L0("DBTask::Do:DoStart...\n");
    m_dbInterface = DBFactory::InstancePtr()->CreateDBInterface(m_dbInterfaceID);
    if (m_dbInterface == NULL)
    {
        TRACE1_ERROR("DBTask::Do:cant create db InterfaceID(%i).\n", m_dbInterfaceID);
        return S_FALSE;
    }
    
    while (!IsDestroyed())
    {
        if (GetCurrIssue() == NULL)
        {
            Wait();
        }
        if (IsDestroyed())
        {
            DoEnd();
            return S_OK;
        }

        DBIssueBase *issue = GetCurrIssue();
        while (issue)
        {
            ProgressIssue(issue);
            DBIssueBase *nextIssue = GetNextIssue();
            if (!nextIssue)
            {
                ProgressEnd();
                break;
            }
            else
            {
                GetTaskPool()->OnIssueFinish(issue);
                issue = nextIssue;
                SetIssue(issue);
            }
        }
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
    DBIssueBase *nextIssue = NULL;

    DBIssueBase *currIssue = GetCurrIssue();
    if (currIssue != NULL && currIssue->GetQueryID() > 0)
        nextIssue = m_taskPool->TryGetOrderIssue(currIssue->GetQueryID());

    if (nextIssue == NULL)
        nextIssue = m_taskPool->PopBufferIssue();

    return nextIssue;
}

DBTaskPool *DBTask::GetTaskPool()
{
    return m_taskPool;
}

void DBTask::Wait()
{
    TRACE0_L0("DBTask::Wait.\n");
    m_semaphore.Wait();
}

void DBTask::Start()
{
    TRACE0_L0("DBTask::Start.\n");
    m_semaphore.Post();
}

void DBTask::ProgressIssue(DBIssueBase *p_issue)
{
    p_issue->SetDBInterface(m_dbInterface);
    if (!p_issue->Progress())
    {
        TRACE1_ERROR("DBTask::ProgressIssue:progress issue error(%s).\n", p_issue->GetErrorStr().c_str());
        // todo : 需要处理某些mysql错误。
    }
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
    if (m_currentIssue != NULL)
    {
        delete m_currentIssue;
        m_currentIssue = NULL;
    }
        
    if (m_dbInterface)
    {
        m_dbInterface->Disconnect();
        delete m_dbInterface;
        m_dbInterface = NULL;
    }

    GetTaskPool()->OnTaskQuit(this);
}

void DBTask::Destroy()
{
    m_isDestroyed = true;
}

bool DBTask::IsDestroyed()
{
    return m_isDestroyed;
}