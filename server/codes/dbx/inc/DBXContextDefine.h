/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#ifndef __DBX_CONTEXT_DEFINE_
#define __DBX_CONTEXT_DEFINE_

#include "lindef.h"
#include "vsdef.h"
#include "Sock.h"

class DBTaskPool;

struct OnConnectsContext
{
    handle m_linkIndex;
    ILinkPort *m_linkPort;
    int m_linkType;

    OnConnectsContext(handle p_linkIndex, ILinkPort *p_linkPort, int p_linkType)
        :m_linkIndex(p_linkIndex), m_linkPort(p_linkPort), m_linkType(p_linkType)
    {}
};

struct DBTaskContext
{
    DBTaskPool *m_dbThreadPool;

    DBTaskContext(DBTaskPool *p_dbThreadPool)
        :m_dbThreadPool(p_dbThreadPool)
    {}
};


#endif // __DBX_CONTEXT_DEFINE_
