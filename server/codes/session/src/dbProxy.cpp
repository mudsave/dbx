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

IInitDBARecordSet* g_recordSet = NULL;
IInitClient* g_pDBAClient = NULL;

CDBProxy::CDBProxy(void)
{

}

CDBProxy::~CDBProxy(void)
{

}

void CDBProxy::init(const char* dbIp, int dbPort)
{
	g_pDBAClient = CreateClient(this, dbIp, dbPort);
	g_recordSet = CreateDBARecordSet();
}

void CDBProxy::onExeDBProc(int operId, IInitClient* pClient, bool result)
{
    TRACE0_L0("CClient::getDBNetEvent()->onExeDBProc_tocpp...\n");
    if (!pClient)
        return;

    int ErrorCode = result ? 0 : -1;

    onDBReturn(operId, ErrorCode);
}

void CDBProxy::doLogin(char* userName, char* passWord, handle hLink)
{
	CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);

    m_msgBuilder.beginMessage();
    const char *strValue = "sp_Login";
    m_msgBuilder.addAttribute("spName", strValue, strlen(strValue));
    int value = 1;
    m_msgBuilder.addAttribute("dataBase", &value, PARAMINT);
    m_msgBuilder.addAttribute("usn", userName, strlen(userName));
    m_msgBuilder.addAttribute("pwd", passWord, strlen(passWord));
    value = 5;
    m_msgBuilder.addAttribute("offTime", &value, PARAMINT);
    strValue = "usn,pwd,offTime";
    m_msgBuilder.addAttribute("sort", strValue, strlen(strValue));
    CSCResultMsg* pMsg = m_msgBuilder.finishMessage();
    pMsg->m_spId = 0;
    pMsg->m_bNeedCallback = true;
    pMsg->m_nLevel = 20;
    int operId = query_client->callDBProc(pMsg);

	_DBStoreContext storeContext;
	storeContext.storeType = eStoreLogin;
	storeContext.hLink = hLink;
	printf("userName = %s, passWord = %s\n",userName, passWord);
	m_mapDBStore.insert(std::make_pair(operId, storeContext));
}

void CDBProxy::PrintAttrInfo(PType p_ptype, char *p_name, void *p_attr, const char *p_description)
{
    switch (p_ptype)
    {
    case PARAMINT:
    case PARAMBOOL:
        TRACE4_L0("CDBProxy::PrintAttrInfo:%s->attrName(%s), type(%i), value(%i)\n", p_description, p_name, p_ptype, *(int *)p_attr);
        break;
    
    case PARAMFLOAT:
        TRACE4_L0("CDBProxy::PrintAttrInfo:%s->attrName(%s), type(%i), value(%f)\n", p_description, p_name, p_ptype, *(float *)p_attr);
        break;

    default:
        TRACE3_L0("CDBProxy::PrintAttrInfo:%s->attrName(%s), type(str:%i)\n", p_description, p_name, p_ptype);
        break;
    }
}

void CDBProxy::doLoginResult(int operId, handle hLink)
{
    TRACE0_L0("CDBProxy::doLoginResult:wsf.....");
    CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);
    CSCResultMsg* resultSet = (CSCResultMsg*)query_client->getAttributeSet(operId, 0);

    // 从第一个结果集取accountId
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    if (!resultSet->getAttribute(attrName, valueType, attr, 0, 0))
    {
        TRACE1_ERROR("CDBProxy::doLoginResult: get accountID faild for operId(%i).\n", operId);
        safeDelete(attrName);
        return;
    }
    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:accountID");
    safeDelete(attrName);

    DBMsg_LoginResult* pRoleMsg = DBMsg_LoginResult::CreateLoginResult();
    pRoleMsg->actionType = DB_MSG_LOGIN;
    pRoleMsg->accountId = *((int *)attr);
    if (pRoleMsg->accountId == 0)
        pRoleMsg->ret = 1;
    else
        pRoleMsg->ret = 0;

    // 处理第二个结果集的角色数据
    resultSet = (CSCResultMsg*)query_client->getAttributeSet(operId, 1);
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
                safeDelete(attrName);
                TRACE1_ERROR("CDBProxy::doLoginResult::cannot get data for account(%i).\n", pRoleMsg->accountId);
                return;
            }

            switch (col)
            {
                case 0:
                {
                    int roleID = *(int*)attr;
                    pRoleMsg->role[row].roleId = roleID;
                    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:roleId");
                    break;
                }
                case 1:
                {
                    int len = valueType;
                    strncpy(pRoleMsg->role[row].name, (char*)attr, len);
                    pRoleMsg->role[row].name[len] = '\0';
                    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:name");
                    break;
                }
                case 2:
                {
                    short level = (short)*(int*)attr;
                    pRoleMsg->role[row].level = level;
                    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:level");
                    break;
                }
                case 3:
                {
                    short school = (short)*(int*)attr;
                    pRoleMsg->role[row].school = school;
                    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:school");
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
                    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:modelId");
                    break;
                }
                case 5:
                {
                    int len = valueType;
                    strncpy(pRoleMsg->role[row].showPart, (char*)attr, len);
                    pRoleMsg->role[row].showPart[len] = '\0';
                    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:showPart");
                    break;
                }
                case 6:
                {
                    int weaponID = *(int*)attr;
                    pRoleMsg->role[row].weaponID = weaponID;
                    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:weaponID");
                    break;
                }
                case 7:
                {
                    int len = valueType;
                    strncpy(pRoleMsg->role[row].remouldAttr, (char*)attr, len);
                    pRoleMsg->role[row].remouldAttr[len] = '\0';
                    PrintAttrInfo(valueType, attrName, attr, "CDBProxy::doLoginResult:remouldAttr");
                    break;
                }
            }   // end switch
            safeDelete(attrName);
        }
    }

    g_session.OnDBReturn(pRoleMsg, hLink);
}

void CDBProxy::doCreateAccount(char* userName, char* passWord, handle hLink)
{
	CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);
	query_client->buildQuery();
	query_client->addParam("spName", "sp_CreateUserTest");
    query_client->addParam("dataBase", 1);
	query_client->addParam("usn", userName);
	query_client->addParam("pwd", passWord);
	query_client->addParam("sort", "usn,pwd");
	int operId = query_client->callSPFROMCPP();
	_DBStoreContext context;
	context.storeType = eStoreCreateAccount;
	context.hLink = hLink;
	context.accountName = userName;
	m_mapDBStore.insert(std::make_pair(operId, context));

}

void CDBProxy::doCreateAccountResult(int operId, handle hLink, std::string accountName)
{
    TRACE0_L0("CDBProxy::doCreateAccountResult:wsf.....\n");
    CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);

    CSCResultMsg* resultSet = (CSCResultMsg*)query_client->getAttributeSet(operId, 0);
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    resultSet->getAttribute(attrName, valueType, attr, 0, 0);
    safeDelete(attrName);

    DBMsg_CreateAccountResult ret;
    ret.actionType = DB_MSG_CREATEUSER;
    strcpy(ret.accountName, accountName.c_str());
    ret.accountId = *((int *)attr);
    ret.result = ret.accountId > 0 ? true : false;
    g_session.OnDBReturn(&ret, hLink);
}

void CDBProxy::doCreateRole( handle hLink, int accountId, _MsgCS_CreateRoleInfo* pRoleInfo)
{
	CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);
	query_client->buildQuery();
	query_client->addParam("spName", "sp_CreatePlayerTest");
	query_client->addParam("dataBase", 1);
	query_client->addParam("playerName", pRoleInfo->roleName);
	query_client->addParam("sex", (int)pRoleInfo->sex);
	query_client->addParam("school", (int)pRoleInfo->school);
	query_client->addParam("modleID", (int)pRoleInfo->modelId);
	query_client->addParam("showParts", pRoleInfo->showParts);
	query_client->addParam("userId",accountId);//
	query_client->addParam("sort", "playerName,sex,userId,school,modleID,showParts");
	int operId = query_client->callSPFROMCPP();
	_DBStoreContext context;
	context.storeType = eStoreCreateRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));

}

void CDBProxy::doCreateRoleResult(int operId, handle hLink)
{
    TRACE0_L0("CDBProxy::doCreateRoleResult:wsf.....\n");
    CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);

    CSCResultMsg* resultSet = (CSCResultMsg*)query_client->getAttributeSet(operId, 0);
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    resultSet->getAttribute(attrName, valueType, attr, 1, 0);   // 取第2个字段
    safeDelete(attrName);

    DBMsg_CreateRoleResult ret;
    ret.actionType = DB_MSG_CREATEROLE;
    ret.roleId = *((int *)attr);
    ret.result = ret.roleId > 0 ? true : false;
    g_session.OnDBReturn(&ret, hLink);
}

void CDBProxy::doDeleteRole(int accountId, int roleId, handle hLink)
{
	CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);
	query_client->buildQuery();
	query_client->addParam("spName", "sp_DeletePlayerTest");
	query_client->addParam("dataBase", 1);
	query_client->addParam("userID", accountId);
	query_client->addParam("roleID", roleId);
	query_client->addParam("sort", "userID,roleID");
	int operId = query_client->callSPFROMCPP();
	_DBStoreContext context;
	context.storeType = eStoreDeleteRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));
}

void CDBProxy::doDeleteRoleResult(int operId, handle hLink)
{
    TRACE0_L0("CDBProxy::doDeleteRoleResult:wsf.....\n");
    CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);

    CSCResultMsg* resultSet = (CSCResultMsg*)query_client->getAttributeSet(operId, 0);
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    resultSet->getAttribute(attrName, valueType, attr, 0, 0);   // 取第1个字段
    safeDelete(attrName);

    // 返回客户端
    DBMsg_DeleteRoleResult ret;
    ret.actionType = DB_MSG_DELETEROLE;
    ret.roleId = *(int*)attr;
    ret.result = ret.roleId > 0 ? true : false;
    g_session.OnDBReturn(&ret, hLink);
}

void CDBProxy::doCheckRoleName(char* pRoleName, handle hLink)
{
	CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);
	query_client->buildQuery();
	query_client->addParam("spName", "sp_CheckPlayerTest");
	query_client->addParam("dataBase", 1);
	query_client->addParam("playerName", pRoleName);
	query_client->addParam("sort", "playerName");
	int operId = query_client->callSPFROMCPP();
	_DBStoreContext context;
	context.storeType = eStoreCheckRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));
}

void CDBProxy::doCheckRoleNameResult(int operId, handle hLink)
{
    TRACE0_L0("CDBProxy::doCheckRoleNameResult:wsf.....\n");
    CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);

    CSCResultMsg* resultSet = (CSCResultMsg*)query_client->getAttributeSet(operId, 0);
    void *attr = NULL;
    PType valueType;
    char *attrName = NULL;
    resultSet->getAttribute(attrName, valueType, attr, 0, 0);   // 取第1个字段
    safeDelete(attrName);

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

void CDBProxy::onDBReturn(int operId,int errorCode)
{
	DBSTOREMAP::iterator it = m_mapDBStore.find(operId);
	if( it == m_mapDBStore.end() )
	{
		TRACE1_L0("store call error operId =%d\n", operId);
		ASSERT_(0);
	}
	int storeType = it->second.storeType;
	switch(storeType)
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
			TRACE1_L0("no this type,type = %d\n",storeType);
			break;
	}
    CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);
    query_client->deleteAttributeSet(operId);
}

HRESULT CDBProxy::Do(HANDLE hContext)
{
    return S_OK;
}

CDBProxy g_DBProxy;
