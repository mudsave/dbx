/**
 * filename : main.cpp
 * desc : world的入口函数
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "LinkContext.h"
#include "world.h"
#include <string.h>

void CleanUp();
void Debug();

/// 参数形式 : ./World -sessionAddr 172.16.2.220:2500 -worldId 0
int main(int argc, char* argv[])
{
	InitTraceServer();

	short worldId = 0;
	char sessionIP[64] = {0};
	int sessionPort = 2500;
	char dbIP[64] = {0};
	int dbPort = 2500;
	if ( argc < 7 )
	{
		TRACE0_L0("error args, the format is :\n");
		TRACE0_L0("\t./World -sessionAddrC 172.16.2.220:2500 -dbAddrC 172.16.2.220:3000 -worldId 0\n");
		return 1;
	}
	for( int i = 1; i < argc; i++ )
	{
		if ( strcasecmp(argv[i], "-sessionAddrC") == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], sessionIP, sessionPort);
		}
		else if ( strcasecmp(argv[i], "-dbAddrC") == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], dbIP, dbPort);
		}
		else if ( strcasecmp(argv[i], "-worldId") == 0 )
		{
			i++; ASSERT_(i < argc);
			worldId = atoi(argv[i]);
		}
	}

	IThreadsPool* pThreadsPool	= GlobalThreadsPool();

	SetCleanup(CleanUp);

	SetDebugFunc(Debug);

	GenerateSignalThread();

	g_world.Init( worldId, sessionIP, sessionPort, dbIP, dbPort );

	HRESULT hr = pThreadsPool->Running();
	if ( hr == S_OK )
	{
		TRACE0_L2("The world stops[ normal ]\n");
	}
	else
	{
		TRACE0_L2("The world stops[ timeout ]\n");
	}

	Sleep( 1000 * 5);

	g_world.Close();
	pThreadsPool->Clear();

	Sleep( 1000 * 5);

	return 0;
}

void CleanUp()
{
	g_world.CleanUp();
}

void Debug()
{
	g_world.Debug();
}
