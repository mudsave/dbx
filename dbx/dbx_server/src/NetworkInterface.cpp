#include "NetWorkInterface.h"

#include "Sock.h"
#include "trace.h"

NetworkInterface::NetworkInterface()
{
	TRACE0_L2( "NetworkInterface init..." );
	m_linkCtrl = CreateLinkCtrl();

}

void NetworkInterface::Listen(const BYTE *p_addr, int *p_port, ILinkSink *p_sink, DWORD p_dwFlags)
{

}

HRESULT NetworkInterface::Send(BYTE *p_appMsg)
{
}

HRESULT NetworkInterface::Recv(BYTE *p_buff, int p_size)
{}

