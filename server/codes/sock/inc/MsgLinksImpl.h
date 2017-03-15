/**
 * filename : MsgLinksImpl.h
 * desc : 网络消息接口的通用实现
 */

#ifndef __MsgLinksImpl_H_
#define __MsgLinksImpl_H_

#include "ArrayEx.h"
#include "vsdef.h"


/// msgLenMax，业务中，消息的最大长度（包含消息头）
/// iLinkType，业务中，连接类别
#define IID_IMsgLinksCS_L       0x0001    // session监听client连接
#define IID_IMsgLinksGS_L       0x0002    // session监听gateway连接
#define IID_IMsgLinksWS_L       0x0004    // session监听world连接
#define IID_IMsgLinksCG_L       0x0008    // gateway监听client连接
#define IID_IMsgLinksWG_L       0x0010    // gateway监听world连接
#define IID_IMsgLinksCS_C       0x0020    // client连接session
#define IID_IMsgLinksGS_C       0x0040    // gateway连接session
#define IID_IMsgLinksWS_C       0x0080    // world连接session
#define IID_IMsgLinksCG_C       0x0100    // client连接gateway
#define IID_IMsgLinksWG_C       0x0200    // world连接gateway
#define IID_IMsgLinksCD_L       0x0400    // dbx监听dbx client
#define IID_IMsgLinksCD_C       0x0800    // dbx client连接dbx

/// IPortSink的通用实现
template<int iLinkType, int msgLenMax> class IMsgLinksImpl;
template<int iLinkType, int msgLenMax>
class MsgDispatch : public IPortSink
{
	typedef IMsgLinksImpl<iLinkType, msgLenMax> _LinkMgr;

public:
	MsgDispatch() : m_hLink(0), m_hLinkContext(NULL), m_pPort(NULL), m_pLinkMgr(NULL), m_bHasClose(false){}
	virtual ~MsgDispatch(){}

public:
	void Init(ILinkPort* pPort, _LinkMgr* pLinkMgr, handle hLink)
	{
		m_pPort = pPort;
		m_pLinkMgr = pLinkMgr;
		m_hLink = hLink;
	}

	HRESULT SendData(BYTE* pData, int len)
	{
		ASSERT_(len <= msgLenMax);

		ASSERT_(m_pPort);

		if(m_bHasClose == true) return S_FALSE;

		return m_pPort->Send(pData, len);
	}

	HRESULT Close(DWORD dwFlags)
	{
		ASSERT_(m_pPort);

		HRESULT hr = m_pPort->Close(dwFlags);
		m_bHasClose = true;

		return hr;
	}

public:
	virtual void OnClose(HRESULT reason)
	{
		ASSERT_(m_pPort);

		if(reason == S_OK && m_bHasClose == false) m_pPort->Close(0);

		m_pLinkMgr->Closed(m_hLink, reason);
	}

	virtual int OnRecv(int iSize, BYTE* pData = NULL)
	{
		int ret = 0;
		static BYTE buf[msgLenMax];
		AppMsg* pMsg = (AppMsg*)buf;
		while(ret + (int)sizeof(AppMsg) <= iSize)
		{
			if(pData) // 我们项目中不用该种形式
			{
				pMsg = reinterpret_cast<AppMsg*>(pData + ret);
				if(ret + pMsg->msgLen > iSize) break;
			}
			else
			{
				ASSERT_(m_pPort);
				HRESULT hr = m_pPort->Peek(buf, sizeof(WORD)); ASSERT_(SUCCEEDED(hr));
				ASSERT_(pMsg->msgLen < msgLenMax);
				if(ret + pMsg->msgLen > iSize) break;
				m_pPort->Recv(buf, pMsg->msgLen);
			}

			m_pLinkMgr->DefaultMsgProc(pMsg, m_hLinkContext);

			ret += pMsg->msgLen;
		}
		return ret;
	}

public:
	inline handle GetLink(){ return m_hLink; }
	inline ILinkPort* GetLinkPort(){ return m_pPort; }
	inline HANDLE GetLinkContext(){ return m_hLinkContext; }
	inline void SetLinkContext(HANDLE hContext){ m_hLinkContext = hContext; }

private:
	handle m_hLink;
	HANDLE m_hLinkContext;
	ILinkPort* m_pPort;
	_LinkMgr* m_pLinkMgr;
	bool m_bHasClose;
};

/// IMsgLink的通用实现
template<int iLinkType, int msgLenMax = _MaxMsgLength>
class IMsgLinksImpl : public ILinkSink
{
public :
	IMsgLinksImpl() {}
	virtual ~IMsgLinksImpl(){}
	void Clear()
	{
		for(typename _LinkSet::iterator it = m_links.begin(); it != m_links.end(); ++it)
		{
			_MsgDispatch* p = m_links[it];
			if(p)
			{
				delete p;
				p = NULL;
			}
		}
		m_links.clear();
	}

public : 
	virtual IPortSink* OnConnects(int operaterId, ILinkPort* pPort, HRESULT result)
	{
		_MsgDispatch* p = NULL;
		handle hLink = INVALID_HANDLE;

		if(SUCCEEDED(result))
		{
			p = new _MsgDispatch;
			hLink = m_links.insert(p);
			ASSERT_(hLink != (int)INVALID_HANDLE);
			p->Init(pPort, this, hLink);
		
			HANDLE hContext = OnConnects(operaterId, hLink, result, pPort, iLinkType);
			ASSERT_(hContext);

			p->SetLinkContext(hContext);

			return p;
		}
		else
		{
			HANDLE hContext = OnConnects(operaterId, hLink, result, pPort, iLinkType);
			ASSERT_(!hContext);
			return NULL;
		}
	}

	void Closed(handle hLink, HRESULT reason)
	{
		_MsgDispatch* p = m_links[hLink];
		if(p)
		{
			OnClosed(p->GetLinkContext(), reason);
			delete p;
			m_links.erase(hLink);
		}
	}

public:
	int LinkCount()
	{
		return m_links.size(); 
	}

	handle FirstLink()
	{
		m_itLink = m_links.begin();
		if(m_itLink == m_links.end()) return INVALID_HANDLE;
		return *m_itLink;
	}

	handle NextLink()
	{
		if(++m_itLink == m_links.end()) return INVALID_HANDLE;
		return *m_itLink;
	}

	handle RandomGetLink()
	{
		int size = m_links.size();
		if(size<=0) return INVALID_HANDLE;
		int times = rand() % size;
		typename _LinkSet::iterator it = m_links.begin();
		for(int i=0; (it != m_links.end())&&(i<times); it++,i++);
		return (*it);
	}

	bool IsValidLink(handle hLink)
	{ 
		return m_links.valid((handle)hLink); 
	}

	HRESULT CloseLink(handle hLink, DWORD dwFlags)
	{
		if(hLink)
		{
			if(m_links.valid(hLink))
			{
				HRESULT hr = m_links[hLink]->Close(dwFlags);
				if(dwFlags != 0) Closed(hLink, E_ABORT);
				return hr;
			}
			else
			{
				return E_FAIL;
			}
		}

		CloseAll();

		return S_OK;
	}

	void CloseAll()
	{
		for(typename _LinkSet::iterator it = m_links.begin(); it != m_links.end(); ++it)
		{
			_MsgDispatch* p = m_links[it];
			if(p)
			{
				p->Close(CLOSE_RELEASE);
				OnClosed(p->GetLinkContext(), E_ABORT);
				delete p;
				p = NULL;
			}
		}
		m_links.clear();
	}

	HRESULT SendData(handle hLink, BYTE* pData, int len)
	{
		if(hLink == (handle)INVALID_HANDLE)
		{
			for(typename _LinkSet::iterator it = m_links.begin(); it != m_links.end(); ++it)
			{
				_MsgDispatch* p =m_links[it];
				if(p)
				{
					p->SendData(pData, len);
				}
			}
			return S_OK;
		}

		_MsgDispatch* p = m_links[hLink];
		if(!p)
		{
			TRACE2_L0("IMsgLinksImpl<iLinkType=%d>::SendData warning，no exist port sink = %d\n", iLinkType, hLink);
			return E_FAIL;
		}

		return p->SendData(pData, len);
	}

	HRESULT SendMsg(handle hLink, AppMsg* pMsg)
	{
		return SendData(hLink, (BYTE*)pMsg, pMsg->msgLen);
	}

	HANDLE GetLinkContext(handle hLink)
	{
		_MsgDispatch* p = m_links[hLink];
		return p ? p->GetLinkContext() : INVALID_HANDLE;
	}

	ILinkPort* GetLinkPort(handle hLink)
	{
		_MsgDispatch* p = m_links[hLink];
		return p ? p->GetLinkPort() : NULL;
	}

public:
	virtual HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int i_link_type){ return NULL; }
	virtual void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext){ ASSERT_(0); }
	virtual void OnClosed(HANDLE hLinkContext, HRESULT reason){}
	/** reason
	 * S_OK，		接收到对方eof
	 * S_FALSE，	关闭超时
	 * E_FAIL，		sock错误
	 * E_ABORT，	自己主动取消
	 */

private:
	typedef MsgDispatch<iLinkType, msgLenMax> _MsgDispatch;
	typedef ArrayEx<_MsgDispatch> _LinkSet;

	_LinkSet m_links;
	typename _LinkSet::iterator m_itLink;
};

#endif
