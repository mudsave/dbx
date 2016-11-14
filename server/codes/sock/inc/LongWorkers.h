/**
 * filename : LongWorkers.h
 */

#ifndef __LONG_WORKERS_H_
#define __LONG_WORKERS_H_

#include <list>

struct _WorkItem
{
	HANDLE hContext;
	DWORD dwTrait;
	ITask* pTask;
	const char* pDescription;

	_WorkItem() : pDescription(NULL) {}
	_WorkItem(ITask* p, HANDLE h, DWORD dw, const char* desc = "default work item") : hContext(h), dwTrait(dw), pTask(p), pDescription(desc) {}
	_WorkItem(const _WorkItem& src){ Copy(src); }
	_WorkItem& operator=(const _WorkItem& src){ if(&src != this) Copy(src); return *this; }
	~_WorkItem(){}
	void Do()
	{
		pTask->Do(hContext);
	}

private:
	void Copy(const _WorkItem& src)
	{
		pTask = src.pTask;
		hContext = src.hContext;
		dwTrait = src.dwTrait;
		pDescription = src.pDescription;
	}
};

class CLongWorkers
{
public:
	CLongWorkers(void);
	~CLongWorkers(void);

public:
	static void cleanup(void* arg);

public:
	void CreateWorker(const _WorkItem& item);
	HRESULT Shutdown();
	HRESULT Status();

private:
	static DWORD LongWorkerProc(void* pvContext);

private:
	struct _LongWorkerContext
	{
		CLongWorkers* pThis;
		_WorkItem item;
		pthread_t tid;
		_LongWorkerContext(CLongWorkers* p, const _WorkItem& it): pThis(p), item(it){}
	};

	typedef std::list<_LongWorkerContext*> _LongWorkers;
	_LongWorkers m_longWorkers;

	DECLARE_THREAD_SAFETY_MEMBER(longWorkers);
};

#endif
