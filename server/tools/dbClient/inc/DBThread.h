#pragma once

class CThread :public ITask
{
private:
	Semaphore m_semaphore;
public:
	static void  doFunciton(void* pThis)
	{
		try
		{
			
			((CThread*)pThis)->doFunciton();
		}
		catch (...) 
		{
		}
	}

	HRESULT Do(HANDLE hContext)
	{
		doFunciton();
		return S_OK;
	}

	CThread():m_semaphore(0){}

	~CThread(){}

	void createThread(void)
	{
		try
		{
			_doContext* pLinkContext=new _doContext(NULL,0,eThread);
			::GlobalThreadsPool(CLS_THREADS_POLL)->QueueTask(this,pLinkContext, TASK_LONG_TIME);

		}
		catch (...) 
		{
		}
	}
	void destroyThread(void)
	{
		
	}
	virtual void doFunciton( void) 
	{
	}
	Semaphore* getSemaphore()
	{
		return &m_semaphore;
	}
};


