#ifndef __DBX_SINGLETON_H_
#define __DBX_SINGLETON_H_

#include <assert.h>
#include <stdio.h>

template<typename T>
class Singleton
{
protected:
    static T *m_instance;

public:
    Singleton()
    {
        assert(!m_instance);
        m_instance = static_cast<T *>(this);
    }

    static void Create()
    {
        if(m_instance == NULL)
        {
            m_instance = new T();
        }
    }

    static T *InstancePtr()
    {
        if (m_instance == NULL)
        {
            Create();
        }
        return m_instance;
    }

    static T &Instance()
    {
        if (m_instance == NULL)
        {
            Create();
        }
        return *m_instance;
    }
};

template<typename T>
T* Singleton<T>::m_instance = NULL;

#endif   // __DBX_SINGLETON_H_