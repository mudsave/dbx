#ifndef __NETWORK_INTERFACE_H__
#define __NETWORK_INTERFACE_H__

// @note by wangshufeng.
// AppMsg在头文件msgdef.h中，应该包含msgdef.h才对，但头文件依赖关系错误。
// msgdef.h用到了vsdef.h中的声明却没有包含vsdef.h。包含msgdef.h会导致找不到某些声明而出错。
// 把msgdef.h和vsdef.h视作一个文件即可，使用时包含vsdef.h.
#include "vsdef.h"
#include "types.h"


class ILinkCtrl;
class ILinkSink;


class NetworkInterface//: public ILinkSink
{
public:
	NetworkInterface(unsigned short p_port = 3000);

    void Listen(int p_port);

	HRESULT Send(AppMsg *p_appMsg);

	HRESULT Recv(BYTE *p_buff, int p_size);

protected:
	ILinkCtrl* m_linkCtrl;
};


#endif // __NETWORK_INTERFACE_H__