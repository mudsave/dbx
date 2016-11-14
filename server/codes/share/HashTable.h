/**
 * filename : HashTable.h
 * desc :
 */

#ifndef __HASH_TABLE_H_
#define __HASH_TABLE_H_

struct _HTUnit
{
	handle hand;
	_HTUnit* pNext;
};

typedef _HTUnit* _HTUnitPtr;

template<int _Factor = 31, int _Size = 101, int _GrowStep = 128>
class HashTable
{
public:
	HashTable() : m_size(0), m_idx(0), m_ppUnit(NULL)
	{
		memset( (void*)m_table, 0, sizeof(_HTUnitPtr) * _Size);
	}

	~HashTable()
	{
		clear();
	}

public:
	void clear()
	{
		for( int i = 0; i < _Size; i++ )
		{
			_HTUnitPtr pUnit = m_table[i];
			m_table[i] = NULL;
			while(pUnit)
			{
				_HTUnitPtr p2 = pUnit;
				pUnit = pUnit->pNext;
				s_memMgr.releaseBlock(p2);
			}
		}
		m_size = 0;
		m_idx = 0;
		m_ppUnit = NULL;
	}

public:
	bool insert(handle h)
	{
		unsigned int hash = _Hash(h);
		m_ppUnit = &(m_table[hash]);
		while( *m_ppUnit )
		{
			if ( (*m_ppUnit)->hand == h )
				return false;
			m_ppUnit = &((*m_ppUnit)->pNext);
		}
		_HTUnitPtr p = (_HTUnitPtr)s_memMgr.newBlock();
		p->hand = h;
		p->pNext = NULL;
		m_idx = hash;
		*m_ppUnit = p;
		m_size++;
		return true;
	}

	bool erase(handle h)
	{
		unsigned int hash = _Hash(h);
		m_ppUnit = &(m_table[hash]);
		while( *m_ppUnit )
		{
			if( (*m_ppUnit)->hand == h )
			{
				_HTUnitPtr p = *m_ppUnit;
				*m_ppUnit = p->pNext;
				s_memMgr.releaseBlock(p);
				m_idx = hash;
				m_size--;
				return true;
			}
			m_ppUnit = &((*m_ppUnit)->pNext);
		}
		return false;
	}

public:
	handle begin()
	{
		for(int i = 0; i < _Size; i++)
		{
			if (m_table[i])
			{
				m_idx = i; 
				m_ppUnit = &(m_table[i]);
				return (*m_ppUnit)->hand;
			}
		}
		m_ppUnit = NULL;
		return INVALID_HANDLE;
	}

	handle next()
	{
		if ( !m_ppUnit || !*m_ppUnit ) return INVALID_HANDLE;
		m_ppUnit = &((*m_ppUnit)->pNext);
		if ( *m_ppUnit ) return (*m_ppUnit)->hand;
		for(int i = m_idx + 1; i < _Size; i++)
		{
			if(m_table[i])
			{
				m_idx = i; 
				m_ppUnit = &(m_table[i]);
				return (*m_ppUnit)->hand;
			}
		}
		m_ppUnit = NULL;
		return INVALID_HANDLE;
	}

	handle erase()
	{
		if( !m_ppUnit || !*m_ppUnit ) return INVALID_HANDLE;
		_HTUnit* p = *m_ppUnit;
		*m_ppUnit = p->pNext;
		s_memMgr.releaseBlock(p);
		if( *m_ppUnit )
		{
			return (*m_ppUnit)->hand;
		}
		else
		{
			for(int i = m_idx + 1; i < _Size; i++)
			{
				if( m_table[i] )
				{
					m_idx = i; 
					m_ppUnit = &(m_table[i]);
					return (*m_ppUnit)->hand;
				}
			}
		}
		return INVALID_HANDLE;
	}

public:
	inline unsigned int size()
	{
		return m_size;
	}

	inline bool empty()
	{
		return m_size == 0;
	}

private:
	inline unsigned int _Hash(handle h)
	{
		char* p = (char*)&h;
		unsigned v = ( ( p[3] * _Factor + p[2] ) * _Factor + p[1] ) * _Factor + p[0];
		return v % _Size;
	}

private:
	_HTUnitPtr m_table[_Size];
	unsigned int m_size;
	unsigned int m_idx;
	_HTUnitPtr* m_ppUnit;

public:
	static FixSizeMemMgr<sizeof(_HTUnit), _GrowStep> s_memMgr;
};

template<int _Factor, int _Size, int _GrowStep>
FixSizeMemMgr<sizeof(_HTUnit), _GrowStep> HashTable<_Factor, _Size, _GrowStep>::s_memMgr;

#endif
