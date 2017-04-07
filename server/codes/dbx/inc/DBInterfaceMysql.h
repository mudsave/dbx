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

/// 参数数据类型
enum
{
    PARAM_DATATYPE_INT = 0,         /// 整型
    PARAM_DATATYPE_CHAR,            /// 字符串类型
    PARAM_DATATYPE_BIN,             /// 二进制类型
    PARAM_DATATYPE_FLOAT,           /// 浮点类型
    PARAM_DATATYPE_BOOL,            /// 布尔类型
};

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

    //用来创建回调消息
    DbxMessageBuilder<DbxMessage> m_SCMsgBuilder;

    std::string m_lastQueryStatement;

protected:
    MYSQL *m_mysql;
};

#endif  // __DB_INTERFACE_MYSQL_H_