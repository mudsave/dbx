/**
 * filename : TcpCtrl.h
 */

#ifndef __TCP_CTRL_H_
#define __TCP_CTRL_H_

#include "Sock.h"
#include "TcpPort.h"
#include <string>
#include <list>

class CTcpCtrl :
	public ILinkCtrl,
	public ITask
{
public:
	CTcpCtrl(void);
	virtual ~CTcpCtrl(void);

public:
	virtual HRESULT Listen(const char* pszLocalAddr, int* piPort, ILinkSink* pSink, DWORD dwFlags);
	virtual HRESULT Connect(const char* pszRemoteAddr, int iPort, ILinkSink* pSink, DWORD dwFlags);
	virtual void CloseCtrl();

public:
	virtual HRESULT Do(HANDLE hContext);

private:
	struct _TaskContext
	{
		enum _TaskType
		{
			TASK_INVALID,
			TASK_ACCEPT,
			TASK_ACCEPTED,
			TASK_CONNECT,
			TASK_CONNECTED
		};
		_TaskType type;
		_TaskContext(_TaskType t = TASK_INVALID) : type(t){}
		virtual ~_TaskContext(){}
	};

private:
	struct _LinkingContext : public _TaskContext
	{
		SOCKET s;
		DWORD dwFlags;
		ILinkSink* pLinkSink;

		std::string addr;
		int iPort;

		_LinkingContext(_TaskType t) :
			_TaskContext(t), 
			s(INVALID_SOCKET),
			dwFlags(0),
			pLinkSink(NULL),
			iPort(0)
		{
			TRACE0_L4("--construct linking context\n");
		}

		virtual ~_LinkingContext()
		{
			TRACE1_L4("--destruct linking context, s=%i\n", s);
			if(s != INVALID_SOCKET) close(s);
		}
	};

	typedef std::list<_LinkingContext*> _LinkingContextList;
	_LinkingContextList m_linkings;
	DECLARE_THREAD_SAFETY_MEMBER(linkings);

private:
	struct _AcceptedContext : public _TaskContext
	{
		SOCKET s;
		_LinkingContext* pListen;

		_AcceptedContext() : _TaskContext(TASK_ACCEPTED), s(INVALID_SOCKET){}

		virtual ~_AcceptedContext(){}
	};

private:
	struct _ConnectedContext : public _TaskContext
	{
		HRESULT result;
		_LinkingContext* pConnect;

		_ConnectedContext() : _TaskContext(TASK_CONNECTED), result(E_FAIL){}

		virtual ~_ConnectedContext(){}
	};

private:
	HRESULT OnAccept(_LinkingContext* pListen);
	HRESULT OnAccepted(_AcceptedContext* pContext);
	HRESULT OnConnect(_LinkingContext* pConnect);
	HRESULT OnConnected(_ConnectedContext* pContext);
};

#endif
