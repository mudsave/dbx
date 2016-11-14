/**
 * filename : test_server.cpp
 * desc：sock模块测试程序（server）
 */

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"
#include <vector>
#include <string>

struct _LinkContext
{
	int linkType;
	handle hLink;
	int linkNum;
	std::string str_addr;
	_LinkContext(int type, handle h, int num) : linkType(type), hLink(h), linkNum(num) {}
};

static int s_client_sn_num = 0;
static std::vector<_LinkContext*> s_clients;

class CNetwork : public IMsgLinksImpl<1>
{
public : 
	virtual HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType)
	{
		int iPort = 0;
		char strbuf[1024] = {0};
		pPort->GetRemoteAddr(strbuf, 1024, &iPort);
		TRACE2_L0("--CNetwork::OnConnects(), 服务器接收新的客户端连接，client address = %s:%d\n", strbuf, iPort);

		_LinkContext* pContext = new _LinkContext(iLinkType, hLink, s_client_sn_num++);
		pContext->str_addr = strbuf;
		s_clients.push_back(pContext);

		return pContext;
	}

	virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext)
	{
		_LinkContext* pContext = (_LinkContext*)hLinkContext;
		int i = pContext->linkNum;

		_LinkContext* pClient = s_clients[i];
		ASSERT_(pClient == pContext);

		TRACE2_L2("--CNetwork::DefaultMsgProc()，服务器收到来自，客户端(%d)的消息：%s\n", i, pContext->str_addr.c_str());
		char* contents = (char*)pMsg + sizeof(AppMsg);
		TRACE1_L2("AppMsg : <<< %s", contents);

		IMsgLinksImpl<1>::SendMsg(pContext->hLink, pMsg);

		return;
	}

	virtual void OnClosed(HANDLE hLinkContext, HRESULT reason)
	{
		// eof，断开和PortSink的关系，并销毁PortSink，port自行管理自己
		// error，断开和PortSink的关系，并销毁PortSink，port自行销毁自己（异步任务）
		// 超时，断开和PortSink的关系，并销毁PortSink，此时port已经彻底销毁
		// 业务主动暴力关闭，断开和PortSink的关系，并销毁PortSink，port自行销毁自己（定时器）
		
		_LinkContext* pContext = (_LinkContext*)hLinkContext;
		int i = pContext->linkNum;

		switch (reason)
		{
			case S_OK:
				TRACE1_L0("close for eof,link num = %d\n", i);
				break;
			case S_FALSE:
				TRACE1_L0("close for timeout,link num = %d\n", i);
				break;
			case E_FAIL:
				TRACE1_L0("close for error,link num = %d\n", i);
				break;
			case E_ABORT:
				TRACE1_L0("close for abort,link num = %d\n", i);
				break;
			default:
				TRACE0_L0("close reason is unknow\n");
		}

		delete s_clients[i];

		s_clients[i] = NULL;
	}
};

static CNetwork s_network;

struct CountTask : public ITask
{
	virtual HRESULT Do(HANDLE hContext)
	{
		int count = 0;
		int total = s_clients.size();
		for ( int i = 0; i < total; i++)
		{
			if ( s_clients[i] != NULL )
				count++;
		}

		TRACE1_L0("--there is %d clients exists\n", count);

		return S_OK;
	}
};

int main(int argc, const char* argv[])
{
	if ( argc != 3 )
	{
		TRACE0_L0("error args, the format is 172.16.2.220 20013\n");
		return 1;
	}

	const char* p_str_addr = argv[1];
	int i_port = atoi(argv[2]);

	//SetCleanup();
	InitTraceServer(true);
	IThreadsPool* pThreadsPool = GlobalThreadsPool();
	ILinkCtrl* pLinkCtrl = CreateLinkCtrl();

	GenerateSignalThread();

	pLinkCtrl->Listen(p_str_addr, &i_port, &s_network, 0);

	CountTask* pTask = new CountTask();
	HANDLE h_count_timer = pThreadsPool->RegTimer(pTask, 0, 0, 1000 * 60 * 2, 1000 * 60 * 2, "h_count_timer");

	HRESULT hr = pThreadsPool->Running();
	if ( hr == S_OK )
	{
		TRACE0_L2("The Process normal stops\n");
	}
	else
	{
		TRACE0_L2("The Process timeout\n");
	}

	Sleep( 1000 * 5);

	// 可以根据timeout决定是否继续清理

	//业务中动态数据的清理在Cleanup_callback里面完成

	//清理server自己的数据
	int n = s_clients.size();
	for( int i = 0; i < n; i++)
	{
		if ( s_clients[i] != NULL )
			delete s_clients[i];
	}
	pThreadsPool->UnregTimer(h_count_timer);
	delete pTask;

	//清理MsgLinks的数据
	s_network.IMsgLinksImpl<1>::Clear();

	//清理sock中数据
	pLinkCtrl->CloseCtrl();
	pThreadsPool->Clear();

	Sleep( 1000 * 5);

	return 0;
}
