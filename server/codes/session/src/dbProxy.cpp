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

void CDBProxy::onExeDBProc_tocpp(int operId, IInitClient* pClient, bool result)
{
	if (!pClient)
		return;
	int ErrorCode = 0;
	if (!result) ErrorCode = -1;
	int record_index = 0;
	int record_set_index = 0;
	int tmp_index = 0;
	char* tmp_name = NULL;
	int tmp_param_type = 0;
	void* tmp_value = NULL;

	std::list<int> rd_indexs;
	IRecordSetManager* record_mgr = g_recordSet->getIRecordSetManager();
	for (int j=0; j < MAXRESNUM-1; j++)
	{
		CSCResultMsg* pTemp = (CSCResultMsg*)pClient->getAttributeSet(operId, j);
		if (!pTemp)
			break;
		int row_count = pTemp->getResCount();
		int field_count = pTemp->m_nAttriNameCount;
		// printf("rs%d:rows: %d, colums: %d\n", j, row_count, field_count);
		IRecordSet* set = record_mgr->newRecordSet(&record_set_index);
		rd_indexs.push_back(record_set_index);
		for(int row_idx = 0; row_idx < row_count; row_idx++)
		{
			IRecord* record = set->newRecord(&record_index);
			for(int field_idx = 0; field_idx < field_count; field_idx++){
				tmp_value = pTemp->getAttribute(&tmp_name, &tmp_param_type, field_idx, row_idx);
				record->newAttribute(tmp_param_type, tmp_value, &tmp_index, tmp_name);
			}
		}
	}

	CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);
	onDBReturn(operId, ErrorCode,rd_indexs);
	query_client->deleteAttributeSet(operId);
}

void CDBProxy::doLogin(char* userName, char* passWord, handle hLink)
{
	CClient* query_client = dynamic_cast<CClient*>(g_pDBAClient);
	query_client->buildQuery();
	query_client->addParam("spName", "sp_Login");
	query_client->addParam("dataBase", 1);
	query_client->addParam("usn", userName);
	query_client->addParam("pwd", passWord);
	query_client->addParam("offTime", 5);
	query_client->addParam("sort", "usn,pwd,offTime");
	int operId = query_client->callSPFROMCPP((IDBCallback*)this);
	_DBStoreContext storeContext;
	storeContext.storeType = eStoreLogin;
	storeContext.hLink = hLink;
	printf("userName = %s, passWord = %s\n",userName, passWord);
	m_mapDBStore.insert(std::make_pair(operId, storeContext));
}

void CDBProxy::doLoginResult(int operId, std::list<int>&record_indexs, handle hLink)
{
	//角色返回数据
	TRACE0_L2("角色返回数据\n");
	int accountId = 0;
	IRecordSetManager* record_mgr = g_recordSet->getIRecordSetManager();
	std::list<int>::iterator iter = record_indexs.begin();
	//第一个结果集
	IRecordSet* pRecordSet = record_mgr->findRecordSet(*iter);
	//第一条记录
	IRecord* pRecord=pRecordSet->readRecord(0);
	if ( pRecord==NULL )
		return;
	void* pAttri=NULL;
	int attritype;
	char* attrname;
	pAttri = pRecord->readAttribute(0, &attritype, &attrname);
	if ( pAttri == NULL )
		return;
	accountId = *(int*)pAttri;
	DBMsg_LoginResult* pRoleMsg = DBMsg_LoginResult::CreateLoginResult();
	pRoleMsg->actionType = DB_MSG_LOGIN;
	pRoleMsg->accountId = accountId;
	if ( accountId == 0 )
		pRoleMsg->ret = 1;
	else
		pRoleMsg->ret = 0;
	record_mgr->deleteRecordSet(*iter);
	//从第二个结果集开始
	iter++;
	for(; iter != record_indexs.end(); iter++)
	{
		IRecordSet* pRecordSet = record_mgr->findRecordSet(*iter);
		pRoleMsg->roleNum = pRecordSet->getRecordCount();

		for (int i=0;;i++)
		{
			IRecord* pRecord=pRecordSet->readRecord(i);
			if ( pRecord==NULL )
				break;
			void* pAttri=NULL;
			//printf("Field Name: ");
			for (int j=0;;j++)
			{
				int attritype;
				char* attrname;
				pAttri = pRecord->readAttribute(j, &attritype, &attrname);
				if (pAttri == NULL)
					break;
				switch(j)
				{
					case 0:
						{
							int roleID = *(int*)pAttri;
							pRoleMsg->role[i].roleId = roleID;
						}
						break;
					case 1:
						{
							int len = attritype;
							strncpy(pRoleMsg->role[i].name,(char*)pAttri,len);
							pRoleMsg->role[i].name[len] = '\0';
						}
						break;
					case 2:
						{
							short level = (short)*(int*)pAttri;
							pRoleMsg->role[i].level = level;

						}
						break;
					case 3:
						{
							short school = (short) *(int*)pAttri;
							pRoleMsg->role[i].school = school;
						}
						break;
					case 4:
						{
							if (attritype == PARAMINT )
							{
								int modelID = (int)*(int*)pAttri;
								pRoleMsg->role[i].modelId = modelID;
							}
							else if(attritype == PARAMFLOAT)
							{
								int modelID = (int)*(float*)pAttri;
								pRoleMsg->role[i].modelId = modelID;
							}

						}
						break;
					case 5:
						{
							int len = attritype;
							strncpy(pRoleMsg->role[i].showPart,(char*)pAttri,len);
							pRoleMsg->role[i].showPart[len] = '\0';
						}
						break;
					case 6:
						{
							int weaponID = *(int*)pAttri;
							pRoleMsg->role[i].weaponID = weaponID;
						}
						break;
					case 7:
						{
							int len = attritype;
							strncpy(pRoleMsg->role[i].remouldAttr,(char*)pAttri,len);
							pRoleMsg->role[i].remouldAttr[len] = '\0';
						}
						break;
				}
			}
		}
		record_mgr->deleteRecordSet(*iter);
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
	int operId = query_client->callSPFROMCPP((IDBCallback*)this);
	_DBStoreContext context;
	context.storeType = eStoreCreateAccount;
	context.hLink = hLink;
	context.accountName = userName;
	m_mapDBStore.insert(std::make_pair(operId, context));

}

void CDBProxy::doCreateAccountResult(int operId, std::list<int>&record_indexs, handle hLink, std::string accountName)
{
	int accountId = 0;
	IRecordSetManager* record_mgr = g_recordSet->getIRecordSetManager();
	std::list<int>::iterator iter = record_indexs.begin();
	//第一个结果集
	IRecordSet* pRecordSet = record_mgr->findRecordSet(*iter);
	//第一条记录
	IRecord* pRecord=pRecordSet->readRecord(0);
	if (pRecord==NULL)
		return;
	void* pAttri=NULL;
	int attritype;
	char* attrname;
	pAttri = pRecord->readAttribute(0, &attritype, &attrname);
	if (pAttri == NULL)
		return;
	accountId = *(int*)pAttri;
	DBMsg_CreateAccountResult ret;
	ret.actionType = DB_MSG_CREATEUSER;
	strcpy(ret.accountName, accountName.c_str());
	ret.accountId = accountId;
	ret.result = accountId > 0 ? true :false;
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
	int operId = query_client->callSPFROMCPP((IDBCallback*)this);
	_DBStoreContext context;
	context.storeType = eStoreCreateRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));

}

void CDBProxy::doCreateRoleResult(int operId, std::list<int>&record_indexs, handle hLink)
{
	//创建角色返回数据
	int roleID = 0;
	IRecordSetManager* record_mgr = g_recordSet->getIRecordSetManager();
	std::list<int>::iterator iter = record_indexs.begin();
	//第一个结果集
	IRecordSet* pRecordSet = record_mgr->findRecordSet(*iter);
	//第一条记录
	IRecord* pRecord=pRecordSet->readRecord(0);
	if (pRecord==NULL) return;
	void* pAttri=NULL;
	int attritype;
	char* attrname;
	//第2个字段
	pAttri = pRecord->readAttribute(1, &attritype, &attrname);
	if (pAttri == NULL) return;
	roleID = *(int*)pAttri;
	//返回客户端
	DBMsg_CreateRoleResult ret;
	ret.actionType = DB_MSG_CREATEROLE;
	ret.roleId = roleID;
	ret.result = roleID > 0 ? true : false;
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
	int operId = query_client->callSPFROMCPP((IDBCallback*)this);
	_DBStoreContext context;
	context.storeType = eStoreDeleteRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));
}

void CDBProxy::doDeleteRoleResult(int operId, std::list<int>&record_indexs, handle hLink)
{
	//删除角色名返回数据
	int roleID = 0;
	int result = 0;
	IRecordSetManager* record_mgr = g_recordSet->getIRecordSetManager();
	std::list<int>::iterator iter = record_indexs.begin();
	//第一个结果集
	IRecordSet* pRecordSet = record_mgr->findRecordSet(*iter);
	//第一条记录
	IRecord* pRecord=pRecordSet->readRecord(0);
	if (pRecord==NULL) return;
	void* pAttri=NULL;
	int attritype;
	char* attrname;
	//第1个字段
	pAttri = pRecord->readAttribute(0, &attritype, &attrname);
	if (pAttri == NULL) return;
	roleID = *(int*)pAttri;
	//第2个字段
	pAttri = pRecord->readAttribute(1, &attritype, &attrname);
	if (pAttri == NULL) return;
	result = *(int*)pAttri;
	//返回客户端
	DBMsg_DeleteRoleResult ret;
	ret.actionType = DB_MSG_DELETEROLE;
	ret.roleId = roleID;
	ret.result = roleID > 0 ? true : false;
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
	int operId = query_client->callSPFROMCPP((IDBCallback*)this);
	_DBStoreContext context;
	context.storeType = eStoreCheckRole;
	context.hLink = hLink;
	m_mapDBStore.insert(std::make_pair(operId, context));
}

void CDBProxy::doCheckRoleNameResult(int operId, std::list<int>&record_indexs, handle hLink)
{
	//校验角色名返回数据
	int result = 0;
	IRecordSetManager* record_mgr = g_recordSet->getIRecordSetManager();
	std::list<int>::iterator iter = record_indexs.begin();
	//第一个结果集
	IRecordSet* pRecordSet = record_mgr->findRecordSet(*iter);
	//第一条记录
	IRecord* pRecord=pRecordSet->readRecord(0);
	if (pRecord==NULL) return;
	void* pAttri=NULL;
	int attritype;
	char* attrname;
	//第1个字段
	pAttri = pRecord->readAttribute(0, &attritype, &attrname);
	if (pAttri == NULL) return;
	result = *(int*)pAttri;
	DBMsg_CheckNameResult ret;
	ret.actionType = DB_MSG_CHECKNAME;
	ret.result = result == 0 ? true : false;
	 g_session.OnDBReturn(&ret, hLink);
}

void CDBProxy::onConnected(bool result)
{
	if ( result )
		TRACE0_L0("conncet DB success\n");
	else
		TRACE0_L0("conncet DB fail\n");
}

void CDBProxy::onDBReturn(int operId,int errorCode, std::list<int>&record_indexs)
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
			doLoginResult(operId, record_indexs, it->second.hLink);
			break;
		case eStoreCreateAccount:
			doCreateAccountResult(operId, record_indexs, it->second.hLink, it->second.accountName);
			break;
		case eStoreCreateRole:
			doCreateRoleResult(operId, record_indexs, it->second.hLink);
			break;
		case eStoreDeleteRole:
			doDeleteRoleResult(operId, record_indexs, it->second.hLink);
			break;
		case eStoreCheckRole:
			doCheckRoleNameResult(operId, record_indexs, it->second.hLink);
			break;
		default:
			TRACE1_L0("no this type,type = %d\n",storeType);
			break;
	}
}

HRESULT CDBProxy::Do(HANDLE hContext)
{
    return S_OK;
}

CDBProxy g_DBProxy;
