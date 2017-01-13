#ifndef __DB_ISSUE_H_
#define __DB_ISSUE_H_

class DBIssueBase
{
public:
    virtual void Progress();
    virtual void OnProgress() = 0;
};


class DBIssueCallSP :public DBIssueBase
{
public:
    virtual void OnProgress();
};


#endif // end of __DB_ISSUE_H_