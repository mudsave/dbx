#ifndef __CLIENT_H_
#define __CLIENT_H_

#include "lua.hpp"
#include "MsgLinksImpl.h"

struct _LinkContext
{
	int linkType;
	handle hLink;
	std::string addr;
	int port;

	_LinkContext(int type, handle h) : linkType(type), hLink(h), port(0){}
};

struct LinkContext_Admin: public _LinkContext
{
	LinkContext_Admin(int type, handle h) : _LinkContext(type, h){}
};

class CClient :
	public IMsgLinksImpl<IID_IMsgLinksAW_C>
{
public:
	int Init();
	int Close();

public:
	HANDLE OnConnects(int operaterId, handle hLink, HRESULT result, ILinkPort* pPort, int iLinkType);
	void DefaultMsgProc(AppMsg* pMsg, HANDLE hLinkContext);
	void OnClosed(HANDLE hLinkContext, HRESULT reason);


public:
	void sendMsgToWorld(AppMsg* pMsg)	
	{
		HRESULT hr = S_OK;
		hr = IMsgLinksImpl<IID_IMsgLinksAW_C>::SendData((handle)INVALID_HANDLE, (BYTE*)pMsg, pMsg->msgLen);
		ASSERT_( SUCCEEDED(hr) );
	}

	lua_State* getLuaState()
	{
		return m_pLuaState;
	}

public:
	const char* translateLinkType(int linkType)
	{
		if ( linkType == IID_IMsgLinksAW_C )
			return "Admin->World";

		return "Admin->error";
	}

	const char* translateReason(HRESULT reason)
	{
		if ( reason == S_OK )
			return "close for eof";

		if ( reason == S_FALSE)
			return "close for timeout";

		if ( reason == E_FAIL )
			return "close for error";

		if ( reason == E_ABORT )
			return "close for abort";

		return "close for unknow reason";
	}


private:
	LinkContext_Admin* m_pAdmin;

private:
	ILinkCtrl* m_pLinkCtrl;
	IThreadsPool* m_pThreadsPool;

	lua_State* m_pLuaState;
};

extern CClient g_client;
#endif
