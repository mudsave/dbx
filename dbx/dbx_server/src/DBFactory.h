#ifndef __DB_FACTORY_H_
#define __DB_FACTORY_H_

#include <map>

#include "Singleton.h"
#include "DBTaskPool.h"

class DBInterface;

class DBFactory : public Singleton<DBFactory>
{
public:
    bool Initialize();
    void Finalise();

    DBInterface *CreateDBInterface(int p_dbInterfaceID);

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


#endif // end of __DB_FACTORY_H_