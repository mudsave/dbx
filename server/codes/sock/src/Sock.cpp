/**
 * filename : Sock.cpp
 *
 * desc : 服务器正常退出，还要考虑将所有玩家踢下线，以及不允许新玩家登陆
 *
 */

#include "lindef.h"
#include "Sock.h"
#include "TcpPort.h"
#include "TcpCtrl.h"
#include "IoPollWorker.h"

struct _Module
{
	int clsid;
	IThreadsPool* pThreadsPool;
	CLongWorkers* pLongWorkers;
	Fun_Cleanup cleanup_callback;

	_Module() : clsid(0), pThreadsPool(NULL), pLongWorkers(NULL), cleanup_callback(NULL)
	{
		TRACE0_L0("--libSock.so, version 30\n");
	}

	~_Module()
	{
		TRACE0_L0("--destruct _Module, to delete pThreadsPoll, pLongWorkers\n");
		if (pThreadsPool)
		{
			if ( clsid == CLS_THREADS_POLL )
				delete (CIoPollWorker*)pThreadsPool;
			else if ( clsid == CLS_THREADS_EPOLL)
				TRACE0_L0("--destruct CIoEPollWorker, not impl\n");
			else
				ASSERT_(0);
		}
		
		if (pLongWorkers) delete pLongWorkers;
	}
} g_module;

class Shutdown_Task : public ITask
{
public:
	virtual HRESULT Do(HANDLE hContext)
	{
		TRACE0_L0("--do the Shutdwon task..\n");

		if ( g_module.cleanup_callback )
		{
			g_module.cleanup_callback();
		}
		else
		{
			IThreadsPool* pThreads = (IThreadsPool*)hContext;
			pThreads->Shutdown();
		}

		return S_OK;
	}
};

static Shutdown_Task task;

extern "C" IThreadsPool* GlobalThreadsPool(int clsid)
{
	if ( !g_module.pThreadsPool )
	{
		if ( clsid == CLS_THREADS_POLL )
		{
			CIoPollWorker* pWorker = new CIoPollWorker();
			pWorker->FinalConstruct();
			g_module.pThreadsPool = pWorker; 
			g_module.clsid = clsid;
		}
		else if ( clsid == CLS_THREADS_EPOLL )
		{
			//CIoPollWorker* pWorker = new CIoEPollWorker();
			//pWorker->FinalConstruct();
			//g_module.pThreadsPool = pWorker; 
			//g_module.clsid = clsid;
			TRACE1_L0("--GlobalThreadsPool clsid = %d is not supported", clsid); 
		}
		else
		{
			TRACE1_L0("--GlobalThreadsPool error clsid:%d", clsid); 
		}
	}

	return g_module.pThreadsPool;
}

extern "C" void GenerateWorker(ITask* pTask, HANDLE hContext)
{
    if ( !g_module.pLongWorkers )
        g_module.pLongWorkers = new CLongWorkers();
    if ( g_module.pLongWorkers )
        g_module.pLongWorkers->CreateWorker(_WorkItem(pTask, hContext, NULL));
}

extern "C" ILinkCtrl* CreateLinkCtrl()
{
	CTcpCtrl* pLinkCtrl = new CTcpCtrl(); 
	return pLinkCtrl;
}

extern "C" bool SetRecvBufLevel(int level)
{
	return CTcpPort::SetRecvBufLevel(level);
}

extern "C" void SetCleanup(Fun_Cleanup pf)
{
	g_module.cleanup_callback = pf;
}

static void* signal_proc(void* arg)
{
	pthread_detach(pthread_self());
	pid_t tid = gettid();
	TRACE1_L0("--signal thread is running, tid = %i\n",tid);

	sigset_t mask;
	sigemptyset(&mask);
	sigaddset(&mask, SIGUSR1);
	sigaddset(&mask, SIGUSR2);
	sigaddset(&mask, SIGQUIT);
	sigaddset(&mask, SIGTERM);
	pthread_sigmask(SIG_SETMASK, &mask, NULL);

	bool isRunning = true;
	IThreadsPool* pThreads = GlobalThreadsPool();

	int err, signo;
	while(isRunning)
	{
		err = sigwait(&mask, &signo);
		if ( err != 0 )
		{
			TRACE2_L0("--sigwait error, errno = %d, errstr = %s\n", err, strerror(errno));
			ASSERT_(0);
		}

		switch (signo)
		{
			case SIGUSR1:
				{
					TRACE1_L0("--signal_proc() recv SIGUSR1, signo = %d\n", signo);
				}
			case SIGUSR2:
				{
					TRACE1_L0("--signal_proc() recv SIGUSR2, signo = %d\n", signo);
				}
				break;
			case SIGQUIT:
				{
					TRACE1_L0("--signal_proc() recv SIGQUIT, signo = %d\n", signo);
					pThreads->QueueTask(&task, pThreads, TASK_LAST_TASK);
					isRunning = false;
				}
				break;
			case SIGTERM:
				{
					TRACE1_L0("--signal_proc() recv SIGTERM, signo = %d\n", signo);
					pThreads->QueueTask(&task, pThreads, TASK_LAST_TASK);
					isRunning = false;
				}
				break;
			default:
				{
					TRACE1_L0("--signal thread recv error signal, signo = %d\n", signo);
				}
				break;
		}
	}

	TRACE1_L0("--signal thread is stopped, tid = %i\n", tid); 

	return NULL;
}

/**
static void sig_usr(int signo)
{
	pid_t tid = gettid(); 
	TRACE2_L2("--sig_usr() recv a signal(%i) in thread %i\n", signo, tid);
}
*/

extern "C" void GenerateSignalThread()
{
	//signal(SIGINT, sig_usr);	

	sigset_t block_set;
	sigfillset(&block_set);
	pthread_sigmask(SIG_BLOCK, &block_set, NULL);

	pthread_t thread_id;
	pthread_create(&thread_id, NULL, signal_proc, 0);
	pthread_detach(thread_id);

	TRACE0_L0("--GenerateSignalThread()\n");
}
