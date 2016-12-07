#ifndef _DBEngine_h
#define _DBEngine_h

#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "DBScheme.h"
#include "DBQueue.h"
#include "DBObject.h"
#include "SqlOuter.h"
#include "DBServer.h"
#include <map>
#include <list>
#include <algorithm>

using namespace std;

extern DBScheme g_scheme;
class CDBQueue;
class CDBServer;

class CDBEngine {
private:
	CDBEngine();
	static CDBEngine* _engine;
public:
	~CDBEngine();
	static CDBEngine* GetInstance();
	static CDBEngine* Release();
	bool Create(CDBServer*);
	int Query(CMysqlQuery* queryObj, int fd);
	void Drive();
	void Close();
	void OnResult();

	void AddReturnObj(CDBObject*);
	void SendResult();
	void SendMsg(int fd);

	void FillBuffer(CDBObject* obj);
	bool FillFields(CDBObject* obj, int headSize);
	bool FillRecords(CDBObject* obj, int headSize);
	bool FillOutputs(CDBObject* obj);
	bool FillResultInfo(CDBObject* obj);

	CDBServer* m_server;
	typedef map<char, CDBQueue*> MapQueueMgr;
	typedef list<CDBObject*> ListResult;
	MapQueueMgr m_queueMgr;
	ListResult m_listResult;

	Mutex m_mutex;
	Semaphore m_sem;

	char* m_pFieldSetsBuffer;
	char* m_pRecordSetsBuffer;
	char* m_pOutParamsBuffer;
	char* m_pResultInfoBuffer;
	int FieldSetsSize;
	int RecordSetsSize;
	int OutParamsSize;
	int ResultInfoSize;
};


#endif
