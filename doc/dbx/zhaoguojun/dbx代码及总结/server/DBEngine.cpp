
#include "DBEngine.h"

DBScheme g_scheme = DBScheme();

CDBEngine* CDBEngine::_engine = NULL;

CDBEngine::CDBEngine() {
	m_pFieldSetsBuffer = new char[1024*1024];
	m_pRecordSetsBuffer = new char[1024*1024*4];
	m_pOutParamsBuffer = new char[1024*512];
	m_pResultInfoBuffer = new char[1024*2];
	FieldSetsSize = 0;
	RecordSetsSize = 0;
	OutParamsSize = 0;
}
CDBEngine::~CDBEngine(){
	delete[] m_pFieldSetsBuffer;
	delete[] m_pRecordSetsBuffer;
	delete[] m_pOutParamsBuffer;
	delete[] m_pResultInfoBuffer;
	m_server = NULL;
}

CDBEngine* CDBEngine::GetInstance(){
	if (_engine == NULL){
		_engine = new CDBEngine;
	}
	return _engine;
}

CDBEngine* CDBEngine::Release(){
	delete _engine;
	_engine = NULL;
}

bool CDBEngine::Create(CDBServer* db_server) {
	m_server = db_server;
	int i = 0;
	for(;i < g_scheme.queueNum; i++) {
		CDBQueue* t_queue = new CDBQueue(i);
		t_queue->Create();
		m_queueMgr.insert(make_pair(i, t_queue));
	}
	return true;
}

int CDBEngine::Query(CMysqlQuery* queryObj, int fd) {
	CDBObject* obj = new CDBObject(queryObj, fd);
	MapQueueMgr::iterator iter = m_queueMgr.find(queryObj->m_queueID);
	CDBQueue* t_queue = NULL;
	if (iter != m_queueMgr.end()) {
		t_queue = iter->second;
		t_queue->AddObject(obj);
	}
	else{
		t_queue = m_queueMgr[0];
		t_queue->AddObject(obj);
	}
	return 0;
}

void CDBEngine::Drive(){
	MapQueueMgr::iterator iter = m_queueMgr.begin();
	for (; iter != m_queueMgr.end(); iter++) {
		iter->second->Drive();
	}
	OnResult();
}

void CDBEngine::OnResult() {
	SendResult();
}

void CDBEngine::Close(){
	MapQueueMgr::iterator iter = m_queueMgr.begin();
	for (; iter != m_queueMgr.end(); iter++) {
		delete iter->second;
	}
	m_queueMgr.clear();
}

void CDBEngine::AddReturnObj(CDBObject* obj) {
	m_mutex.Lock();
	m_listResult.push_back(obj);
	m_mutex.Unlock();
	m_sem.Post();
}

void CDBEngine::SendResult() {
	CDBObject* obj;
	if (m_sem.Wait()) {
		m_mutex.Lock();
		obj = m_listResult.front();
		m_listResult.pop_front();
		m_mutex.Unlock();
	}
	if (!obj) {
		return;
	}
	obj->result_info();
	FillBuffer(obj);
	SendMsg(obj->m_fd);
	// destroy obj
	//to-do 需完善内存释放
}

void CDBEngine::SendMsg(int fd){
	int intSize = sizeof(int);
	int sum = sizeof(int)*4 + FieldSetsSize + RecordSetsSize + OutParamsSize + ResultInfoSize;
	m_server->send(fd, &sum, intSize);

	m_server->send(fd, &ResultInfoSize, intSize);
	m_server->send(fd, m_pResultInfoBuffer, ResultInfoSize);

	m_server->send(fd, &FieldSetsSize, intSize);
	m_server->send(fd, m_pFieldSetsBuffer, FieldSetsSize);

	m_server->send(fd, &RecordSetsSize, intSize);
	m_server->send(fd, m_pRecordSetsBuffer, RecordSetsSize);

	m_server->send(fd, &OutParamsSize, intSize);
	m_server->send(fd, m_pOutParamsBuffer, OutParamsSize);
}

void CDBEngine::FillBuffer(CDBObject* obj) {
	int size1 = 0;//field
	int size2 = 0;//record
	int fieldHeadSize = 0;
	int recordHeadSize = 0;
	int charSize = sizeof(char);
	int intSize = sizeof(int);
	size1 += charSize;
	size2 = size1;
	fieldHeadSize += charSize;
	recordHeadSize = fieldHeadSize;
	MapResultInfo::iterator iter = obj->m_mapResultInfo.begin();
	for(; iter != obj->m_mapResultInfo.end(); iter++) {
		size1 += 2 * charSize + intSize;
		fieldHeadSize += 2 * charSize + intSize;
		size1 += iter->second.fields * 2 *charSize;
		size2 += 2 * charSize + intSize * 2;
		recordHeadSize += 2 * charSize + intSize * 2;
		size2 += iter->second.fields * iter->second.rows * ( 2*charSize + intSize);
	}
	FieldSetsSize = obj->m_fieldSetsSize + size1;
	RecordSetsSize = obj->m_recordSetsSize + size2;

	int size3 = obj->m_output_param_set.size();
	if (size3 > 0) {
		OutParamsSize = charSize + size3*charSize + obj->m_outputParamsSize;
	}

	ResultInfoSize = sizeof(int)*3 + strlen(obj->m_error_msg);

	size1 = sizeof(m_pFieldSetsBuffer);
	if (size1 < FieldSetsSize) {
		while(size1 < FieldSetsSize) {
			size1 += size1;
		}
		delete[] m_pFieldSetsBuffer;
		m_pFieldSetsBuffer = new char[size1]();
	}
	size1 = sizeof(m_pRecordSetsBuffer);
	if (size1 < RecordSetsSize) {
		while(size1 < RecordSetsSize) {
			size1 += size1;
		}
		delete[] m_pRecordSetsBuffer;
		m_pRecordSetsBuffer= new char[size1]();
	}
	size1 = sizeof(m_pOutParamsBuffer);
	if (size1 < OutParamsSize) {
		while(size1 < OutParamsSize) {
			size1 += size1;
		}
		delete[] m_pOutParamsBuffer;
		m_pOutParamsBuffer = new char[size1]();
	}
	size1 = sizeof(m_pResultInfoBuffer);
	if (size1 < ResultInfoSize) {
		while(size1 < ResultInfoSize) {
			size1 += size1;
		}
		delete[] m_pResultInfoBuffer;
		m_pResultInfoBuffer = new char[size1]();
	}
	FillFields(obj, fieldHeadSize);
	FillRecords(obj, recordHeadSize);
	FillOutputs(obj);
	FillResultInfo(obj);
}

bool CDBEngine::FillOutputs(CDBObject* obj) {
	int charSize = sizeof(char);
	void* addr = (void*) m_pOutParamsBuffer;
	char char_tmp = 0;

	MapOutputParamSet& param_set = obj->m_output_param_set;
	char param_size = param_set.size();
	addr = mempcpy(addr, &param_size, charSize);
	for(int idx=0; idx < param_size; idx++) {
		OutputParam& output = param_set[idx];
		char_tmp = idx + 1;
		addr = mempcpy(addr, &char_tmp, charSize);
		addr = mempcpy(addr, output.name, strlen(output.name)+1);
		addr = mempcpy(addr, &(output.type), sizeof(output.type));
		addr = mempcpy(addr, &(output.size), sizeof(output.size));
		addr = mempcpy(addr, output.value, output.size);
	}
}

bool CDBEngine::FillResultInfo(CDBObject* obj) {
	int intSize = sizeof(int);
	int int_tmp;
	void* addr = (void*) m_pResultInfoBuffer;
	int_tmp = obj->m_operationID;
	addr = mempcpy(addr, &int_tmp, intSize);

	int_tmp = obj->m_errno;
	addr = mempcpy(addr, &int_tmp, intSize);

	int_tmp = strlen(obj->m_error_msg);
	addr = mempcpy(addr, &int_tmp, intSize);
	memcpy(addr, obj->m_error_msg, int_tmp);
}


bool CDBEngine::FillFields(CDBObject* obj, int headSize) {
	int charSize = sizeof(char);
	int intSize = sizeof(int);
	char ResultSum = obj->m_mapResultInfo.size();
	void* statAddr = static_cast<void*>(m_pFieldSetsBuffer);
	void* contentAddr = statAddr;
	contentAddr = (void*)((char*)contentAddr + headSize);
	char char_tmp = 0;
	int int_tmp = 0;
	statAddr = mempcpy(statAddr, &ResultSum, charSize);
	MapFieldSets::iterator iter = obj->m_field_sets.begin();
	for (; iter != obj->m_field_sets.end(); iter++ ) {
		char_tmp = iter->first;
		statAddr = mempcpy(statAddr, &char_tmp, charSize);
		_RowFields& _tmpRowFields = (obj->m_mapResultInfo)[iter->first];
		char_tmp = _tmpRowFields.fields;
		statAddr = mempcpy(statAddr, &char_tmp, charSize);
		int_tmp = (char*)contentAddr - m_pFieldSetsBuffer;
		statAddr = mempcpy(statAddr, &int_tmp, intSize);

		MapFieldSet& fset = iter->second;
		MapFieldSet::iterator item = fset.begin();
		for(; item != fset.end(); item++) {
			char_tmp = iter->first;
			contentAddr = mempcpy(contentAddr, &char_tmp, charSize);
			char_tmp = item->first;
			contentAddr = mempcpy(contentAddr, &char_tmp, charSize);
			int_tmp = item->second.type;
			contentAddr = mempcpy(contentAddr, &int_tmp, intSize);
			int tmp_length = strlen(item->second.name) + 1;
			contentAddr = mempcpy(contentAddr, item->second.name, tmp_length);
		}
	}
}

bool CDBEngine::FillRecords(CDBObject* obj, int headSize) {
	int charSize = sizeof(char);
	int intSize = sizeof(int);
	char ResultSum = obj->m_mapResultInfo.size();
	//处理记录
	void* statAddr = static_cast<void*>(m_pRecordSetsBuffer);
	void* contentAddr = statAddr;
	contentAddr = (void*)( (char*)contentAddr + headSize );
	char char_tmp = 0;
	int int_tmp = 0;
	statAddr = mempcpy(statAddr, &ResultSum, charSize);
	MapRecordSets::iterator set_iter = obj->m_record_sets.begin();
	for(; set_iter != obj->m_record_sets.end(); set_iter++) {
		char_tmp = set_iter->first;
		statAddr = mempcpy(statAddr, &char_tmp, charSize);
		int_tmp = obj->m_mapResultInfo[set_iter->first].rows;
		statAddr = mempcpy(statAddr, &int_tmp, intSize);
		char_tmp = obj->m_mapResultInfo[set_iter->first].fields;
		statAddr = mempcpy(statAddr, &char_tmp, charSize);
		int_tmp = (char*)contentAddr - m_pRecordSetsBuffer;
		statAddr = mempcpy(statAddr, &int_tmp, intSize);

		MapRecordSet& record_set = set_iter->second;
		MapRecordSet::iterator row_iter = record_set.begin();
		for (; row_iter != record_set.end(); row_iter++) {

			MapRecordRow& record_row = row_iter->second;
			MapRecordRow::iterator record_iter = record_row.begin();
			for (; record_iter != record_row.end(); record_iter++) {
				Record& record = record_iter->second;
				char_tmp = set_iter->first;
				contentAddr = mempcpy(contentAddr, &char_tmp, charSize);
				int_tmp = row_iter->first;
				contentAddr = mempcpy(contentAddr, &int_tmp, intSize);
				char_tmp = record_iter->first;
				contentAddr = mempcpy(contentAddr, &char_tmp, charSize);
				int_tmp = record.size;
				contentAddr = mempcpy(contentAddr, &int_tmp, intSize);
				contentAddr = mempcpy(contentAddr, record.value, int_tmp);
			}
		}
	}
}
