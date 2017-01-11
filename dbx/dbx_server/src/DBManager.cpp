#include "DBManager.h"

//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

#include "DBTaskPoolMgr.h"

DBManager::DBManager():
m_networkInterface()
{
}

HRESULT DBManager::Running(int p_port)
{
	TRACE0_L0( "DBManager is Running...\n" );
    m_networkInterface.Listen(p_port);

    InitDB();
}

void DBManager::Finalise()
{
    TRACE0_L0("DBManager::Finalise.\n");
}

void DBManager::InitDB()
{
    TRACE0_L0("DBManager::InitDB...\n");

    DBTaskPoolMgr::InstancePtr()->Initialize();
}

void DBManager::CallSP(AppMsg *p_appMsg)
{

}

void DBManager::CallSQL(AppMsg *p_appMsg)
{

}