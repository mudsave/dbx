#include "DBInterfaceMysql.h"

#include "lindef.h"


bool DBInterfaceMysql::Query(const char *p_cmd, int p_size, AppMsg *p_appMsg)
{
    TRACE1_L0("DBInterfaceMysql::Query p_dbInterfaceID(%s)\n", p_cmd);
    return true;
}

bool DBInterfaceMysql::Connect(int p_dbInterfaceID)
{
    TRACE1_L0("DBInterfaceMysql::Connect p_dbInterfaceID(%i)\n", p_dbInterfaceID);
    return true;
}

void DBInterfaceMysql::Disconnect()
{
    TRACE0_L0("DBInterfaceMysql::Disconnect.\n" );
}

bool DBInterfaceMysql::Initialize()
{
    TRACE1_L0("DBInterfaceMysql::Initialize p_dbInterfaceID(%i)\n", m_dbInterfaceID);
    return true;
}

