/**
 * filename : PriorityQueue.h
 */

#ifndef __PRIORITY_QUEUE_H_
#define __PRIORITY_QUEUE_H_

#include <queue>
#include <vector>

template<class RandomAccessIterator, class Compare>
inline void _AdjustHeap(RandomAccessIterator first, RandomAccessIterator last, RandomAccessIterator it, Compare comp)
{
	typename std::iterator_traits<RandomAccessIterator>::value_type temp = *it;
	typename std::iterator_traits<RandomAccessIterator>::difference_type len = last - first;
	typename std::iterator_traits<RandomAccessIterator>::difference_type holeIndex = it - first;
	typename std::iterator_traits<RandomAccessIterator>::difference_type nextIndex = 2 * holeIndex + 1;
	// 尝试向下调整
	while(nextIndex < len)
	{
		if(nextIndex < len - 1 && comp(*(first + nextIndex), *(first + (nextIndex + 1)))) nextIndex++;
		if(comp(*(first + nextIndex), temp)) break;
		*(first + holeIndex) = *(first + nextIndex);
		holeIndex = nextIndex;
		nextIndex = 2 * nextIndex + 1;
	}
	if(holeIndex == it - first)
	{
		// 向下调整不成，则尝试向上调整
		nextIndex = (holeIndex - 1) / 2;
		while(holeIndex > 0 && comp(*(first + nextIndex), temp))
		{
			*(first + holeIndex) = *(first + nextIndex);
			holeIndex = nextIndex;
			nextIndex = (nextIndex - 1) / 2;
		}
	}
	*(first + holeIndex) = temp;
};

// 排队时优先级可改变的优先级队列，要求父类采用的是最大堆算法
template<class Type, class Less>
class PriorityQueue : public std::priority_queue<Type, std::vector<Type>, Less>
{
	typedef std::priority_queue<Type, std::vector<Type>, Less> _BaseCls;
public:
	void Reserve(int num){ _BaseCls::c.reserve(num); }
	void Clear(){ _BaseCls::c.clear(); }
	Type& Top(){ return _BaseCls::c.front(); }
	// 队首元素优先级改变后调整队列
	void AdjustTop()
	{
		_AdjustHeap(_BaseCls::c.begin(), _BaseCls::c.end(), _BaseCls::c.begin(), _BaseCls::comp);
	}
	// 队中元素优先级改变后调整队列，参数p为改变了优先级的元素vector地址
	void Adjust(const Type* p)
	{
		int distance = p - &_BaseCls::c.front();
		ASSERT_(distance >= 0 && distance < (int)_BaseCls::c.size());
		_AdjustHeap(_BaseCls::c.begin(), _BaseCls::c.end(), _BaseCls::c.begin() + distance, _BaseCls::comp);
	}
};

#endif
