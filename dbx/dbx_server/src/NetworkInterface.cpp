#include "NetWorkInterface.h"

#include "Sock.h"

NetworkInterface::NetworkInterface()
{
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

