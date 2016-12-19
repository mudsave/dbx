#include "NetworkInterface.h"

//#include "trace.h"
#include "lindef.h"	// 包含lindef.h来使用trace.h
#include "Sock.h"	// 使用Sock.h必先包含lindef.h，依赖其中的声明

#include "ContextDefine.h"

NetworkInterface::NetworkInterface(int p_port)
{
	TRACE0_L2( "NetworkInterface init...\n" );
	m_linkCtrl = CreateLinkCtrl();

}

void NetworkInterface::Listen(int p_port)
{
    HRESULT result = m_linkCtrl->Listen(NULL, &p_port, this, 0);
    TRACE1_L2("NetworkInterface::Listen result(%i)\n", result);
}

HRESULT NetworkInterface::Send(AppMsg *p_appMsg)
{
}

HRESULT NetworkInterface::Recv(BYTE *p_buff, int p_size)
{
}

HANDLE NetworkInterface::OnConnects(SOCKET p_socket, handle p_linkIndex, HRESULT p_result, ILinkPort* p_linkPort, int p_linkType)
{
    if(FAILED(p_result))
    {
        TRACE1_L2("NetworkInterface::OnConnects Failed(%i)\n", p_result);
        return NULL;
    }
    TRACE1_L0("NetworkInterface::OnConnects success(%i)\n", p_linkIndex);
    OnConnectsContext *context = new OnConnectsContext(p_linkIndex, p_linkPort, p_linkType);
    return context;
}

void NetworkInterface::DefaultMsgProc(AppMsg *pMsg, HANDLE hLinkContext)
{
    OnConnectsContext *context = static_cast<OnConnectsContext *>(hLinkContext);
    
    TRACE2_L0("NetworkInterface::DefaultMsgProc m_linkIndex(%i), pMsg->msgLen(%i)\n", context->m_linkIndex, pMsg->msgLen);
}

void NetworkInterface::OnClosed(HANDLE hLinkContext, HRESULT p_reason)
{
    TRACE1_L0("NetworkInterface::OnClosed reason(%i)\n", p_reason);
}