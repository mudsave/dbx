/**
 * filename : LongWorkers.cpp
 */

#include "lindef.h"
#include "Sock.h"
#include "LongWorkers.h"

CLongWorkers::CLongWorkers(void)
{
}

CLongWorkers::~CLongWorkers(void)
{
	TRACE0_L2("--destruct CLongWorkers\n");
}

void CLongWorkers::cleanup(void* arg)
{
	pid_t tid = GetCurrentThreadId();
	TRACE1_L2("--pthread_cancel is ok, to cleanup in thread %i\n", tid);

	_LongWorkerContext* pContext = reinterpret_cast<_LongWorkerContext*>(arg);

	ENTER_CRITICAL_SECTION_MEMBER_STATIC(pContext->pThis, longWorkers);
	for(_LongWorkers::iterator it = pContext->pThis->m_longWorkers.begin(); it != pContext->pThis->m_longWorkers.end(); it++)
	{
		if( (*it) == pContext )
		{
			pContext->pThis->m_longWorkers.erase(it);
			delete pContext;
			return;
		}
	}
	ASSERT_(0);
	LEAVE_CRITICAL_SECTION_MEMBER;

	return;
}

HRESULT CLongWorkers::Status()
{
	ENTER_CRITICAL_SECTION_MEMBER(longWorkers);

	if ( m_longWorkers.empty() )
	{
		return S_OK;
	}

	return S_FALSE;

	LEAVE_CRITICAL_SECTION_MEMBER;
}

void CLongWorkers::CreateWorker(const _WorkItem& item)
{
	_LongWorkerContext* pContext = new _LongWorkerContext(this, item);

	ENTER_CRITICAL_SECTION_MEMBER(longWorkers);

	pthread_attr_t attr;
	pthread_attr_init(&attr);
	pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
	pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_DETACHED);

	pthread_t dwThreadId;
	int ret = BEGIN_THREAD(&dwThreadId, &attr, LongWorkerProc, pContext);
	VERIFY_SYS(ret == 0);

	pthread_attr_destroy(&attr);

	pContext->tid = dwThreadId;
	m_longWorkers.push_back(pContext);

	LEAVE_CRITICAL_SECTION_MEMBER;
}

DWORD CLongWorkers::LongWorkerProc(void* pvContext)
{
	_LongWorkerContext* pContext = reinterpret_cast<_LongWorkerContext*>(pvContext);

	TRACE1_L1("--LongWorkerProc(), long worker thread startup, id=%i\n", GetCurrentThreadId());

	pthread_cleanup_push(cleanup, pvContext);
	pContext->item.Do();
	pthread_cleanup_pop(0);

	TRACE1_L1("--LongWorkerProc(), long worker thread exit, id=%i\n", GetCurrentThreadId());

	ENTER_CRITICAL_SECTION_MEMBER_STATIC(pContext->pThis, longWorkers);

	for(_LongWorkers::iterator it = pContext->pThis->m_longWorkers.begin(); it != pContext->pThis->m_longWorkers.end(); it++)
	{
		if( (*it) == pContext )
		{
			pContext->pThis->m_longWorkers.erase(it);
			delete pContext;
			return 0;
		}
	}
	ASSERT_(0);

	LEAVE_CRITICAL_SECTION_MEMBER;

	return 1;
}

HRESULT CLongWorkers::Shutdown()
{
	ENTER_CRITICAL_SECTION_MEMBER(longWorkers);

	if ( m_longWorkers.empty() )
	{
		return S_OK;
	}

	for(_LongWorkers::iterator it = m_longWorkers.begin(); it != m_longWorkers.end(); it++)
	{
		_LongWorkerContext* pContext = *it;
		int ret = pthread_cancel(pContext->tid);
		if (ret)
		{
			TRACE0_L2("--thread cancel failed\n");
			TRACE4_L2("pTask=0x%x, hContext=0x%x, flags=0x%x, description: %s\n", pContext->item.pTask, pContext->item.hContext, pContext->item.dwTrait, pContext->item.pDescription);
		}

		ASSERT_(ret == 0);
	}

	return S_FALSE;

	LEAVE_CRITICAL_SECTION_MEMBER;
}
