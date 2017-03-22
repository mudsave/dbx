#ifndef __DB_CLIENT_NETCTRL_H_
#define __DB_CLIENT_NETCTRL_H_

#include <string>

#include "lindef.h"
#include "Sock.h"
#include "MsgLinksImpl.h"


class NetCtrl : public IMsgLinksImpl<IID_IMsgLinksCD_C>, ITask
{
public:
    NetCtrl();
    ~NetCtrl();

    HRESULT Do(HANDLE hContext);

    void Connect(std::string p_serverAddr, int p_port);

    virtual HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int i_link_type);
    virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext);
    virtual void OnClosed(HANDLE hLinkContext, HRESULT reason);

    void Close(DWORD dwFlags);

    void Send(AppMsg *p_appMsg);

private:
    void StartConnectTimer();
    void StopConnectTimer();

    ILinkCtrl* m_linkCtrl;

    std::string m_serverAddr;
    int m_port;

    bool m_connected;
    handle m_linkIndex;

    HANDLE m_connectDBXTimer;

};

#endif // __DB_CLIENT_NETCTRL_H_