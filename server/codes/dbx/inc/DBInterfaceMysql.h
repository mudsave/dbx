/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#ifndef __DB_INTERFACE_MYSQL_H_
#define __DB_INTERFACE_MYSQL_H_

#include "mysql.h"

#include "DBInterface.h"
#include "DBXMessageTranslate.h"


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

    MYSQL * GetMysql() { return m_mysql; }

    char * GetQueryBuffer() { return m_szQueryBuffer; }

private:
    void SetIssueError(DBIssueBase *p_issue);

    //用来创建查询缓冲，放在这里可以避免多次创建和释放内存
    char m_szQueryBuffer[QUERYBUFFER_MAX_LEN];

protected:
    MYSQL *m_mysql;
};

#endif  // end of __DB_INTERFACE_MYSQL_H_