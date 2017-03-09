#pragma once
#include "stdlib.h"
#include "vsdeftemp.h"
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
	int Param[1];
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
		Param[0]=0;
	}
	void operator=(ObjDoMsg &obj)
	{
		ObjectId=obj.ObjectId;
		Param[0]=obj.Param[0];
		for(int i=0;i<Param[0];i++)
		{
			Param[i+1]=obj.Param[i+1];
		}
		char* curParam=(char*)&obj.Param[1+obj.Param[0]];
		char* theParam=(char*)&Param[1+Param[0]];
		for(int i=0;i<Param[0];i++)
		{
			if (obj.Param[1+i]>0)
			{
				for (int j=0;j<obj.Param[1+i];j++)
				{
					*(theParam+j)=*(curParam+j);
				}
				curParam=curParam+obj.Param[1+i];
				theParam=theParam+obj.Param[1+i];
			}
			else
			{
				switch(obj.Param[1+i])
				{
				case PARAMINT:
					*(int*)theParam=*(int*)curParam; 
					theParam=theParam+sizeof(int);
					curParam=curParam+sizeof(int);
					break;
				case PARAMBOOL:
					*(bool*)theParam=*(bool*)curParam;
					theParam=theParam+sizeof(bool);
					curParam=curParam+sizeof(bool);
					break;
				case PARAMFLOAT:
					*(float*)theParam=*(float*)curParam;
					theParam=theParam+sizeof(float);
					curParam=curParam+sizeof(float);
					break;
				}

			}
		}
	}
	~ObjDoMsg()
	{
		
	}
	inline void setParam(int ParamType,void* pParam )
	{
		char* curParam=NULL;
		curParam=MoveParam((char*)((int*)&Param[0]+1+Param[0]),&Param[1],Param[0],4);
		Param[1+Param[0]]=ParamType;   //setParamType

		if (Param[0]==0)
			curParam=(char*)&Param[2];
		for (int i=1;i<=Param[0];i++)
		{
			curParam=curParam+getTypeSize(Param[i]);
		}
		if (ParamType>=0)
		{
			for (int i=0;i<ParamType;i++)
			{
				*((char*)curParam+i)=*((char*)pParam+i);
			}
		}
		else
		{
			switch(ParamType)
			{
			case PARAMINT:
				*(int*)curParam=*(int*)pParam; break;
			case PARAMBOOL:
				*(bool*)curParam=*(bool*)pParam;break;
			case PARAMFLOAT:
				*(float*)curParam=*(float*)pParam;break;
			}
		}
		Param[0]++;
	}
	inline int getParamCount()
	{
		return Param[0];
	}
	inline int getParamLen()
	{
		return getParamLen(&Param[1],Param[0])+Param[0]*sizeof(int);
	}
	inline void* getParam(int* pParamType/*out*/,int index/*from 0*/)
	{
		if ((Param[0]>0)&&(Param[0]>index))
		{	
			char* temp=(char*)&Param[Param[0]+1];
			for (int i=0;i<Param[0];i++)
			{
				if (i==index)
				{
					*pParamType=Param[1+i];
					break;
				}
				temp=temp+getTypeSize(Param[1+i]);
			}	
			return (void*)temp;
		}
		return NULL;
	}

// 	static void* copyParam(void* param,int paramType)
// 	{
// 		if (paramType>=0) 
// 		{
// 			void* temp=malloc(paramType+1);
// 			//memset(temp,0,paramType+1);
// 			memcpy(temp,param,paramType);
// 			temp[paramType] = 0;
// 			return temp;
// 		}
// 		switch(paramType)
// 		{
// 		case PARAMINT:
// 			{
// 				int* temp=(int*)malloc(sizeof(int));
// 				memcpy(temp,param,sizeof(int));
// 				return (void*)temp;
// 			}
// 		case PARAMBOOL:
// 			{
// 				bool* temp=(bool*)malloc(sizeof(bool));
// 				memcpy(temp,param,sizeof(bool));
// 				return (void*)temp;
// 			}
// 		case PARAMFLOAT:
// 			{
// 				float* temp=(float*)malloc(sizeof(float));
// 				memcpy(temp,param,sizeof(float));
// 				return (void*)temp;
// 			}
// 		}	
// 		return	NULL;
// 	}
	
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
		if (!data) return NULL;
		int nCount=*data;
		int nTypeLen=nCount*sizeof(int);
		int nDataLen=getParamLen(data+1,nCount);

		int nTotalLen=sizeof(int)+nTypeLen/compressMode+nDataLen;
		int* newData=(int*)malloc(nTotalLen+1);
		memset(newData,0,nTotalLen+1);
		switch(compressMode)
		{
		case MaxCompress:
			{
				*newData=*data;	
				int* told=data+1;
				char* tNew=(char*)(newData+1);
				for (int i=0;i<nCount;i++,tNew++,told++)
				{
					*(char*)tNew=*told;
				}	
				memcpy(tNew,told,nDataLen);
				
			}
			break;
		case MidCompress:
			{
				*newData=*data;	
				int* told=data+1;
				short* tNew=(short*)(newData+1);
				for (int i=0;i<nCount;i++,tNew++,told++)
				{
					*(short*)tNew=*told;
				}	
				memcpy(tNew,told,nDataLen);
			}
			break;
		case NonCompress:
			{
				memcpy(newData,data,nTotalLen);
			}
			break;
		}
		*TotalLen=nTotalLen;
		return newData;

	}
	inline int* uncompressData(int* data,int compressMode,int * TotalLen)
	{
		if (!data) return NULL;
		int nCount=*data;
		int* newData=NULL;

		switch(compressMode)
		{
		case MaxCompress:
			{
				int nTypeLen=nCount*sizeof(int);
				char* tData=(char*)(data+1);
				int* typeList=(int*)malloc(nTypeLen+1);
				memset(typeList,0,nTypeLen+1);
				for (int i=0;i<nCount;i++,tData++)
				{
					typeList[i]=*tData;
				}
				int nDataLen=getParamLen(typeList,nCount);
				int nTotalLen=sizeof(int)+nTypeLen+nDataLen;
				newData=(int*)malloc(nTotalLen+1);
				memset(newData,0,nTotalLen+1);
				memcpy(newData,data,sizeof(int));
				memcpy(newData+1,typeList,nTypeLen);
				memcpy(newData+1+nCount,tData,nDataLen);
				if(typeList) free(typeList);
				*TotalLen=nTotalLen;
			}
			break;
		case MidCompress:
			{
				int nTypeLen=nCount*sizeof(int);
				short* tData=(short*)(data+1);
				int* typeList=(int*)malloc(nTypeLen+1);
				memset(typeList,0,nTypeLen+1);
				for (int i=0;i<nCount;i++,tData++)
				{
					typeList[i]=*tData;
				}
				int nDataLen=getParamLen(typeList,nCount);
				int nTotalLen=sizeof(int)+nTypeLen+nDataLen;
				newData=(int*)malloc(nTotalLen+1);
				memset(newData,0,nTotalLen+1);
				memcpy(newData,data,sizeof(int));
				memcpy(newData+1,typeList,nTypeLen);
				memcpy(newData+1+nCount,tData,nDataLen);
				if(typeList) free(typeList);
				*TotalLen=nTotalLen;
			}
			break;
		case NonCompress:
			{
				int nTypeLen=nCount*sizeof(int);
				int* tData=(int*)(data+1);
				int nDataLen=getParamLen(tData,nCount);
				int nTotalLen=sizeof(int)+nTypeLen+nDataLen;
				newData=(int*)malloc(nTotalLen+1);
				memset(newData,0,nTotalLen+1);
				memcpy(newData,data,nTotalLen);
				*TotalLen=nTotalLen;
			}
			break;
		}
		return newData;

	}
private:
	inline char* MoveParam(void *pCurParam,int* pParamType,int paramCount,int step)
	{
		int paramLen=getParamLen(pParamType,paramCount);
		
		char* pNewParam=(char*)pCurParam+paramLen+step;
		char* pLastParam=(char*)pCurParam+paramLen;
		for (int i=(paramCount-1);i>=0;i--)
		{
			if ((*(pParamType+i))>0)
			{

				for (int j=1;j<=(*(pParamType+i));j++)
				{
					*((char*)pNewParam-j)=*(pLastParam-j);
				}
				pLastParam=(pLastParam-(*(pParamType+i)));
				pNewParam=(pNewParam-(*(pParamType+i)));
			}
			else
			{
				switch((*(pParamType+i)))
				{
				case PARAMINT:
					pLastParam =pLastParam-(sizeof(int));
					pNewParam = pNewParam-(sizeof(int));
					*(int*)pNewParam=*(int*)pLastParam; break;
				case PARAMBOOL:
					pLastParam=pLastParam-(sizeof(bool));
					pNewParam = pNewParam-(sizeof(bool));
					*(bool*)pNewParam=*(bool*)pLastParam; break;
				case PARAMFLOAT:
					pLastParam=pLastParam-(sizeof(float));
					pNewParam = pNewParam-(sizeof(float));
					*(float*)pNewParam=*(float*)pLastParam; break;
				}
			}
		}
		return (char*)pNewParam;
	}
	
	//不包含类型数组长度
	inline int getParamLen(int* pParamType,int paramCount)
	{
		int paramLen=0;
		for (int i=0;i<paramCount;i++)
		{
			if ((*(pParamType+i))>0)
				paramLen=paramLen+*(pParamType+i);
			else
			{
				switch((*(pParamType+i)))
				{
				case PARAMINT:
					paramLen=paramLen+sizeof(int);break;
				case PARAMBOOL:
					paramLen=paramLen+sizeof(bool);break;
				case PARAMFLOAT:
					paramLen=paramLen+sizeof(float);break;
				}
			}
		}
		return paramLen;
	}
	
};



class CResultMsg : public AppMsg
{
public:
	bool isValidResMsg()
	{
		if (m_pObjDoMsg)
		{
			ObjDoMsg *pTemp=(ObjDoMsg*)m_pObjDoMsg;
			if (pTemp->Param[0]==0) return false;
			if (pTemp->Param[0]<0) return false;
			int len=pTemp->getParamLen();
			if ((len>=0)&&(len<msgLen)) return true;
		}
	}

	void initAttribute()
	{
		m_nAttriIndex=((ObjDoMsg*)m_pObjDoMsg)->getParamCount();
		m_nAttriNameCount=0;
		m_nAttriCount=0;
		m_bEnd=true;
		m_bNeedCallback=true;
	}
	void setAttribute(char* name,void* value,int valueType)
	{
		if(name!=NULL) 
		{
			((ObjDoMsg*)m_pObjDoMsg)->setParam((int)strlen(name),name);
			m_nAttriNameCount++;
		}
		if(value!=NULL) 
		{
			((ObjDoMsg*)m_pObjDoMsg)->setParam(valueType,value);	
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
			void* pAttriName=((ObjDoMsg*)m_pObjDoMsg)->getParam(&nameType,m_nAttriIndex+indexAttri*2);
			if (!pAttriName) return NULL;
			*name=(char*)pAttriName;
			*name=(char*)malloc(nameType+1);
			memset(*name,0,nameType+1);
			memcpy(*name,pAttriName,nameType);

			if ((indexRes==0))
				return ((ObjDoMsg*)m_pObjDoMsg)->getParam(valueType,m_nAttriIndex+indexAttri*2+1);

			else
				return ((ObjDoMsg*)m_pObjDoMsg)->getParam(valueType,m_nAttriIndex+m_nAttriNameCount*(1+indexRes)+indexAttri);
		}
		return NULL;
	}
	char* getStream()
	{  
		char * attriName=NULL; int valuetype=0; int attriSize=0;int valueSize=0; 
		char* des=NULL;int len=0;void * value=NULL; char* temp=NULL;
		for(int i=0;i<getResCount();i++)
		{
			for(int j=0;j<m_nAttriNameCount;j++)
			{
				value=getAttribute(&attriName,&valuetype,j,i);
				if (i==0)
				{
					attriSize=attriSize+strlen(attriName)+1;
				}
				if (attriName)
				{
					free(attriName);
					attriName=NULL;
				}
				if (valuetype<0)
				{
					temp=(char*)malloc(MAXVALUE);
					memset(temp,0,MAXVALUE);
				}
				
				if(value)
				{
					switch(valuetype)  
					{
					case PARAMINT:
						if(temp) sprintf(temp,"%d ",*(int*)value);
						valueSize=valueSize+strlen(temp);
						break;
					case PARAMBOOL:
						if(temp) sprintf(temp,"%d ",*(bool*)value);
						valueSize=valueSize+strlen(temp);
						break;
					case PARAMFLOAT:
						if(temp) sprintf(temp,"%f ",*(float*)value);
						valueSize=valueSize+strlen(temp);
						break;
					default:
						valueSize=valueSize+valuetype+1;
					}
#ifdef DEBUGINFO
					TRACE1_L0("1# %d \n",valueSize);
#endif
				}
				if (temp )
				{
					free (temp);
					temp=NULL;
				}
			}
		}
		len=attriSize+valueSize+1;
#ifdef DEBUGINFO
		TRACE3_L0("1# getStream() attriName size is %d values Size is %d len is %d\n",attriSize,valueSize,len);
		int attrilen=0;int desLen=0;
#endif
		des=(char*)malloc(len);
		memset(des,0,len);
		valuetype=0; value=NULL; 
		if (des)
		{
			for(int i=0;i<getResCount();i++)
			{
				for(int j=0;j<m_nAttriNameCount;j++)
				{
					value=getAttribute(&attriName,&valuetype,j,i);
					if (i==0)
					{
						strcat(des,attriName);
						strcat(des," ");
#ifdef DEBUGINFO
						attrilen=attrilen+strlen(attriName)+1;
#endif		
					}
					if (attriName)
					{
						free(attriName);
						attriName=NULL;
					}
					if (valuetype>=MAXVALUE)
					{
						temp=(char*)malloc(valuetype+2);
						memset(temp,0,valuetype+2);
					}
					else
					{
						temp=(char*)malloc(MAXVALUE+1);
						memset(temp,0,MAXVALUE+1);
					}
					if (temp )
					{
						if (value)
						{
							switch(valuetype)
							{
							case PARAMINT:
								sprintf(temp,"%d ",*(int*)value);
								strcat(des,temp);				
								break;
							case PARAMBOOL:
								sprintf(temp,"%d ",*(bool*)value);
								strcat(des,temp);
								break;
							case PARAMFLOAT:
								sprintf(temp,"%f ",*(float*)value);
								strcat(des,temp);
								break;
							default: 
								memcpy(temp,value,valuetype);
								strcat(temp," ");
								strcat(des,temp);
							}
#ifdef DEBUGINFO
							desLen=desLen+strlen(temp);
							TRACE1_L0("2# %d \n",desLen);
#endif
						}
						free (temp);
						temp=NULL;
					}
				}
			}
#ifdef DEBUGINFO
			TRACE3_L0("\n 2# getStream() attriName size is %d values Size is %d len is %d\n",attrilen,desLen,strlen(des));
#endif
			return des;
		}
		return NULL;
	}

	CResultMsg* compressData(int mode)
	{
		if (((ObjDoMsg*)m_pObjDoMsg)&&(mode!=NonCompress))
		{
			int newDataLen=0;
			int* newData=((ObjDoMsg*)m_pObjDoMsg)->compressData(((ObjDoMsg*)m_pObjDoMsg)->Param,mode,&newDataLen);
			int TotalLen=sizeof(CResultMsg)+sizeof(ObjDoMsg)-sizeof(int)+newDataLen;
			CResultMsg* pNewMsg=(CResultMsg*)malloc(TotalLen);
			memset(pNewMsg,0,TotalLen);
			*pNewMsg=*this;
			pNewMsg->m_pObjDoMsg=(LONGLONG)((char*)pNewMsg+sizeof(CResultMsg));
			memcpy((char*)pNewMsg->m_pObjDoMsg+sizeof(int),newData,newDataLen);
			((ObjDoMsg*)(pNewMsg->m_pObjDoMsg))->ObjectId=((ObjDoMsg*)m_pObjDoMsg)->ObjectId;
			pNewMsg->msgLen=TotalLen;
			if (newData) free(newData);
			return pNewMsg;
		}
		return this;
	}
	CResultMsg* uncompressData(int mode)
	{
		if (((ObjDoMsg*)m_pObjDoMsg)&&(mode!=NonCompress))
		{
			int newDataLen=0;
			int* newData=((ObjDoMsg*)m_pObjDoMsg)->uncompressData(((ObjDoMsg*)m_pObjDoMsg)->Param,mode,&newDataLen);
			int TotalLen=sizeof(CResultMsg)+sizeof(ObjDoMsg)-sizeof(int)+newDataLen;
			CResultMsg* pNewMsg=(CResultMsg*)malloc(TotalLen);
			memset(pNewMsg,0,TotalLen);
			*pNewMsg=*this;
			pNewMsg->m_pObjDoMsg=(LONGLONG)((char*)pNewMsg+sizeof(CResultMsg));
			memcpy((char*)pNewMsg->m_pObjDoMsg+sizeof(int),newData,newDataLen);
			((ObjDoMsg*)(pNewMsg->m_pObjDoMsg))->ObjectId=((ObjDoMsg*)m_pObjDoMsg)->ObjectId;
			pNewMsg->msgLen=TotalLen;
			if (newData) free(newData);
			return pNewMsg;
		}
		return this;
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
	LONGLONG		m_pObjDoMsg;

};

class CSSResultMsg :public CResultMsg
{
public:
	void init()
	{
		m_objDoMsg.initMsg();
		m_pObjDoMsg=(LONGLONG)&m_objDoMsg;
	}
	void getInit()
	{
		m_pObjDoMsg=(LONGLONG)&m_objDoMsg;
	}
	int m_nResCount;
	ObjDoMsg m_objDoMsg;
};


class CCSResultMsg :public CResultMsg
{
public:
	void init()
	{
		m_objDoMsg.initMsg();
		m_pObjDoMsg=(LONGLONG)&m_objDoMsg;
	}
	void getInit()
	{
		m_pObjDoMsg=(LONGLONG)&m_objDoMsg;
	}
	ObjDoMsg m_objDoMsg;
};

class CSCResultMsg :public CResultMsg
{
public:

	void init()
	{
		m_objDoMsg.initMsg();
		m_pObjDoMsg=(LONGLONG)&m_objDoMsg;
	}
	void getInit()
	{
		m_pObjDoMsg=(LONGLONG)&m_objDoMsg;
	}
	ObjDoMsg m_objDoMsg;
};

