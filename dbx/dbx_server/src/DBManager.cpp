#include "DBManager.h"

//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

#include "DBFactory.h"

DBManager::DBManager():
m_networkInterface()
{
}

bool DBManager::Initialize(int p_port)
{
	TRACE0_L0( "DBManager::Initialize...\n" );
    IThreadsPool* pThreadsPool = GlobalThreadsPool();    // 对象池初始化

    return m_networkInterface.Listen(p_port) && InitDB();
}

void DBManager::Finalise()
{
    TRACE0_L0("DBManager::Finalise.\n");
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
}

void DBManager::CallSQL(AppMsg *p_appMsg)
{
}