#pragma once
#define INVALIDLINK 0

#include <string>
#include <list>


struct AppMsg;
class CSCResultMsg;
class IInitClient;
class IDBANetEvent
{
public:
	virtual void onConnected(bool result){};
	virtual void onLogined(int id,int userId,AppMsg *pMsg,bool result){};
	virtual void onExeDBProc(int id,IInitClient* pInitClient,bool result){};
};




class IInitClient
{
public:
	virtual void* getAttributeSet(int attriIndex,int index=0)=0;
	virtual void  deleteAttributeSet(int index)=0;
    virtual int callDBProc(CSCResultMsg *pMsg) = 0;
	virtual int callDBSQL(AppMsg *pMsg)=0;
};


#define DBACLIENT_API extern "C"


DBACLIENT_API IInitClient* CreateClient(IDBANetEvent* pNetEvent,std::string serverAddr,int iPort);

#define USERDEFERROR 1
#define STLLIBERROR  2
#define SYSTEMERROR  3
#define UNKNOWNERROR 4

DBACLIENT_API int GetErrorCount();
DBACLIENT_API int GetError(int index);
