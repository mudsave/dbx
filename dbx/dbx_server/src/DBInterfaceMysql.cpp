/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#include "DBInterfaceMysql.h"

#include <string.h>

#include "lindef.h"

#include "DBXCommon.h"
#include "DBInterface.h"
#include "DBXConfig.h"
#include "DBIssue.h"


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
    TRACE1_L0("DBInterfaceMysql::Query p_dbInterfaceID(%s).\n", p_cmd);
    if (m_mysql == NULL)
    {
        TRACE0_ERROR("DBInterfaceMysql::Query: MYSQL has not init.");
        ProcessQueryResult(p_issue);
        return false;
    }

    if (mysql_real_query(m_mysql, p_cmd, p_size) != 0)
    {
        TRACE0_ERROR("DBInterfaceMysql::SetIssueError1:mysql_real_query.\n");
        SetIssueError(p_issue);
        return false;
    }

    return ProcessQueryResult(p_issue);
}

bool DBInterfaceMysql::ProcessQueryResult(DBIssueBase *p_issue)
{
    TRACE0_L0("DBInterfaceMysql::ProcessQueryResult.\n");
    if (p_issue == NULL)
        return true;

    MYSQL_RES *result = NULL;
    int status = 0;
    do
    {
        result = mysql_store_result(m_mysql);
        if (result)
        {
            // todo:创建数据包
            unsigned int fieldNum = mysql_num_fields(result);
            MYSQL_FIELD *fields = mysql_fetch_fields(result);
            MYSQL_ROW row;
            while (row = mysql_fetch_row(result))
            {
                unsigned long *lengths = mysql_fetch_lengths(result);
                for (int i = 0; i < fieldNum; ++i)
                {
                    const char *value = (row[i] == NULL ? "NULL" : row[i]);
                    TRACE3_L0("DBInterfaceMysql::ProcessQueryResult:field(%i) data:type(%i),value(%s).\n", i, fields[i].type, value);
                }
            }

            mysql_free_result(result);
        }
        else
        {
            if (mysql_field_count(m_mysql) == 0)
            {
                TRACE1_L0("DBInterfaceMysql::ProcessQueryResult:mysql_field_count(m_mysql) == 0,affected rows:%i.\n", m_mysql->affected_rows);
            }
            else
            {
                TRACE0_ERROR("DBInterfaceMysql::SetIssueError2:mysql_field_count(m_mysql) != 0.\n");
                SetIssueError(p_issue);
                return false;
            }
        }

        if ((status = mysql_next_result(m_mysql)) > 0)
        {
            TRACE0_ERROR("DBInterfaceMysql::SetIssueError3:mysql_next_result(m_mysql)) > 0.\n");
            SetIssueError(p_issue);
            return false;
        }
    } while (status == 0);

    return true;
}

bool DBInterfaceMysql::ProcessError(DBIssueBase *p_issue)
{
    TRACE0_L0("DBInterfaceMysql::ProcessError.\n");
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
        NULL, 
        CLIENT_MULTI_STATEMENTS) == NULL)
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

void DBInterfaceMysql::SetIssueError(DBIssueBase *p_issue)
{
    TRACE2_ERROR("DBInterfaceMysql::SetIssueError:mysql_errno(%i),mysql_error(%s).\n", mysql_errno(m_mysql), mysql_error(m_mysql));
    p_issue->SetError(mysql_errno(m_mysql), mysql_error(m_mysql));
}