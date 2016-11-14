/**
 * filename : CWorker.cpp
 */

#include "lindef.h"
#include "Sock.h"
#include "Worker.h"

CWorker::CWorker(void)
{
	m_dwWorkerId = INVALID_THREAD_ID;
	m_refuse = 2;
	m_state = WORKER_INIT;
	m_pLongWorkers = new CLongWorkers;

	m_timerCount = 0;
	m_sn = 0;

	m_dwShutdown = 0;
	m_exitTimeout = 0;
}

CWorker::~CWorker(void)
{
	TRACE0_L1("--destruct CWorker, to delete m_pLongWorkers\n");
	delete m_pLongWorkers;
}

HRESULT CWorker::FinalConstruct()
{
	ASSERT_(m_dwWorkerId == INVALID_THREAD_ID);

	pthread_t tid;
	pthread_attr_t attr;
	pthread_attr_init(&attr);
	pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);
	pthread_attr_setdetachstate(&attr,PTHREAD_CREATE_DETACHED);
	int ret = BEGIN_THREAD(&tid, &attr, ThreadFunc, this);
	pthread_attr_destroy(&attr);

	if(ret != 0) return E_FAIL;
	return S_OK;
}

HANDLE CWorker::RegTimer(ITask* pTask, HANDLE hContext, DWORD dwFlags, unsigned int uiElapse, unsigned int uiPeriod, const char* pDebugInfo)
{
	if(m_state == WORKER_CLOSING || m_state == WORKER_CLOSED)
	{
		TRACE0_L4("--CWorker::RegTimer(), does not accept timer registration while closing or closed.\n");
		return NULL;
	}

	ASSERT_(pTask);

	_TimerInfo* pTimer = new _TimerInfo(pTask, hContext, dwFlags, pDebugInfo);
	pTimer->dwLastTime = GetTickCount();
	pTimer->dwNextTime = pTimer->dwLastTime + uiElapse;
	pTimer->uiPeriod = uiPeriod;
	pTimer->sn = m_sn++;
	m_timerQueue.push(pTimer);
	m_timerCount++;

	m_timerMap.insert( std::map<_TimerInfo*, bool>::value_type(pTimer, true) );

	TRACE5_L0("--CWorker::RegTimer(), handle=0x%x, hContext=0x%x, elapse=%i, period=%i, count=%i\n", (HANDLE)(pTimer), hContext, uiElapse, uiPeriod, m_timerCount);
	TRACE2_L0("\tTimer Info: pTask = 0x%x, debugStr = %s\n", pTask, pDebugInfo);

	return (HANDLE)pTimer;
}

HRESULT CWorker::UnregTimer(HANDLE hTimer)
{
	std::map<_TimerInfo*, bool>::iterator ret = m_timerMap.find((_TimerInfo*)hTimer);
	if ( ret == m_timerMap.end() )
	{
		TRACE1_L0("--CWorker::UnregTimer() error, no find the timer, handle = 0x%x\n", hTimer);
		return E_FAIL;
	}

	m_timerMap.erase(ret);

	_TimerInfo* pTimer = (_TimerInfo*)hTimer;
	if(pTimer->item.pTask && m_timerCount > 0)
	{
		pTimer->item.pTask = NULL;
		m_timerCount--;
		TRACE3_L0("--CWorker::UnregTimer() ok, handle = 0x%x, hContext=0x%x, count=%i\n", hTimer, pTimer->item.hContext, m_timerCount);
		TRACE1_L0("\tTimer Info: debugStr = %s\n", pTimer->item.pDescription);
		return S_OK;
	}
	else
	{
		TRACE3_L0("--CWorker::UnregTimer() error, handle = 0x%x, hContext=0x%x, count=%i\n", hTimer, pTimer->item.hContext, m_timerCount);
		TRACE1_L0("\tTimer Info: debugStr = %s\n", pTimer->item.pDescription);
		return E_FAIL;
	}
}

void CWorker::Shutdown(int timeout)
{
	TRACE1_L0("--CWorker::shutdown(), timeout=%i...\n", timeout);

	ASSERT_(m_state == WORKER_RUNNING);

	m_dwShutdown = (unsigned long)GetTickCount();
	m_exitTimeout = (unsigned long)timeout;

	m_pLongWorkers->Shutdown();

	if(m_state == WORKER_RUNNING)
	{
		m_state = WORKER_CLOSING;
	}
}

void CWorker::Clear()
{
	int m = 0;
	int n = m_timerQueue.size();

	_TimerInfo* p = NULL;
	while(!m_timerQueue.empty())
	{
		p = m_timerQueue.top();
		if(!p->item.pTask) m++;
		delete p;
		m_timerQueue.pop();
	}
	TRACE3_L2("--CWorker::Clear(), timerQueue size = %i, timer count = %i, released timer = %i\n", n, m_timerCount, m);

	n = m_workQueue.size();
	while(!m_workQueue.empty()) m_workQueue.pop();
	TRACE1_L2("--CWorker::Clear(), work item count = %i\n", n);
}

void CWorker::OnQueueRun()
{
	DWORD bt = GetTickCount();
	int count = 0;
	while(!m_workQueue.empty())
	{
		if(m_workQueue.front().dwTrait & TASK_LAST_TASK)
		{
			if(m_workQueue.size() > 1)
			{
				m_workQueue.push(m_workQueue.front());
				m_workQueue.pop();
				m_refuse = 1;
				continue;
			}
			else
			{
				m_refuse = 0;
			}
		}

		if(m_workQueue.front().dwTrait & TASK_LONG_TIME)
		{
			m_pLongWorkers->CreateWorker(m_workQueue.front());
		}
		else
		{
			m_workQueue.front().Do();
		}

		m_workQueue.pop();
		count++;
	}

	DWORD span = GetTickCount() - bt;
	if(span > FARME_TICK_TASK)
	{
		TRACE2_L0("--CWorker::OnQueueRun(), handling %d tasks for a rather long time: %dms in a task frame\n",count, span);
	}
}

unsigned int CWorker::OnTimeClick()
{
	DWORD bt = GetTickCount();
	int count = 0;

	_TimerInfo* p = NULL;
	while(!m_timerQueue.empty())
	{
		p = m_timerQueue.top();
		if(!p->item.pTask)
		{
			delete p;
			m_timerQueue.pop();
			TRACE1_L4("--CWorker::OnTimeClick(), canceled, queue size=%i\n", m_timerQueue.size());
			continue;
		}

		DWORD dwCurrent = GetTickCount();
		DWORD dwSpan = p->dwNextTime - p->dwLastTime;
		DWORD dwElapse = dwCurrent - p->dwLastTime;
		if(dwSpan > dwElapse)
		{
			break;
		}

		if(p->uiPeriod > 0)
		{
			p->dwLastTime = dwCurrent;
			p->dwNextTime = dwCurrent + p->uiPeriod;
			m_timerQueue.AdjustTop();
		}

		if(p->item.dwTrait & TASK_LONG_TIME)
		{
			m_pLongWorkers->CreateWorker(p->item);
		}
		else
		{
			p->item.Do();
		}

		count++;

		if(p->uiPeriod <= 0)
		{
			delete p;
			m_timerQueue.pop();
			m_timerCount--;
			TRACE1_L2("--CWorker::OnTimeClick(), remove once timer, count=%i\n", m_timerCount);
		}
	}

	DWORD span = GetTickCount() - bt;
	if(span > FARME_TICK_TIMER)
	{
		TRACE2_L0("--CWorker::OnTimeClick(), handling %d timers for a rather long time in a timer frame: %dms\n",count, span);
	}
	
	return span;
}

HRESULT CWorker::ExitWaitting()
{
	unsigned long cur = GetTickCount();
	if ( m_pLongWorkers->Status() == S_OK )
	{
		TRACE0_L2("--CWorker::ExitWaitting() is ok\n");
		TRACE4_L2("\tellapse = %lu, m_exitTimeout = %lu, cur = %lu, shut = %lu\n", cur - m_dwShutdown, m_exitTimeout, cur, m_dwShutdown);
		return S_OK;
	}

	if ( cur - m_dwShutdown > m_exitTimeout )
	{
		TRACE0_L2("--CWorker::ExitWaitting() is timeout\n");
		TRACE4_L2("\tellapse = %lu, m_exitTimeout = %lu, cur = %lu, shut = %lu\n", cur - m_dwShutdown, m_exitTimeout, cur, m_dwShutdown);
		return S_FALSE;
	}
	return E_FAIL;
}

DWORD CWorker::ThreadFunc(void* pvContext)
{
	DWORD dwThreadId = GetCurrentThreadId();

	CWorker* pThis = reinterpret_cast<CWorker*>(pvContext);
	pThis->m_dwWorkerId = dwThreadId;

	TRACE2_L2("--ThreadFunc(), worker thread startup, id=%i, context=%x\n", dwThreadId, pvContext);
	pThis->WorkerProc();
	TRACE2_L2("--ThreadFunc(), worker thread exit, id=%i, context=%x\n", dwThreadId, pvContext);

	pThis->m_dwWorkerId = INVALID_THREAD_ID;
	return 0;
}
