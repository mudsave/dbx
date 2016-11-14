/**
 * filename : main.cpp
 * desc : gateway的入口函数
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "PlayerMgr.h"
#include "LinkContext.h"
#include "gateway.h"
#include <string.h>

/// 参数形式 : ./Gateway -loginAddr 172.16.2.220:20015 -worldAddr 172.16.2.220:2700 -sessionAddr 172.16.2.220:2300 -gatewayId 0
int main(int argc, char* argv[])
{
	InitTraceServer();

	short gatewayId = 0;

	char loginIP[64]		= {0};	int loginPort	= 20015;
	char worldIP_Listen[64]	= {0};	int worldPort	= 2700;
	char sessionIP[64]		= {0};	int sessionPort	= 2300;
	if ( argc < 7 )
	{
		TRACE0_L0("error args, the format is :\n");
		TRACE0_L0("\t./Gateway -loginAddr 172.16.2.220:20015 -worldAddr 172.16.2.220:2700 -sessionAddr 172.16.2.220:2300 -gatewayId 0\n");
		return 1;
	}
	for( int i = 1; i < argc; i++ )
	{
		if ( strcasecmp(argv[i], "-loginAddr") == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], loginIP, loginPort);
		}
		else if ( strcasecmp(argv[i], "-worldAddr") == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], worldIP_Listen, worldPort);
		}
		else if ( strcasecmp(argv[i], "-sessionAddr") == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], sessionIP, sessionPort);
		}
		else if ( strcasecmp(argv[i], "-gatewayId") == 0 )
		{
			i++; ASSERT_(i < argc);
			gatewayId = atoi(argv[i]);
		}
	}

	IThreadsPool* pThreadsPool	= GlobalThreadsPool();

	GenerateSignalThread();

	g_gateway.Init(	gatewayId, loginIP, loginPort, worldIP_Listen, worldPort, sessionIP, sessionPort );

	HRESULT hr = pThreadsPool->Running();
	if ( hr == S_OK )
	{
		TRACE0_L2("The gateway stops[ normal ]\n");
	}
	else
	{
		TRACE0_L2("The gateway stops[ timeout ]\n");
	}

	Sleep( 1000 * 5);

	g_gateway.Close();
	pThreadsPool->Clear();

	Sleep( 1000 * 5);

	return 0;
}
