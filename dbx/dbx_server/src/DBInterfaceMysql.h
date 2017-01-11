#ifndef __DB_INTERFACE_MYSQL_H_
#define __DB_INTERFACE_MYSQL_H_

#include "DBInterface.h"


class DBInterfaceMysql : public DBInterface
{
public:
    virtual bool Query(const char *p_cmd, int p_size, AppMsg *p_appMsg);
};

#endif  // end of __DB_INTERFACE_MYSQL_H_