/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#include "DBManager.h"

//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

#include "DBFactory.h"

#define DBX_DEFALT_DATABASE_ID 1   // 默认数据库id
#define DBX_MAIN_TICK_TIME 100

DBManager::DBManager()
    :m_networkInterface()
{
}

bool DBManager::Initialize(int p_port)
{
	TRACE0_L0( "DBManager::Initialize...\n" );
    m_mainProcessTimer = GlobalThreadsPool()->RegTimer(this, NULL, 0, DBX_MAIN_TICK_TIME, DBX_MAIN_TICK_TIME, "DBX_Main_Process_Timer");
    if (m_mainProcessTimer == NULL)
    {
        TRACE0_ERROR("DBManager::Initialize...Register timer error.\n");
        return false;
    }

    return m_networkInterface.Listen(p_port) && InitDB();
}

void DBManager::Finalise()
{
    TRACE0_L0("DBManager::Finalise.\n");
    GlobalThreadsPool()->UnregTimer(m_mainProcessTimer);

    DBFactory::InstancePtr()->Finalise();
    m_networkInterface.Finalise();
    GlobalThreadsPool()->Shutdown();
}

HRESULT DBManager::Run()
{
    TRACE0_L0("DBManager::Run.\n");
    return GlobalThreadsPool()->Running();
}

void DBManager::Shutdown()
{
    Finalise();
}

bool DBManager::InitDB()
{
    TRACE0_L0("DBManager::InitDB...\n");

    return DBFactory::InstancePtr()->Initialize();
}

void DBManager::CallSP(AppMsg *p_appMsg)
{
    // todo:从p_appMsg中获得queryID

    DBTaskPool* dbTaskPool = DBFactory::InstancePtr()->GetTaskPool(DBX_DEFALT_DATABASE_ID);
    if (dbTaskPool == NULL)
    {
        TRACE1_ERROR("DBManager::CallSQL:Cant get task pool(id:%i), it is maybe destroyed.\n", DBX_DEFALT_DATABASE_ID);
        return;
    }

	//对于sp调用来说，queryID默认是-1
    dbTaskPool->AddIssue(new DBIssueCallSP(p_appMsg, -1));
}

void DBManager::CallSQL(AppMsg *p_appMsg)
{
    // todo:从p_appMsg中获得queryID

    DBTaskPool* dbTaskPool = DBFactory::InstancePtr()->GetTaskPool(DBX_DEFALT_DATABASE_ID);
    if (dbTaskPool == NULL)
    {
        TRACE1_ERROR("DBManager::CallSQL:Cant get task pool(id:%i), it is maybe destroyed.\n", DBX_DEFALT_DATABASE_ID);
        return;
    }
    dbTaskPool->AddIssue(new DBIssueCallSQL(p_appMsg, -1));
}

HRESULT DBManager::Do(HANDLE hContext)
{
    TRACE0_L0("DBManager::Do...\n");
    DBFactory::InstancePtr()->MainTick();
}