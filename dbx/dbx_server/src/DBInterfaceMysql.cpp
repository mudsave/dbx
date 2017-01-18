#include "DBInterfaceMysql.h"

#include <string.h>

#include "lindef.h"

#include "DBXCommon.h"
#include "DBInterface.h"
#include "DBXConfig.h"


DBInterfaceMysql::DBInterfaceMysql(int p_dbInterfaceID)
    :DBInterface(p_dbInterfaceID),
    m_mysql(NULL)
{
}

bool DBInterfaceMysql::Query(const char *p_cmd, int p_size, AppMsg *p_appMsg)
{
    TRACE1_L0("DBInterfaceMysql::Query p_dbInterfaceID(%s)\n", p_cmd);
    return true;
}

bool DBInterfaceMysql::Connect()
{
    if (m_dbInterfaceID == 0)
    {
        TRACE0_ERROR("DBInterfaceMysql::Connect: Cant connect cause have no DB InterfaceID.\n");
        return false;
    }

    TRACE1_L0("DBInterfaceMysql::Connect p_dbInterfaceID(%i)\n", m_dbInterfaceID);
    return true;
}

void DBInterfaceMysql::Disconnect()
{
    TRACE0_L0("DBInterfaceMysql::Disconnect.\n" );
}


