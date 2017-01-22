/*
Written by wangshufeng.
RTX:6016.
√Ë ˆ£∫

*/

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

bool DBInterfaceMysql::Initialize()
{
    DBInterface::Initialize();

    m_mysql = mysql_init(NULL);
    if (m_mysql == NULL)
    {
        TRACE0_ERROR("Connect:mysql_init error:maybe in case of insufficient memory.\n");
        return false;
    }

    return true;
}

bool DBInterfaceMysql::Query(const char *p_cmd, int p_size, DBIssueBase *p_issue)
{
    TRACE1_L0("DBInterfaceMysql::Query p_dbInterfaceID(%s)\n", p_cmd);
    if (m_mysql == NULL)
    {
        TRACE0_ERROR("DBInterfaceMysql::Query: MYSQL has not init.");
        ProcessQueryResult(p_issue);
        return false;
    }

    if (mysql_real_query(m_mysql, p_cmd, p_size) != 0)
    {
        
    }

    return true;
}

bool DBInterfaceMysql::ProcessQueryResult(DBIssueBase *p_issue)
{
    if (p_issue == NULL)
        return true;

    return true;
}

bool DBInterfaceMysql::Connect()
{
    if (m_dbInterfaceID == 0)
    {
        TRACE0_ERROR("DBInterfaceMysql::Connect: Cant connect cause have no DB InterfaceID.\n");
        return false;
    }
    if (m_mysql == NULL)
    {
        TRACE0_ERROR("DBInterfaceMysql::Connect: MYSQL has not init.\n");
        return false;
    }

    if (mysql_real_connect(m_mysql,
        m_dbIP,
        m_dbUserName, m_dbPassword,
        m_dbName,
        m_dbPort,
        NULL, CLIENT_MULTI_STATEMENTS) == NULL)
    {
        TRACE1_ERROR("DBInterfaceMysql::Connect:error:%s.\n", mysql_error(m_mysql));
        return false;
    }

    TRACE1_L0("DBInterfaceMysql::Connect p_dbInterface(%i) sucess.\n", m_dbInterfaceID);
    return true;
}

void DBInterfaceMysql::Disconnect()
{
    TRACE0_L0("DBInterfaceMysql::Disconnect.\n" );
    if (m_mysql != NULL)
    {
        mysql_close(m_mysql);
        m_mysql = NULL;
    }
}
