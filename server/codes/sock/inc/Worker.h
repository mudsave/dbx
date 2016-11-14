/**
 * filename : Worker.h
 */

#ifndef __WORKER_H_
#define __WORKER_H_

#include "LongWorkers.h"
#include "PriorityQueue.h"
#include <map>

const unsigned int FARME_TICK_TASK = 500;		// 每一帧，处理任务队列的时间限制
const unsigned int FARME_TICK_TIMER = 500;		// 每一帧，处理定时器队列的时间限制
const unsigned int FRAME_TICK_POLL = 500;		// 每一帧，处理poll轮询结果的时间限制
const unsigned int FRAME_TICK_EPOLL = 500;		// 每一帧，处理epoll轮询结果的时间限制

class CWorker : public IThreadsPool
{
public:
	CWorker(void);
	virtual ~CWorker(void);
	HRESULT FinalConstruct();

public:
	virtual HRESULT QueueTask(ITask* pTask, HANDLE hContext, DWORD dwFlags){ return E_NOTIMPL; }
	virtual HANDLE RegTimer(ITask* pTask, HANDLE hContext, DWORD dwFlags, unsigned int uiElapse, unsigned int uiPeriod, const char* pDebugInfo = "default debug info");
	virtual HRESULT UnregTimer(HANDLE hTimer);
	virtual HRESULT Running(){ return E_NOTIMPL; }
	virtual void Shutdown(int timeout);
	virtual void Clear();

protected:
	virtual DWORD WorkerProc(){ return 0; }
	void OnQueueRun();
	unsigned int OnTimeClick();
	HRESULT ExitWaitting();

private:
	static DWORD ThreadFunc(void* pvContext);

protected:
	DWORD m_dwWorkerId;
	std::queue<_WorkItem> m_workQueue;
	int m_refuse;
	_WorkerState m_state;
	CLongWorkers* m_pLongWorkers;

private:
	struct _TimerInfo
	{
		_TimerInfo(ITask* p, HANDLE h, DWORD dw, const char* pStr = "default timer info") : item(p, h, dw, pStr)
		{
			TRACE3_L4("--construct timerInfo, hContext=0x%x, uiPeriod=%i, debugInfo=%s\n", item.hContext, uiPeriod, pStr);
		}

		~_TimerInfo()
		{
			TRACE3_L4("--destruct timerInfo, hContext=0x%x, uiPeriod=%i, debugInfo=%s\n", item.hContext, uiPeriod, item.pDescription);
		}

		_WorkItem item;
		DWORD dwLastTime;			// 上一次调度时刻
		DWORD dwNextTime;			// 下一次调度时刻
		unsigned int uiPeriod;		// 触发周期
		unsigned int sn;			// 定时器ID

		struct _Less
		{
			bool operator()(const _TimerInfo* l, const _TimerInfo* r) const
			{
				// 如果两者都在同一个时间轮回，大者愈小
				if( ( l->dwNextTime >= l->dwLastTime && r->dwNextTime >= r->dwLastTime ) ||
					( l->dwNextTime < l->dwLastTime && r->dwNextTime < r->dwLastTime ) )
				{
					return ( l->dwNextTime > r->dwNextTime ) || 
						( l->dwNextTime == r->dwNextTime && l->sn > r->sn );
				}

				if(l->dwNextTime < l->dwLastTime)
					return ( r->dwNextTime >= 0x80000000 ) ? true : ( l->dwNextTime > r->dwNextTime );
				else
					return ( l->dwNextTime >= 0x80000000 ) ? false : ( l->dwNextTime > r->dwNextTime );
			}
		};
	};

private:
	typedef PriorityQueue<_TimerInfo*, _TimerInfo::_Less> _PriQueue;
	_PriQueue m_timerQueue;					// 定时器队列
	int m_timerCount;						// 已经注册的定时器数目
	unsigned int m_sn;						// 用于定时器ID的累加值
	std::map<_TimerInfo*, bool> m_timerMap;	// 用于调试

private:
	unsigned long m_dwShutdown;
	unsigned long m_exitTimeout;
};

#endif
