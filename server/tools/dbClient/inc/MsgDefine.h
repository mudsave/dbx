#pragma once
#include "stdlib.h"
#include "vsdeftemp.h"
#include <vector>
typedef long long LONGLONG;
//msg_id
enum msg_id
{
	C_DOACTION=1,
	C_DOSQL,
	C_SP_FROM_CPP
};

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

enum DataType
{
	PARAMINT	=-1 ,
	PARAMBOOL	=-2 ,
	PARAMFLOAT	=-3 ,
	DATATYPEEND =-4 
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

class ObjDoMsg 
{
public:
	int ObjectId;

	int param_count;
	std::vector<int> param_types;
	std::vector<void *> param_values;

	ObjDoMsg()
	{
		initMsg();
	}

	ObjDoMsg(ObjDoMsg &obj)
	{
		*this=obj;
	}

	int streamSize()
	{
		return sizeof(ObjectId) + sizeof(param_count) + getParamLen();
	}

	BYTE * readStream(BYTE * stream)
	{
		if (stream == NULL)
		{
			return NULL;
		}

		/*
		数据组织格式：
		|ObjectId(int)|param_count(int)|param_type_1(int)param_type_2(int)...|param_value_1(void *)param_value_2(void *)...|
		*/
		BYTE * rpos = stream;

		//read ObjectId
		ObjectId = *((int *)rpos);
		rpos += sizeof(ObjectId);

		//read param_count
		param_count = *((int *)rpos);
		rpos += sizeof(param_count);

		//read param_types
		for (int i = 0; i < param_count; i++)
		{
			param_types.push_back(*((int *)rpos));
			rpos += sizeof(int);
		}

		//read param_values
		for (int i = 0; i < param_count; i++)
		{
			int size = getTypeSize(param_types[i]);
			void * param = malloc(size);
			memcpy(param, rpos, size);
			param_values.push_back(param);
			rpos += size;
		}

		//ok
		return rpos;
	}

	BYTE * writeStream(BYTE * stream)
	{
		/*
		数据组织格式：
			|ObjectId(int)|param_count(int)|param_type_1(int)param_type_2(int)...|param_value_1(void *)param_value_2(void *)...|
		*/
		if (stream == NULL)
		{
			return NULL;
		}
		BYTE * wpos = stream;

		//write ObjectId
		memcpy(wpos, &ObjectId, sizeof(ObjectId));
		wpos += sizeof(ObjectId);

		//write param_count
		memcpy(wpos, &param_count, sizeof(param_count));
		wpos += sizeof(param_count);

		//write param_types
		for (int i = 0; i < param_count; i++)
		{
			memcpy(wpos, &param_types[i], sizeof(param_types[i]));
			wpos += sizeof(param_types[i]);
		}

		//write param_values
		for (int i = 0; i < param_count; i++)
		{
			int size = getTypeSize(param_types[i]);
			memcpy(wpos, param_values[i], size);
			wpos += size;
		}

		//ok
		return wpos;
	}

	void initMsg()
	{
		param_count = 0;
		param_types.clear();
		for (int i = 0; i < param_values.size(); i++)
		{
			free(param_values[i]);
		}
		param_values.clear();
	}

	void operator=(ObjDoMsg &obj)
	{
		ObjectId = obj.ObjectId;
		initMsg();

		for (int i = 0; i < obj.param_count; i++)
		{
			setParam(obj.param_types[i], obj.param_values[i]);
		}
	}

	~ObjDoMsg()
	{
		for (int i = 0; i < param_values.size(); i++)
		{
			free(param_values[i]);
		}
		param_values.clear();
	}

	inline void setParam(int ParamType,void* pParam )
	{
		param_count++;
		param_types.push_back( ParamType );

		int type_size = getTypeSize(ParamType);
		void * new_param = malloc(type_size);
		memcpy(new_param, pParam, type_size);
		param_values.push_back( new_param );
	}

	inline int getParamCount()
	{
		return param_count;
	}

	inline int getParamLen()
	{
		int len = param_count * sizeof(int);
		for (int i = 0; i < param_count; i++)
		{
			len += getTypeSize(param_types[i]);
		}
		return len;
	}

	inline void* getParam(int* pParamType/*out*/,int index/*from 0*/)
	{
		if (index >= param_count)
			return NULL;
		
		*pParamType = param_types[index];
		return param_values[index];
	}

	static int getTypeSize(int paramType)
	{
		if (paramType>=0) return paramType;
		switch(paramType)
		{
		case PARAMINT:
			return sizeof(int);
		case PARAMBOOL:
			return sizeof(bool);
		case PARAMFLOAT:
			return sizeof(float);
		}	
		return 0;
	}
	
	static int getCharacterSize(char* pValue)
	{
		return (int)strlen(pValue);
	}

	static int getCharacterType(char* pValue)
	{
		return getCharacterSize(pValue);
	}

	//已经包含了对数据的压缩，但目前只对类型压缩了
	inline int* compressData(int* data,int compressMode,int* TotalLen /*out*/)
	{
		return NULL;
	}

	inline int* uncompressData(int* data,int compressMode,int * TotalLen)
	{
		return NULL;
	}

private:
	inline char* MoveParam(void *pCurParam,int* pParamType,int paramCount,int step)
	{
		return NULL;
	}
};


class CResultMsg : public AppMsg
{
public:

	virtual int streamSize()
	{
		return sizeof(AppMsg) + sizeof(m_nAttriIndex) + sizeof(m_nAttriNameCount)
			+ sizeof(m_nAttriCount) + sizeof(m_nTempObjId) + sizeof(m_nSessionId)
			+ sizeof(m_spId) + sizeof(m_bEnd) + sizeof(m_bNeedCallback) + sizeof(m_nLevel)
			+ m_objDoMsg.streamSize();
	}

	virtual BYTE * readStream(BYTE * stream)
	{
		if (stream == NULL)
		{
			return NULL;
		}

		BYTE * rpos = stream;

		//read AppMsg
		msgLen = *(unsigned short *)rpos;
		rpos += sizeof(msgLen);

		msgFlags = *(unsigned char *)rpos;
		rpos += sizeof(msgFlags);

		msgCls = *(unsigned char *)rpos;
		rpos += sizeof(msgCls);

		msgId = *(unsigned short *)rpos;
		rpos += sizeof(msgId);

		context = *(long *)rpos;
		rpos += sizeof(context);

		//write this attributes
		m_nAttriIndex = *(int *)rpos;
		rpos += sizeof(m_nAttriIndex);

		m_nAttriNameCount = *(int *)rpos;
		rpos += sizeof(m_nAttriNameCount);

		m_nAttriCount = *(int *)rpos;
		rpos += sizeof(m_nAttriCount);

		m_nTempObjId = *(int *)rpos;
		rpos += sizeof(m_nTempObjId);

		m_spId = *(int *)rpos;
		rpos += sizeof(m_spId);

		m_bEnd = *(bool *)rpos;
		rpos += sizeof(m_bEnd);

		m_bNeedCallback = *(bool *)rpos;
		rpos += sizeof(m_bNeedCallback);

		m_nLevel = *(short *)rpos;
		rpos += sizeof(m_nLevel);

		return m_objDoMsg.readStream(rpos);
	}

	virtual BYTE * writeStream(BYTE * stream)
	{
		if (stream == NULL)
		{
			return NULL;
		}
		BYTE * wpos = stream;

		//write AppMsg
		memcpy(wpos, &msgLen, sizeof(msgLen));
		wpos += sizeof(msgLen);

		memcpy(wpos, &msgFlags, sizeof(msgFlags));
		wpos += sizeof(msgFlags);

		memcpy(wpos, &msgCls, sizeof(msgCls));
		wpos += sizeof(msgCls);

		memcpy(wpos, &msgId, sizeof(msgId));
		wpos += sizeof(msgId);

		memcpy(wpos, &context, sizeof(context));
		wpos += sizeof(context);

		//write this attributes
		memcpy(wpos, &m_nAttriIndex, sizeof(m_nAttriIndex));
		wpos += sizeof(m_nAttriIndex);

		memcpy(wpos, &m_nAttriNameCount, sizeof(m_nAttriNameCount));
		wpos += sizeof(m_nAttriNameCount);

		memcpy(wpos, &m_nAttriCount, sizeof(m_nAttriCount));
		wpos += sizeof(m_nAttriCount);

		memcpy(wpos, &m_nTempObjId, sizeof(m_nTempObjId));
		wpos += sizeof(m_nTempObjId);

		memcpy(wpos, &m_spId, sizeof(m_spId));
		wpos += sizeof(m_spId);

		memcpy(wpos, &m_bEnd, sizeof(m_bEnd));
		wpos += sizeof(m_bEnd);

		memcpy(wpos, &m_bNeedCallback, sizeof(m_bNeedCallback));
		wpos += sizeof(m_bNeedCallback);

		memcpy(wpos, &m_nLevel, sizeof(m_nLevel));
		wpos += sizeof(m_nLevel);

		return m_objDoMsg.writeStream(wpos);
	}

	bool isValidResMsg()
	{
		if (m_objDoMsg.param_count <= 0)
			return false;
			
		int len = m_objDoMsg.getParamLen();
		if ((len>=0)&&(len<msgLen)) 
			return true;
	}

	void initAttribute()
	{
		m_nAttriIndex = m_objDoMsg.getParamCount();
		m_nAttriNameCount=0;
		m_nAttriCount=0;
		m_bEnd=true;
		m_bNeedCallback=true;
	}

	void setAttribute(char* name,void* value,int valueType)
	{
		if(name!=NULL) 
		{
			m_objDoMsg.setParam((int)strlen(name), name);
			m_nAttriNameCount++;
		}
		if(value!=NULL) 
		{
			m_objDoMsg.setParam(valueType, value);
			m_nAttriCount++;
		}
	}

	int getResCount()
	{
		if (m_nAttriNameCount==0) return 0;
		return m_nAttriCount/m_nAttriNameCount;
	}

	void* getAttribute(char** name/*out*/,int* valueType/*out*/, int indexAttri/*in*/,int indexRes)
	{
		if (indexAttri<m_nAttriNameCount)	
		{
			int nameType;
			void* pAttriName = m_objDoMsg.getParam(&nameType, m_nAttriIndex + indexAttri * 2);
			if (!pAttriName) return NULL;
			*name=(char*)malloc(nameType+1);
			memset(*name,0,nameType+1);
			memcpy(*name,pAttriName,nameType);

			if ((indexRes==0))
				return m_objDoMsg.getParam(valueType, m_nAttriIndex + indexAttri * 2 + 1);

			else
				return m_objDoMsg.getParam(valueType, m_nAttriIndex + m_nAttriNameCount*(1 + indexRes) + indexAttri);
		}
		return NULL;
	}

	char* getStream()
	{
		std::string paramstr;
		int tempsize = 20;	//保证可以放下一个整数/浮点数转为字符串表示之后的尺寸
		char * temp = (char *)malloc(tempsize);
		if (temp == NULL) return NULL;

		for (int resIndex = 0; resIndex < getResCount(); resIndex++)
		{
			for (int attrIndex = 0; attrIndex < m_nAttriNameCount; attrIndex++)
			{
				char * name; int type;
				void * value = getAttribute(&name, &type, attrIndex, resIndex);
				int typesize = ObjDoMsg::getTypeSize(type);

				//字符串需要加上结束符
				if (type > 0)
				{
					typesize += 1;
				}

				//调整temp的大小，使其可以容下当前的内容
				if (typesize > tempsize)
				{
					free(temp);
					tempsize = typesize;
					temp = (char *)malloc(tempsize);

					if (temp == NULL)
						return NULL;
				}

				memcpy(temp, 0, tempsize);
				paramstr = paramstr + name + ": ";

				switch (type)
				{
				case PARAMINT:
					sprintf(temp, "%d", *(int*)value);
					break;
				case PARAMBOOL:
					sprintf(temp, "%d", *(bool*)value);
					break;
				case PARAMFLOAT:
					sprintf(temp, "%f", *(float*)value);
					break;
				default:
					memcpy(temp, value, type);
				}

				paramstr = paramstr + temp + " ";
				if (name) free(name);
			}
		}
		free(temp);

		//拷贝到新地址以便返回
		temp = (char *)malloc(paramstr.length() + 1);
		if (temp == NULL) return NULL;
		strcpy(temp, paramstr.c_str());
		
		return temp;
	}

	CResultMsg* compressData(int mode)
	{
		return NULL;
	}

	CResultMsg* uncompressData(int mode)
	{
		return NULL;
	}

	int		m_nAttriIndex;  //从第几个参数开始是属性参数
	int		m_nAttriNameCount;
	int		m_nAttriCount;
	int		m_nTempObjId;  //响应的流水号
	int		m_nSessionId;	//session号
	int		m_spId;			//存储过程ID号
	bool	m_bEnd;	
	bool	m_bNeedCallback;
	short	m_nLevel;
	ObjDoMsg m_objDoMsg;
};

class CSSResultMsg :public CResultMsg
{
public:
	void init()
	{
		m_objDoMsg.initMsg();
	}

	void getInit()
	{
	}

	int streamSize()
	{
		return CResultMsg::streamSize() + sizeof(m_nResCount);
	}

	BYTE * readStream(BYTE * stream)
	{
		if (stream == NULL)
		{
			return NULL;
		}

		BYTE * rpos = stream;

		//read m_nResCount
		m_nResCount = *(int *)rpos;
		rpos += sizeof(m_nResCount);

		return CResultMsg::readStream(rpos);
	}

	BYTE * writeStream(BYTE * stream)
	{
		if (stream == NULL)
		{
			return NULL;
		}
		BYTE * wpos = stream;

		//write m_nResCount
		memcpy(wpos, &m_nResCount, sizeof(m_nResCount));
		wpos += sizeof(m_nResCount);

		return CResultMsg::writeStream(wpos);
	}

public:
	int m_nResCount;
};


class CCSResultMsg :public CResultMsg
{
public:
	void init()
	{
		m_objDoMsg.initMsg();
	}
	void getInit()
	{
	}
};

class CSCResultMsg :public CResultMsg
{
public:

	void init()
	{
		m_objDoMsg.initMsg();
	}
	void getInit()
	{
	}
};

