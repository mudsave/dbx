/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#ifndef __DB_ISSUE_H_
#define __DB_ISSUE_H_

#include <string>

#include "lindef.h"
#include "DBInterface.h"
#include "DBXMessageTranslate.h"

class DBIssueBase
{
public:
    DBIssueBase(AppMsg *p_appMsg, int p_queryID, handle p_linkIndex = -1);

    virtual bool Progress();
    virtual bool OnProgress() = 0;
    virtual void MainProgress();

    void SetDBInterface(DBInterface *p_dbInterface);

    int GetQueryID();

    bool HasError();
    std::string &GetErrorStr();
    void SetError(int p_errnum, std::string p_errstr);
    void ProcessError();
protected:
    DBInterface *m_dbInterface;
    int m_queryID;              // 查询的序号id，有效的同序号须按顺序处理查询

    handle m_linkIndex;         // 发起查询的客户端网络索引，可通过此索引把查询结果集发回查询方
    AppMsg m_resultAppMsg;      // 查询结果数据包

    unsigned int m_errnum;
    std::string m_errstr;
};


class DBIssueCallSP :public DBIssueBase
{
public:
    DBIssueCallSP(AppMsg *p_appMsg, int p_queryID, handle p_linkIndex);

    virtual bool OnProgress();
    virtual void MainProgress();

    const TListOutput & GetOutParams() { return m_outParams; }

private:
    TListOutput m_outParams;    //输出参数，从查询结果构建消息协议时用到

    AppMsg * m_pAppMsg;
};


class DBIssueCallSQL :public DBIssueBase
{
public:
    DBIssueCallSQL(AppMsg *p_appMsg, int p_queryID, handle p_linkIndex);

    virtual bool OnProgress();
    virtual void MainProgress();

    AppMsg * m_pAppMsg;
};

#endif // __DB_ISSUE_H_