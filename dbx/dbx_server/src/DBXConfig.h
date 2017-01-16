#ifndef __DBX_CONFIG_H_
#define __DBX_CONFIG_H_

#include <string>
#include <vector>

#include "DBXCommon.h"
#include "tinyxml.h"
#include "Singleton.h"


struct DBInterfaceInfo
{
    DBInterfaceInfo()
    {
        id = 0;
        memset(db_ip, 0, sizeof(db_ip));
        memset(db_name, 0, sizeof(db_name));
        memset(db_username, 0, sizeof(db_username));
        memset(db_password, 0, sizeof(db_password));
    }

    int id;                             // 数据库接口id
    char db_type[DBX_MAX_BUF];          // 数据库类型
    char db_ip[DBX_MAX_BUF];            // 数据库ip地址
    int db_port;                        // 数据库端口
    char db_name[DBX_MAX_NAME];         // 数据库名字
    char db_username[DBX_MAX_NAME];     // 连接数据库的用户名
    char db_password[DBX_MAX_BUF];      // 连接数据库的密码
    int db_connectionsNum;              // 数据库最大连接
};

class DBXConfig: public Singleton<DBXConfig>
{
public:
    bool LoadConfig(std::string p_filePath);

    DBInterfaceInfo *GetDBInterfaceInfo(int p_dbInterfaceID);

    std::vector<DBInterfaceInfo> m_interfaceInfos;

protected:
    std::string GetElementAttributeStr(TiXmlElement *p_element, const char *p_key);

    int GetElementAttributeInt(TiXmlElement *p_element, const char *p_key);
};

#define g_dbxConfig DBXConfig::Instance()


#endif  // end of __DBX_CONFIG_H_