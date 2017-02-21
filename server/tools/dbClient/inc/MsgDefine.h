#pragma once
#include "stdlib.h"
#include "vsdeftemp.h"
#include <vector>
#include "dbx_msgdef.h"

typedef long long LONGLONG;

//---------------------------
enum action_res
{
	S_DOACTION_RESULT	=1001,
	S_DOSQL_RESULT,
	S_SP_CPP_RESULT
};

enum error_id
{
	S_ERROR			=2001,
	C_ERROR			=3001,
};


//msg_flag
#define CS_NOMAL		1000
#define CS_EXCEPTION	2000
//---------------------------
#define SS_NOMAL		2000
#define SS_EXCEPTION	3001
//---------------------------
#define SC_NOMAL		4000

enum log_cls
{
	DBAINFO	=1,
	DBADEBUG,
	DBAERROR,
	DBALOGTYPEEND
};


//moduleId
enum ModuleID
{
	S_DBASESSION	=	1,
	S_DBARECORDSET,
	S_DBAACCESS,
	S_DBAMSGSERVER,
	S_DBALOGSERVER,
	S_DBASERVER,
	S_DBAENGINE,
	C_DBACLIENT		=	10,
	MODULEEND
};
enum PrintType
{
	C_LOCAL		=		1, 
	C_REMOTE
};
enum MsgType
{
	APPMSG =0,
	CSSRESMSG,
	CSCRESMSG,
	CCSRESMSG
};

enum DataCompressMode
{
	NonCompress = 1,
	MidCompress = 2,
	MaxCompress = 4
};


extern const char* g_translate6[MODULEEND];
extern const char* g_translate7[DBALOGTYPEEND];
extern int g_translate8[-DATATYPEEND];




//msg_ObjectId
#define VALIDOBJID		0

//recordset index
#define VALIDINDEX		-1


#define MAXVALUE 20


enum doAction
{
	eSend,
	eRecv,
	eClose,
	ePeek,
	eThread
};

class _doContext
{
public:
	void*	pBuf;
	long	len;
	int		flag;
	_doContext(void* pb,long re,int _flg):pBuf(pb),len(re),flag(_flg)
	{

	}
};


template<class T1,class T2>
void copyAppMsg(T1 &obj1,T2 &obj)
{
	obj1.m_objDoMsg=obj.m_objDoMsg;
	obj1.msgId=obj.msgId;
	obj1.msgCls=obj.msgCls;
	obj1.msgFlags=obj.msgFlags;
	obj1.msgLen=obj.msgLen;
}

class CMsgString
{
public:

	CMsgString():m_pStr(NULL)
	{

	}
	CMsgString(void* name,int paramType):m_pStr(NULL)
	{
		if (paramType>0)
		{
			m_pStr=(char*)new BYTE[paramType+1];
			memset(m_pStr,0,paramType+1);
			memcpy(m_pStr,name,paramType);
		}
	}
	~CMsgString()
	{
		if (m_pStr) delete[] m_pStr;
	}
	CMsgString(CMsgString &obj)
	{
		*this=obj;
	}
	void operator=(CMsgString &obj)
	{
		if (m_pStr) delete[] m_pStr;
		m_pStr=(char*)new BYTE[obj.size()+1];
		memset(m_pStr,0,obj.size()+1);
		memcpy(m_pStr,obj.c_str(),obj.size());
	}
	char* c_str()
	{
		return m_pStr;
	}
	int size()
	{
		return (int)strlen(m_pStr);
	}
private:
	char* m_pStr;
};

