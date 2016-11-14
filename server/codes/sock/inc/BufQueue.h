/**
 * filename : BufQueue.h
 */

#ifndef __BUF_QUEUE_H_
#define __BUF_QUEUE_H_

#include <list>

template<int _BufUnitSize = 8192, int _GrowStep = 16>
class BufQueue
{
public:
	BufQueue() : m_iSize(0){}
	~BufQueue(){ Clear(); }

public:
	bool Empty() const { return m_c.empty(); }
	int Size() const { return m_iSize; }

public:
	bool Push(const BYTE* pData, int dataLen)
	{
		ASSERT_(pData && dataLen > 0);

		int i = 0;
		while(i < dataLen)
		{
			if(m_c.empty() || m_c.back().end == m_c.back().bufLen)
			{
				_Buf buf;
				buf.bufLen = _BufUnitSize;
				// buf.pDataBuf = (BYTE*)s_memMgr.newBlock(); ASSERT_(buf.pDataBuf);
				buf.pDataBuf = new BYTE[_BufUnitSize]; ASSERT_(buf.pDataBuf);
				buf.begin = buf.end = 0;
				m_c.push_back(buf);
			}
			_Buf& back = m_c.back();
			int cpylen = (dataLen - i < back.bufLen - back.end) ? dataLen - i : back.bufLen - back.end;
			memcpy(back.pDataBuf + back.end, pData + i, cpylen);
			back.end += cpylen;
			i += cpylen;
		}

		ASSERT_(i == dataLen);
		m_iSize += dataLen;

		return true;
	}

	bool Pop(BYTE* pBuf, int dataLen)
	{
		ASSERT_(dataLen <= m_iSize);

		int i = 0;
		while(i < dataLen)
		{
			_Buf& front = m_c.front();
			int cpylen = ( dataLen - i < front.end - front.begin ) ? dataLen - i : front.end - front.begin;
			if(pBuf) memcpy(pBuf + i, front.pDataBuf + front.begin, cpylen);
			front.begin += cpylen;
			if(front.begin == front.end)
			{
				// s_memMgr.releaseBlock(front.pDataBuf);
				delete [] front.pDataBuf;
				m_c.pop_front();
			}
			i += cpylen;
		}

		ASSERT_(i == dataLen);
		m_iSize -= dataLen;
		return true;
	}

	void Clear()
	{
		while(!m_c.empty())
		{
			// s_memMgr.releaseBlock(m_c.front().pDataBuf);
			delete [] m_c.front().pDataBuf;
			m_c.pop_front();
		}
		m_iSize = 0;
	}

public:
	const BYTE* Front(int& dataLen) const
	{
		if(m_c.empty()) return NULL;
		const _Buf& front = m_c.front();
		dataLen = front.end - front.begin;
		return front.pDataBuf + front.begin;
	}

	void Front(BYTE* pBuf, int dataLen) const
	{
		ASSERT_(pBuf && dataLen <= m_iSize);

		int i = 0;
		typename std::list<_Buf>::const_iterator it = m_c.begin();
		while(i < dataLen)
		{
			ASSERT_(it != m_c.end());
			int cpylen = ( dataLen - i < (*it).end - (*it).begin ) ? dataLen - i : (*it).end - (*it).begin;
			memcpy(pBuf + i, (*it).pDataBuf + (*it).begin, cpylen);
			i += cpylen;
			++it;
		}

		ASSERT_(i == dataLen);
	}

private:
	struct _Buf
	{
		int begin;
		int end;
		BYTE* pDataBuf;
		int bufLen;
		_Buf() : begin(0), end(0), pDataBuf(NULL), bufLen(0){}
		~_Buf(){}
	};
	std::list<_Buf> m_c;
	int m_iSize;

private:
	static FixSizeMemMgr<_BufUnitSize, _GrowStep> s_memMgr;
};

template<int _BufUnitSize, int _GrowStep>
FixSizeMemMgr<_BufUnitSize, _GrowStep> BufQueue<_BufUnitSize, _GrowStep>::s_memMgr;

#endif
