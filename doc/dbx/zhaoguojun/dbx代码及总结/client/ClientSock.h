
#ifndef _ClientSock_H
#define _ClientSock_H

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
#include <list>
#include "DBShare.h"
using namespace std;

void* connect_db(void* sock);

void read_cb(struct bufferevent *bev, void* arg);
void write_cb(struct bufferevent *bev, void* arg);
void error_cb(struct bufferevent *bev, short events, void *arg);

class CClientSock{
public:
	CClientSock(){}
	int connect(char* ip, unsigned short port);
	int connect();
	int send(void* data, int len);
	int fetch_result(void** result, int* len);

	void on_connect(int fd, const char* ip, unsigned short port);
	void on_close();
	void on_recv(void* data, int len);
	void on_send(struct bufferevent *bev);
private:

	list<void*> m_input;
	list<void*> m_output;
	map<void*, int> m_map_input;
	map<void*, int> m_map_output;
	char* m_ip;
	unsigned short m_port;
	Mutex m_in_mutex;
	Mutex m_out_mutex;
};

#endif