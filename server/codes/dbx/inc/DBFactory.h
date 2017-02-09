/*
Written by wangshufeng.
RTX:6016.
鎻忚堪锛?
*/

#ifndef __DB_FACTORY_H_
#define __DB_FACTORY_H_

#include <map>

#include "lindef.h"

#include "Singleton.h"
#include "DBTaskPool.h"

class DBInterface;

class DBFactory : public DBX::Singleton<DBFactory>
{
public:
    bool Initialize();
    void Finalise();
    void MainTick();

    DBInterface *CreateDBInterface(int p_dbInterfaceID);

    typedef std::map<int, DBTaskPool *> DBTaskPoolMap;
    DBTaskPool *GetTaskPool(int p_id)
    {
        DBTaskPoolMap::iterator iter = m_taskPoolMap.find(p_id);
        if (iter == m_taskPoolMap.end())
        {
            TRACE1_ERROR("DBFactory::GetTaskPool:Cant get task pool for db interface(id:%i).\n", p_id);
            return NULL;
        }
        if (iter->second->IsDestroyed())
        {
            TRACE1_ERROR("DBFactory::GetTaskPool:Cant get task pool for db interface(id:%i).it had been destroyed.\n", p_id);
            return NULL;
        }

        return iter->second;
    }
private:
    DBTaskPoolMap m_taskPoolMap;
};


#endif // end of __DB_FACTORY_H_