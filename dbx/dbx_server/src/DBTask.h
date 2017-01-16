#ifndef __DB_TASK_H_
#define __DB_TASK_H_

#include "lindef.h"
#include "Sock.h"

#include "DBInterface.h"
#include "DBIssue.h"

class DBTaskPool;

class DBTask : public ITask
{
public:
    DBTask(int p_dbInterfaceID, DBTaskPool *p_dbTaskPool);
    ~DBTask();

    virtual HRESULT Do(HANDLE hContext);

    void SetIssue(DBIssueBase *p_issue);
    DBIssueBase *GetCurrIssue();
    DBIssueBase *GetNextIssue();

    DBTaskPool *GetTaskPool();

    void Wait();
    void Start();

    void ProgressIssue(DBIssueBase *p_issue);

    void Destroy();
    bool IsDestroyed();
protected:
    void DoEnd();

    void ProgressEnd();
protected:
    int m_dbInterfaceID;
    DBTaskPool *m_taskPool;
    DBInterface *m_dbInterface;

    DBIssueBase *m_currentIssue;

    Semaphore m_semaphore;

    bool m_isDestroyed;
};


#endif // end of __DB_TASK_H_