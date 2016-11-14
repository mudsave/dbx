#pragma once
#include "MsgDefine.h"
//#include "Unl.h"


#define MAX_TRACE_MSG_SIZE 512
#define MAXTICKCOUNT		80
#define FILTERlEN			300
#define RESNAME		"resIndex"
class CErrorMsg : public AppMsg
{
public:
	CErrorMsg()
	{
		init();
	}
	~CErrorMsg()
	{
		destroyErrorMsg(this);
	}
	void init()
	{
		m_nDesSize=0;
		msgLen=sizeof(CErrorMsg);

		time_t t;
		struct tm *tm;
		time(&t);
		tm=localtime(&t);

		char temp[100] = {0};
		sprintf(temp, "%02d:%02d:%02d", tm->tm_hour, tm->tm_min, tm->tm_sec);
		strcpy(m_errorTime, temp);
	}
	static void destroyErrorMsg(CErrorMsg* pErrorMsg)
	{
		if (pErrorMsg)
		{
			free(pErrorMsg);
			pErrorMsg=NULL;
		}
	}
	static CErrorMsg* createErrorMsg(int size,BYTE moduleId )
	{
		if (size<0) return NULL;
		CErrorMsg* pThis=NULL;
		pThis=(CErrorMsg*)malloc(sizeof(CErrorMsg)+size+sizeof(pThis));
		memset(pThis,0,sizeof(CErrorMsg)+size+sizeof(pThis));
		if(pThis)
		{
			pThis->init();
			pThis->m_nDesSize=size;
			pThis->msgLen=sizeof(CErrorMsg)+size+sizeof(pThis);
			pThis->m_moduleId=moduleId;
		}
		return pThis;
	}
	char* getDestription()
	{
		return &m_Destription[0];
	}
	char* getSeparateBlock(int index)
	{
		unsigned int maxSize=MAX_TRACE_MSG_SIZE*2;
		static char temp[MAX_TRACE_MSG_SIZE*2+1];
		memset(temp,0,maxSize+1);
		if (strlen(m_Destription+(index*maxSize))>maxSize)
			memcpy(temp,m_Destription+(index*maxSize),maxSize);
		else
			memcpy(temp,m_Destription+(index*maxSize),strlen(m_Destription+(index*maxSize)));
		return temp;
	}
	int getSeparateBlockNum()
	{
		int blockNum=m_nDesSize/(MAX_TRACE_MSG_SIZE*2);
		int mod=m_nDesSize%(MAX_TRACE_MSG_SIZE*2);
		if (mod>0) blockNum++;
		return blockNum;		
	}
	void printMsg()
	{
		int blockNum=getSeparateBlockNum();
		if(blockNum>0)
		{
			for (int i=0;i<blockNum;i++)
			{
				if (i==0) TRACE3_L0("%s| module :%s %s>> ",m_errorTime,g_translate6[m_moduleId],g_translate7[msgCls]);
				TRACE1_L0("%s",getSeparateBlock(i));
			}
			TRACE0_L0("\n");
		}
	}
	char m_errorTime[20];
	BYTE m_moduleId;
	int m_nDesSize;
	char m_Destription[1];

};



#define LOGPRINT(pMsg) pMsg->printMsg()

#define TICKCOUNT(count,IMsgClass,function,x,y) extern int g_TickCount[MAXTICKCOUNT];g_TickCount[x]=GetTickCount(); \
{char temp[100]="operationId %d ,spId %d, TickCount %d"; \
	CErrorMsg* pCountMsg=CErrorMsg::createErrorMsg(strlen(temp)+MAXVALUE*3,S_DBAACCESS);\
	pCountMsg->msgCls=DBAINFO;\
	pCountMsg->msgId=S_ERROR; \
	if (pCountMsg->getDestription()) {\
	sprintf(pCountMsg->getDestription(),temp,y,x,g_TickCount[x]);\
	if(IMsgClass) IMsgClass->function(pCountMsg); CErrorMsg::destroyErrorMsg(pCountMsg);}}



#define DBAMSGPRINT(printType,IMsgClass,function,DBAmodule,infoType,destription,pMsg) \
	if (pMsg)\
{\
	char preMsg[40]=" msg Id %d msg Len %d msg cls %d "; \
	char* temp=NULL; char* des=NULL; int len=0;\
	if ((pMsg->context==CSCRESMSG)||(pMsg->context==CCSRESMSG))\
{ \
	CSCResultMsg *pDataMsg=(CSCResultMsg *) (pMsg);  \
	pDataMsg->getInit();\
	temp=pDataMsg->getStream(); \
	len=strlen(destription)+strlen(temp)+strlen(preMsg)+1;\
	if (len<0) len=0; \
	des=(char*)malloc(len);\
	if (des) \
{ \
	memset(des,0,len);\
	memcpy(des,destription,strlen(destription));\
	strcat(des,preMsg); \
	strcat(des,temp); \
} \
	if(temp) free(temp); \
}\
		else \
{\
	len=strlen(destription)+strlen(preMsg)+1;\
	if (len<0) len=0; \
	des=(char*)malloc(len);\
	if (des)  \
{ \
	memset(des,0,len);\
	memcpy(des,destription,strlen(destription));\
	strcat(des,preMsg); \
}\
}\
	CErrorMsg *pErrorMsg=CErrorMsg::createErrorMsg(len+MAXVALUE*3,DBAmodule);\
	if(pErrorMsg)  \
{ \
	pErrorMsg->msgId=S_ERROR; \
	pErrorMsg->msgCls=infoType;\
	if(pErrorMsg->getDestription())  \
{\
	sprintf(pErrorMsg->getDestription(),des,pMsg->msgId,pMsg->msgLen,pMsg->msgCls);\
	if (DBAmodule==C_DBACLIENT) {pErrorMsg->msgId=C_ERROR; } \
	if (printType==C_LOCAL) LOGPRINT(pErrorMsg); else  \
{	\
	if (IMsgClass) IMsgClass->function(pErrorMsg) ; \
} \
}\
	CErrorMsg::destroyErrorMsg(pErrorMsg);	\
}\
	if (des) free(des); \
}


#define DBAPRINT0(printType,IMsgClass,function,DBAmodule,infoType,destription)	\
{CErrorMsg *pErrorMsg=CErrorMsg::createErrorMsg(strlen(destription),DBAmodule);\
	if(pErrorMsg) {\
	pErrorMsg->msgCls=infoType;\
	pErrorMsg->msgId=S_ERROR; \
	if(pErrorMsg->getDestription()) {\
	sprintf(pErrorMsg->getDestription(),destription);\
	if (DBAmodule==C_DBACLIENT){pErrorMsg->msgId=C_ERROR;}	\
	if (printType==C_LOCAL) LOGPRINT(pErrorMsg); else {	\
	if(IMsgClass) IMsgClass->function(pErrorMsg);}} \
	CErrorMsg::destroyErrorMsg(pErrorMsg);}}

#define DBAPRINT1(printType,IMsgClass,function,DBAmodule,infoType,destription,p1)	\
{CErrorMsg *pErrorMsg=CErrorMsg::createErrorMsg(strlen(destription)+MAXVALUE,DBAmodule);\
	if(pErrorMsg) {\
	pErrorMsg->msgCls=infoType;\
	pErrorMsg->msgId=S_ERROR; \
	if(pErrorMsg->getDestription()) {\
	sprintf(pErrorMsg->getDestription(),destription,p1);\
	if (DBAmodule==C_DBACLIENT){pErrorMsg->msgId=C_ERROR; }	\
	if (printType==C_LOCAL) LOGPRINT(pErrorMsg); else {	\
	if(IMsgClass) IMsgClass->function(pErrorMsg) ; }}\
	CErrorMsg::destroyErrorMsg(pErrorMsg);}}

#define DBAPRINT2(printType,IMsgClass,function,DBAmodule,infoType,destription,p1,p2)	\
{CErrorMsg *pErrorMsg=CErrorMsg::createErrorMsg(strlen(destription)+MAXVALUE*2,DBAmodule);\
	if(pErrorMsg) {\
	pErrorMsg->msgCls=infoType;\
	pErrorMsg->msgId=S_ERROR; \
	if(pErrorMsg->getDestription()) {\
	sprintf(pErrorMsg->getDestription(),destription,p1,p2);\
	if (DBAmodule==C_DBACLIENT) {pErrorMsg->msgId=C_ERROR;}	\
	if (printType==C_LOCAL) LOGPRINT(pErrorMsg); else {	\
	if(IMsgClass) IMsgClass->function(pErrorMsg) ;}}\
	CErrorMsg::destroyErrorMsg(pErrorMsg);}}

#define DBAPRINT3(printType,IMsgClass,function,DBAmodule,infoType,destription,p1,p2,p3)	\
{CErrorMsg *pErrorMsg=CErrorMsg::createErrorMsg(strlen(destription)+MAXVALUE*3,DBAmodule);\
	if(pErrorMsg) {\
	pErrorMsg->msgCls=infoType;\
	pErrorMsg->msgId=S_ERROR; \
	if(pErrorMsg->getDestription()) {\
	sprintf(pErrorMsg->getDestription(),destription,p1,p2,p3);\
	if (DBAmodule==C_DBACLIENT) {pErrorMsg->msgId=C_ERROR; }	\
	if (printType==C_LOCAL) LOGPRINT(pErrorMsg); else {	\
	if(IMsgClass) IMsgClass->function(pErrorMsg);} }\
	CErrorMsg::destroyErrorMsg(pErrorMsg);}}

#define DBAPRINT4(dbaError,IMsgClass,function,DBAmodule,infoType,destription,p1,p2,p3,p4)	\
{CErrorMsg *pErrorMsg=CErrorMsg::createErrorMsg(strlen(destription)+MAXVALUE*4,DBAmodule);\
	if(pErrorMsg) {\
	pErrorMsg->msgCls=infoType;\
	pErrorMsg->msgId=S_ERROR; \
	if(pErrorMsg->getDestription()) {\
	sprintf(pErrorMsg->getDestription(),destription,p1,p2,p3,p4);\
	if (DBAmodule==C_DBACLIENT) {pErrorMsg->msgId=C_ERROR; }\
	if (printType==C_LOCAL) LOGPRINT(pErrorMsg); else {	\
	if(IMsgClass) IMsgClass->function(pErrorMsg); }}\
	CErrorMsg::destroyErrorMsg(pErrorMsg);}}

