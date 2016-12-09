#include "DBManager.h"

#include "trace.h"

DBManager::DBManager()
{
	m_networkInterface = NetworkInterface();
}

void DBManager::Running()
{
	TRACE0_L2( "DBManager is Running..." );
}