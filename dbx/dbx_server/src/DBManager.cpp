#include "DBManager.h"

//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

#include "DBTaskPoolMgr.h"

DBManager::DBManager():
m_networkInterface()
{
}

bool DBManager::Initialize(int p_port)
{
	TRACE0_L0( "DBManager::Initialize...\n" );
    IThreadsPool* pThreadsPool = GlobalThreadsPool();   // 对象池初始化

    bool result = m_networkInterface.Listen(p_port);
    if (!result || !InitDB())
    {
        TRACE0_ERROR("DBManager::Running:initDB ERROR.\n");
        return false;
    }

    return true;
}

void DBManager::Finalise()
{
    TRACE0_L0("DBManager::Finalise.\n");
}

HRESULT DBManager::Run()
{
    TRACE0_L0("DBManager::Run.\n");
    return GlobalThreadsPool()->Running();
}

bool DBManager::InitDB()
{
    TRACE0_L0("DBManager::InitDB...\n");

    return DBTaskPoolMgr::InstancePtr()->Initialize();
}

void DBManager::CallSP(AppMsg *p_appMsg)
{

}

void DBManager::CallSQL(AppMsg *p_appMsg)
{

}