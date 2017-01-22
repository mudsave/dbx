#ifndef __DB_INTERFACE_H_
#define __DB_INTERFACE_H_

#include <stdio.h>

// @note by wangshufeng.
// for AppMsg。AppMsg在msgdef.h中声明，但却需要包含vsdef.h，因为msgdef.h中的一些声明依赖于vsdef.h，不能独立使用，vsdef.h在文件尾包含了msgdef.h。
#include "lindef.h"
#include "vsdef.h"

/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#include "DBXCommon.h"
#include "DBXConfig.h"

class DBInterface
{
public:
    DBInterface(int p_dbInterfaceID) :
        m_dbInterfaceID(p_dbInterfaceID),
        m_dbPort(3306),
        m_lastQuery()
    {
    }

    ~DBInterface()
    {
    }

    virtual bool Query(const char *p_cmd, int p_size, AppMsg *p_appMsg) = 0;

    virtual bool Connect() = 0;

    virtual void Disconnect() = 0;

    virtual bool Initialize()
    {
        TRACE1_L0("DBInterfaceMysql::Initialize p_dbInterfaceID(%i)\n", m_dbInterfaceID);

        DBInterfaceInfo *dbInfo = g_dbxConfig.GetDBInterfaceInfo(m_dbInterfaceID);
        if (dbInfo == NULL)
        {
            TRACE1_ERROR("DBInterfaceMysql::Initialize:g_dbxConfig.GetDBInterfaceInfo error:cant find database info for ID(%id).\n", m_dbInterfaceID);
            return false;
        }

        m_dbPort = dbInfo->db_port;

        ConfigStrcpy(m_dbType, dbInfo->db_type, DBX_MAX_BUF);
        ConfigStrcpy(m_dbIP, dbInfo->db_ip, DBX_MAX_BUF);
        ConfigStrcpy(m_dbUserName, dbInfo->db_username, DBX_MAX_NAME);
        ConfigStrcpy(m_dbPassword, dbInfo->db_password, DBX_MAX_BUF);
        ConfigStrcpy(m_dbName, dbInfo->db_name, DBX_MAX_NAME);

        return true;
    }

private:
    // 配置初始化到属性，安全的字符串复制，确保目标字符数组以'\0'结尾
    void ConfigStrcpy(char *p_dststr, char *p_srcstr, size_t p_buffLen)
    {
        strncpy(p_dststr, p_srcstr, p_buffLen);
        if (p_dststr[p_buffLen - 1] != '\0')
            p_dststr[p_buffLen - 1] = '\0';
    }

protected:
    int m_dbInterfaceID;
    char m_dbType[DBX_MAX_BUF];
    int m_dbPort;
    char m_dbIP[DBX_MAX_BUF];
    char m_dbUserName[DBX_MAX_NAME];
    char m_dbPassword[DBX_MAX_BUF];
    char m_dbName[DBX_MAX_NAME];

    std::string m_lastQuery;
};



#endif // end of __DB_INTERFACE_H_