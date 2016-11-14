#pragma once
#define INVALIDLINK 0

#include <string>
#include <list>


class IDBCallback{
public:
	virtual void onDBReturn(int, int, std::list<int>&) = 0;
};

struct AppMsg;
class IInitClient;
class IDBANetEvent
{
public:
	virtual void onConnected(bool result){};
	virtual void onLogined(int id,int userId,AppMsg *pMsg,bool result){};
	virtual void onExeDBProc(int id,IInitClient* pInitClient,bool result){};
	virtual void onExeDBProc_tocpp(int id,IInitClient* pInitClient,bool result){};
};




class IInitClient
{
public:
	virtual void* getAttributeSet(int attriIndex,int index=0)=0;
	virtual void  deleteAttributeSet(int index)=0;
	virtual int callDBProc(AppMsg *pMsg)=0;
	virtual int callDBSQL(AppMsg *pMsg)=0;
};

#ifdef WIN32
#ifdef DBACLIENT_EXPORTS
#define DBACLIENT_API __declspec(dllexport)  
#else
#define DBACLIENT_API __declspec(dllimport) 
#endif
#else
#define DBACLIENT_API extern "C"
#endif


//string请使用stlport库的

DBACLIENT_API IInitClient* CreateClient(IDBANetEvent* pNetEvent,std::string serverAddr,int iPort);

#define USERDEFERROR 1
#define STLLIBERROR  2
#define SYSTEMERROR  3
#define UNKNOWNERROR 4

DBACLIENT_API int GetErrorCount();
DBACLIENT_API int GetError(int index);
