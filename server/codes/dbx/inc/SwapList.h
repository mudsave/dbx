#ifndef __SWAP_LIST_H__
#define __SWAP_LIST_H__

#include <list>

/**
@name : 翻转队列
@brief: 在多线程生产者-消费者模式中生产者线程向队列添加对象，消费者线程从队列取走对象
        因为涉及到多线程访问，这个队列必须在添加/取走对象时加锁。这个模版实现这种多线程
        安全的队列，另外使用两个队列翻转的技术，可以极大的减少锁互斥的几率
*/

namespace DBX
{

template<typename _OBJ>
class SwapList
{
typedef std::list<_OBJ> PRODUCT_LIST;
public:
    bool addElem(_OBJ obj)
    {
        ENTER_CRITICAL_SECTION_MEMBER(front);
        m_frontList->push_back(obj);
        LEAVE_CRITICAL_SECTION_MEMBER
        return true;
    }

    bool getElem(_OBJ& obj)
    {
        if (m_backList->empty())
        {
            swap();
        }
        if (m_backList->empty())
        {
            return false;
        }
        obj = m_backList->front();
        m_backList->pop_front();
        return true;
    }

    void swap()
    {
        if (m_frontList->size() > 0)
        {
            ENTER_CRITICAL_SECTION_MEMBER(front);
            PRODUCT_LIST* temp = m_backList;
            m_backList = m_frontList;
            m_frontList = temp;
            LEAVE_CRITICAL_SECTION_MEMBER
        }
    }

    SwapList() : INIT_THREAD_SAFETY_MEMBER_FAST(front)
    {
        m_frontList = new PRODUCT_LIST;
        m_backList  = new PRODUCT_LIST;
    }

    virtual ~SwapList()
    {
        safeDelete(m_frontList);
        safeDelete(m_backList);
    }

protected:
    PRODUCT_LIST*   m_frontList;
    PRODUCT_LIST*   m_backList;
    DECLARE_THREAD_SAFETY_MEMBER(front);
};

}   // end namespace DBX

#endif//__SWAP_LIST_H__
