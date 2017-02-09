/*
Written by wangshufeng.
RTX:6016.
描述：

*/

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

    int id;                             // ���ݿ�ӿ�id
    char db_type[DBX_MAX_BUF];          // ���ݿ�����
    char db_ip[DBX_MAX_BUF];            // ���ݿ�ip��ַ
    int db_port;                        // ���ݿ�˿�
    char db_name[DBX_MAX_NAME];         // ���ݿ�����
    char db_username[DBX_MAX_NAME];     // �������ݿ���û���
    char db_password[DBX_MAX_BUF];      // �������ݿ������
    int db_connectionsNum;              // ���ݿ��������
};

class DBXConfig: public DBX::Singleton<DBXConfig>
{
public:
    bool LoadConfig(std::string p_filePath);

    DBInterfaceInfo *GetDBInterfaceInfo(int p_dbInterfaceID);

    typedef std::vector<DBInterfaceInfo> DB_INTERFACE_INFOS;
    DB_INTERFACE_INFOS const &GetAllDBInterfaceInfo();

    DB_INTERFACE_INFOS m_interfaceInfos;

protected:
    std::string GetElementAttributeStr(TiXmlElement *p_element, const char *p_key);

    int GetElementAttributeInt(TiXmlElement *p_element, const char *p_key);
};

#define g_dbxConfig DBXConfig::Instance()


#endif  // end of __DBX_CONFIG_H_