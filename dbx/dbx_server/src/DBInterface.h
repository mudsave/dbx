#ifndef __DB_INTERFACE_H_
#define __DB_INTERFACE_H_

#include <string>

// @note by wangshufeng.
// for AppMsg。AppMsg在msgdef.h中声明，但却需要包含vsdef.h，因为msgdef.h中的一些声明依赖于vsdef.h，不能独立使用，vsdef.h在文件尾包含了msgdef.h。
#include "lindef.h"
#include "vsdef.h"

#include "DBCommon.h"


class DBInterface
{
public:
    DBInterface(int p_dbInterfaceID) :
        m_dbInterfaceID(p_dbInterfaceID),
        m_dbPort(3306),
        m_lastQuery()
    {

    }

    ~DBInterface();

    virtual bool Query(const char *p_cmd, int p_size, AppMsg *p_appMsg) = 0;

    virtual bool Connect() = 0;

    virtual void Disconnect() = 0;

    virtual bool Initialize() {};
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