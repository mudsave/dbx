/**
 * filename : thread.h
 * desc : 关于多线程的辅助代码
 */

#ifndef __THREAD_H_
#define __THREAD_H_

/// 原子增
inline long InterlockedIncrement(long volatile* v)
{
	long src = 1;
	/* Modern 486+ processor */
	__asm__ __volatile__(
			"lock xaddl %0, %1;"
			:"=r"(src), "=m"(*v)
			:"0"(src));
	return src + 1;
}

/// 原子减
inline long InterlockedDecrement(long volatile* v)
{
	long src = -1;
	/* Modern 486+ processor */
	__asm__ __volatile__(
			"lock xaddl %0, %1;"
			:"=r"(src), "=m"(*v)
			:"0"(src));
	return src - 1;
}

/// 多线程互斥量
class Mutex
{
	public:
		Mutex(bool recursive = true)
		{
			if(recursive)
			{	
				pthread_mutexattr_t attr;
				pthread_mutexattr_init(&attr);
				pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE_NP);
				pthread_mutex_init(&m_mutex, &attr);
				pthread_mutexattr_destroy(&attr);
			}
			else
			{
				pthread_mutex_init(&m_mutex, NULL);
			}
		}
		~Mutex(){ pthread_mutex_destroy(&m_mutex); }
		void Lock(){ pthread_mutex_lock(&m_mutex); }
		void Unlock(){ pthread_mutex_unlock(&m_mutex); }

	private:
		pthread_mutex_t m_mutex;
};

/// 单线程互斥量
class FakeMutex
{
public:
	FakeMutex(bool recursive = true){}
	void Lock(){}
	void Unlock(){}
};

/// 临界区线程安全自动保护
template<class Mutex = Mutex>
class ResGuard
{
public:
	ResGuard(Mutex& mtx) : m_mtx(mtx){ m_mtx.Lock(); }
	~ResGuard(){ m_mtx.Unlock(); }
private:
	Mutex& m_mtx;
};

/// 单线程模型，自增减没有互斥处理
class SingleThread
{
public:
	static long _Increment(long* p){ return ++(*p); }
	static long _Decrement(long* p){ return --(*p); }
	typedef FakeMutex _Mutex;
};

/// 多线程模型，自增减互斥处理
class MultiThread
{
public:
	static long _Increment(long* p){ return ::InterlockedIncrement(p); }
	static long _Decrement(long* p){ return ::InterlockedDecrement(p); }
	typedef Mutex _Mutex;
};

/// 信号量
class Semaphore
{
private:
	sem_t m_sem;

public:
	Semaphore(int initCount = 0)
	{
		ASSERT_(initCount >= 0);
		int ret = sem_init(&m_sem, 0, initCount);
		VERIFY_SYS(ret == 0);
	}

	~Semaphore()
	{
		sem_destroy(&m_sem);
	}

	bool Wait(unsigned int timeOut = 0xffffffff)
	{
		int ret = 0;
		if(timeOut == 0xffffffff)
		{
			while(1)
			{
				ret = sem_wait(&m_sem);
				if(ret == 0)
				{
					return true;
				}
				ASSERT_(errno == EINTR);
			}
		}
		else
		{
			timespec ts;
			ret = clock_gettime(CLOCK_REALTIME, &ts);
			VERIFY_SYS(ret == 0);
			ts.tv_sec += timeOut / 1000;
			ts.tv_nsec += (timeOut %1000) * 1000000;
			if(ts.tv_nsec >= 1000000000)
			{
				ts.tv_sec += 1;
				ts.tv_nsec -= 1000000000;
			}
			while(1)
			{
				ret = sem_timedwait(&m_sem, &ts);
				if(ret == 0) return true;
				if(errno == EINTR) continue;
				ASSERT_(errno == ETIMEDOUT);
				return false;
			}
		}
		ASSERT_(0);
		return false;
	}

	void Post()
	{
		int ret = sem_post(&m_sem);
		VERIFY_SYS(ret == 0);
	}
};

#endif
