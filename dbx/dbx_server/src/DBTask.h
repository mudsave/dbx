#ifndef __DB_TASK_H_
#define __DB_TASK_H_

#include "lindef.h"
#include "Sock.h"

#include "DBInterface.h"


class DBTaskPool;
class DBTask : public ITask
{
public:
    DBTask(int p_dbInterfaceID, DBTaskPool *p_dbTaskPool);
    ~DBTask();

    virtual HRESULT Do(HANDLE hContext);

protected:
    int m_dbInterfaceID;
    DBTaskPool *m_taskPool;
    DBInterface *m_dbInterface;
};




#endif // end of __DB_TASK_H_