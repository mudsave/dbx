#include "DBFactory.h"

#include <vector>
#include <string>

//#include "trace.h"
#include "lindef.h"

#include "DBXConfig.h"
#include "DBTaskPool.h"
#include "DBInterfaceMysql.h"


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

        DBInterface *dbInterface = CreateDBInterface(dbInterfaceInfo->id);
    }

    return true;
}

void DBFactory::Finalise()
{
    TRACE0_L0("DBFactory::Finalise.\n");
    DBFactory::DBTaskPoolMap::iterator iter = m_taskPoolMap.begin();
    for (; iter != m_taskPoolMap.end(); ++iter)
    {
        iter->second->Finalise();
        delete iter->second;    // todo：定义安全释放宏
    }
}

DBInterface *DBFactory::CreateDBInterface(int p_dbInterfaceID)
{
    DBInterfaceInfo *dbInfo = g_dbxConfig.GetDBInterfaceInfo(p_dbInterfaceID);
    if (dbInfo == NULL)
    {
        TRACE1_ERROR("DBFactory::CreateDBInterface: there is no DBInfo for DBInterface ID(%i).", p_dbInterfaceID);
        return NULL;
    }

    DBInterface *dbInterface = NULL;
    if (strcmp(dbInfo->db_type, "mysql") == 0)
    {
        dbInterface = new DBInterfaceMysql(p_dbInterfaceID);
        if (!dbInterface->Initialize())
        {
            TRACE1_ERROR("DBFactory::CreateDBInterface: DBInterfaceMysql Initialize error.(id:%i).", p_dbInterfaceID);
            return NULL;
        }
    }

    if (!dbInterface->Connect())
    {
        TRACE1_ERROR("DBFactory::CreateDBInterface:DB interface(id:%i) Connect Error.\n", p_dbInterfaceID);
        return NULL;
    }

    TRACE1_L0("DBFactory::CreateDBInterface:%i.\n", p_dbInterfaceID);
    return dbInterface;
}