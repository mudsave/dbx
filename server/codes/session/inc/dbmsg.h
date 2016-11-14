/**
 * filename : dbmsg.h
 * desc : 数据库返回结果集的消息定义
 */

#ifndef _DB_DEF_H
#define _DB_DEF_H

#define MaxRoleInfosMsgSize 300
#define MaxShowPartSize 8
#define MaxNameSize 64

enum _DBMsgType
{
	DB_MSG_LOGIN,
	DB_MSG_CREATEUSER,
	DB_MSG_CREATEROLE,
	DB_MSG_DELETEROLE,
	DB_MSG_CHECKNAME,
};

struct _DBMsg
{
	int actionType;
};

struct DBRoleInfo
{
	int roleId;
	int modelId;
	short school;
	short sex;
	char showPart[MaxShowPartSize];
	short level;
	char name[MaxNameSize];
};

struct DBMsg_LoginResult : public _DBMsg
{
	void Release()
	{
		delete this;
	}

	static DBMsg_LoginResult* CreateLoginResult()
	{
		char* buff = new char[MaxRoleInfosMsgSize];
		memset(buff,0,MaxRoleInfosMsgSize);
		DBMsg_LoginResult* pRet = (DBMsg_LoginResult*)buff;
		return pRet;
	}
public:
	int accountId;
	short ret;
	short roleNum;
	DBRoleInfo role[];
};

struct DBMsg_CreateAccountResult : public _DBMsg
{
	int accountId;
	bool result;
	char accountName[64];
};

struct DBMsg_CreateRoleResult : public _DBMsg
{
	int roleId;
	bool result;
};

struct DBMsg_DeleteRoleResult : public _DBMsg
{
	int	roleId;
	bool result;
};

struct DBMsg_CheckNameResult : public _DBMsg
{
	bool result;
};

#endif
