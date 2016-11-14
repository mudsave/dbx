/**
 * filename : HandleMgr.h
 */

#ifndef __HANDLEMGR_H__
#define __HANDLEMGR_H__

/** 
 工作原理：句柄的原理有点类似于小内存分配的原理，首先他分配一定数量的句柄系
 列供使用（这个序列一旦用完，会重新realloc），并充分利用空闲的用户数据域，给
 他们初始化成链表关系，这样就几乎不存在遍历整个数组来查找空闲的句柄节点，系
 统总是记录一个当前空闲的节点索引（当一个句柄关闭后，他就是当前的空闲节点的索
 引），而每个空闲节点总是指向下一个空闲节点，所以基于这种思路，句柄的创建和关
 闭操作是非常快的，时间复杂度为O(1)。再看看句柄的有效性问题，前面讲到，每个句
 柄都包含有创建次数（Create Count），当一个空闲句柄第一次创建时，Count=1，这
 时，如果关闭该句柄，Count还是等于1，当下一个句柄创建请求过来，那么Count就递
 增为2，每个句柄域里面的Count自从初始化后就会一直递增，当递增到最大值后在下次
 创建时，会将Count进行回绕。
 */

// handle的各部分信息描述
//   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
//   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
//  +------------------------+--------------------------------------+
//  |      Create Count      |                Index                 |
//  +------------------------+--------------------------------------+

typedef unsigned int handle;

/// 缺省为多线程不安全
/// #define handleLock ResGuard res(m_mtx);
#define handleLock

/// 现有句柄使用完毕后的增长增量
#define GROW_COUNT				512							

#define HANDLE_MASK_COUNT		0xFFF00000
#define HANDLE_SHIFT_COUNT		20
#define HANDLE_MASK_INDEX		0x000FFFFF
#define HANDLE_SHIFT_INDEX		0

#define countFromHandle(h)		(DWORD)(((DWORD)(h) & HANDLE_MASK_COUNT) >> HANDLE_SHIFT_COUNT)
#define indexFromHandle(h)		(DWORD)(((DWORD)(h) & HANDLE_MASK_INDEX))

#define handleFromCount(h)		(((DWORD)(h)) << HANDLE_SHIFT_COUNT)
#define handleFromIndex(h)		(((DWORD)(h)))

class HandleMgr
{
public:
	HandleMgr(): m_aHandleEntry(NULL), m_handlesAllocated(0), m_firstFree(1) {}
	~HandleMgr(){ clear(); }

public:
	void clear()
	{
		handleLock;

		if(m_aHandleEntry)
		{
			delete[] m_aHandleEntry;
			m_aHandleEntry = NULL;
			m_firstFree = 1;
			m_handlesAllocated = 0;
		}
	}

public:
	handle createHandle(const void* userData)
	{
		handleLock;

		handle h;
		unsigned int i;
		long long nextFree;
		PHandleEntry phe = NULL;

		if(m_firstFree >= m_handlesAllocated)
		{
			if(m_handlesAllocated == 0)
			{
				m_aHandleEntry = (PHandleEntry)new char[sizeof(HandleEntry) * GROW_COUNT];
				ASSERT_(m_aHandleEntry);
			}
			else
			{
				PHandleEntry newHandleEntry = (PHandleEntry)new char[sizeof(HandleEntry) * (m_handlesAllocated + GROW_COUNT)];
				ASSERT_(m_aHandleEntry);
				memcpy(newHandleEntry, m_aHandleEntry, sizeof(HandleEntry) * m_handlesAllocated);
				delete[] m_aHandleEntry;
				m_aHandleEntry = newHandleEntry;
			}

			i = m_handlesAllocated;
			m_handlesAllocated += GROW_COUNT;
			phe = &m_aHandleEntry[i];
			while (i < m_handlesAllocated)
			{
				phe->h = 0;
				phe->userData = (void*)(++i); // 下一个空闲索引
				phe++;
			}
		}

		int nextCreateCount = countFromHandle(m_aHandleEntry[m_firstFree].h);
		nextCreateCount++;
		h = m_aHandleEntry[m_firstFree].h = (handle)( handleFromCount(nextCreateCount) | handleFromIndex(m_firstFree) );
		nextFree = (long long)m_aHandleEntry[m_firstFree].userData;
		m_aHandleEntry[m_firstFree].userData = (void*)userData;
		m_firstFree = nextFree;

		return h;
	}

	bool closeHandle(handle h)
	{
		handleLock;

		if(!_isValidHandle(h)) return false;
		register int i;
		i = indexFromHandle(h);
		m_aHandleEntry[i].h = (handle)handleFromCount(countFromHandle(h));
		m_aHandleEntry[i].userData = (void*)m_firstFree;
		m_firstFree = i;

		return true;
	}

public:
	void* getHandleData(handle h)
	{
		handleLock;

		if(!_isValidHandle(h)) return 0;
		return m_aHandleEntry[indexFromHandle(h)].userData;
	}

	bool setHandleData(handle h, void* userData)
	{
		handleLock;

		if(!_isValidHandle(h)) return false;
		m_aHandleEntry[indexFromHandle(h)].userData = userData;
		return true;
	}

	bool isValidHandle(handle h)
	{
		handleLock;
		return _isValidHandle(h);
	}

private:
	bool _isValidHandle(handle h)
	{
		return ( indexFromHandle(h) > 0 && indexFromHandle(h) < m_handlesAllocated && m_aHandleEntry[indexFromHandle(h)].h == h );
	}

private:
	typedef struct tagHandleEntry
	{
		handle			h;						/// 句柄
		void*			userData;				/// 用户数据
	} HandleEntry, *PHandleEntry;

	PHandleEntry		m_aHandleEntry;			/// 句柄表入口地址
	unsigned int		m_handlesAllocated;		/// 已经分配的句柄数
	unsigned int		m_firstFree;			/// 第一个空闲句柄索引,0索引的句柄为系统使用，用于标记句柄

private:
	// Mutex m_mtx;
};

#endif
