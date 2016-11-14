/**
 * filename : TcpCtrl.cpp
 */

#include "lindef.h"
#include "TcpCtrl.h"

CTcpCtrl::CTcpCtrl(void)
{
}

CTcpCtrl::~CTcpCtrl(void)
{
}

HRESULT CTcpCtrl::Listen(const char* pszLocalAddr, int* piPort, ILinkSink* pSink, DWORD dwFlags)
{
	pszLocalAddr = pszLocalAddr ? pszLocalAddr : "0.0.0.0";

	ASSERT_(pszLocalAddr && pSink);

	SOCKET ss = socket(AF_INET, SOCK_STREAM, 0);

	VERIFY_SYS(ss != INVALID_SOCKET);

	if( dwFlags | REUSE_ADDR )
	{
		int optVal = 1;
		setsockopt(ss, SOL_SOCKET, SO_REUSEADDR, (char*)&optVal, sizeof(optVal));
	}

	_LinkingContext* pContext = new _LinkingContext(_TaskContext::TASK_ACCEPT);
	pContext->s = ss;
	pContext->dwFlags = dwFlags;
	pContext->pLinkSink = pSink;
	pContext->addr = pszLocalAddr;
	pContext->iPort = *piPort;

	struct sockaddr_in address;
	address.sin_family = AF_INET;
	address.sin_port = htons(static_cast<WORD>(*piPort));
	inet_pton(AF_INET, pszLocalAddr, &address.sin_addr);

	int ret = bind(ss, (struct sockaddr*)&address, sizeof(address));
	VERIFY_SYS(ret != -1);
	
	ret = listen(ss, 128);
	VERIFY_SYS(ret != -1);
	
	ENTER_CRITICAL_SECTION_MEMBER(linkings);

	m_linkings.push_back(pContext);
	HRESULT hr = GlobalThreadsPool()->QueueTask(this, pContext, TASK_LONG_TIME);
	if(FAILED(hr))
	{
		m_linkings.pop_back();
		return hr;
	}

	LEAVE_CRITICAL_SECTION_MEMBER;

	TRACE2_L0("--Listen(), listen %s:%i..\n", pszLocalAddr, *piPort);

	return S_OK;
}

HRESULT CTcpCtrl::Connect(const char* pszRemoteAddr, int iPort, ILinkSink* pSink, DWORD dwFlags)
{
	ASSERT_(pszRemoteAddr && pSink);

	SOCKET cs = socket(AF_INET, SOCK_STREAM, 0);

	VERIFY_SYS(cs != INVALID_SOCKET);

	_LinkingContext* pContext = new _LinkingContext(_TaskContext::TASK_CONNECT);
	pContext->s = cs;
	pContext->dwFlags = dwFlags;
	pContext->pLinkSink = pSink;
	pContext->addr = pszRemoteAddr;
	pContext->iPort = iPort;

	ENTER_CRITICAL_SECTION_MEMBER(linkings);

	m_linkings.push_back(pContext);
	HRESULT hr = ::GlobalThreadsPool()->QueueTask(this, pContext, TASK_LONG_TIME);
	if(FAILED(hr))
	{
		m_linkings.pop_back();
		return hr;
	}

	LEAVE_CRITICAL_SECTION_MEMBER;

	TRACE2_L2("--Connect(), connect to %s:%i..\n", pszRemoteAddr, iPort);

	return cs;
}

void CTcpCtrl::CloseCtrl()
{
	ENTER_CRITICAL_SECTION_MEMBER(linkings);

	for(_LinkingContextList::iterator it = m_linkings.begin(); it != m_linkings.end(); it++)
	{
		(*it)->pLinkSink = NULL;
		close((*it)->s);
		(*it)->s = INVALID_SOCKET;
		delete (*it);
	}
	m_linkings.clear();

	LEAVE_CRITICAL_SECTION_MEMBER;

	delete this;
}

HRESULT CTcpCtrl::Do(HANDLE hContext)
{
	_TaskContext* pContext = reinterpret_cast<_TaskContext*>(hContext);
	switch(pContext->type)
	{
	case _TaskContext::TASK_ACCEPT:
		return OnAccept(static_cast<_LinkingContext*>(pContext));
	case _TaskContext::TASK_ACCEPTED:
		return OnAccepted(static_cast<_AcceptedContext*>(pContext));
	case _TaskContext::TASK_CONNECT:
		return OnConnect(static_cast<_LinkingContext*>(pContext));
	case _TaskContext::TASK_CONNECTED:
		return OnConnected(static_cast<_ConnectedContext*>(pContext));
	default:
		ASSERT_(0);
	}

	return S_OK;
}

HRESULT CTcpCtrl::OnAccept(_LinkingContext* pListen)
{
	while(1)
	{
		struct sockaddr_in client;
		socklen_t addrLen = sizeof(client);
		SOCKET s = accept(pListen->s, reinterpret_cast<sockaddr*>(&client), &addrLen);

		if(s == INVALID_SOCKET)
		{
			DWORD error = GetLastError();
			char strBuf[256];
			LAST_ERROR_INFO(strBuf);
			TRACE3_L0("--CTcpCtrl::OnAccept(), accept operation failed, s=%i, error=%i, desc=%s\n", pListen->s, error, strBuf);

			switch(error)
			{
				case ECONNABORTED:
				case EINTR:
				{
					Sleep(1000);
					continue;
				}
				default:
					ASSERT_(0);
			}
		}

		_AcceptedContext* pAccepted = new _AcceptedContext;
		pAccepted->s = s;
		pAccepted->pListen = pListen;

		HRESULT hr = GlobalThreadsPool()->QueueTask(this, pAccepted, 0);
		if(FAILED(hr))
		{
			delete pAccepted;
			return hr;
		}

		TRACE1_L3("--CTcpCtrl::OnAccept(), recv connection, s=%i\n", s);
	}

	return S_OK;
}

HRESULT CTcpCtrl::OnAccepted(_AcceptedContext* pContext)
{
	ASSERT_(pContext->pListen->pLinkSink);

	VERIFY_SYS(SetFileOpt(pContext->s, O_NONBLOCK));

	struct sockaddr_in addr;
	socklen_t addrLen = sizeof(struct sockaddr_in);
	VERIFY_SYS(getpeername(pContext->s, (struct sockaddr*)&addr, &addrLen) == 0);

	CTcpPort* pNewPort = new CTcpPort;
	pNewPort->Init(pContext->s, ::inet_ntoa(addr.sin_addr), ::ntohs(addr.sin_port), 0, true);

	IPortSink* pPortSink = pContext->pListen->pLinkSink->OnConnects(pContext->s, pNewPort, S_OK);
	if(!pPortSink)
	{
		TRACE1_L3("--CTcpCtrl::OnAccepted(), new link rejected, s=%i\n", pContext->s);
		pNewPort->Close(CLOSE_UNGRACEFUL);
	}
	else
	{
		TRACE0_L3("--CTcpCtrl::OnAccepted(), new link arrived\n");
		pNewPort->StartRecv(pPortSink);
	}

	delete pContext;

	return S_OK;
}

HRESULT CTcpCtrl::OnConnect(_LinkingContext* pConnect)
{
	struct sockaddr_in addr;
	addr.sin_family = AF_INET;
	addr.sin_port = htons(static_cast<WORD>(pConnect->iPort));
	inet_pton(AF_INET, pConnect->addr.c_str(), &addr.sin_addr);

	int result = connect(pConnect->s, reinterpret_cast<sockaddr*>(&addr), sizeof(struct sockaddr_in));

	_ConnectedContext* pConnected = new _ConnectedContext;
	pConnected->result = S_OK;
	pConnected->pConnect = pConnect;
	if(result == SOCKET_ERROR)
	{
		pConnected->result = E_FAIL;

		DWORD error = GetLastError();
		char strBuf[256];
		LAST_ERROR_INFO(strBuf);
		TRACE3_L0("--CTcpCtrl::OnConnect(), connect operation failed, s=%i, error=%i, desc=%s\n", pConnect->s, error, strBuf);
	}

	HRESULT hr = GlobalThreadsPool()->QueueTask(this, pConnected, 0);
	if(FAILED(hr))
	{
		delete pConnected;
		return hr;
	}

	TRACE4_L3("--CTcpCtrl::OnConnect(), connect to %s:%i, result=%i, s=%i\n", pConnect->addr.c_str(), pConnect->iPort, result, pConnect->s);

	return S_OK;
}

HRESULT CTcpCtrl::OnConnected(_ConnectedContext* pContext)
{
	ASSERT_(pContext->pConnect->pLinkSink);

	if(pContext->result == S_OK)
	{
		VERIFY_SYS(SetFileOpt(pContext->pConnect->s, O_NONBLOCK));

		CTcpPort* pNewPort = new CTcpPort;
		pNewPort->Init(pContext->pConnect->s, pContext->pConnect->addr.c_str(), pContext->pConnect->iPort, 0, true);

		IPortSink* pPortSink = pContext->pConnect->pLinkSink->OnConnects(pContext->pConnect->s, pNewPort, S_OK);
		if(!pPortSink)
		{
			TRACE1_L3("--CTcpCtrl::OnConnected(), connect rejected, s=%i\n", pContext->pConnect->s);
			pNewPort->Close(CLOSE_UNGRACEFUL);
		}
		else
		{
			TRACE0_L3("--CTcpCtrl::OnConnected(), new link arrived\n");
			pNewPort->StartRecv(pPortSink);
		}
	}
	else
	{
		TRACE1_L3("--CTcpCtrl::OnConnected(), report connect failed, reason=%x\n", pContext->result);

		CTcpPort* pNewPort = new CTcpPort;
		pNewPort->Init(pContext->pConnect->s, pContext->pConnect->addr.c_str(), pContext->pConnect->iPort, 0, false);
		
		pContext->pConnect->pLinkSink->OnConnects(pContext->pConnect->s, pNewPort, pContext->result);

		delete pNewPort;
	}
	
	ENTER_CRITICAL_SECTION_MEMBER(linkings);

	for(_LinkingContextList::iterator it = m_linkings.begin(); it != m_linkings.end(); it++)
	{
		if(*it == pContext->pConnect)
		{
			pContext->pConnect->s = INVALID_SOCKET;
			delete pContext->pConnect;
			m_linkings.erase(it);
			break;
		}
	}

	LEAVE_CRITICAL_SECTION_MEMBER;

	delete pContext;

	return S_OK;
}
