/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#ifndef __DB_INTERFACE_MYSQL_H_
#define __DB_INTERFACE_MYSQL_H_

#include "mysql.h"

#include "DBInterface.h"


class DBInterfaceMysql : public DBInterface
{
public:
    DBInterfaceMysql(int p_dbInterfaceID);

    virtual bool Query(const char *p_cmd, int p_size, DBIssueBase *p_issue = NULL);

    bool ProcessQueryResult(DBIssueBase *p_issue);

    bool ProcessError(DBIssueBase *p_issue);

    virtual bool Initialize();

    virtual bool Connect();

    virtual void Disconnect();

private:
    void SetIssueError(DBIssueBase *p_issue);

protected:
    MYSQL *m_mysql;
};

#endif  // __DB_INTERFACE_MYSQL_H_