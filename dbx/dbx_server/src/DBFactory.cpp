/*
Written by wangshufeng.
RTX:6016.
描述：

*/

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

    const DBXConfig::DB_INTERFACE_INFOS allDBInterfaceInfos = g_dbxConfig.GetAllDBInterfaceInfo();
    if (allDBInterfaceInfos.size() == 0)
    {
        TRACE0_ERROR( "DBFactory::Initialize:cant find database interface.\n" );
        return false;
    }

    std::vector<DBInterfaceInfo>::const_iterator iter = allDBInterfaceInfos.begin();
    for (; iter != allDBInterfaceInfos.end(); ++iter)
    {
        TRACE1_L0("DBFactory::Initialize DBInterface %i.\n", iter->id);
        m_taskPoolMap[iter->id] = new DBTaskPool(iter->id);
        if (!m_taskPoolMap[iter->id]->InitTasks(iter->db_connectionsNum))
        {
            TRACE1_ERROR("DBFactory::Initialize:Cant initTasks for db interface(id:%i).\n", iter->id);
            return false;
        }            
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
        delete iter->second;
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
            delete dbInterface;
            dbInterface = NULL;
            return NULL;
        }
    }

    if (!dbInterface->Connect())
    {
        TRACE1_ERROR("DBFactory::CreateDBInterface:DB interface(id:%i) Connect Error.\n", p_dbInterfaceID);
        delete dbInterface;
        dbInterface = NULL;
        return NULL;
    }

    TRACE1_L0("DBFactory::CreateDBInterface:%i.\n", p_dbInterfaceID);
    return dbInterface;
}

void DBFactory::MainTick()
{
    DBFactory::DBTaskPoolMap::iterator iter = m_taskPoolMap.begin();
    for (; iter != m_taskPoolMap.end(); ++iter)
        iter->second->MainTick();
}