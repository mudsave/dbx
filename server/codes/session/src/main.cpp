/**
 * filename : main.cpp
 * desc : session的入口函数
 */

#include "lindef.h"
#include "misc.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include "AccountMgr.h"
#include "LinkContext.h"
#include "session.h"
#include <string.h>

// 参数形式 : ./Session -loginAddr 172.16.2.220:20013 -gateAddrL 172.16.2.220:2300 -worldAddrL 172.16.2.220:2500 -dbAddrC 172.16.2.220:3000
int main(int argc, char* argv[])
{
	InitTraceServer();

	char loginIP[64]		= {0};	int loginPort	= 20013;
	char gateIP_Listen[64]	= {0};	int gatePort	= 2300;
	char worldIP_Listen[64]	= {0};	int worldPort	= 2500;
	char dbIP_Connect[64]	= {0};	int dbPort		= 3000;
	if ( argc != 9 )
	{
		TRACE0_L0("error args for Session, the format is :\n");
		TRACE0_L0("\t./Session -loginAddr 172.16.2.220:20013 -gateAddrL 172.16.2.220:2300 -worldAddrL 172.16.2.220:2500 -dbAddrC 172.16.2.220:3000\n");
		return 1;
	}
	for( int i = 1; i < argc; i++ )
	{
		if ( strcasecmp(argv[i], "-loginAddr" ) == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], loginIP, loginPort);
		}
		else if ( strcasecmp(argv[i], "-gateAddrL" ) == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], gateIP_Listen, gatePort);
		}
		else if ( strcasecmp(argv[i], "-worldAddrL" ) == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], worldIP_Listen, worldPort);
		}
		else if ( strcasecmp(argv[i], "-dbAddrC" ) == 0 )
		{
			i++; ASSERT_(i < argc);
			ParseAddr(argv[i], dbIP_Connect, dbPort);
		}
	}

	IThreadsPool* pThreadsPool	= GlobalThreadsPool();

	GenerateSignalThread();

	g_session.Init(	loginIP, loginPort, gateIP_Listen, gatePort, worldIP_Listen, worldPort, dbIP_Connect, dbPort );

	HRESULT hr = pThreadsPool->Running();
	if ( hr == S_OK )
	{
		TRACE0_L2("The session stops[ normal ]\n");
	}
	else
	{
		TRACE0_L2("The session stops[ timeout ]\n");
	}

	Sleep( 1000 * 5);

	// 可以根据timeout决定是否继续清理
	// 业务中动态数据的清理在Cleanup_callback里面，通过执行最后一个任务来清理

	g_session.Close();
	pThreadsPool->Clear();

	Sleep( 1000 * 5);

	return 0;
}
