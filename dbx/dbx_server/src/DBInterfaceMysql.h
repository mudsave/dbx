/*
Written by wangshufeng.
RTX:6016.
√Ë ˆ£∫

*/

#ifndef __DB_INTERFACE_MYSQL_H_
#define __DB_INTERFACE_MYSQL_H_

#include "mysql.h"

#include "DBInterface.h"


class DBInterfaceMysql : public DBInterface
{
public:
    DBInterfaceMysql(int p_dbInterfaceID);

    virtual bool Query(const char *p_cmd, int p_size, AppMsg *p_appMsg = NULL);

    bool ProcessQueryResult(AppMsg *p_appMsg);

    virtual bool Initialize();

    virtual bool Connect();

    virtual void Disconnect();

protected:
    MYSQL *m_mysql;
};

#endif  // end of __DB_INTERFACE_MYSQL_H_