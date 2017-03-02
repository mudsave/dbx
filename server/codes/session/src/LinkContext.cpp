/**
 * filename : LinkContext.cpp
 * desc : session中的各种连接上下文
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "AccountMgr.h"
#include "LinkContext.h"
#include "session.h"
#include "dbProxy.h"
#include "Version.h"

LinkContext_Client::~LinkContext_Client()
{
	if ( roleList )
	{
		memset(roleList->role,0, sizeof(DBRoleInfo) * MaxRoleSize);
		roleList->Release();
	}

	if ( hStateTimer != NULL )
	{
		pThreadsPool->UnregTimer(hStateTimer);
		hStateTimer = NULL;
	}
}

void LinkContext_Client::doLoginAccount(DBMsg_LoginResult* pRet)
{
	if ( pRet ) roleList = pRet;
	ASSERT_(roleList);
	accountId = roleList->accountId;
	g_accountMgr.regAccount(accountId, hLink);
	AccountInfo& account = g_accountMgr.getAccount(accountId);
	account.m_accountName = accountName;
	if(g_accountMgr.getIdByName(accountName) == -1)
	{
		g_accountMgr.saveAccountInfo(accountName, accountId, passwd);	
	}
	g_session.send_MsgSC_Login_ResultInfo(hLink, 0, roleList);
	_SwitchState(LINK_CONTEXT_LOGINED);
}

void LinkContext_Client::doKickAccount(AccountInfo& account)
{
	LinkContext_Client* pOtherClient = g_session.getClientLink(account.hLink); ASSERT_(pOtherClient);
	ASSERT_( g_accountMgr.unregAccount(account.accountId) );
	g_session.send_MsgSC_AccountKickedInfo(account.hLink);
	pOtherClient->_SwitchState(LINK_CONTEXT_DISCONNECTED);
}

void LinkContext_Client::doKickAccount(AccountInfo& account, DBMsg_LoginResult* pRet)
{
	g_session.send_MsgSG_KickAccountInfo(account);
	account.hPendingLink = hLink;
	account._SwitchStatus(ACCOUNT_STATE_KICKING);
	roleList = pRet;
	_SwitchState(LINK_CONTEXT_LOGINING_PENDING);
}

void LinkContext_Client::onLoginError(int reason, DBMsg_LoginResult* pRet)
{
	g_session.send_MsgSC_Login_ResultInfo(hLink, reason, pRet);
	_SwitchState(LINK_CONTEXT_CONNECTED);
	pRet->Release();
}

void LinkContext_Client::_Close(int opt)
{
	bool ret = g_session.IMsgLinksImpl<IID_IMsgLinksCS_L>::IsValidLink(hLink); ASSERT_(ret);

	if ( ret )
	{
		g_session.IMsgLinksImpl<IID_IMsgLinksCS_L>::CloseLink(hLink, opt);
	}
}

void LinkContext_Client::_SwitchState(int s)
{
	if ( state == s )
	{
		return;
	}

	if ( hStateTimer != NULL )
	{
		pThreadsPool->UnregTimer(hStateTimer);
		hStateTimer = NULL;
	}

	int interval = -1;
	if ( s == LINK_CONTEXT_INIT ) interval = eClientInitInterval;
	else if ( s == LINK_CONTEXT_CONNECTED ) interval = eClientConnectedInterval;
	else if ( s == LINK_CONTEXT_LOGINING ) interval = eClientLoginingInterval;
	else if ( s == LINK_CONTEXT_LOGINING_PENDING ) interval = eClientLoginingPendingInterval;
	else if ( s == LINK_CONTEXT_LOGINED ) interval = eClientLoginedInterval;
	else if ( s == LINK_CONTEXT_ROLE_CREATEING) interval = eClientRoleCreateingInterval;
	else if ( s == LINK_CONTEXT_ROLE_DELETEING) interval = eClientRoleDeleteingInterval;
	else if ( s == LINK_CONTEXT_DISCONNECTED ) interval = eClientDisconnectedInterval;

	if ( interval != -1 )
		hStateTimer = pThreadsPool->RegTimer( this, (HANDLE)s, 0, interval, 0, "session client state timer" );

	state = s;
}

void LinkContext_Client::OnPendingOver()
{
	ASSERT_( state == LINK_CONTEXT_LOGINING_PENDING );
	doLoginAccount();
}

void LinkContext_Client::OnNetMsg(AppMsg* pMsg)
{
	int msgCls	= pMsg->msgCls;
	int msgId	= pMsg->msgId;
	if ( state == LINK_CONTEXT_CONNECTED )
	{
		if ( msgId == MSG_S_C_CHECK_VERSION )
		{
			_MsgCS_VersionCheck* pInfo = ( _MsgCS_VersionCheck* )pMsg;
			bool checkSuccess = true;
			if ( pInfo->version != g_session.m_version )
				checkSuccess = false;
			g_session.send_MsgSC_VersionCheck_ResultInfo(hLink, checkSuccess);
			if ( checkSuccess )
				g_session.send_MsgSC_WorldListInfo(hLink);
			return;
		}
		if ( msgId == MSG_S_C_USER_LOGIN )
		{
			_MsgCS_UserLoginInfo* pInfo = (_MsgCS_UserLoginInfo*)pMsg;
			accountName = std::string(pInfo->accountName);
			passwd = std::string(pInfo->passwd);
			int accountId = g_accountMgr.getIdByName(accountName);
			bool flag = false;
			if (accountId != -1)
			{
				if(g_accountMgr.verifyPasswd(accountName, passwd))
				{
					AccountInfo *p_account = g_accountMgr.getAccountPtr(accountId);
					if (p_account != 0)
					{
						if (p_account->getIsOffline())
						{
							ASSERT_(p_account->status == ACCOUNT_STATE_OFFLINE_IN_FIGHT);
							p_account->hLink = hLink;
							p_account->gatewayId = g_session.getRanGatewayId(p_account->worldId);
							ASSERT_(p_account->gatewayId != -1);
							p_account->_SwitchStatus(ACCOUNT_STATE_RECONNECTING_FIGHT);
							g_session.send_MsgSC_OffFightReConnect(hLink, *p_account);
							_SwitchState(LINK_CONTEXT_DISCONNECTED);
						}
						else
						{flag = true;}
					}
					else
					{flag = true;}				
				}
				else
				{
					g_session.send_MsgSC_Login_ResultInfo(hLink, LOGIN_FAILED_PASSWD_ERROR, NULL);
					_SwitchState(LINK_CONTEXT_CONNECTED);
					return;
				}
			}
			else
			{flag = true;}
			if (true == flag)
			{
				g_DBProxy.doLogin(pInfo->accountName, pInfo->passwd, hLink);
				_SwitchState(LINK_CONTEXT_LOGINING);
			}
			return;
		}
		if ( msgId == MSG_S_C_USER_CREATE )
		{
			_MsgCS_CreateUserInfo* pInfo = (_MsgCS_CreateUserInfo*)pMsg;
			std::map<std::string, int>::iterator iter = m_creatingList.find(pInfo->accountName);
			if ( iter != m_creatingList.end() )
			{
				g_session.send_MsgSC_CreateUser_ResultInfo(hLink, NULL);
				return;
			}
			m_creatingList.insert( std::make_pair(pInfo->accountName, 1) );
			g_DBProxy.doCreateAccount(pInfo->accountName, pInfo->passwd, hLink);
			return;
		}
		if ( msgId == MSG_S_C_CHANGE_SESSION_STATE )
		{
			_MsgCS_StateChanged_Info* pInfo = (_MsgCS_StateChanged_Info*)pMsg;
			accountName = std::string(pInfo->accountName);
			passwd = std::string(pInfo->passwd);
			int flag = false;
			accountId = g_accountMgr.getIdByName(accountName);
			if(accountId != -1)
			{
				AccountInfo* p_account = g_accountMgr.getAccountPtr(accountId);
				if (p_account != 0)
				{
					if(g_accountMgr.verifyPasswd(accountName, passwd))
					{
						p_account->hLink = hLink;
						g_session.send_MsgSC_ChangeSessionState_ResultInfo(hLink, true);
						_SwitchState(LINK_CONTEXT_LOGINED);
						bool _roleList = pInfo->roleList;
						if(_roleList)
							g_DBProxy.doLogin(pInfo->accountName, pInfo->passwd, hLink);
						return;
					}
					else
					{flag = true;}
				}
				else
				{flag = true;}
			}
			else
			{flag = true;}
			if (flag == true)
			{
				g_session.send_MsgSC_ChangeSessionState_ResultInfo(hLink, false);
			}
			return;
		}
	}

	if ( state == LINK_CONTEXT_LOGINED )
	{
		if ( msgId == MSG_S_C_CHOOSE_ROLE )
		{
			_MsgCS_ChooseRoleInfo* pInfo = (_MsgCS_ChooseRoleInfo*)pMsg;
			int roleId = pInfo->roleId;
			short worldId = pInfo->worldId;
			short gatewayId	= g_session.getRanGatewayId(worldId);
			ASSERT_( gatewayId >= 0 );
			AccountInfo& account = g_accountMgr.getAccount(accountId);
			account.roleId = roleId;
			account.worldId = worldId;
			account.gatewayId = gatewayId;
			int version = GenerateVersionNum();
			account.version = version;
			account._SwitchStatus(ACCOUNT_STATE_LOADING);
			g_session.send_MsgSC_ChooseRole_ResultInfo(hLink, accountId, gatewayId, version);
			_SwitchState(LINK_CONTEXT_DISCONNECTED);
			return;
		}

		if ( msgId == MSG_S_C_ROLE_CREATE )
		{
			_MsgCS_CreateRoleInfo* pInfo = (_MsgCS_CreateRoleInfo*)pMsg;
			LinkContext_Client* pClient = g_session.getClientLink(hLink); ASSERT_(pClient);
			g_DBProxy.doCreateRole(hLink, pClient->accountId, pInfo);
			_SwitchState(LINK_CONTEXT_ROLE_CREATEING);
			return;
		}

		if ( msgId == MSG_S_C_ROLE_DELETE )
		{
			_MsgCS_DeleteRoleInfo* pInfo = (_MsgCS_DeleteRoleInfo*)pMsg;
			LinkContext_Client* pClient = g_session.getClientLink(hLink); ASSERT_(pClient);
			g_DBProxy.doDeleteRole(pClient->accountId, pInfo->roleId, hLink);
			_SwitchState(LINK_CONTEXT_ROLE_DELETEING);
			return;
		}

		if ( msgId == MSG_S_C_CHECK_NAME )
		{
			_MsgCS_CheckNameInfo* pInfo = (_MsgCS_CheckNameInfo* ) pMsg;
			g_DBProxy.doCheckRoleName(pInfo->roleName, hLink);
			return;
		}
	}

	TRACE0_L2("LinkContext_Client::OnNetMsg(), the msg on the wrong state..\n");
	TRACE1_L2("\thLink	= %i\n", hLink);
	TRACE1_L2("\tstate	= %i\n", state);
	TRACE1_L2("\tmsgCls	= %i\n", msgCls);
	TRACE1_L2("\tmsgId	= %i\n", msgId);
	// ASSERT_(0);
	return;
}

void LinkContext_Client::OnDBMsg(_DBMsg* pMsg)
{
	int type = pMsg->actionType;
	if ( state == LINK_CONTEXT_LOGINING )
	{
		if ( type == DB_MSG_LOGIN )
		{
			DBMsg_LoginResult* pRet = (DBMsg_LoginResult*)pMsg;
			if ( pRet->ret != 0 )
			{
				onLoginError(LOGIN_FAILED_PASSWD_ERROR, pRet);
				return;
			}
			bool flag = g_accountMgr.isRegistered(pRet->accountId);
			TRACE1_L0("LinkContext_Client::OnDBMsg(), accountId=%d\n",pRet->accountId);
			if (!flag)
			{
				TRACE1_L0("doLoginAccount->%d\n",pRet->accountId);
				doLoginAccount(pRet);
				return;
			}
			AccountInfo& account = g_accountMgr.getAccount(pRet->accountId);
			int s = account.status;
			if ( s == ACCOUNT_STATE_LOGINED )
			{
				LinkContext_Client* pOther = g_session.getClientLink(account.hLink);
				if (0 == pOther)
				{
					TRACE1_L0("Account %d can not find LinkContext!\n", pRet->accountId);
					ASSERT_( g_accountMgr.unregAccount(pRet->accountId) );	
					doLoginAccount(pRet);
					return;
				}
				if ( pOther->state == LINK_CONTEXT_ROLE_CREATEING || pOther->state == LINK_CONTEXT_ROLE_DELETEING )
				{
					onLoginError(LOGIN_FAILED_PROCESSING, pRet);
					return;
				}
				doKickAccount(account);
				doLoginAccount(pRet);
				return;
			}

			if ( s == ACCOUNT_STATE_LOADING || s == ACCOUNT_STATE_KICKING )
			{
				onLoginError(LOGIN_FAILED_PROCESSING, pRet);
				return;
			}

			if ( s == ACCOUNT_STATE_LOADED && account.getIsFight() == false )
			{
				doKickAccount(account, pRet);
				return;
			}
			TRACE3_L0("Account:%d login failed! status:%d, isFight:%d\n", account.accountId, s, account.getIsFight());
			//ASSERT_(0);
			return;
		}
	}

	if ( state == LINK_CONTEXT_CONNECTED )
	{
		if ( type == DB_MSG_CREATEUSER )
		{
			DBMsg_CreateAccountResult* pRet = (DBMsg_CreateAccountResult*)pMsg ;
			std::map<std::string, int>::iterator iter = m_creatingList.find(pRet->accountName);
			if ( iter == m_creatingList.end() ) ASSERT_(0);
			m_creatingList.erase(iter);
			g_session.send_MsgSC_CreateUser_ResultInfo(hLink, pRet);
			return;
		}
	}

	if ( state == LINK_CONTEXT_ROLE_CREATEING )
	{
		if ( type == DB_MSG_CREATEROLE )
		{
			DBMsg_CreateRoleResult* pRet = (DBMsg_CreateRoleResult*)pMsg;
			g_session.send_MsgSC_CreateRole_ResultInfo(hLink, pRet);
			_SwitchState(LINK_CONTEXT_LOGINED);
			return;
		}
	}

	if ( state == LINK_CONTEXT_ROLE_DELETEING )
	{
		if ( type == DB_MSG_DELETEROLE )
		{
			DBMsg_DeleteRoleResult* pRet = (DBMsg_DeleteRoleResult*)pMsg;
			g_session.send_MsgSC_DeleteRole_ResultInfo(hLink, pRet);
			_SwitchState(LINK_CONTEXT_LOGINED);
			return;
		}
	}

	if ( state == LINK_CONTEXT_LOGINED )
	{
		if ( type == DB_MSG_CHECKNAME )
		{
			DBMsg_CheckNameResult* pRet = (DBMsg_CheckNameResult* )pMsg;
			g_session.send_MsgSC_CheckName_ResultInfo(hLink, pRet->result);
			return;
		}
		if ( type == DB_MSG_LOGIN )
		{
			DBMsg_LoginResult* pRet = (DBMsg_LoginResult*)pMsg;
			if ( pRet->ret != 0 )
			{
				TRACE0_L0("LinkContext_Client::OnDBMsg(), get role list error!\n");
				return;
			}
			g_session.send_MsgSC_Login_ResultInfo(hLink, 0, pRet);
			return;
		}
	}

	TRACE0_L2("LinkContext_Client::OnDBMsg(), the msg on the wrong state..\n");
	TRACE1_L2("\thLink		= %i\n", hLink);
	TRACE1_L2("\tstate		= %i\n", state);
	TRACE1_L2("\tactionType	= %i\n", type);
	//ASSERT_(0);
	return;
}

HRESULT LinkContext_Client::Do(HANDLE hContext)
{
	hStateTimer = NULL;
	int state = (int)(long)(hContext);
	switch ( state )
	{
		case LINK_CONTEXT_CONNECTED:
		case LINK_CONTEXT_LOGINING:
		case LINK_CONTEXT_LOGINING_PENDING:
		case LINK_CONTEXT_LOGINED:
		case LINK_CONTEXT_DISCONNECTED:
			_Close(CLOSE_RELEASE);
			break;
		default:
			ASSERT_(0);
			break;
	}

	return S_OK;
}
