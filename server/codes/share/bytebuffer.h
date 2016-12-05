#ifndef _BYTEBUFFER_H
#define _BYTEBUFFER_H

#include <vector>
#include <string>
#include "string.h"

#define PRINTF printf

class ByteBuffer
{
public:
	const static int DEFAULT_SIZE = 512;

	ByteBuffer(): _rpos(0), _wpos(0)
	{
		_storage.reserve(DEFAULT_SIZE);
	}

	ByteBuffer(int res): _rpos(0), _wpos(0)
	{
		_storage.reserve(res);
	}

	void clear()
	{
		_rpos = _wpos = 0;
	}

	ByteBuffer &operator<<(bool value)
	{
		append<char>((char)value);
		return *this;
	}
	ByteBuffer &operator<<(char value)
	{
		append<char>(value);
		return *this;
	}
	ByteBuffer &operator<<(int value)
	{
		append<int>(value);
		return *this;
	}
	ByteBuffer &operator<<(long long value)
	{
		append<long long>(value);
		return *this;
	}
	ByteBuffer &operator<<(const std::string &value)
	{
		append(value.c_str(), value.length());
		append(0);
		return *this;
	}
	ByteBuffer &operator<<(const char *str)
	{
		if (str)	{
			append(str, str ? strlen(str) : 0);
		}
		append(0);
		return *this;
	}

	const ByteBuffer &operator>>(bool &value) const
	{
		value = read<char>() > 0 ? true : false;
		return *this;
	}
	const ByteBuffer &operator>>(char &value) const
	{
		value = read<char>();
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

	int rpos() const
	{
		return _rpos;
	};

	int rpos(int rpos)
	{
		_rpos = rpos;
		return _rpos;
	};

	int wpos() const
	{
		return _wpos;
	}

	int wpos(int wpos)
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
	template <typename T> T read(int pos) const
	{
		return *((T*)&_storage[pos]);
	}

	void read(char *dest, int len) const
	{
		memcpy(dest, &_storage[_rpos], len);
		_rpos += len;
	}

	template <typename T> void append(T value)
	{
		append((char *)&value, sizeof(value));
	}

	void append(const char *src, int cnt)
	{
		if (!cnt) return;
		if (_storage.size() < (unsigned int)(_wpos + cnt))
			_storage.resize(_wpos + cnt);
		memcpy(&_storage[_wpos], src, cnt);
		_wpos += cnt;
	}

	void print_storage() const
	{
		PRINTF("STORAGE_SIZE: %d\n", size() );
		for(int i = 0; i < size(); i++)
			PRINTF("%u - ", read<char>(i) );
		PRINTF("\n");
	}
	void textlike() const
	{
		PRINTF("STORAGE_SIZE: %d\n", size() );
		for(int i = 0; i < size(); i++)
			PRINTF("%c", read<char>(i) );
		PRINTF("\n");
	}
	void hexlike() const
	{
		int j = 1, k = 1;
		PRINTF("STORAGE_SIZE: %d\n", size() );
		for(int i = 0; i < size(); i++)
		{
			if ((i == (j*8)) && ((i != (k*16))))
			{
				if (read<char>(i) <= 0x0F)
				{
					PRINTF("| 0%X ", read<char>(i) );
				}
				else
				{
					PRINTF("| %X ", read<char>(i) );
				}
				j++;
			}
			else if (i == (k*16))
			{
				if (read<char>(i) <= 0x0F)
				{
					PRINTF("\n0%X ", read<char>(i) );
				}
				else
				{
					PRINTF("\n%X ", read<char>(i) );
				}

				k++;
				j++;
			}
			else
			{
				if (read<char>(i) <= 0x0F)
				{
					PRINTF("0%X ", read<char>(i) );
				}
				else
				{
					PRINTF("%X ", read<char>(i) );
				}
			}
		}
		PRINTF("\n");
	}
	const char *contents() const { return &_storage[0]; };
	int size() const { return _wpos; };

protected:
	mutable int _rpos, _wpos;
	mutable int wrong;
	std::vector<char> _storage;
};
#endif
