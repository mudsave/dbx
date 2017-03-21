#pragma once

#include <string>

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

IInitClient* CreateClient(IDBANetEvent* pNetEvent,std::string serverAddr,int iPort);

