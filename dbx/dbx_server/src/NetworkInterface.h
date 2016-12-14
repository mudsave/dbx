#ifndef __NETWORK_INTERFACE_H__
#define __NETWORK_INTERFACE_H__

// @note by wangshufeng.
// for AppMsg。AppMsg在msgdef.h中声明，但却需要包含vsdef.h，因为vsdef.h在文件尾包含了msgdef.h，而msgdef.h中的一些声明依赖于vsdef.h。
#include "lindef.h"
#include "vsdef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"

class ILinkCtrl;
class ILinkSink;


class NetworkInterface : public IMsgLinksImpl<1>    // 暂且用类型1
{
public:
	NetworkInterface(int p_port = 3000);

    void Listen(int p_port);

	HRESULT Send(AppMsg *p_appMsg);

	HRESULT Recv(BYTE *p_buff, int p_size);

public:
    virtual HANDLE OnConnects(SOCKET p_socket, handle p_linkID, HRESULT p_result, ILinkPort* p_connPort, int p_linkType);
    virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext);
    virtual void OnClosed(HANDLE hLinkContext, HRESULT p_reason);

protected:
	ILinkCtrl* m_linkCtrl;
};


#endif // __NETWORK_INTERFACE_H__