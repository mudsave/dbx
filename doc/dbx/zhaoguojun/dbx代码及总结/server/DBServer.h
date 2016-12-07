
#ifndef _DBServer_H
#define _DBServer_H

#include "ServerSock.h"
#include "DBEngine.h"

class CDBEngine;

class CDBServer: public ITcpPort {
public:
	int listen(const char* ip, unsigned short port);
	int execute(int);
	int send(int fd, void* data, int len);
	void on_connect(int fd, const char* ip, unsigned short port);
	void on_close(int fd);
	void on_recv(void* data, int len, int fd);

	CDBServer();
	~CDBServer();

	CMysqlQuery* m_query;
	CSock *m_sock;
	CDBEngine* m_engine;
};

#endif