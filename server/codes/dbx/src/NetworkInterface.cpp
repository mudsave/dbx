/*
Written by wangshufeng.
RTX:6016.
描述：

*/

#include "NetworkInterface.h"

//#include "trace.h"
#include "lindef.h" // 包含lindef.h来使用trace.h
#include "Sock.h"   // 使用Sock.h必先包含lindef.h，依赖其中的声明

#include "DBXContextDefine.h"
#include "DBManager.h"

#include "dbx_msgdef.h"

NetworkInterface::NetworkInterface(int p_port)
{
    TRACE0_L0( "NetworkInterface init...\n" );
    m_linkCtrl = CreateLinkCtrl();

}

bool NetworkInterface::Listen(int p_port)
{
    TRACE1_L0("NetworkInterface::Listen at(%i)\n", p_port);
    HRESULT result = m_linkCtrl->Listen(NULL, &p_port, this, 0);
    if (result != S_OK)
    {
        TRACE1_ERROR( "NetworkInterface::Listen:result(%i).\n", result );
        return false;
    }
    return true;
}

void NetworkInterface::Send(AppMsg *p_appMsg)
{
}

HANDLE NetworkInterface::OnConnects(SOCKET p_socket, handle p_linkIndex, HRESULT p_result, ILinkPort* p_linkPort, int p_linkType)
{
    if(FAILED(p_result))
    {
        TRACE1_L0("NetworkInterface::OnConnects Failed(%i)\n", p_result);
        return NULL;
    }
    TRACE1_L0("NetworkInterface::OnConnects success(%i)\n", p_linkIndex);
    OnConnectsContext *context = new OnConnectsContext(p_linkIndex, p_linkPort, p_linkType);
    return context;
}

void NetworkInterface::DefaultMsgProc(AppMsg *pMsg, HANDLE hLinkContext)
{
    OnConnectsContext *context = static_cast<OnConnectsContext *>(hLinkContext);

    char addr[1024] = {0};
    int port = 0;
    context->m_linkPort->GetRemoteAddr(addr, 1024, &port);
    //TRACE4_L0("NetworkInterface::DefaultMsgProc m_linkIndex(%i), pMsg->msgLen(%i) from:%s:%d\n", context->m_linkIndex, pMsg->msgLen, addr, port);

    char* contents = (char*)pMsg + sizeof(AppMsg);

    //DBManager::InstancePtr()

    //SendMsg(context->m_linkIndex, pMsg);

    if (pMsg->msgId == C_DOACTION)
    {
        DBManager::InstancePtr()->CallSP(context->m_linkIndex, pMsg);
    }
    else
    {
        DBManager::InstancePtr()->CallSQL(context->m_linkIndex, pMsg);
    }
}

void NetworkInterface::OnClosed(HANDLE hLinkContext, HRESULT p_reason)
{
    OnConnectsContext *context = static_cast<OnConnectsContext *>(hLinkContext);
    handle linkIndex = context->m_linkIndex;

    // eof，断开和PortSink的关系，并销毁PortSink，port自行管理自己
    // error，断开和PortSink的关系，并销毁PortSink，port自行销毁自己（异步任务）
    // 超时，断开和PortSink的关系，并销毁PortSink，此时port已经彻底销毁
    // 业务主动暴力关闭，断开和PortSink的关系，并销毁PortSink，port自行销毁自己（定时器）
    switch(p_reason)
    {
    case S_OK:
        TRACE1_L0("NetworkInterface::OnClosed.close for eof,link num = %d\n", linkIndex);
        break;
    case S_FALSE:
        TRACE1_L0("NetworkInterface::OnClosed.close for timeout,link num = %d\n", linkIndex);
        break;
    case E_FAIL:
        TRACE1_L0("NetworkInterface::OnClosed.close for error,link num = %d\n", linkIndex);
        break;
    case E_ABORT:
        TRACE1_L0("NetworkInterface::OnClosed.close for abort,link num = %d\n", linkIndex);
        break;
    default:
        TRACE0_L0("NetworkInterface::OnClosed.close reason is unknow\n");
        break;
    }

    TRACE1_L0("NetworkInterface::OnClosed reason(%i)\n", p_reason);
    delete context;
}

void NetworkInterface::Finalise()
{
    Clear();
    m_linkCtrl->CloseCtrl();
}