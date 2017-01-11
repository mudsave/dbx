#include "DBTaskPoolMgr.h"

#include <vector>

//#include "trace.h"
#include "lindef.h"

#include "DBXConfig.h"
#include "DBTaskPool.h"

bool DBTaskPoolMgr::Initialize()
{
    TRACE0_L0("DBTaskPoolMgr::Initialize.\n");

    if (g_dbxConfig.m_interfaceInfos.size() == 0)
    {
        TRACE0_ERROR( "DBTaskPoolMgr::Initialize:cant find database interface.\n" );
        return false;
    }

    std::vector<DBInterfaceInfo>::iterator dbInterfaceInfo = g_dbxConfig.m_interfaceInfos.begin();
    for (; dbInterfaceInfo != g_dbxConfig.m_interfaceInfos.end(); ++dbInterfaceInfo)
    {
        TRACE1_L0("DBTaskPoolMgr::Initialize DBInterface %i.\n", dbInterfaceInfo->id);
        m_taskPoolMap[dbInterfaceInfo->id] = new DBTaskPool(dbInterfaceInfo->id);
    }

    return true;
}

void DBTaskPoolMgr::finalise()
{
    TRACE0_L0("DBTaskPoolMgr::finalise:%i.\n");
    DBTaskPoolMgr::DBTaskPoolMap::iterator iter = m_taskPoolMap.begin();
    for (; iter != m_taskPoolMap.end(); ++iter)
    {
        iter->second->finalise();
        delete iter->second;    // todo：定义安全释放宏
    }
}