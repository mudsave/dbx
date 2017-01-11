#include "DBTask.h"

#include "lindef.h"


DBTask::DBTask(int p_dbInterfaceID, DBTaskPool *p_dbTaskPool):
    m_dbInterfaceID(p_dbInterfaceID),
    m_taskPool(p_dbTaskPool),
    m_dbInterface(NULL)
{}

DBTask::~DBTask()
{}

HRESULT DBTask::Do(HANDLE hContext)
{
    while (true)
    {
        TRACE0_L0("DBTask::Do\n");

        // todo：
        // 1. 尝试从TaskPool获得新的issue并执行，注意使用线程锁
        // 2. 如果没有新的issue，那么通知TaskPool空闲状态，并进入等待wait
        // 3. TaskPool分配新的任务时会Post通知
    }
    return 1;
}