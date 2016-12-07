
#ifndef _DBClient_H
#define _DBClient_H

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "ClientSock.h"
#include "DBShare.h"

extern char MYSQLBUFFER[];


class CDBClient {
private:
	CDBClient(){
		m_sock = new CClientSock();
	}
	static CDBClient* _instance;
public:
	static CDBClient* GetInstance(){
		if (_instance == NULL){
			_instance = new CDBClient();
			return _instance;
		}
	}

	int connect(char* ip, unsigned short port);
	int sendMsg(void* data, int len);
	int executeQuery(CMysqlQuery* query_obj, IDBCallback*);
	void on_return();
	int close();
	int generateOperationId();

	ResultInfo* parse_info(void* data, int len);
	MapFieldSets* parse_field(void* data, int len);
	MapRecordSets* parse_record(void* data, int len);
	MapOutputParamSet* parse_output(void* data, int len);

	typedef map<int, CMysqlQuery> map_query;
	map_query m_query_items;

	typedef map<int, IDBCallback*> map_callbacks;
	map_callbacks m_db_callbacks;

	CClientSock *m_sock;
};

class CQueryClient: public IDBCallback {
public:
	int buildSpQuery(const char* str, int queue_id);
	int buildSqlQuery(const char* str, int queue_id);
	int addParams(bool);
	int addParams(int);
	int addParams(long long);
	int addParams(float);
	int addParams(const char*);
	int addParams(void*, int);
	int executeQuery();

	void do_return(DBResult*);

	CMysqlQuery queryObj;
	int index;
	CQueryClient():index(1){}
};

#endif