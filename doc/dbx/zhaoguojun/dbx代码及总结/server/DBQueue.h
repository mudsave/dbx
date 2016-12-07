#ifndef _DBQueque_h
#define _DBQueque_h

#include "DBObject.h"
#include "SqlOuter.h"
#include "DBScheme.h"
#include "DBEngine.h"
#include "DBShare.h"

#include <stdio.h>
#include <list>
#include <algorithm>

using namespace std;

class CDBEngine;

class CDBQueue {
	typedef list<CDBObject*> TLISTQUEUE;
private:
	TLISTQUEUE m_asyncQueue;
public:
	CDBQueue(char id);
	~CDBQueue();
	bool Create();
	bool AddObject(CDBObject* obj);
	void Drive();

	char m_nqueueId;
	CSqlOuter* m_pmysql;
	Mutex m_mutex;
	Semaphore m_sem;
};

#endif
