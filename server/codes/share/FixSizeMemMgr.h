/**
 * filename : FixSizeMemMgr.h
 */

#ifndef __FIXSIZE_MEMMGR_H_
#define __FIXSIZE_MEMMGR_H_

#include <list>

template<int _UnitSize, int _GrowStep, class ThreadModel = SingleThread>
class FixSizeMemMgr : public ThreadModel
{
	struct _BlockEntry
	{
		char pdata[_UnitSize];
		_BlockEntry* nextFree;				
	};

	typedef std::list<_BlockEntry*> EntryList;

public:
	FixSizeMemMgr(): m_blockUsed(0), m_firstFree(NULL){}
	~FixSizeMemMgr(){ clear(); }

public:
	void clear()
	{
		m_mutex.Lock();

		for(typename EntryList::iterator it = m_entryList.begin(); it!=m_entryList.end(); it++)
		{
			if(*it) delete (*it);
		}
		m_firstFree = NULL; 
		m_blockUsed = 0;

		m_mutex.Unlock();
	}

	void* newBlock()
	{
		m_mutex.Lock();

		if(m_firstFree == NULL)
		{
			_BlockEntry* phead = new _BlockEntry[_GrowStep];
			ASSERT_(phead);
			if(!phead)
			{
				m_mutex.Unlock();
				return NULL;
			}

			m_entryList.push_front(phead);

			for(int i = 0; i < _GrowStep; i++)
			{
				if(i == _GrowStep - 1)
				{
					phead[i].nextFree = NULL;
				}
				else
				{
					phead[i].nextFree = &(phead[i + 1]);
				}
			}
			m_firstFree = phead;
		}

		_BlockEntry* pbe = m_firstFree;
		m_firstFree = pbe->nextFree;
		m_blockUsed++;

		m_mutex.Unlock();

		return (void*)(pbe->pdata);
	}

	bool releaseBlock(void* pData)
	{
		m_mutex.Lock();

		_BlockEntry* pbe = (_BlockEntry*)pData;
		pbe->nextFree = m_firstFree;
		m_firstFree = pbe;
		m_blockUsed--;

		m_mutex.Unlock();

		return true;
	}

private:
	typename ThreadModel::_Mutex m_mutex;

	int m_blockUsed;			
	_BlockEntry* m_firstFree;			

	EntryList m_entryList;
};

#endif
