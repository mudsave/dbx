#include "DBFactory.h"

#include <vector>

//#include "trace.h"
#include "lindef.h"

#include "DBXConfig.h"
#include "DBTaskPool.h"

bool DBFactory::Initialize()
{
    TRACE0_L0("DBFactory::Initialize.\n");

    if (g_dbxConfig.m_interfaceInfos.size() == 0)
    {
        TRACE0_ERROR( "DBFactory::Initialize:cant find database interface.\n" );
        return false;
    }

    std::vector<DBInterfaceInfo>::iterator dbInterfaceInfo = g_dbxConfig.m_interfaceInfos.begin();
    for (; dbInterfaceInfo != g_dbxConfig.m_interfaceInfos.end(); ++dbInterfaceInfo)
    {
        TRACE1_L0("DBFactory::Initialize DBInterface %i.\n", dbInterfaceInfo->id);
        m_taskPoolMap[dbInterfaceInfo->id] = new DBTaskPool(dbInterfaceInfo->id);
        if (!m_taskPoolMap[dbInterfaceInfo->id]->InitTasks(dbInterfaceInfo->db_connectionsNum))
            return false;
    }

    return true;
}

void DBFactory::Finalise()
{
    TRACE0_L0("DBFactory::Finalise:%i.\n");
    DBFactory::DBTaskPoolMap::iterator iter = m_taskPoolMap.begin();
    for (; iter != m_taskPoolMap.end(); ++iter)
    {
        iter->second->Finalise();
        delete iter->second;    // todo：定义安全释放宏
    }
}