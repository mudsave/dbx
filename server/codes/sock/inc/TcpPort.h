/**
 * filename : TcpPort.h
 */

#ifndef __TCP_PORT_H_
#define __TCP_PORT_H_

#include "IoWorker.h"
#include "BufQueue.h"
#include <string>

const int SOCK_RECV_BUF_LEN = 1 * 1024;

class CTcpPort : 
	public ILinkPort, 
	public IIoTask,
	public ITask
{
	struct _TaskContext
	{
		enum _TaskType
		{
			TASK_INVALID,
			TASK_CLOSE,
			TASK_CLOSING,
		};

		_TaskType type;

		_TaskContext(_TaskType t = TASK_INVALID) : type(t){}
		virtual ~_TaskContext(){}
	};

	struct _CloseContext : public _TaskContext
	{
		HRESULT reason;
		_CloseContext() : _TaskContext(TASK_CLOSE), reason(E_FAIL){}
		virtual ~_CloseContext(){}
	};

	struct _ClosingContext : public _TaskContext
	{
		_ClosingContext() : _TaskContext(TASK_CLOSING){}
		virtual ~_ClosingContext(){}
	} m_closingContext;

public:
	CTcpPort();
	virtual ~CTcpPort();

public:
	void Release();

public:
	void Init(SOCKET s, const char* psAddr, int iPort, DWORD dwFlags, bool bConnctOk = true);
	virtual void StartRecv(IPortSink* pSink);

public:
	virtual HRESULT Send(const BYTE* pData, int len);
	virtual HRESULT Recv(BYTE* pBuf, int len);
	virtual HRESULT Peek(BYTE* pBuf, int len);
	virtual HRESULT GetRemoteAddr(char* pAddrBuf, int len, int* pPort);
	virtual HRESULT SetRecvBufSize(int iSize);
	virtual int GetRecvingSize();
	virtual int GetSendingSize();
	virtual HRESULT Close(DWORD dwFlags);

public:
	virtual HRESULT DoIo(HANDLE hContext, int result);

public:
	virtual HRESULT Do(HANDLE hContext);

private:
	HRESULT OnClose(_CloseContext* pContext);
	HRESULT OnClosing(_ClosingContext* pContext);

private:
	HRESULT SendData(const BYTE* pData, int len);

private:
	virtual HRESULT do_io_read();
	virtual HRESULT do_io_write();

private:
	inline void async_sock_eof()
	{
		if(m_sock_error == -1)
		{
			TRACE1_L1("--(%i)error is occur before async_sock_eof()\n", m_s);
			print_port_state();
			return;
		}

		ASSERT_(m_stateRecv == LINK_CLOSING);

		m_stateRecv = LINK_CLOSED;

		_CloseContext* pContext = new _CloseContext;
		pContext->reason = S_OK;
		HRESULT hr = m_pThreadsPool->QueueTask(this, pContext, 0);
		ASSERT_( SUCCEEDED(hr) );
	}

	inline void async_sock_error(const char* str_reason = "no reason")
	{
		if(m_sock_error == -1)
		{
			TRACE1_L1("--(%i)error is occur before async_sock_eof()\n", m_s);
			print_port_state();
			return;
		}

		m_sock_error = -1;
		m_error_num = errno;
		m_error_reason = str_reason;

		TRACE1_L1("--(%i)CTcpPort::async_sock_error()\n", m_s);
		TRACE1_L1("\terrno = %i\n", m_error_num);
		TRACE1_L1("\terrstr = %s\n", strerror(m_error_num));
		TRACE1_L1("\treason = %s\n", m_error_reason.c_str());

		_CloseContext* pContext = new _CloseContext;
		pContext->reason = E_FAIL;
		HRESULT hr = m_pThreadsPool->QueueTask(this, pContext, 0);
		ASSERT_( SUCCEEDED(hr) );
	}

public:
	inline void print_port_state()
	{
		TRACE0_L1("\tTcpPort info is :\n");
		TRACE1_L1("\t\tsock : %d\n", m_s);
		TRACE2_L1("\t\tremote address : %s:%d\n", m_addrRemote.c_str(), m_iPort);
		if (m_sock_error == -1)
		{
			TRACE1_L1("\t\terrno : %d\n", m_error_num);
			TRACE1_L1("\t\terrstr : %s\n", strerror(m_error_num));
			TRACE1_L1("\t\treason : %s\n", m_error_reason.c_str());
		}
		TRACE2_L1("\t\tsend state : (%d, %d)\n", m_stateSend, GetSendingSize());
		TRACE2_L1("\t\trecv state : (%d, %d)\n", m_stateRecv, GetRecvingSize());
		TRACE1_L1("\t\treg ASYN_IO_WRITE : %d\n", m_pIoWorker->HasIoEvents(m_regKey, ASYN_IO_WRITE));
		TRACE1_L1("\t\treg ASYN_IO_READ : %d\n", m_pIoWorker->HasIoEvents(m_regKey, ASYN_IO_READ));
		TRACE1_L1("\t\ttimer state : %p\n", m_hClosingTimer);
	}

private:
	SOCKET m_s;
	std::string m_addrRemote;
	int m_iPort;
	DWORD m_dwFlags;

private:
	HRESULT m_regKey;
	IPortSink* m_pPortSink;
	HANDLE m_hClosingTimer;

private:
	enum LinkState
	{
		LINK_INIT,
		LINK_CONNECTED,
		LINK_CLOSING,
		LINK_CLOSED
	};

	LinkState m_stateSend;
	LinkState m_stateRecv;

private:
	int m_sock_error;
	int m_error_num;
	std::string m_error_reason;

private:
	BufQueue<> m_sendQueue;
	BufQueue<> m_recvQueue;

private:
	int m_iRecvBufSize;

private:
	IIoWorker* m_pIoWorker;
	IThreadsPool* m_pThreadsPool;

private:
	static BYTE		s_buf0[SOCK_RECV_BUF_LEN * 8];
	static BYTE		s_buf1[SOCK_RECV_BUF_LEN * 40];
	static BYTE		s_buf2[SOCK_RECV_BUF_LEN * 80];
	static BYTE*	s_recvbuf;
public:
	static bool SetRecvBufLevel(int level)
	{
		if ( level == 0 )
		{
			s_recvbuf = s_buf0;
			return true;
		}
		if ( level == 1 )
		{
			s_recvbuf = s_buf1;
			return true;
		}
		if ( level == 2 )
		{
			s_recvbuf = s_buf2;
			return true;
		}
		return false;
	}
};

#endif
