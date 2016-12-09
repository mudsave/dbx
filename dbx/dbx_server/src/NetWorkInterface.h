#ifndef __NETWORK_INTERFACE_H__
#define __NETWORK_INTERFACE_H__

#include "types.h"

//class AppMsg;	// 没找到AppMsg定义在哪里，暂时如此
class ILinkCtrl;
class ILinkSink;


class NetworkInterface
{
public:
	NetworkInterface();

	void Listen(const BYTE *p_addr, int *p_port, ILinkSink *p_sink, DWORD p_dwFlags);

	HRESULT Send(BYTE *p_appMsg);	// 没找到AppMsg定义在哪里，为了让程序跑起来，暂时使用BYTE

	HRESULT Recv(BYTE *p_buff, int p_size);

protected:
	ILinkCtrl* m_linkCtrl;
};


#endif // __NETWORK_INTERFACE_H__