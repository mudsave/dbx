/*
Written by wangshufeng.
RTX:6016.
描述：

*/


#include "NetCtrl.h"

#include "lindef.h" // 包含lindef.h来使用trace.h
#include "Sock.h"   // 使用Sock.h必先包含lindef.h，依赖其中的声明

#include "Client.h"
#include "DBClientException.h"

#define DB_CLIENT_RECONNECT_INTERVAL 5000

struct _LinkContext_DB
{
    int linkType;
    handle hLink;

    _LinkContext_DB(int type, handle h)
        :linkType(type),
         hLink(h)
    {}
};


NetCtrl::NetCtrl()
    :m_serverAddr(),
     m_port(-1),
     m_connected(false),
     m_linkIndex(0),
     m_connectDBXTimer(NULL)
{
    TRACE0_L0("NetCtrl::NetCtrl:construct...\n");
    m_linkCtrl = CreateLinkCtrl();

    if (m_linkCtrl == NULL)
    {
        CDBClientException e;
        e.m_nExceptionType = C_LOADSOCK_EXCEPTION;
        e.m_strDescription = "load sock.dll failed!";
        throw e;
    }
}

NetCtrl::~NetCtrl()
{
    Close(CLOSE_UNGRACEFUL);
}

void NetCtrl::Close(DWORD dwFlags)
{
    TRACE0_L0("NetCtrl::CloseLink.\n");
    if (m_connected)
    {
        CloseLink(m_linkIndex, dwFlags);
        m_linkIndex = 0;
        m_connected = false;
    }
}

HRESULT NetCtrl::Do(HANDLE hContext)
{
    TRACE0_L0("CClient::Do....\n");
    if (m_connected)
    {
        TRACE0_L0("CClient::Do:m_connected is true....\n");
    }
    m_linkCtrl->Connect(m_serverAddr.c_str(), m_port, this, 0);

    return S_OK;
}

void NetCtrl::Connect(std::string p_serverAddr, int p_port)
{
    m_serverAddr = p_serverAddr;
    m_port = p_port;

    StartConnect();
}

void NetCtrl::StartConnect()
{
    if (!m_connected && m_connectDBXTimer == NULL)
    {
        m_connectDBXTimer = GlobalThreadsPool()->RegTimer(this, NULL, 0, 0, DB_CLIENT_RECONNECT_INTERVAL, "Connect_to_DBX");
    }
}

void NetCtrl::StopConnect()
{
    if (m_connectDBXTimer != NULL)
    {
        GlobalThreadsPool()->UnregTimer(m_connectDBXTimer);
        m_connectDBXTimer = NULL;
    }
    else
    {
        TRACE0_ERROR("NetCtrl::StopConnectDBX:m_connectDBXTimer is NULL.\n");
    }
}

HANDLE NetCtrl::OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int i_link_type)
{
    TRACE1_L0("NetCtrl::OnConnects:result(%i)", result);
    CClient::InstancePtr()->ConnectResult(result);

    if (result == S_OK)
    {
        StopConnect();

        m_connected = true;
        m_linkIndex = hLink;

        _LinkContext_DB* pNew = new _LinkContext_DB(i_link_type, hLink);
        return pNew;
    }

    return NULL;
}

void NetCtrl::DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext)
{
    AppMsg* newMsg = (AppMsg*)malloc(pMsg->msgLen);//TODO 优化用内存池
    memcpy(newMsg, pMsg, pMsg->msgLen);

    CClient::InstancePtr()->Recv(newMsg);
}

void NetCtrl::OnClosed(HANDLE hLinkContext, HRESULT reason)
{
    _LinkContext_DB *context = (_LinkContext_DB *)hLinkContext;
    delete context;
    m_connected = false;
    m_linkIndex = 0;

    StartConnect();
}

void NetCtrl::Send(AppMsg *p_appMsg)
{
    TRACE0_L0("NetCtrl::Send...\n");
    if (m_linkIndex != 0)
    {
        SendData(m_linkIndex, (BYTE*)p_appMsg, p_appMsg->msgLen);
    }
    else
    {
        TRACE0_L1("[NetCtrl::Send] connect with dbserver failed!\n");
    }
}