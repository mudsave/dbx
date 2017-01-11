#ifndef __DB_TASK_H_
#define __DB_TASK_H_



#include "lindef.h"
#include "Sock.h"

class DBTask : public ITask
{
public:
    virtual HRESULT Do(HANDLE hContext);
};




#endif // end of __DB_TASK_H_