/**
 * filename : ArrayEx.h 
 */

#ifndef __ARRAY_EX_H_
#define __ARRAY_EX_H_

#include <set>
#include "HandleMgr.h"

template<class Type>
class ArrayEx
{
public:
	typedef std::set<handle> _HandleSet;
	typedef _HandleSet::iterator iterator;

public:
	ArrayEx() : m_size(0){}
	~ArrayEx(){}

public:
	int size() { return m_size; }
	bool empty() { return m_size == 0; }
	bool valid(int h) { return m_hMgr.isValidHandle(h); }

public:
	iterator begin(){ return m_hSet.begin(); }
	iterator end(){ return m_hSet.end(); }
	Type* operator[](handle h){ return (Type*)(m_hMgr.getHandleData(h)); }
	Type* operator[](iterator it){ return (Type*)(m_hMgr.getHandleData(*it)); }

public:
	handle insert(const Type* s)
	{ 
		handle h = m_hMgr.createHandle(s);
		m_hSet.insert(h);
		m_size++;
		return h;
	}
	void erase(handle h)
	{
		m_hSet.erase(h);
		m_hMgr.closeHandle(h);
		m_size--;
	}
	void clear()
	{
		m_hMgr.clear();
		m_hSet.clear();
		m_size = 0;
	}

private:
	HandleMgr m_hMgr;
	_HandleSet m_hSet;
	int m_size;
};

#endif
