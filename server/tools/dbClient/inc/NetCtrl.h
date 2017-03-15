/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#ifndef __DB_CLIENT_NETCTRL_H_
#define __DB_CLIENT_NETCTRL_H_

#include <string>

// @note by wangshufeng.
// for AppMsg。AppMsg在msgdef.h中声明，但却需要包含vsdef.h，因为msgdef.h中的一些声明依赖于vsdef.h，不能独立使用，vsdef.h在文件尾包含了msgdef.h。
#include "lindef.h"
#include "vsdef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"


class NetCtrl: public IMsgLinksImpl<1>, ITask // TODO(@wangshufeng):暂且用类型1，需定义正确的连接类型
{
public:
    NetCtrl();
    ~NetCtrl();

    HRESULT Do(HANDLE hContext);

    void Connect(std::string p_serverAddr, int p_port);

    virtual HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int i_link_type);
    virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext);
    virtual void OnClosed(HANDLE hLinkContext, HRESULT reason);

    void CloseLink(DWORD dwFlags);

    void Send(AppMsg *p_appMsg);
private:
    void StartConnect();
    void StopConnect();

    ILinkCtrl* m_linkCtrl;

    std::string m_serverAddr;
    int m_port;

    bool m_connected;
    handle m_linkIndex;

    HANDLE m_connectDBXTimer;

};

#endif // __DB_CLIENT_NETCTRL_H_