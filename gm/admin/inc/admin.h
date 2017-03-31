
#ifndef _ADMIN_H__
#define _ADMIN_H__

#include "lindef.h"
#include <semaphore.h>
#include <string>
#include <map>
#include <microhttpd.h>
#include "Sock.h"

using namespace std;

class ConContext;

class MsgResponse{
public:
	int result;
	const char* response;
	MsgResponse(): result(0), response(0){}
	MsgResponse(int _rt, const char* _resp): result(_rt), response(_resp){}
	~MsgResponse() {
		if(response != 0) delete response;
	}
};

class MsgRequest {
public:
	virtual ~MsgRequest(){}

public:
	string url;
	string method;
	map<string, string> params;
};

class ConContext: public ITask
{
public:
	ConContext(int _id):id(_id){
		sem_init(&sem, 0, 0);
		connection = 0;
		request = 0;
		response = 0;
	}
	virtual ~ConContext(){
		sem_destroy(&sem);
		delete request;
		delete response;
		request = 0;
		response = 0;
	}
	void wait(){sem_wait(&sem);}
	void post(){sem_post(&sem);}

	int process();
	HRESULT Do(HANDLE hContext);

public:
	MHD_Connection* connection;
	MsgRequest* request;
	MsgResponse* response;
	int id;
private:
	sem_t sem;
};


class CAdmin: public ITask
{
public:
	bool init(short);
	bool start();
	bool stop();

	HRESULT Do(HANDLE hContext);
	struct MHD_Daemon *daemon;
	IThreadsPool* m_pThreadsPool;
	ConContext* getContext(int);
	void addContext(ConContext*);
	void rmContext(ConContext*);

private:
	map<int, ConContext*> m_contexts;
};

extern CAdmin g_admin;

#endif
