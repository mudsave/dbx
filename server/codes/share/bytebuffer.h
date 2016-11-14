/* 
* Copyright (C) 2005,2006,2007 MaNGOS <http://www.mangosproject.org/>
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#ifndef _BYTEBUFFER_H
#define _BYTEBUFFER_H

#include <iostream>
#include <vector>
#include <list>
#include <map>
#include <cassert>
#include <cstdio>
#include <cstring>
#include "types.h"

#define WPAssert( assertion ) { if( !(assertion) ) { fprintf( stderr, "\n%s:%i ASSERTION FAILED:\n  %s\n", __FILE__, __LINE__, #assertion ); assert( #assertion &&0 ); } }
#define WPError( assertion, errmsg ) if( ! (assertion) ) { sLog.outError( "%s:%i ERROR:\n  %s\n", __FILE__, __LINE__, (char *)errmsg ); assert( false ); }
#define WPWarning( assertion, errmsg ) if( ! (assertion) ) { sLog.outError( "%s:%i WARNING:\n  %s\n", __FILE__, __LINE__, (char *)errmsg ); }

#define WPFatal( assertion, errmsg ) if( ! (assertion) ) { sLog.outError( "%s:%i FATAL ERROR:\n  %s\n", __FILE__, __LINE__, (char *)errmsg ); assert( #assertion &&0 ); abort(); }

#define ASSERT WPAssert

#define PRINTF printf

class ByteBuffer
{
public:
	const static size_t DEFAULT_SIZE = 128;

	// constructor
	ByteBuffer(): _rpos(0), _wpos(0)
	{
		_storage.reserve(DEFAULT_SIZE);
	}
	// constructor
	ByteBuffer(size_t res): _rpos(0), _wpos(0)
	{
		_storage.reserve(res);
	}
	// constructor
	ByteBuffer(BYTE* pBuf, size_t len, size_t res): _rpos(0), _wpos(0)
	{
		_storage.reserve(res);
		append(pBuf, len);
	}
	// copy constructor
	ByteBuffer(const ByteBuffer &buf): _rpos(buf._rpos), _wpos(buf._wpos), _storage(buf._storage) { }

	void clear()
	{
		//_storage.clear();
		_rpos = _wpos = 0;
	}
	inline void reset()
	{
		_rpos = _wpos = 0;
	}

	template <typename T> void append(T value)
	{
		append((BYTE *)&value, sizeof(value));
	}
	template <typename T> void put(size_t pos,T value)
	{
		put(pos,(BYTE *)&value,sizeof(value));
	}

	ByteBuffer &operator<<(bool value)
	{
		append<BYTE>((BYTE)value);
		return *this;
	}
	ByteBuffer &operator<<(BYTE value)
	{
		append<BYTE>(value);
		return *this;
	}
	ByteBuffer &operator<<(WORD value)
	{
		append<WORD>(value);
		return *this;
	}
	ByteBuffer &operator<<(DWORD value)
	{
		append<DWORD>(value);
		return *this;
	}
	ByteBuffer &operator<<(unsigned long long value)
	{
		append<unsigned long long>(value);
		return *this;
	}

	ByteBuffer &operator<<(long value)
	{
		append<long>(value);
		return *this;
	}
	ByteBuffer &operator<<(void* value)
	{
		append<void*>(value);
		return *this;
	}
	// floating points
	ByteBuffer &operator<<(float value)
	{
		append<float>(value);
		return *this;
	}
	ByteBuffer &operator<<(double value)
	{
		append<double>(value);
		return *this;
	}
	ByteBuffer &operator<<(const std::string &value)
	{
		append((BYTE *)value.c_str(), value.length());
		append((BYTE)0);
		return *this;
	}
	ByteBuffer &operator<<(const char *str)
	{
		if (str)	{
			append((BYTE *)str, str ? strlen(str) : 0);
		}
		append((BYTE)0);
		return *this;
	}
/*
	const ByteBuffer &operator>>(char** value) const
	{
		if (*value)
		{
			delete[] (*value);
		}
		size_t len=read<size_t>();
		size_t count = 0;
		char* str = new char[len + 1];
		while (count < len)
		{
			char c=read<char>();
			if (c==0)
				break;
			str[count] = c;
			++count;
		}
		str[len] = 0;
		*value = str;
		return *this;
	}
*/
	const ByteBuffer &operator>>(bool &value) const
	{
		value = read<char>() > 0 ? true : false;
		return *this;
	}
	const ByteBuffer &operator>>(BYTE &value) const
	{
		value = read<BYTE>();
		return *this;
	}
	const ByteBuffer &operator>>(WORD &value) const
	{
		value = read<WORD>();
		return *this;
	}
	const ByteBuffer &operator>>(DWORD &value) const
	{
		value = read<DWORD>();
		return *this;
	}
	const ByteBuffer &operator>>(unsigned long long &value) const
	{
		value = read<unsigned long long>();
		return *this;
	}

	//signed as in 2e complement
	const ByteBuffer &operator>>(char &value) const
	{
		value = read<char>();
		return *this;
	}
	const ByteBuffer &operator>>(short &value) const
	{
		value = read<short>();
		return *this;
	}
	const ByteBuffer &operator>>(int &value) const
	{
		value = read<int>();
		return *this;
	}
	const ByteBuffer &operator>>(long long &value) const
	{
		value = read<long long>();
		return *this;
	}
	const ByteBuffer &operator>>(long &value) const
	{
		value = read<long>();
		return *this;
	}
	const ByteBuffer &operator>>(void* &value) const
	{
		value = read<void*>();
		return *this;
	}
	const ByteBuffer &operator>>(float &value) const
	{
		value = read<float>();
		return *this;
	}
	const ByteBuffer &operator>>(double &value) const
	{
		value = read<double>();
		return *this;
	}
	const ByteBuffer &operator>>(std::string& value) const
	{
		value.clear();
		while (true)
		{
			char c=read<char>();
			if (c==0)
				break;
			value+=c;
		}
		return *this;
	}

	BYTE operator[](size_t pos) const
	{
		return read<BYTE>(pos);
	}

	size_t rpos() const
	{
		return _rpos;
	};


	int getWrong() const
	{
		return wrong;
	};

	size_t rpos(size_t rpos)
	{
		_rpos = rpos;
		return _rpos;
	};

	size_t wpos() const
	{
		return _wpos;
	}

	size_t wpos(size_t wpos)
	{
		_wpos = wpos;
		return _wpos;
	}

	template <typename T> T read() const
	{
		T r=read<T>(_rpos);
		_rpos += sizeof(T);
		return r;
	};
	template <typename T> T read(size_t pos) const
	{
		//暴露错误
		WPAssert(pos + sizeof(T) <= size() || PrintPosError(false,pos,sizeof(T)));
		return *((T*)&_storage[pos]);
	}

	void read(BYTE *dest, size_t len) const
	{
		WPAssert(_rpos  + len  <= size() || PrintPosError(false,_rpos,len));
		memcpy(dest, &_storage[_rpos], len);
		_rpos += len;
	}

    void read(ByteBuffer& buffer, size_t len) const
    {
        WPAssert(_rpos  + len  <= size() || PrintPosError(false,_rpos,len));
        buffer.append(&_storage[_rpos], len);
        _rpos += len;
    }

	const BYTE *contents() const { return &_storage[0]; };

	inline size_t size() const { return _wpos; };

	void reserve(size_t ressize)
	{
		if (ressize > size()) _storage.reserve(ressize);
	};
	void append(const std::string& str)
	{
		append((BYTE *)str.c_str(),str.size() + 1);
	}
	void append(const char *src, size_t cnt)
	{
		return append((const BYTE *)src, cnt);
	}
	void append(const BYTE *src, size_t cnt)
	{
		if (!cnt) return;
		if (_storage.size() < _wpos + cnt)
			_storage.resize(_wpos + cnt);
		memcpy(&_storage[_wpos], src, cnt);
		_wpos += cnt;
	}
	void append(const ByteBuffer& buffer)
	{
		if(buffer.size()) append(buffer.contents(),buffer.size());
	}
	void append(const ByteBuffer& buffer, size_t pos)
	{
		if(buffer.size() && (buffer.size() - pos) > 0) append(&(buffer._storage[pos]),buffer.size()-pos);
	}
	void put(size_t pos, const BYTE *src, size_t cnt)
	{
		WPAssert(pos + cnt <= size() || PrintPosError(true,pos,cnt));
		memcpy(&_storage[pos], src, cnt);
	}
	void print_storage() const
	{
		PRINTF("STORAGE_SIZE: %u\n", size() );
		for(DWORD i = 0; i < size(); i++)
			PRINTF("%u - ", read<BYTE>(i) );
		PRINTF("\n");
	}

	void textlike() const
	{
		PRINTF("STORAGE_SIZE: %u\n", size() );
		for(DWORD i = 0; i < size(); i++)
			PRINTF("%c", read<BYTE>(i) );
		PRINTF("\n");
	}

	void hexlike() const
	{
		DWORD j = 1, k = 1;
		PRINTF("STORAGE_SIZE: %u\n", size() );
		for(DWORD i = 0; i < size(); i++)
		{
			if ((i == (j*8)) && ((i != (k*16))))
			{
				if (read<BYTE>(i) <= 0x0F)
				{
					PRINTF("| 0%X ", read<BYTE>(i) );
				}
				else
				{
					PRINTF("| %X ", read<BYTE>(i) );
				}
				j++;
			}
			else if (i == (k*16))
			{
				if (read<BYTE>(i) <= 0x0F)
				{
					PRINTF("\n0%X ", read<BYTE>(i) );
				}
				else
				{
					PRINTF("\n%X ", read<BYTE>(i) );
				}

				k++;
				j++;
			}
			else
			{
				if (read<BYTE>(i) <= 0x0F)
				{
					PRINTF("0%X ", read<BYTE>(i) );
				}
				else
				{
					PRINTF("%X ", read<BYTE>(i) );
				}
			}
		}
		PRINTF("\n");
	}

protected:
	bool PrintPosError(bool add, size_t pos, size_t esize) const
	{
		PRINTF("ERROR: Attempt %s in ByteBuffer (pos: %u size: %u) value with size: %u",(add ? "put" : "get"),pos, size(), esize);

		// assert must fail after function call
		return false;
	}

	mutable size_t _rpos, _wpos;
	mutable int wrong;
	std::vector<BYTE> _storage;
};


template <typename T> ByteBuffer &operator<<(ByteBuffer &b, std::vector<T> v)
{
	b << (DWORD)v.size();
	for (typename std::vector<T>::iterator i = v.begin(); i != v.end(); i++)
	{
		b << *i;
	}
	return b;
}

template <typename T> ByteBuffer &operator>>(ByteBuffer &b, std::vector<T> &v)
{
	DWORD vsize;
	b >> vsize;
	v.clear();
	while(vsize--)
	{
		T t;
		b >> t;
		v.push_back(t);
	}
	return b;
}

template <typename T> ByteBuffer &operator<<(ByteBuffer &b, std::list<T> v)
{
	b << (DWORD)v.size();
	for (typename std::list<T>::iterator i = v.begin(); i != v.end(); i++)
	{
		b << *i;
	}
	return b;
}

template <typename T> ByteBuffer &operator>>(ByteBuffer &b, std::list<T> &v)
{
	DWORD vsize;
	b >> vsize;
	v.clear();
	while(vsize--)
	{
		T t;
		b >> t;
		v.push_back(t);
	}
	return b;
}

template <typename K, typename V> ByteBuffer &operator<<(ByteBuffer &b, std::map<K, V> &m)
{
	b << (DWORD)m.size();
	for (typename std::map<K, V>::iterator i = m.begin(); i != m.end(); i++)
	{
		b << i->first << i->second;
	}
	return b;
}

template <typename K, typename V> ByteBuffer &operator>>(ByteBuffer &b, std::map<K, V> &m)
{
	DWORD msize;
	b >> msize;
	m.clear();
	while(msize--)
	{
		K k;
		V v;
		b >> k >> v;
		m.insert(make_pair(k, v));
	}
	return b;
}

#endif
