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

typedef int PType;

class DbxMessage : public AppMsg
{
public:
	DbxMessage() : p_content(NULL) {}

	int getParamCount()
	{
		return p_content ? *(int *)p_content : 0;
	}

	int getParamLen()
	{
		int param_count = getParamCount();
		if (param_count == 0) return 0;

		const BYTE * rpos = p_content;
		const PType * temp;

		//跳过数量字节
		rpos += sizeof(int);

		int type_size;
		//放数量的字节 + 放类型长度的字节
		int len = sizeof(int) + getParamCount() * sizeof(PType);

		for (int i = 0; i < getParamCount(); i++)
		{
			temp = (PType *)rpos;
			type_size = getTypeSize(*temp);
			len += type_size;

			//跳过类型和数据字节
			rpos += sizeof(PType) + type_size;
		}
		return len;
	}

	bool getParam(PType & type/*out*/, const void *& pValue/*out*/, const int & index/*from 0*/)
	{
		//数据结构：|变量数量|变量1类型|变量1的数据|变量2类型|变量2的数据|...|

		if (index >= getParamCount())
			return false;

		const BYTE * rpos = p_content;
		const PType * temp;

		//跳过数量字节
		rpos += sizeof(int);

		for (int i = 0; i < getParamCount(); i++)
		{
			if (i == index)
			{
				type = *(PType *)rpos;
				pValue = (void *)(rpos + sizeof(PType));
				return true;
			}
			else
			{
				temp = (PType *)rpos;
				//跳过类型和数据字节
				rpos += sizeof(PType) + getTypeSize(*temp);
			}
		}
		return false;
	}

	/*为了兼容旧版*/
	bool getParam(PType & type/*out*/, void *& pValue/*out*/, const int & index/*from 0*/)
	{
		const void * temp = NULL;
		if (getParam(type, temp, index))
		{
			pValue = const_cast<void *>(temp);
			return true;
		}
		else
		{
			pValue = NULL;
			return false;
		}
	}

	bool getAttribute(std::string & name/*out*/, PType & valueType/*out*/, const void *& pValue/*out*/, const int & col, const int & row)
	{
		if (col < attribute_cols)
		{
			return getAttribute(name, valueType, pValue, row * attribute_cols + col);
		}
		return false;
	}

	bool getAttribute(std::string & name/*out*/, PType & valueType/*out*/, const void *& pValue/*out*/, const int & index)
	{
		if (index < attribute_count)
		{
			int nameType; const void * pName(NULL);
			if (getParam(nameType, pName, index % attribute_cols))
			{
				char * temp = (char*)malloc(nameType + 1);
				if (temp == NULL) return false;

				//取属性名
				memcpy(temp, pName, nameType);
				temp[nameType] = '\0';
				name = temp;
				free(temp);

				/*取属性值（存放的顺序是：
				|属性名1长度|属性名1|属性名2长度|属性名2...|属性1类型|属性1|属性2类型|属性2|...|其他参数|
				）*/
				int value_pos = attribute_cols + index;
				return getParam(valueType, pValue, value_pos);
			}
		}
		return false;
	}

	/*为了兼容旧版*/
	bool getAttribute(char *& name/*out*/, PType & valueType/*out*/, void *& pValue/*out*/, const int & col, const int & row)
	{
		if (col < attribute_cols)
		{
			int nameType; const void * pName(NULL);
			if (getParam(nameType, pName, col))
			{
				name = (char*)malloc(nameType + 1);
				if (name == NULL) return false;

				//取属性名
				memcpy(name, pName, nameType);
				name[nameType] = '\0';
				//name = temp;
				//free(temp);	由外部释放

				/*取属性值（存放的顺序是：
				|属性名1长度|属性名1|属性名2长度|属性名2...|属性1类型|属性1|属性2类型|属性2|...|其他参数|
				）*/
				int value_pos = attribute_cols + row * attribute_cols + col;
				return getParam(valueType, pValue, value_pos);
			}
		}
		return false;
	}

	/*
	* 根据索引获取非属性参数
	*/
	bool getNonAttribute(PType & type/*out*/, const void *& pValue/*out*/, const int & index/*from 0*/)
	{
		return getParam(type, pValue, attribute_cols + attribute_count + index);
	}

	int getAttributeRows()
	{
		return attribute_count / attribute_cols;
	}

	int getAttributeCols()
	{
		return attribute_cols;
	}

	int getAttributeCount()
	{
		return attribute_count;
	}

	static int getTypeSize(const PType & paramType)
	{
		if (paramType >= 0) return paramType;
		switch (paramType)
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

	static int getCharacterSize(const char* pValue)
	{
		return (int)strlen(pValue);
	}

	static int getCharacterType(const char* pValue)
	{
		return getCharacterSize(pValue);
	}

	template<class T>
	static T convert(const void * pValue)
	{
		return *(T *)pValue;
	}

	/*
	* 外部记得用free释放掉
	*/
	static char * convertString(const int & len, const void * pValue)
	{
		char * temp = (char *)malloc(len + 1);
		memcpy(temp, pValue, len);
		temp[len] = '\0';
		return temp;
	}

protected:
	template<class T> friend class DbxMessageBuilder;

	int attribute_cols;		//属性的列数
	int attribute_count;	//属性总数

	//数据结构：|变量数量|变量1类型|变量1的数据|变量2类型|变量2的数据|...|
	BYTE * p_content;
};


template<class MessageType>
class DbxMessageBuilder
{
private:
	struct Param
	{
		Param(const PType & t, const void * v)
		{
			type = t;

			int size = DbxMessage::getTypeSize(t);
			p_value = malloc(size);
			if (p_value)
			{
				memcpy(p_value, v, size);
			}
		}

		~Param()
		{
			if (p_value)
			{
				free(p_value);
				p_value = NULL;
			}
		}

		PType type;
		void * p_value;
	};

public:
	~DbxMessageBuilder()
	{
		reset();
	}

	void reset()
	{
		attribute_cols = 0;
		attribute_count = 0;

		if (params.size() > 0)
		{
			for (size_t i = 0; i < params.size(); i++)
			{
				delete params[i];
			}
			params.clear();
			//保证vector的内存可以释放掉
			std::vector<Param *>(params).swap(params);
		}
	}

	void beginMessage()
	{
		reset();
	}

	/*
	* 消息填充完成，将所有数据放入新内存
	*/
	MessageType * finishMessage()
	{
		int size = sizeof(MessageType) + getParamLen();
		MessageType * p_msg = (MessageType *)malloc(size);
		if (p_msg == NULL) return NULL;
		memset(p_msg, 0, size);

		//设置消息长度
		p_msg->msgLen = (unsigned short)size;
		p_msg->attribute_cols = attribute_cols;
		p_msg->attribute_count = attribute_count;

		int param_count = params.size();
		if (param_count <= 0) return p_msg;

		/*定位p_content指针，指向结构末尾*/
		p_msg->p_content = (BYTE *)p_msg;
		p_msg->p_content += sizeof(MessageType);
		BYTE * wpos = p_msg->p_content;

		//写参数数量
		memcpy(wpos, &param_count, sizeof(int));
		wpos += sizeof(int);

		for (int i = 0; i < param_count; i++)
		{
			//写类型
			memcpy(wpos, &params[i]->type, sizeof(PType));
			wpos += sizeof(PType);

			//写数据
			size = DbxMessage::getTypeSize(params[i]->type);
			memcpy(wpos, params[i]->p_value, size);
			wpos += size;
		}

		//消息写完，把临时数据清理掉
		reset();

		return p_msg;
	}

	void addParam(const PType & ParamType, const void* pParam)
	{
		params.push_back(new Param(ParamType, pParam));
	}

	void addAttribute(const char* name, const void* value, const PType &  valueType)
	{
		int pos;

		/*属性会按顺序放入到前面，存放的顺序是：
		|属性名1长度|属性名1|属性名2长度|属性名2|...|属性1类型|属性1|属性2类型|属性2|...|其他参数|
		*/
		if (name != NULL)
		{
			pos = attribute_cols++;
			params.insert(params.begin() + pos, new Param((PType)strlen(name), name));
		}
		if (value != NULL)
		{
			pos = attribute_cols + attribute_count;
			params.insert(params.begin() + pos, new Param(valueType, value));
			attribute_count++;
		}
	}

	int getParamLen()
	{
		int param_count = params.size();
		if (param_count == 0)
			return 0;

		//放数量的字节 + 放类型长度的字节
		int len = sizeof(int) + param_count * sizeof(PType);

		for (int i = 0; i < param_count; i++)
		{
			len += DbxMessage::getTypeSize(params[i]->type);
		}
		return len;
	}

	static void locateContent(MessageType * p_msg)
	{
		if (p_msg->msgLen <= sizeof(MessageType))
		{
			p_msg->p_content = NULL;
		}
		else
		{
			/*定位p_content指针，指向结构末尾*/
			p_msg->p_content = (BYTE *)p_msg;
			p_msg->p_content += sizeof(MessageType);
		}
	}

private:
	int attribute_cols;
	int attribute_count;
	std::vector<Param *> params;
};


class DbxResultMessage : public DbxMessage
{
public:

	char* getStream()
	{
		std::string paramstr;
		int tempsize = 20;	//保证可以放下一个整数/浮点数转为字符串表示之后的尺寸
		char * temp = (char *)malloc(tempsize);
		if (temp == NULL) return NULL;

		for (int index = 0; index < attribute_count; index++)
		{
			std::string name; PType type; const void * pValue;
			getAttribute(name, type, pValue, index);
			int typesize = getTypeSize(type);

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
				sprintf(temp, "%d", *(int*)pValue);
				break;
			case PARAMBOOL:
				sprintf(temp, "%d", *(bool*)pValue);
				break;
			case PARAMFLOAT:
				sprintf(temp, "%f", *(float*)pValue);
				break;
			default:
				memcpy(temp, pValue, type);
			}

			paramstr = paramstr + temp + " ";

		}
		free(temp);

		//拷贝到新地址以便返回
		temp = (char *)malloc(paramstr.length() + 1);
		if (temp == NULL) return NULL;
		strcpy(temp, paramstr.c_str());

		return temp;
	}

public:
	//	int		m_nAttriIndex;  //从第几个参数开始是属性参数
	//	int		m_nAttriNameCount;
	//	int		m_nAttriCount;
	int		m_nTempObjId;  //响应的流水号
	int		m_nSessionId;	//session号
	int		m_spId;			//存储过程ID号
	bool	m_bEnd;
	bool	m_bNeedCallback;
	short	m_nLevel;
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

	ObjDoMsg & operator=(ObjDoMsg &obj)
	{
		if (this == &obj)
			return *this;
		
		ObjectId = obj.ObjectId;
		initMsg();

		for (int i = 0; i < obj.param_count; i++)
		{
			setParam(obj.param_types[i], obj.param_values[i]);
		}
		
		return *this;
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
	CResultMsg & operator=(CResultMsg &obj)
	{
		if (this == &obj)
			return *this;

		m_nAttriIndex = obj.m_nAttriIndex;
		m_nAttriNameCount = obj.m_nAttriNameCount;
		m_nAttriCount = obj.m_nAttriCount;
		m_nTempObjId = obj.m_nTempObjId;
		m_nSessionId = obj.m_nSessionId;
		m_spId = obj.m_spId;
		m_bEnd = obj.m_bEnd;
		m_bNeedCallback = obj.m_bNeedCallback;
		m_nLevel = obj.m_nLevel;
		m_objDoMsg = obj.m_objDoMsg;
		
		return *this;
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

class CSSResultMsg :public DbxResultMessage
{
public:
	void init()
	{
	}

	void getInit()
	{
	}

	CSSResultMsg & operator=(CSSResultMsg &obj)
	{
		if (this == &obj)
			return *this;

		static_cast<DbxResultMessage &>(*this) = obj;
		m_nResCount = obj.m_nResCount;
		return *this;
	}

public:
	int m_nResCount;
};


class CCSResultMsg :public DbxResultMessage
{
public:
	void init()
	{
	}
	void getInit()
	{
	}
};

class CSCResultMsg :public DbxResultMessage
{
public:

	void init()
	{
	}
	void getInit()
	{
	}
};

