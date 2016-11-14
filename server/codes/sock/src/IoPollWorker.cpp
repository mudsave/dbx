/**
 * filename : IoPollWorker.cpp
 */

#include "lindef.h"
#include "Sock.h"
#include "TcpPort.h"
#include "IoPollWorker.h"

CIoPollWorker::CIoPollWorker(void)
{
	m_bChanged = false;
	m_ioHandleMap.reserve(2048);
	m_ioCount = 0;
}

CIoPollWorker::~CIoPollWorker(void)
{
	TRACE0_L1("--destruct CIoPollWorker!\n");
}

HRESULT CIoPollWorker::FinalConstruct()
{
	if (pipe(m_pipe) != 0) return E_FAIL;

	if (!SetFileOpt(m_pipe[0], O_NONBLOCK)) return E_FAIL;
	if (!SetFileOpt(m_pipe[1], O_NONBLOCK)) return E_FAIL;

	if (m_ioHandleMap.size() <= (unsigned int)m_pipe[0]) m_ioHandleMap.resize(m_pipe[0] + 1);

	m_ioHandleMap[m_pipe[0]].evts = POLLIN;
	m_bChanged = true;

	return S_OK;
}

HRESULT CIoPollWorker::Running()
{
	if(m_state == WORKER_INIT)
	{
		m_state = WORKER_RUNNING;
		m_dwWorkerId = GetCurrentThreadId();
		TRACE1_L2("--CIoPollWorker::Running(), the thread id = %i\n", m_dwWorkerId);
		DWORD ret = WorkerProc();
		return ret;
	}
	return E_FAIL;
}

void CIoPollWorker::Clear()
{
	close(m_pipe[1]);
	close(m_pipe[0]);

	int n = 0;
	for ( size_t index = 0; index < m_ioHandleMap.size(); ++index )
	{
		IIoTask* pTask = m_ioHandleMap[index].pTask;
		if ( pTask )
		{
			n++;
			CTcpPort* p = dynamic_cast<CTcpPort*>(pTask);
			ASSERT_(p);
			p->Release();
		}
	}
	TRACE1_L2("--CIoPollWorker::Clear(), there is %i ports no release\n", n);
	
	CWorker::Clear();
}

struct _PollItem
{
	_WorkItem item;
	_PollItem(ITask* p, HANDLE h, DWORD dw): item(p, h, dw){}
};

HRESULT CIoPollWorker::QueueTask(ITask* pTask, HANDLE hContext, DWORD dwFlags)
{
	if(m_refuse < 2) return E_FAIL;

	if(GetCurrentThreadId() == m_dwWorkerId)
	{
		m_workQueue.push(_WorkItem(pTask, hContext, dwFlags));
	}
	else
	{
		_PollItem* pNew = new _PollItem(pTask, hContext, dwFlags);
		if(write(m_pipe[1], &pNew, sizeof(pNew)) != sizeof(pNew))
		{
			char strBuf[256];
			LAST_ERROR_INFO(strBuf);
			TRACE1_L0("--CIoPollWorker::QueueTask(), write pipe failed, %s\n", strBuf);
			return E_FAIL;
		}
	}
	return S_OK;
}

HRESULT CIoPollWorker::RegAsynIoTask(IIoTask* pTask, HANDLE hContext, int hIo)
{
	TRACE3_L3("--CIoPollWorker::RegAsynIoTask(), fd=%i, context=%i, count=%i\n", hIo, hContext, m_ioCount);
	if(m_ioHandleMap.size() <= (unsigned int)hIo) m_ioHandleMap.resize(hIo + 1); ASSERT_(!m_ioHandleMap[hIo].pTask);
	m_ioHandleMap[hIo].pTask = pTask;
	m_ioHandleMap[hIo].hContext = hContext;
	m_ioCount++;
	return hIo;
}

HRESULT CIoPollWorker::AttachIoEvents(HRESULT hIokey, DWORD dwEvts)
{
	ASSERT_(m_ioHandleMap[hIokey].pTask);

	DWORD evts = m_ioHandleMap[hIokey].evts;

	if ( (dwEvts & ASYN_IO_READ) && !(evts & POLLIN) )
	{
		m_ioHandleMap[hIokey].evts |= POLLIN;
		m_bChanged = true;
	}

	if ( dwEvts & ASYN_IO_WRITE && !(evts & POLLOUT) )
	{
		m_ioHandleMap[hIokey].evts |= POLLOUT;
		m_bChanged = true;
	}

	TRACE3_L4("--CIoPollWorker::AttachIoEvents(), set fd=%i, evts=%x, changed=%d\n", hIokey, dwEvts, m_bChanged);

	return m_bChanged ? S_OK : S_FALSE;
}

HRESULT CIoPollWorker::DetachIoEvents(HRESULT hIokey, DWORD dwEvts)
{
	ASSERT_(m_ioHandleMap[hIokey].pTask);

	DWORD evts = m_ioHandleMap[hIokey].evts;

	if ( (dwEvts & ASYN_IO_READ) && (evts & POLLIN) )
	{
		m_ioHandleMap[hIokey].evts &= ~POLLIN;
		m_bChanged = true;
	}

	if ( dwEvts & ASYN_IO_WRITE && (evts & POLLOUT) )
	{
		m_ioHandleMap[hIokey].evts &= ~POLLOUT;
		m_bChanged = true;
	}

	TRACE3_L4("--CIoPollWorker::DetachIoEvents(), set fd=%i, evts=%x, changed=%d\n", hIokey, dwEvts, m_bChanged);

	return m_bChanged ? S_OK : S_FALSE;
}

HRESULT CIoPollWorker::UnregIoTask(HRESULT hIokey)
{
	TRACE2_L3("--CIoPollWorker::UnregIoTask(), unreg io poll task, fd=%i, count=%i\n", hIokey, m_ioCount);

	ASSERT_(m_ioHandleMap[hIokey].pTask);

	m_ioHandleMap[hIokey].pTask = NULL;
	m_ioHandleMap[hIokey].hContext = NULL;
	m_ioHandleMap[hIokey].evts = 0;
	m_ioCount--;

	m_bChanged = true;

	return S_OK;
}

HRESULT CIoPollWorker::HasIoEvents(HRESULT hIokey, DWORD dwEvts)
{
	ASSERT_(m_ioHandleMap[hIokey].pTask);

	DWORD evts = 0;

	if ( dwEvts & ASYN_IO_READ )
		evts = evts | POLLIN;

	if ( dwEvts & ASYN_IO_WRITE )
		evts = evts | POLLOUT;

	return ( m_ioHandleMap[hIokey].evts & evts );
}

DWORD CIoPollWorker::WorkerProc()
{
	TRACE1_L1("--CIoPollWorker::WorkerProc(), poll worker thread startup, id=%i\n", GetCurrentThreadId());

	HRESULT retCode = S_OK;

	int fdSize = 2048;
	pollfd* pfds = new pollfd[fdSize];

	int ret;			// 轮询成功的fd数目
	int n = 0;			// 参与轮询的fd数目
	while(m_state == WORKER_RUNNING || m_state == WORKER_CLOSING)
	{
        if(m_state == WORKER_RUNNING)
        {
			DWORD bt = GetTickCount();

	        int idx = CopyFdSets(&pfds, &fdSize);
	        if(idx >= 0) n = idx + 1;

	        ret = poll(pfds, n, 10);

	        if(ret == SOCKET_ERROR && GetLastError() == EINTR)
	        {
		        ret = 0;
	        }

			// 确保不会出现SOCKET_ERROR，如果出现一定要查找出原因
	        VERIFY_SYS(ret != SOCKET_ERROR);

	        if(ret > 0)
	        {
				if(pfds[0].revents & POLLIN)
				{
					OnQueueExRun();
					ret--;
				}
				
				if(ret > 0)
				{
					DoIos(n, pfds);
				}
	        }

			DWORD span = GetTickCount() - bt;
			if(span > FRAME_TICK_POLL)
			{
				TRACE1_L0("--CIoPollWorker::WorkerProc(), handling network(poll) for a rather long time: %dms in a frame\n", span);
			}

	        OnQueueRun();

	        OnTimeClick();
        }

	    if(m_state == WORKER_CLOSING)
	    {
			retCode = ExitWaitting();
		    if ( SUCCEEDED( retCode ) )
		    {
			    m_state = WORKER_CLOSED;
		    }
	    }
	}

	delete[] pfds;

	TRACE1_L1("--CIoPollWorker::WorkerProc(), poll worker thread exit, id=%i\n", GetCurrentThreadId());

	return retCode;
}

void CIoPollWorker::OnQueueExRun()
{
	_PollItem* pItem = NULL;
	while(1)
	{
		int sz = read(m_pipe[0], &pItem, sizeof(pItem));

		if(sz == 0)
		{
			TRACE0_L0("--CIoPollWorker::OnQueueExRun() read eof, but is impossible\n");
			break;
		}

		if(sz == -1 && GetLastError() == EAGAIN)
		{
			TRACE0_L4("--CIoPollWorker::OnQueueExRun() read EAGAIN\n");
			break;
		}

		if(sz == -1 && GetLastError() == EINTR)
		{
			TRACE0_L4("CIoPollWorker::OnQueueExRun() read EINTR\n");
			break;
		}

		if(sz == -1)
		{
			VERIFY_SYS(0);
		}

		VERIFY_SYS(sz == sizeof(pItem));

		if(m_refuse == 2)
		{
			if(pItem->item.dwTrait & TASK_LONG_TIME)
			{
				m_pLongWorkers->CreateWorker(pItem->item);
			}
			else
			{
				m_workQueue.push(pItem->item);
			}
		}

		delete pItem;
	}
}

void CIoPollWorker::DoIos(int fdTotal, pollfd* fds)
{
	int j = random() % fdTotal + 1;
	for(int i = 1; i < fdTotal; i++, j++)
	{
		if(j == fdTotal)
		{
			j = 1;
		}

		ASSERT_(j > 0 && j < fdTotal);

		int fd = fds[j].fd;
		int what = fds[j].revents;

		if(!what)
		{
			continue;
		}

		if(what & (POLLHUP | POLLERR))
		{
			what |= POLLIN;
		}

		if(what & POLLIN)
		{
			ASSERT_(m_ioHandleMap[fd].pTask);
			m_ioHandleMap[fd].pTask->DoIo(m_ioHandleMap[fd].hContext, ASYN_IO_READ);
		}

		if(what & POLLOUT)
		{
			ASSERT_(m_ioHandleMap[fd].pTask);
			m_ioHandleMap[fd].pTask->DoIo(m_ioHandleMap[fd].hContext, ASYN_IO_WRITE);
		}
	}
}

int CIoPollWorker::CopyFdSets(pollfd** fds, int* pfdSize)
{
	if((unsigned int)(*pfdSize) < m_ioHandleMap.size())
	{
		delete *fds;
		unsigned int i = m_ioHandleMap.size() * 2;
		*pfdSize = i;
		*fds = new pollfd[i];
		m_bChanged = true;
	}

	int idx = -1;
	if(m_bChanged)
	{
		for(unsigned int i = 0; i < m_ioHandleMap.size(); i++)
		{
			if(m_ioHandleMap[i].evts)
			{
				idx++;
				(*fds)[idx].fd = i;
				(*fds)[idx].events = m_ioHandleMap[i].evts;
			}
		}
		m_bChanged = false;
	}

	return idx;
}
