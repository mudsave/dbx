#include "DBPoolMgr.h"

#include <vector>

//#include "trace.h"
#include "lindef.h"

#include "DBXConfig.h"

bool DBPoolMgr::Initialize()
{
    TRACE0_L0("DBPoolMgr::Initialize.\n");

    if (g_dbxConfig.m_interfaceInfos.size() == 0)
    {
        TRACE0_ERROR( "DBPoolMgr::Initialize:cant find database interface.\n" );
        return false;
    }

    std::vector<DBInterfaceInfo>::iterator dbInterfaceInfo = g_dbxConfig.m_interfaceInfos.begin();
    for (; dbInterfaceInfo != g_dbxConfig.m_interfaceInfos.end(); ++dbInterfaceInfo)
    {
        TRACE1_L0("DBPoolMgr::Initialize DBInterface %i.\n", dbInterfaceInfo->id);
    }

    return true;
}