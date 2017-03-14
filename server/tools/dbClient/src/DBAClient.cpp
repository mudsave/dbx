// DBAClient.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "IDBAClient.h"
#include "Client.h"
#include <list>
#include <algorithm>

#ifdef WIN32

#ifdef _MANAGED
#pragma managed(push, off)
#endif

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
    return TRUE;
}

#ifdef _MANAGED
#pragma managed(pop)
#endif

#endif

std::map<int,int> errorMap;
static int ErrorCount=0;

// This is an example of an exported function.
DBACLIENT_API IInitClient* CreateClient(IDBANetEvent* pNetEvent,std::string serverAddr,int iPort)
{
	try
	{
		CClient* pClient=CClient::InstancePtr();
		CClient::setDBNetEvent(pNetEvent);
        pClient->ConnectDBX(serverAddr, iPort);
		return dynamic_cast<IInitClient*>(pClient);
	}
	catch (CDBClientException e)
	{
		errorMap.insert(std::make_pair(USERDEFERROR,e.m_nExceptionType));
		return NULL;
	}
	catch (...) 
	{
		errorMap.insert(std::make_pair(SYSTEMERROR,0));
		return NULL;
	}
	
}
class IsError
{
public:
	bool operator()(std::pair<int,int> error)
	{
 		if ((error.second<=0)&&(error.first==USERDEFERROR))
 			return false;
		return true;
	}
};

DBACLIENT_API int GetErrorCount()
{
	ErrorCount=0;
	ErrorCount = std::count_if(errorMap.begin(),errorMap.end(),IsError());
	return ErrorCount;
}

DBACLIENT_API int GetError(int index)
{
	if (index<ErrorCount)
		return errorMap[index];
	return 0;
}

DBACLIENT_API bool ClearError()
{
	try
	{
		errorMap.clear();
	}
	catch (std::exception e)
	{
		errorMap.insert(std::make_pair(STLLIBERROR,1));
		return false;
	}
	catch (...) 
	{
		errorMap.insert(std::make_pair(SYSTEMERROR,1));
		return false;
	}
	return true;
}
