#ifndef __DBX_CONTEXT_DEFINE__
#define __DBX_CONTEXT_DEFINE__

#include "lindef.h"
#include "vsdef.h"
#include "Sock.h"

struct OnConnectsContext
{
    handle m_linkIndex;
    ILinkPort *m_linkPort;
    int m_linkType;

    OnConnectsContext(handle p_linkIndex, ILinkPort *p_linkPort, int p_linkType)
        :m_linkIndex(p_linkIndex), m_linkPort(p_linkPort), m_linkType(p_linkType)
    {}
};


#endif // __DBX_CONTEXT_DEFINE__
