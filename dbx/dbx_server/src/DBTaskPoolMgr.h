#ifndef __DB_TASK_POOL_MGR_
#define __DB_TASK_POOL_MGR_

#include "Singleton.h"

class DBTaskPoolMgr : public Singleton<DBTaskPoolMgr>
{
public:
    bool Initialize();
};


#endif // end of __DB_TASK_POOL_MGR_