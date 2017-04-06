/**
  管理进程入口函数
**/

#include "string"
#include "iostream"

#include "lindef.h"
#include "Sock.h"

#include "admin.h"
#include "client.h"

using namespace std;

CAdmin g_admin;
extern CClient g_client;

int main()
{
	InitTraceServer();
	IThreadsPool* pThreadsPool	= GlobalThreadsPool();
	GenerateSignalThread();

	short httpPort = 5588;
	if(g_admin.init(httpPort))
	{
		g_admin.start();
	}
	else
	{
		cout << "MHD init ERROR!" << endl;
		return -1;
	}

	if(-1 == g_client.Init())
	{
		cout << "client init ERROR!" << endl;
		return -1;
	}

	HRESULT hr = pThreadsPool->Running();
	if ( hr == S_OK )
	{
		TRACE0_L2("The client stops[ normal ]\n");
	}
	else
	{
		TRACE0_L2("The client stops[ timeout ]\n");
	}
	g_admin.stop();

	Sleep( 1000 * 1);
	pThreadsPool->Clear();
	Sleep( 1000 * 1);
	return 0;
}
