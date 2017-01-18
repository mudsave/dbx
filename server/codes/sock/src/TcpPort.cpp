/**
 * filename : TcpPort.cpp
 *
 * desc : 需要改进的问题：
 *			1. 接收阀值，控制了io read event，但实际上不可能超过阀值，应该屏蔽掉对io read event的操作
 *			2. 接收数据用的静态缓冲区。这个要改进，直接用recvBufQueue里面的缓冲区
 *			3. 发送数据时，发送一部分的时候，是否退出循环，需要测试一下，看效果
 *			4. 发送数据时，可能会出现小段的数据（因为每次都是从bufQueue头部pop出来的数据，感觉策略有点简单）
 *
 */

#include "lindef.h"
#include "Sock.h"
#include "TcpPort.h"

CTcpPort::CTcpPort()
{
	m_s = INVALID_SOCKET;

	m_regKey = E_FAIL;
	m_pPortSink = NULL;
	m_hClosingTimer = NULL;

	m_stateSend = LINK_INIT;
	m_stateRecv = LINK_INIT;

	m_sock_error = 0;
	m_error_num = 0;
	m_error_reason = "";

	m_iRecvBufSize = 256 * 1024;

	m_pIoWorker = NULL;
	m_pThreadsPool = GlobalThreadsPool();

	TRACE1_L4("--(%i)new tcp port\n", m_s);
}

CTcpPort::~CTcpPort()
{
	ASSERT_(FAILED(m_regKey));
	ASSERT_(!m_pPortSink);
	ASSERT_(!m_hClosingTimer);

	if(m_s != INVALID_SOCKET)
	{
		close(m_s);
	}

	TRACE1_L4("--(%i)delete tcp port\n", m_s);
}

void CTcpPort::Release()
{
	m_regKey = E_FAIL;
	m_pPortSink = NULL;
	m_hClosingTimer = NULL;

	delete this;
}

void CTcpPort::Init(SOCKET s, const char* psAddr, int iPort, DWORD dwFlags, bool bConnctOk)
{
	m_s = s;
	m_addrRemote = psAddr;
	m_iPort = iPort;
	m_dwFlags = dwFlags;

	if(bConnctOk)
	{
		m_pIoWorker = dynamic_cast<IIoWorker*>(m_pThreadsPool);
		ASSERT_(m_pIoWorker);

		m_regKey = m_pIoWorker->RegAsynIoTask(this, 0, m_s);
		ASSERT_(SUCCEEDED(m_regKey));

		m_stateSend = LINK_CONNECTED;
		m_stateRecv = LINK_CONNECTED;
	}
	else
	{
		m_stateSend = LINK_CLOSED;
		m_stateRecv = LINK_CLOSED;
	}
}

void CTcpPort::StartRecv(IPortSink* pSink)
{
	m_pPortSink = pSink;
	HRESULT hr = m_pIoWorker->AttachIoEvents(m_regKey, ASYN_IO_READ);
	ASSERT_(SUCCEEDED(hr));
	TRACE1_L3("--(%i)CTcpPort::StartRecv(), attach read io event\n", m_s);
}

HRESULT CTcpPort::Send(const BYTE* pData, int len)
{
	TRACE2_L4("--(%i)CTcpPort::Send(), pData lenth = %i\n", m_s, len);

	ASSERT_(pData && len > 0);

	if(m_sock_error == -1)
	{
		TRACE2_L1("--(%i)error is occur before CTcpPort::Send(), data len=%i\n", m_s, len);
		print_port_state();
		return E_FAIL;
	}

	if(m_stateSend != LINK_CONNECTED)
	{
		TRACE3_L0("--(%i)CTcpPort::Send, failed, stateSend=%i, stateRecv=%i\n", m_s, m_stateSend, m_stateRecv);
		return E_FAIL;
	}

	return SendData(pData, len);
}

HRESULT CTcpPort::Recv(BYTE* pBuf, int len)
{
	TRACE2_L4("--(%i)CTcpPort::Recv(), buffer lenth = %i\n", m_s, len);

	ASSERT_EX(len <= m_recvQueue.Size(), "CTcpPort::Recv(), no enough data to recv");

	m_recvQueue.Pop(pBuf, len);

	/**
	int new_size = m_recvQueue.Size();
	int old_size = new_size + len;
	if( old_size >= m_iRecvBufSize && new_size < m_iRecvBufSize && m_stateRecv == LINK_CONNECTED )
	{
		HRESULT hr = m_pIoWorker->AttachIoEvents(m_regKey, ASYN_IO_READ);
		ASSERT_( SUCCEEDED(hr) );
		TRACE3_L2("--(%i)CTcpPort::Recv(), attach read io event, old_size=%i, new_size=%i\n", m_s, old_size, new_size);
	}
	*/

	return S_OK;
}

HRESULT CTcpPort::Peek(BYTE* pBuf, int len)
{
	if ( len > m_recvQueue.Size() )
	{
		return E_FAIL;
	}

	m_recvQueue.Front(pBuf, len);

	return S_OK;
}

HRESULT CTcpPort::GetRemoteAddr(char* pAddrBuf, int len, int* pPort)
{
	ASSERT_(pAddrBuf);

	if( (int)m_addrRemote.size() >= len )
	{
		return E_FAIL;
	}

	strcpy(pAddrBuf, m_addrRemote.c_str());

	if(pPort)
	{
		*pPort = m_iPort;
	}

	return S_OK;
}

HRESULT CTcpPort::SetRecvBufSize(int iSize)
{
	if ( iSize <= 1024 ) return E_FAIL;
	m_iRecvBufSize = iSize;
	return S_OK;
}

int CTcpPort::GetRecvingSize()
{
	return m_recvQueue.Size();
}

int CTcpPort::GetSendingSize()
{
	return m_sendQueue.Size();
}

HRESULT CTcpPort::Close(DWORD dwFlags)
{
	TRACE4_L2("--(%i)CTcpPort::Close(), flags = %d, send state = %d, recv state = %d\n", m_s, dwFlags, m_stateSend, m_stateRecv);

	if(m_sock_error == -1)
	{
		TRACE1_L1("--(%i)error is occur before CTcpPort::Close()\n", m_s);
		print_port_state();
		return E_FAIL;
	}

	if(m_stateSend == LINK_CLOSED || m_stateSend == LINK_CLOSING)
	{
		TRACE1_L2("--(%i)CTcpPort::Close(), Port already has closed\n", m_s);
		return S_FALSE;
	}

	ASSERT_(m_stateSend == LINK_CONNECTED);

	m_stateSend = LINK_CLOSING;

	if(m_sendQueue.Empty())
	{
		shutdown(m_s, SHUT_WR);
		m_stateSend = LINK_CLOSED;
	}

	if((dwFlags & CLOSE_UNGRACEFUL) || (dwFlags & CLOSE_RELEASE))
	{
		ASSERT_(SUCCEEDED(m_regKey));

		m_stateRecv = LINK_CLOSING;
		m_pIoWorker->DetachIoEvents(m_regKey, ASYN_IO_READ);

		m_stateRecv = LINK_CLOSED;
		m_pPortSink = NULL;
	}

	int uiElapse = 1000 * 5;
	if ( dwFlags & CLOSE_RELEASE ) uiElapse = 0;
	else if ( dwFlags & CLOSE_UNGRACEFUL ) uiElapse = 1000 * 2;
	m_hClosingTimer = m_pThreadsPool->RegTimer(this, &m_closingContext, 0, uiElapse, 0, "CTcpPort::m_hClosingTimer");

	return S_OK;
}

HRESULT CTcpPort::DoIo(HANDLE hContext, int result)
{
	if(m_sock_error == -1)
	{
		TRACE2_L1("--(%i)error is occour before CTcpPort::DoIo( result = %i)\n", m_s, result);
		print_port_state();
		return E_FAIL;
	}

	if(result & ASYN_IO_READ)
	{
		return do_io_read();
	}

	if(result & ASYN_IO_WRITE)
	{
		return do_io_write();
	}

	return S_FALSE;
}

HRESULT CTcpPort::Do(HANDLE hContext)
{
	_TaskContext* pContext = reinterpret_cast<_TaskContext*>(hContext);
	switch(pContext->type)
	{
	case _TaskContext::TASK_CLOSE:
		return OnClose(static_cast<_CloseContext*>(pContext));
	case _TaskContext::TASK_CLOSING:
		return OnClosing(static_cast<_ClosingContext*>(pContext));
	default:
		ASSERT_(0);
	}
	return S_OK;
}

HRESULT CTcpPort::OnClose(_CloseContext* pContext)
{
	if(pContext->reason == S_OK)
	{
		ASSERT_(m_stateRecv == LINK_CLOSED);
		ASSERT_(m_pPortSink);

		TRACE1_L2("--(%i)CTcpPort::OnClose(), do eof\n", m_s);
		m_pPortSink->OnClose(S_OK);
		m_pPortSink = NULL;
	}

	if(pContext->reason == E_FAIL)
	{
		ASSERT_(m_sock_error == -1);

		TRACE1_L2("--(%i)CTcpPort::OnClose(), do sock error\n", m_s);
		print_port_state();

		if(m_pPortSink)
		{
			m_pPortSink->OnClose(E_FAIL);
			m_pPortSink = NULL;
		}

		ASSERT_(m_regKey);
		HRESULT hr = m_pIoWorker->UnregIoTask(m_regKey);
		ASSERT_(SUCCEEDED(hr));
		m_regKey = E_FAIL;

		if(m_hClosingTimer)
		{
			m_pThreadsPool->UnregTimer(m_hClosingTimer);
			m_hClosingTimer = NULL;
		}

		delete this;
	}

	delete pContext;

	return S_OK;
}

HRESULT CTcpPort::OnClosing(_ClosingContext* pContext)
{
	ASSERT_(m_hClosingTimer);

	m_hClosingTimer = NULL;

	TRACE1_L2("--(%i)CTcpPort::OnClosing()\n", m_s);
	print_port_state();

	if(m_pPortSink)
	{
		m_pPortSink->OnClose(S_FALSE);
		m_pPortSink = NULL;
	}

	ASSERT_(m_regKey);
	HRESULT hr = m_pIoWorker->UnregIoTask(m_regKey);
	ASSERT_(SUCCEEDED(hr));
	m_regKey = E_FAIL;

	delete this;

	return S_OK;
}

HRESULT CTcpPort::SendData(const BYTE* pData, int len)
{
	int iSended = 0;

	if( m_sendQueue.Empty() )
	{
		iSended = send(m_s, (char*)pData, len, MSG_NOSIGNAL);
		if(iSended >= 0)
		{
			//TRACE3_L2("--(%i)CTcpPort::SendData(), len=(%i,%i)\n", m_s, len, iSended);
			if(iSended == len) return S_OK;
		}
		else
		{
			if( GetLastError() != EWOULDBLOCK && GetLastError() != EINTR )
			{
				async_sock_error("CTcpPort::SendData()");
				return E_FAIL;
			}

			iSended = 0;
			TRACE2_L2("--(%i)CTcpPort::SendData(),send blocked, %s\n", m_s, strerror(errno));
		}

		TRACE1_L3("--(%i)CTcpPort::SendData(), attach write io event\n", m_s);
		HRESULT hr = m_pIoWorker->AttachIoEvents(m_regKey, ASYN_IO_WRITE);
		ASSERT_( SUCCEEDED(hr) );
	}

	if( !m_sendQueue.Push(pData + iSended, len - iSended) )
	{
		TRACE1_L0("--(%i)CTcpPort::SendData(), failed to push data into sendQueue\n", m_s);
		return E_FAIL;
	}

	return S_OK;
}

HRESULT CTcpPort::do_io_read()
{
	HRESULT hr = E_PENDING;
	int iRecv = 0;

	if ( m_stateRecv == LINK_CLOSING || m_stateRecv == LINK_CLOSED )
	{
		TRACE1_L0("--(%i)CTcpPort::do_io_read(), has already read eof, buf still want to read\n", m_s);
		async_sock_error("CTcpPort::do_io_read(), already eof");
		return S_FALSE;
	}

	while(1)
	{
		if(m_recvQueue.Size() >= m_iRecvBufSize)
		{
			TRACE2_L0("--(%i)CTcpPort::do_io_read(), full recv buf, recvQueue size = %i\n", m_s, m_recvQueue.Size());
			//ASSERT_(SUCCEEDED(m_regKey));
			//m_pIoWorker->DetachIoEvents(m_regKey, ASYN_IO_READ);
			hr = S_FALSE;
			break;
		}

		int len = recv(m_s, (char*)s_recvbuf, SOCK_RECV_BUF_LEN, 0);
		if(len > 0)
		{
			iRecv += len;
			ASSERT_( m_recvQueue.Push(s_recvbuf, len) );
		}
		else if(len == 0)
		{
			TRACE1_L1("--(%i)CTcpPort::do_io_read(), recv finish segment, detach read io event\n", m_s);
			m_stateRecv = LINK_CLOSING;
			ASSERT_(SUCCEEDED(m_regKey));
			m_pIoWorker->DetachIoEvents(m_regKey, ASYN_IO_READ);
			hr = S_OK;
			break;
		}
		else
		{
			if(GetLastError() != EWOULDBLOCK && GetLastError() != EINTR)
			{
				async_sock_error("CTcpPort::do_io_read(), not eof");
				hr = E_FAIL;
			}
			else
			{
				TRACE1_L4("--(%i)CTcpPort::do_io_read(), recv blocked\n", m_s);
			}
			break;
		}
	}

	TRACE1_L3("--(%i)CTcpPort::do_io_read(), break recv loop\n", m_s);
	TRACE1_L3("\tbreak reason is %i\n", hr);
	TRACE1_L3("\ttotal recv size is %i bytes\n", iRecv);

	if ( hr == E_FAIL ) return S_FALSE;

	int totalsize = m_recvQueue.Size();
	if(totalsize > 0)
	{
		ASSERT_(m_pPortSink);
		m_pPortSink->OnRecv(totalsize, NULL);
	}

	if ( hr == S_OK )
	{
		async_sock_eof();
	}

	return S_OK;
}

HRESULT CTcpPort::do_io_write()
{
	ASSERT_(!m_sendQueue.Empty());

	HRESULT hr = E_PENDING;
	int iTotal = 0;

	while(1)
	{
		if(m_sendQueue.Empty())
		{
			ASSERT_(SUCCEEDED(m_regKey));
			m_pIoWorker->DetachIoEvents(m_regKey, ASYN_IO_WRITE);
			if(m_stateSend == LINK_CLOSING)
			{
				shutdown(m_s, SHUT_WR);
				m_stateSend = LINK_CLOSED;
			}

			TRACE1_L2("--(%i)CTcpPort::do_io_write(), send buf empty, detach write io event\n", m_s);
			hr = S_OK;
			break;
		}

		int len = 0; const BYTE* pData = m_sendQueue.Front(len);
		int iSended = send(m_s, (const char*)pData, len, MSG_NOSIGNAL);
		ASSERT_(iSended != 0);
		if(iSended > 0)
		{
			iTotal += iSended;
			m_sendQueue.Pop(NULL, iSended);
			if(iSended < len)
			{
				TRACE3_L2("--(%i)CTcpPort::do_io_write(), want to send %i bytes, but only send %i bytes\n", m_s, len, iSended);
				hr = S_FALSE;
				break;
			}
		}
		else
		{
			if(GetLastError() != EWOULDBLOCK && GetLastError() != EINTR)
			{
				async_sock_error("CTcpPort::do_io_write()");
				hr = E_FAIL;
			}
			else
			{
				TRACE1_L4("--(%i)CTcpPort::do_io_write(), send blocked\n", m_s);
			}
			break;
		}
	}

	TRACE1_L3("--(%i)CTcpPort::do_io_write(), break send loop\n", m_s);
	TRACE1_L3("\tbreak reason is %i\n", hr);
	TRACE1_L3("\ttotal send size is %i bytes\n", iTotal);

	if ( hr == E_FAIL ) return S_FALSE;

	return S_OK;
}

BYTE CTcpPort::s_buf0[SOCK_RECV_BUF_LEN * 8] = {0};

BYTE CTcpPort::s_buf1[SOCK_RECV_BUF_LEN * 40] = {0};

BYTE CTcpPort::s_buf2[SOCK_RECV_BUF_LEN * 80] = {0};

BYTE* CTcpPort::s_recvbuf = s_buf1;
