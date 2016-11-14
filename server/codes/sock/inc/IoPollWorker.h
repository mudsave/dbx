/**
 * filename : IoPollWorker.h
 */

#ifndef __IO_POLL_WORKER_H_
#define __IO_POLL_WORKER_H_

#include "IoWorker.h"
#include "Worker.h"
#include <sys/poll.h>

class CIoPollWorker :
	public CWorker,
	public IIoWorker
{
public:
	CIoPollWorker(void);
	virtual ~CIoPollWorker(void);
	HRESULT FinalConstruct();

/// CWorker
public:
	virtual HRESULT QueueTask(ITask* pTask, HANDLE hContext, DWORD dwFlags);
	virtual HRESULT Running();
	virtual void Clear();
	virtual DWORD WorkerProc();

/// IIoWorker
public:
	virtual HRESULT RegAsynIoTask(IIoTask* pTask, HANDLE hContext, int hIo);
	virtual HRESULT AttachIoEvents(HRESULT hIokey, DWORD dwEvts);
	virtual HRESULT DetachIoEvents(HRESULT hIokey, DWORD dwEvts);
	virtual HRESULT UnregIoTask(HRESULT hIokey);
	virtual HRESULT HasIoEvents(HRESULT hIokey, DWORD dwEvts);

private:
	int CopyFdSets(pollfd** fds, int* pfdSize);
	void DoIos(int fdTotal, pollfd* fds);
	void OnQueueExRun();

private:
	struct _IoCallback
	{
		IIoTask* pTask;
		HANDLE hContext;
		DWORD evts;
		_IoCallback(): pTask(NULL), hContext(NULL), evts(0){}
	};

	typedef std::vector<_IoCallback> _IoHandleMap;
	_IoHandleMap m_ioHandleMap;
	int m_ioCount;
	int m_pipe[2];
	bool m_bChanged;
};

#endif
