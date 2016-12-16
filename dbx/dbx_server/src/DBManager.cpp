#include "DBManager.h"

//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

DBManager::DBManager()
{
	m_networkInterface = NetworkInterface();
    m_threadsPoll = GlobalThreadsPool();
}

HRESULT DBManager::Running(int p_port)
{
	TRACE0_L2( "DBManager is Running...\n" );
    m_networkInterface.Listen(p_port);
    m_threadsPoll->Running();
}

void DBManager::RunOut()
{
    TRACE0_L2("DBManager had run out...\n");
}