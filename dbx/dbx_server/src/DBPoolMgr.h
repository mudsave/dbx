#ifndef __DB_POOL_MGR_
#define __DB_POOL_MGR_

#include "Singleton.h"

class DBPoolMgr : public Singleton<DBPoolMgr>
{
public:
    bool Initialize();
};


#endif // end of __DB_POOL_MGR_