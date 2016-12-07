
#include "DBQueue.h"

CDBQueue::CDBQueue(char id) {
	m_nqueueId = id;
}

bool CDBQueue::Create() {
	m_pmysql = new CSqlOuter();
	m_pmysql->Init();
}

bool CDBQueue::AddObject(CDBObject* obj) {
	m_mutex.Lock();
	m_asyncQueue.push_back(obj);
	m_mutex.Unlock();
	m_sem.Post();
}

void CDBQueue::Drive() {
	CDBObject* obj;
	if (m_sem.Wait() ) {
		m_mutex.Lock();
		obj = m_asyncQueue.front();
		m_asyncQueue.pop_front();
		m_mutex.Unlock();
	}
	if (!m_pmysql->IsAlive()) {
		puts("ERROR: MYSQL connection is not alive");
		return;
	}
	int rt = m_pmysql->Execute(obj);
	if (rt == 0) {
		CDBEngine::GetInstance()->AddReturnObj(obj);
	}else {
		// to-do 出错处理
		obj->destroy();
		delete obj;
	}
}

CDBQueue::~CDBQueue() {
	TLISTQUEUE::iterator iter = m_asyncQueue.begin();
	for (; iter != m_asyncQueue.end(); ++iter) {
		delete *iter;
	}
	m_asyncQueue.clear();
	delete m_pmysql;
	m_pmysql = NULL;
}


