#include "DBInterfaceMysql.h"

#include <string.h>

#include "lindef.h"

#include "DBCommon.h"
#include "DBInterface.h"
#include "DBXConfig.h"


DBInterfaceMysql::DBInterfaceMysql(int p_dbInterfaceID):
DBInterface(p_dbInterfaceID)
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

bool DBInterfaceMysql::Initialize()
{
    TRACE1_L0("DBInterfaceMysql::Initialize p_dbInterfaceID(%i)\n", m_dbInterfaceID);
    DBInterface::Initialize();

    DBInterfaceInfo *dbInfo = g_dbxConfig.GetDBInterfaceInfo(m_dbInterfaceID);
    if (dbInfo == NULL)
    {
        TRACE1_ERROR("DBInterfaceMysql::Initialize:g_dbxConfig.GetDBInterfaceInfo error:cant find database info for ID(%id).\n", m_dbInterfaceID);
        return false;
    }

    m_dbPort = dbInfo->db_port;
    
    DBXCommon::DBXStrncpy(m_dbType, dbInfo->db_type, DBX_MAX_BUF);
    DBXCommon::DBXStrncpy(m_dbIP, dbInfo->db_ip, DBX_MAX_BUF);
    DBXCommon::DBXStrncpy(m_dbUserName, dbInfo->db_username, DBX_MAX_NAME);
    DBXCommon::DBXStrncpy(m_dbPassword, dbInfo->db_password, DBX_MAX_BUF);
    DBXCommon::DBXStrncpy(m_dbName, dbInfo->db_name, DBX_MAX_NAME);

    return true;
}

