/**
 * filename	: misc.h
 * desc		: linux杂项工具文件
 */

#ifndef __MISC_H_
#define __MISC_H_

inline void ParseAddr(const char* paddr, char* ip, int& port)
{
	int colon = -1;
	bool numOnly = true;
	for(int i = 0; paddr[i] != '\0'; i++)
	{
		if(numOnly) numOnly = paddr[i] >= '0' && paddr[i] <= '9';
		if(paddr[i] == ':')
		{
			colon = i;
			break;
		}
	}

	if(colon >= 0)
	{
		if(colon > 0)
		{
			strncpy(ip, paddr, colon);
			ip[colon] = '\0';
		}
		sscanf(paddr + colon + 1, "%i", &port);
		return;
	}

	if(numOnly)
	{
		sscanf(paddr, "%i", &port);
		return;
	}

	strcpy(ip, paddr);
	return;
}

#include <string>
struct str_hash
{
	size_t operator()(const std::string& str) const
	{
		size_t hash = 0;
		for( size_t i = 0; i != str.length(); i++ )
		{
			hash = ((hash<<5) + hash) + (size_t)str[i];
		}
		return hash;
	}
};

template<class T>
class _CountedArray
{
public:
	T* p;
	int count;

public:
	_CountedArray() : p(NULL), count(0){}

	~_CountedArray()
	{
		count = 0;
		if (p) delete[] p;
	}

	T* operator[](size_t index)const{
		assert(index<(unsigned)count);
		return index<(unsigned)count?p+index:0;
	}
};

#endif
