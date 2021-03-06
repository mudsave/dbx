/*
 * filename : dbProxy.cpp
 * desc : 处理数据回调
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "AccountMgr.h"
#include "LinkContext.h"
#include "session.h"
#include "dbProxy.h"

DBClient* g_pDBAClient = NULL;

#ifndef safeFree
#define safeFree(ptr)	if ((ptr)) {free (ptr); (ptr) = 0;}
#endif


void CDBProxy::init(const char* dbIp, int dbPort)
{
	g_pDBAClient = CreateClient(this, dbIp, dbPort);
}

void CDBProxy::onExeDBProc(int operId, bool result)
{
    DBSTOREMAP::iterator it = m_mapDBStore.find(operId);
    if (it == m_mapDBStore.end())
    {
        TRACE1_ERROR("CDBProxy::onExeDBProc:store call error operId =%d\n", operId);
        g_pDBAClient->deleteAttributeSet(operId);
        return;
    }

    int storeType = it->second.storeType;
    switch (storeType)
    {
    case eStoreLogin:
        doLoginResult(operId, it->second.hLink);
        break;
    case eStoreCreateAccount:
        doCreateAccountResult(operId, it->second.hLink, it->second.accountName);
        break;
    case eStoreCreateRole:
        doCreateRoleResult(operId, it->second.hLink);
        break;
    case eStoreDeleteRole:
        doDeleteRoleResult(operId, it->second.hLink);
        break;
    case eStoreCheckRole:
        doCheckRoleNameResult(operId, it->second.hLink);
        break;
    default:
        TRACE1_ERROR("CDBProxy::onExeDBProc:no this type,type = %d\n", storeType);
        break;
    }
    g_pDBAClient->deleteAttributeSet(operId);
}

void CDBProxy::doLogin(char* userName, char* passWord, handle hLink)
{
    m_msgBuilder.beginMessage();
    m_msgBuilder.addQueryParam("spName", "sp_Login");
    m_msgBuilder.addQueryParam("dataBase", 1);
    m_msgBuilder.addQueryParam("usn", userName);
    m_msgBuilder.addQueryParam("pwd", passWord);
    m_msgBuilder.addQueryParam("offTime", 5);
    m_msgBuilder.addQueryParam("sort", "usn,pwd,offTime");
    DbxMessage* pMsg = m_msgBuilder.finishMessage();

    pMsg->m_spId = 0;
    pMsg->m_bNeedCallback = true;
    pMsg->m_nLevel = 20;
    int operId = g_pDBAClient->callDBProc(pMsg);

	_DBStoreContext storeContext;
	storeContext.storeType = eStoreLogin;
	storeContext.hLink = hLink;
	printf("userName = %s, passWord = %s\n",userName, passWord);
	m_mapDBStore.insert(std::make_pair(operId, storeContext));
}

void CDBProxy::doLoginResult(int operId, handle hLink)
{
    DbxMessage* resultSet = (DbxMessage*)g_pDBAClient->getAttributeSet(operId, 0);

    // 从第一个结果集取accountId
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    if (!resultSet->getAttribute(attrName, valueType, attr, 0, 0))
    {
        TRACE1_ERROR("CDBProxy::doLoginResult: get accountID faild for operId(%i).\n", operId);
        safeFree(attrName);
        return;
    }
    safeFree(attrName);

    DBMsg_LoginResult* pRoleMsg = DBMsg_LoginResult::CreateLoginResult();
    pRoleMsg->actionType = DB_MSG_LOGIN;
    pRoleMsg->accountId = *((int *)attr);
    if (pRoleMsg->accountId == 0)
        pRoleMsg->ret = 1;
    else
        pRoleMsg->ret = 0;

    // 处理第二个结果集的角色数据
    resultSet = (DbxMessage*)g_pDBAClient->getAttributeSet(operId, 1);
    if (resultSet == NULL)
    {
        TRACE1_ERROR("CDBProxy::doLoginResult:account(%i)'s result set for role is null.\n", pRoleMsg->accountId);
        return;
    }

    int maxRows = resultSet->getAttributeRows();
    pRoleMsg->roleNum = maxRows;
    int cols = resultSet->getAttributeCols();
    for (int row = 0; row < maxRows; ++row)
    {
        for (int col = 0; col < cols; ++col)
        {
            if (!resultSet->getAttribute(attrName, valueType, attr, col, row))
            {
                safeFree(attrName);
                TRACE1_ERROR("CDBProxy::doLoginResult::cannot get data for account(%i).\n", pRoleMsg->accountId);
                return;
            }

            switch (col)
            {
                case 0:
                {
                    int roleID = *(int*)attr;
                    pRoleMsg->role[row].roleId = roleID;
                    break;
                }
                case 1:
                {
                    int len = valueType;
                    strncpy(pRoleMsg->role[row].name, (char*)attr, len);
                    pRoleMsg->role[row].name[len] = '\0';
                    break;
                }
                case 2:
                {
                    short level = (short)*(int*)attr;
                    pRoleMsg->role[row].level = level;
                    break;
                }
                case 3:
                {
                    short school = (short)*(int*)attr;
                    pRoleMsg->role[row].school = school;
                    break;
                }
                case 4:
                {
                    if (valueType == PARAMINT)
                    {
                        int modelID = (int)*(int*)attr;
                        pRoleMsg->role[row].modelId = modelID;
                    }
                    else if (valueType == PARAMFLOAT)
                    {
                        int modelID = (int)*(float*)attr;
                        pRoleMsg->role[row].modelId = modelID;
                    }
                    break;
                }
                case 5:
                {
                    int len = valueType;
                    strncpy(pRoleMsg->role[row].showPart, (char*)attr, len);
                    pRoleMsg->role[row].showPart[len] = '\0';
                    break;
                }
                case 6:
                {
                    int weaponID = *(int*)attr;
                    pRoleMsg->role[row].weaponID = weaponID;
                    break;
                }
                case 7:
                {
                    int len = valueType;
                    strncpy(pRoleMsg->role[row].remouldAttr, (char*)attr, len);
                    pRoleMsg->role[row].remouldAttr[len] = '\0';
                    break;
                }
				case 8:
				{
					int value = *(int*)attr;
					pRoleMsg->role[row].showDrama = value;
					break;
				}
				case 9:
				{
					bool value = *(bool*)attr;
					pRoleMsg->role[row].sex = value;
					break;
				}
            }   // end switch
            safeFree(attrName);
        }
    }

    g_session.OnDBReturn(pRoleMsg, hLink);
}

void CDBProxy::doCreateAccount(char* userName, char* passWord, handle hLink)
{
    m_msgBuilder.beginMessage();
    m_msgBuilder.addQueryParam("spName", "sp_CreateUserTest");
    m_msgBuilder.addQueryParam("dataBase", 1);
    m_msgBuilder.addQueryParam("usn", userName);
    m_msgBuilder.addQueryParam("pwd", passWord);
    m_msgBuilder.addQueryParam("sort", "usn,pwd");
    DbxMessage* pMsg = m_msgBuilder.finishMessage();

    pMsg->m_spId = 0;
    pMsg->m_bNeedCallback = true;
    pMsg->m_nLevel = 20;
    int operId = g_pDBAClient->callDBProc(pMsg);

	_DBStoreContext context;
	context.storeType = eStoreCreateAccount;
	context.hLink = hLink;
	context.accountName = userName;
	m_mapDBStore.insert(std::make_pair(operId, context));
}

void CDBProxy::doCreateAccountResult(int operId, handle hLink, std::string accountName)
{
    DbxMessage* resultSet = (DbxMessage*)g_pDBAClient->getAttributeSet(operId, 0);
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    resultSet->getAttribute(attrName, valueType, attr, 0, 0);
    safeFree(attrName);

    DBMsg_CreateAccountResult ret;
    ret.actionType = DB_MSG_CREATEUSER;
    strcpy(ret.accountName, accountName.c_str());
    ret.accountId = *((int *)attr);
    ret.result = ret.accountId > 0 ? true : false;
    g_session.OnDBReturn(&ret, hLink);
}

void CDBProxy::doCreateRole( handle hLink, int accountId, _MsgCS_CreateRoleInfo* pRoleInfo)
{
    m_msgBuilder.beginMessage();
    m_msgBuilder.addQueryParam("spName", "sp_CreatePlayerTest");
    m_msgBuilder.addQueryParam("dataBase", 1);
    m_msgBuilder.addQueryParam("playerName", pRoleInfo->roleName);
    m_msgBuilder.addQueryParam("sex", (int)pRoleInfo->sex);
    m_msgBuilder.addQueryParam("school", (int)pRoleInfo->school);
    m_msgBuilder.addQueryParam("modleID", (int)pRoleInfo->modelId);
    m_msgBuilder.addQueryParam("showParts", pRoleInfo->showParts);
    m_msgBuilder.addQueryParam("userId", accountId);
    m_msgBuilder.addQueryParam("sort", "playerName,sex,userId,school,modleID,showParts");
    DbxMessage* pMsg = m_msgBuilder.finishMessage();

    pMsg->m_spId = 0;
    pMsg->m_bNeedCallback = true;
    pMsg->m_nLevel = 20;
    int operId = g_pDBAClient->callDBProc(pMsg);

	_DBStoreContext context;
	context.storeType = eStoreCreateRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));

}

void CDBProxy::doCreateRoleResult(int operId, handle hLink)
{
    DbxMessage* resultSet = (DbxMessage*)g_pDBAClient->getAttributeSet(operId, 0);
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    resultSet->getAttribute(attrName, valueType, attr, 1, 0);   // 取第2个字段
    safeFree(attrName);

    DBMsg_CreateRoleResult ret;
    ret.actionType = DB_MSG_CREATEROLE;
    ret.roleId = *((int *)attr);
    ret.result = ret.roleId > 0 ? true : false;
    g_session.OnDBReturn(&ret, hLink);
}

void CDBProxy::doDeleteRole(int accountId, int roleId, handle hLink)
{
    m_msgBuilder.beginMessage();
    m_msgBuilder.addQueryParam("spName", "sp_DeletePlayerTest");
    m_msgBuilder.addQueryParam("dataBase", 1);
    m_msgBuilder.addQueryParam("userID", accountId);
    m_msgBuilder.addQueryParam("roleID", roleId);
    m_msgBuilder.addQueryParam("sort", "userID,roleID");
    DbxMessage* pMsg = m_msgBuilder.finishMessage();

    pMsg->m_spId = 0;
    pMsg->m_bNeedCallback = true;
    pMsg->m_nLevel = 20;
    int operId = g_pDBAClient->callDBProc(pMsg);

	_DBStoreContext context;
	context.storeType = eStoreDeleteRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));
}

void CDBProxy::doDeleteRoleResult(int operId, handle hLink)
{
    DbxMessage* resultSet = (DbxMessage*)g_pDBAClient->getAttributeSet(operId, 0);
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    resultSet->getAttribute(attrName, valueType, attr, 0, 0);   // 取第1个字段
    safeFree(attrName);

    // 返回客户端
    DBMsg_DeleteRoleResult ret;
    ret.actionType = DB_MSG_DELETEROLE;
    ret.roleId = *(int*)attr;
    ret.result = ret.roleId > 0 ? true : false;
    g_session.OnDBReturn(&ret, hLink);
}

void CDBProxy::doCheckRoleName(char* pRoleName, handle hLink)
{
    m_msgBuilder.beginMessage();
    m_msgBuilder.addQueryParam("spName", "sp_CheckPlayerTest");
    m_msgBuilder.addQueryParam("dataBase", 1);
    m_msgBuilder.addQueryParam("playerName", pRoleName);
    m_msgBuilder.addQueryParam("sort", "playerName");
    DbxMessage* pMsg = m_msgBuilder.finishMessage();

    pMsg->m_spId = 0;
    pMsg->m_bNeedCallback = true;
    pMsg->m_nLevel = 20;
    int operId = g_pDBAClient->callDBProc(pMsg);

	_DBStoreContext context;
	context.storeType = eStoreCheckRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));
}

void CDBProxy::doCheckRoleNameResult(int operId, handle hLink)
{
    DbxMessage* resultSet = (DbxMessage*)g_pDBAClient->getAttributeSet(operId, 0);
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    resultSet->getAttribute(attrName, valueType, attr, 0, 0);   // 取第1个字段
    safeFree(attrName);

    DBMsg_CheckNameResult ret;
    ret.actionType = DB_MSG_CHECKNAME;
    ret.result = ( *(int*)attr == 0 ? true : false );
    g_session.OnDBReturn(&ret, hLink);
}

void CDBProxy::onConnected(bool result)
{
	if ( result )
		TRACE0_L0("conncet DB success\n");
	else
		TRACE0_L0("conncet DB fail\n");
}

HRESULT CDBProxy::Do(HANDLE hContext)
{
    return S_OK;
}

CDBProxy g_DBProxy;
