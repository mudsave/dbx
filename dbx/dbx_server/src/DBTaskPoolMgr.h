#ifndef __DB_TASK_POOL_MGR_
#define __DB_TASK_POOL_MGR_

#include <map>

#include "Singleton.h"
#include "DBTaskPool.h"


class DBTaskPoolMgr : public Singleton<DBTaskPoolMgr>
{
public:
    bool Initialize();

    typedef std::map<int, DBTaskPool *> DBTaskPoolMap;
    DBTaskPool *GetTaskPool(int p_id)
    {
        DBTaskPoolMap::iterator iter = m_taskPoolMap.find(p_id);
        if (iter != m_taskPoolMap.end())
            return iter->second;

        return NULL;
    }
private:
    DBTaskPoolMap m_taskPoolMap;
};


#endif // end of __DB_TASK_POOL_MGR_