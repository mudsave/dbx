/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#include "DBManager.h"

//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

#include "DBFactory.h"

#define DBX_DEFALT_DATABASE_ID 1   // 默认数据库id
#define DBX_MAIN_TICK_TIME 100

DBManager::DBManager()
    :m_networkInterface()
{
}

bool DBManager::Initialize(int p_port)
{
    TRACE0_L0( "DBManager::Initialize...\n" );
    m_mainProcessTimer = GlobalThreadsPool()->RegTimer(this, NULL, 0, DBX_MAIN_TICK_TIME, DBX_MAIN_TICK_TIME, "DBX_Main_Process_Timer");
    if (m_mainProcessTimer == NULL)
    {
        TRACE0_ERROR("DBManager::Initialize...Register timer error.\n");
        return false;
    }

    return m_networkInterface.Listen(p_port) && InitDB();
}

void DBManager::Finalise()
{
    TRACE0_L0("DBManager::Finalise.\n");
    GlobalThreadsPool()->UnregTimer(m_mainProcessTimer);

    DBFactory::InstancePtr()->Finalise();
    m_networkInterface.Finalise();
    GlobalThreadsPool()->Shutdown();
}

HRESULT DBManager::Run()
{
    TRACE0_L0("DBManager::Run.\n");
    return GlobalThreadsPool()->Running();
}

void DBManager::Shutdown()
{
    Finalise();
}

bool DBManager::InitDB()
{
    TRACE0_L0("DBManager::InitDB...\n");

    return DBFactory::InstancePtr()->Initialize();
}

void DBManager::CallSP(handle p_linkIndex, AppMsg *p_appMsg)
{
    // todo:从p_appMsg中获得queryID

    DBTaskPool* dbTaskPool = DBFactory::InstancePtr()->GetTaskPool(DBX_DEFALT_DATABASE_ID);
    if (dbTaskPool == NULL)
    {
        TRACE1_ERROR("DBManager::CallSQL:Cant get task pool(id:%i), it is maybe destroyed.\n", DBX_DEFALT_DATABASE_ID);
        return;
    }

    //获取queryIndex
    PType type; const void * pValue; int queryIndex = -1;
    CCSResultMsg * pQueryMsg = (CCSResultMsg *)p_appMsg;
    DbxMessageBuilder<CCSResultMsg>::locateContent(pQueryMsg);

    if (pQueryMsg->getAttibuteByName("queryIndex", 0, type, pValue) && type == PARAMINT)
    {
        queryIndex = *(int *)pValue;
    }

    dbTaskPool->AddIssue(new DBIssueCallSP(p_appMsg, queryIndex, p_linkIndex));
}

void DBManager::CallSQL(handle p_linkIndex, AppMsg *p_appMsg)
{
    // todo:从p_appMsg中获得queryID

    DBTaskPool* dbTaskPool = DBFactory::InstancePtr()->GetTaskPool(DBX_DEFALT_DATABASE_ID);
    if (dbTaskPool == NULL)
    {
        TRACE1_ERROR("DBManager::CallSQL:Cant get task pool(id:%i), it is maybe destroyed.\n", DBX_DEFALT_DATABASE_ID);
        return;
    }

    //获取queryIndex
    PType type; const void * pValue; int queryIndex = -1;
    CCSResultMsg * pQueryMsg = (CCSResultMsg *)p_appMsg;
    DbxMessageBuilder<CCSResultMsg>::locateContent(pQueryMsg);

    TRACE1_L0("size of CCSResultMsg %i", sizeof(CCSResultMsg));
    TRACE1_L0("query message start at %i", pQueryMsg);
    TRACE2_L0("message msgLen %i, at %i", pQueryMsg->msgLen, &pQueryMsg->msgLen);
    TRACE2_L0("message msgFlags %i, at %i", pQueryMsg->msgFlags, &pQueryMsg->msgFlags);
    TRACE2_L0("message msgCls %i, at %i", pQueryMsg->msgCls, &pQueryMsg->msgCls);
    TRACE2_L0("message msgId %i, at %i", pQueryMsg->msgId, &pQueryMsg->msgId);
    TRACE2_L0("message context %i, at %i", pQueryMsg->context, &pQueryMsg->context);
    TRACE1_L0("message paramCount %i", pQueryMsg->getParamCount());
    TRACE2_L0("message attribute_cols %i, at %i", pQueryMsg->getAttributeCols(), &pQueryMsg->attribute_cols);
    TRACE2_L0("message attribute_count %i, at %i", pQueryMsg->getAttributeCount(), &pQueryMsg->attribute_count);
    TRACE2_L0("message p_content %i, at %i", pQueryMsg->content_offset, &pQueryMsg->content_offset);
    TRACE2_L0("message m_nTempObjId %i, at %i", pQueryMsg->m_nTempObjId, &pQueryMsg->m_nTempObjId);
    TRACE2_L0("message m_nSessionId %i, at %i", pQueryMsg->m_nSessionId, &pQueryMsg->m_nSessionId);
    TRACE2_L0("message m_spId %i, at %i", pQueryMsg->m_spId, &pQueryMsg->m_spId);
    TRACE2_L0("message m_bEnd %i, at %i", pQueryMsg->m_bEnd, &pQueryMsg->m_bEnd);
    TRACE2_L0("message m_bNeedCallback %i, at %i", pQueryMsg->m_bNeedCallback, &pQueryMsg->m_bNeedCallback);
    TRACE2_L0("message m_nLevel %i, at %i", pQueryMsg->m_nLevel, &pQueryMsg->m_nLevel);

    if (pQueryMsg->getAttibuteByName("queryIndex", 0, type, pValue) && type == PARAMINT)
    {
        queryIndex = *(int *)pValue;
    }

    dbTaskPool->AddIssue(new DBIssueCallSQL(p_appMsg, queryIndex, p_linkIndex));
}

void DBManager::SendResult(handle p_linkIndex, AppMsg *p_appMsg)
{
    m_networkInterface.SendMsg(p_linkIndex, p_appMsg);
}

HRESULT DBManager::Do(HANDLE hContext)
{
    //TRACE0_L0("DBManager::Do...\n");
    DBFactory::InstancePtr()->MainTick();
    return S_OK;
}
