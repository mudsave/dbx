
#ifndef __SOCK_H
#define __SOCK_H

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <assert.h>
#include <string.h>

#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include "event2/event.h"
#include "event2/bufferevent.h"
#include "event2/buffer.h"

#include <map>
using namespace std;

class ITcpPort{
public:
	virtual void on_connect(int fd, const char* ip, unsigned short port)=0;
	virtual void on_close(int fd)=0;
	virtual void on_recv(void* data, int len, int fd)=0;
};


void accept_cb(evutil_socket_t listen_fd, short what, void* arg);
void read_cb(struct bufferevent *bev, void* arg);
void write_cb(struct bufferevent *bev, void* arg);
void error_cb(struct bufferevent *bev, short events, void *ctx);

class CSock{
public:
	CSock(ITcpPort* port):m_port(port){}
	int listen(const char* ip, unsigned short port);
	int send(int fd, void* data, int len);

	void on_connect(int fd, void* bufferevent_ptr, const char* ip, unsigned short port);
	void on_close(int fd);
	void on_recv(void* data, int len, int fd);

	ITcpPort* m_port;
	struct event_base* m_base;
	typedef map<int, void*> mapFdBufferevent;
	mapFdBufferevent m_fdbe;
private:

};

#endif