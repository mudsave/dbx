#include "DBManager.h"

//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

#include "DBFactory.h"
#include "DBXCommon.h"


DBManager::DBManager():
m_networkInterface()
{
}

bool DBManager::Initialize(int p_port)
{
	TRACE0_L0( "DBManager::Initialize...\n" );
    IThreadsPool* pThreadsPool = GlobalThreadsPool();    // 对象池初始化

    m_mainProcessTimer = pThreadsPool->RegTimer(this, NULL, 0, 1000, 1000, "DBX_Main_Process_Timer");
    if (m_mainProcessTimer == NULL)
    {
        TRACE0_ERROR("DBManager::Initialize...RegTimer error.\n");
        return false;
    }

    return m_networkInterface.Listen(p_port) && InitDB();
}

void DBManager::Finalise()
{
    TRACE0_L0("DBManager::Finalise.\n");
    GlobalThreadsPool()->UnregTimer(m_mainProcessTimer);

    DBFactory::InstancePtr()->Finalise();
}

HRESULT DBManager::Run()
{
    TRACE0_L0("DBManager::Run.\n");
    return GlobalThreadsPool()->Running();
}

bool DBManager::InitDB()
{
    TRACE0_L0("DBManager::InitDB...\n");

    return DBFactory::InstancePtr()->Initialize();
}

void DBManager::CallSP(AppMsg *p_appMsg)
{
    DBTaskPool* dbTaskPool = DBFactory::InstancePtr()->GetTaskPool(DBX_DEFALT_DATABASE_ID);
    dbTaskPool->AddIssue(new DBIssueCallSP(p_appMsg));
}

void DBManager::CallSQL(AppMsg *p_appMsg)
{
    DBTaskPool* dbTaskPool = DBFactory::InstancePtr()->GetTaskPool(DBX_DEFALT_DATABASE_ID);
    dbTaskPool->AddIssue(new DBIssueCallSQL(p_appMsg));
}

HRESULT DBManager::Do(HANDLE hContext)
{
    TRACE0_L0("DBManager::Do...\n");
    DBFactory::InstancePtr()->MainTick();
}