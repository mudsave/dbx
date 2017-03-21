/**
 * filename : LinkContext.h
 * desc : world中的各种连接上下文
 */

#ifndef __LINK_CONTEXT_H_
#define __LINK_CONTEXT_H_

#include <string>

enum _LinkContextState
{
	LINK_CONTEXT_INIT,
	LINK_CONTEXT_INIT_2,
	LINK_CONTEXT_CONNECTED
};

struct _LinkContext
{
	int linkType;
	handle hLink;
	std::string addr;
	int port;
	int state;

	_LinkContext(int type, handle h) : linkType(type), hLink(h), port(0), state(LINK_CONTEXT_INIT){}
};

struct LinkContext_Session : public _LinkContext
{
	LinkContext_Session(int type, handle h) : _LinkContext(type, h){}
};

struct LinkContext_Gate : public _LinkContext
{
	short gatewayId;

	LinkContext_Gate(int type, handle h) : _LinkContext(type, h)
	{
		gatewayId = -1;
	}
};

struct LinkContext_Admin: public _LinkContext
{
	LinkContext_Admin(int type, handle h) : _LinkContext(type, h){}
};

#endif
