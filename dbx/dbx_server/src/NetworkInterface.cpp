#include "NetworkInterface.h"

//#include "trace.h"
#include "lindef.h"	// 包含lindef.h来使用trace.h
#include "Sock.h"	// 使用Sock.h必先包含lindef.h，依赖其中的声明

NetworkInterface::NetworkInterface(int p_port)
{
	TRACE0_L2( "NetworkInterface init...\n" );
	m_linkCtrl = CreateLinkCtrl();

}

void NetworkInterface::Listen(int p_port)
{
    m_linkCtrl->Listen(NULL, &p_port, this, 0);
}

HRESULT NetworkInterface::Send(AppMsg *p_appMsg)
{
}

HRESULT NetworkInterface::Recv(BYTE *p_buff, int p_size)
{
}

HANDLE NetworkInterface::OnConnects(SOCKET p_socket, handle p_linkID, HRESULT p_result, ILinkPort* p_connPort, int p_linkType)
{
    if(FAILED(p_result))
    {
        TRACE1_L2("NetworkInterface::OnConnects Failed(%i)", p_result);
        return;
    }
    TRACE1_L0("NetworkInterface::OnConnects success(%i)", p_result);


}

void NetworkInterface::DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext)
{
}

void NetworkInterface::OnClosed(HANDLE hLinkContext, HRESULT p_reason)
{
}