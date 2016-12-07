
#include "DBClient.h"

#define MAXBUFFERSIZE (1024*1024*4)
char MYSQLBUFFER [MAXBUFFERSIZE];
CDBClient* CDBClient::_instance = NULL;

int CDBClient::connect(char* ip, unsigned short port){
	m_sock->connect(ip, port);
}

int CDBClient::sendMsg(void* data, int len) {
	m_sock->send(data, len);
}

void CDBClient::on_return() {
	void* result;
	int len;
	int len2;
	char* addr;
	while(m_sock->fetch_result(&result, &len)){
		DBResult _result;
		addr = (char*)result;
		int count = sizeof(int)*4;
		len2 = *(int*)addr;
		count += len2;
		addr += sizeof(int);
		_result.m_info = parse_info(addr, len2);

		addr += len2;
		len2 = *(int*)addr;
		count += len2;
		addr += sizeof(int);
		_result.m_fields = parse_field(addr, len2);

		addr += len2;
		len2 = *(int*)addr;
		count += len2;
		addr += sizeof(int);
		_result.m_records = parse_record(addr, len2);

		addr += len2;
		len2 = *(int*)addr;
		count += len2;
		addr += sizeof(int);
		_result.m_outputs = parse_output(addr, len2);
		assert(count == len);

		int opid = _result.m_info->m_operationID;
		IDBCallback* do_action = m_db_callbacks[opid];
		//_result.show();
		do_action->do_return(&_result);
		m_query_items.erase(opid);
		m_db_callbacks.erase(opid);
	}
}

int CDBClient::close(){}

int CDBClient::generateOperationId() {
	static int operationID = 0;
	operationID++;
	return operationID;
}

int CDBClient::executeQuery(CMysqlQuery* queryObj, IDBCallback* callback) {
	m_db_callbacks.insert(make_pair(queryObj->m_operationID, callback));
	int int_tmp;
	char char_tmp;
	int int_size = sizeof(int);
	int char_size = sizeof(char);
	void* buffer = (void*)MYSQLBUFFER;
	memset(buffer, 0, MAXBUFFERSIZE);
	//operationID
	int_tmp = queryObj->m_operationID;
	buffer = mempcpy(buffer, &int_tmp, int_size);
	//queueID
	int_tmp = queryObj->m_queueID;
	buffer = mempcpy(buffer, &int_tmp, int_size);
	//参数个数
	char_tmp = queryObj->m_params.size();
	buffer = mempcpy(buffer, &char_tmp, char_size);
	//查询类型，sql or sp
	char_tmp = queryObj->m_actionType;
	buffer = mempcpy(buffer, &char_tmp, char_size);
	//sql command
	int_tmp = queryObj->m_sqlCommandSize;
	buffer = mempcpy(buffer, &int_tmp, int_size);
	buffer = mempcpy(buffer, queryObj->m_sqlCommand, queryObj->m_sqlCommandSize);

	map_mysqlParam& params = queryObj->m_params;
	map_mysqlParam::iterator iter = params.begin();
	for(; iter != params.end(); iter++) {
		MysqlParam& param = iter->second;
		char_tmp = param.key;
		buffer = mempcpy(buffer, &char_tmp, char_size);
		char_tmp = param.type;
		buffer = mempcpy(buffer, &char_tmp, char_size);
		int_tmp = param.size;
		buffer = mempcpy(buffer, &int_tmp, int_size);

		buffer = mempcpy(buffer, param.value, param.size);
	}
	int buffer_length = (char*)buffer - MYSQLBUFFER;
	this->sendMsg(MYSQLBUFFER, buffer_length);
	return buffer_length;
}


int CQueryClient::buildSpQuery(const char* str, int queue_id) {
	queryObj.m_queueID = queue_id;
	queryObj.m_sqlCommandSize = strlen(str);
	queryObj.m_sqlCommand = (void*)str;
	queryObj.m_actionType = 1;
	queryObj.m_operationID = CDBClient::GetInstance()->generateOperationId();
}

int CQueryClient::buildSqlQuery(const char* str, int queue_id) {
	queryObj.m_queueID = queue_id;
	queryObj.m_sqlCommandSize = strlen(str);
	queryObj.m_sqlCommand = (void*)str;
	queryObj.m_actionType = 0;
	queryObj.m_operationID = CDBClient::GetInstance()->generateOperationId();
}

int CQueryClient::addParams(bool p) {
	MysqlParam param;
	param.key = index;
	param.type = PARAMCHAR;
	param.size = sizeof(char);
	param.value = (void*)new char(p);
	queryObj.m_params.insert(make_pair(index, param));
	index++;
}
int CQueryClient::addParams(int p) {
	MysqlParam param;
	param.key = index;
	param.type = PARAMINT;
	param.size = sizeof(int);
	param.value = (void*)new int(p);
	queryObj.m_params.insert(make_pair(index, param));
	index++;
}
int CQueryClient::addParams(long long p) {
	MysqlParam param;
	param.key = index;
	param.type = PARAMBIGINT;
	param.size = sizeof(long long);
	param.value = (void*)new long long(p);
	queryObj.m_params.insert(make_pair(index, param));
	index++;
}
int CQueryClient::addParams(float p) {
	MysqlParam param;
	param.key = index;
	param.type = PARAMFLOAT;
	param.size = sizeof(float);
	param.value = (void*)new float(p);
	queryObj.m_params.insert(make_pair(index, param));
	index++;
}
int CQueryClient::addParams(const char* str) {
	MysqlParam param;
	param.key = index;
	param.type = PARAMSTRING;
	int length = strlen(str);
	param.size = length;
	param.value = (void*)new char[length];
	memcpy(param.value, str, length);
	queryObj.m_params.insert(make_pair(index, param));
	index++;
}
int CQueryClient::addParams(void* str, int length) {
	MysqlParam param;
	param.key = index;
	param.type = PARAMBIN;
	param.value = (void*)new char[length];
	memcpy(param.value, str, length);
	queryObj.m_params.insert(make_pair(index, param));
	index++;
}

int CQueryClient::executeQuery() {
	CDBClient* db_client = CDBClient::GetInstance();
	int opid = db_client->generateOperationId();
	queryObj.m_operationID = opid;
	queryObj.show();
	db_client->executeQuery(&queryObj, this);
	return 0;
}

void CQueryClient::do_return(DBResult* result) {
	result->show();
}

ResultInfo* CDBClient::parse_info(void* info_buffer, int len) {
	ResultInfo* info = new ResultInfo;
	char* addr = (char*)info_buffer;
	int int_tmp = 0;
	int int_size = sizeof(int);
	int_tmp = *(int*)addr;
	addr += int_size;
	info->m_operationID = int_tmp;
	int_tmp = *(int*)addr;
	addr += int_size;
	info->m_errno = int_tmp;
	int_tmp = *(int*)addr;
	addr += int_size;
	info->len = int_tmp;
	info->m_error_msg = new char[info->len];
	memcpy(info->m_error_msg, addr, info->len);
	addr += info->len;
	assert(addr - (char*)info_buffer == len);
	return info;
}

MapFieldSets* CDBClient::parse_field(void* field_buffer, int len) {
	MapFieldSets* fieldSets = new MapFieldSets();
	int intSize = sizeof(int);
	char* buffer = (char*)field_buffer;
	char* addr = buffer;
	char* field_addr = NULL;
	char set_sum = *addr;
	addr++;
	int i = 0;
	char set_num = 0, field_num=0, field_sum=0;
	int offset = 0;
	char tmp_set_num = 0;
	int field_type = 0;
	int name_length=0;
	char* tmp_name = 0;
	for(; i<set_sum; i++) {
		set_num = *addr;
		addr++;
		field_sum = *addr;
		addr++;
		offset = *(int*)addr;
		addr += intSize;
		field_addr = buffer + offset;
		MapFieldSet map_field_set;
		int field_idx = 0;
		for(; field_idx < field_sum; field_idx++) {
			tmp_set_num = *field_addr;
			field_addr++;
			if (tmp_set_num != set_num) {
				printf("ERROR: the NO of set is wrong! %d,%d\n", tmp_set_num, set_num);
			}
			field_num = *field_addr;
			field_addr++;
			field_type = *(int*)field_addr;
			field_addr += intSize;
			name_length = strlen(field_addr) + 1;
			tmp_name = new char[name_length];
			memcpy(tmp_name, field_addr, name_length);
			field_addr += name_length;
			Field field;
			field.type = field_type;
			field.name = tmp_name;
			map_field_set.insert(make_pair(field_idx, field));
		}
		fieldSets->insert(make_pair(i, map_field_set));
	}
	return fieldSets;
}

MapRecordSets* CDBClient::parse_record(void* record_buffer, int len) {
	MapRecordSets* recordSets = new MapRecordSets();
	int intSize = sizeof(int);
	char* buffer = (char*)record_buffer;
	char* addr = buffer;
	char* content_addr = 0;
	char set_sum = *addr;
	addr++;
	int set_idx = 0;
	int row_idx = 0;
	int record_idx = 0;

	char set_num = 0;
	int row_sum = 0;
	char record_sum = 0;
	int offset = 0;

	char char_tmp = 0;
	int int_tmp = 0;
	for(; set_idx < set_sum; set_idx++) {
		MapRecordSet set;
		set_num = *addr;
		addr++;
		row_sum = *(int*)addr;
		addr += intSize;
		record_sum = *addr;
		addr++;
		offset = *(int*)addr;
		addr += intSize;

		row_idx = 0;
		content_addr = buffer + offset;
		for(; row_idx < row_sum; row_idx++) {
			MapRecordRow row;

			record_idx = 0;
			for(; record_idx < record_sum; record_idx++) {
				Record record;
				char_tmp = *content_addr;
				content_addr++;
				if (char_tmp != set_idx) {
					printf("ERROR: set index is wrong!%d-%d\n", char_tmp, set_idx);
					return NULL;
				}
				int_tmp = *(int*)content_addr;
				content_addr += intSize;
				if (int_tmp != row_idx) {
					printf("ERROR: row index is wrong!%d-%d\n", int_tmp, row_idx);
					return NULL;
				}
				char_tmp = *content_addr;
				content_addr++;
				if (char_tmp != record_idx) {
					printf("ERROR: record index is wrong!%d-%d\n", char_tmp, record_idx);
					return NULL;
				}
				record.size = *(int*)content_addr;
				content_addr += intSize;
				char* tmp_buffer = new char[record.size];	
				memcpy((void*)tmp_buffer, (void*)content_addr, record.size);
				content_addr += record.size;
				record.value = tmp_buffer;
				row.insert(make_pair(record_idx, record));
			}
			set.insert(make_pair(row_idx, row));
		}
		recordSets->insert(make_pair(set_idx, set));
	}
	return recordSets;
}

MapOutputParamSet* CDBClient::parse_output(void* output_buffer, int len) {
	MapOutputParamSet* outParams = new MapOutputParamSet;
	char* addr = (char*)output_buffer;
	char char_tmp = 0;
	char param_count = *addr;
	char param_idx = 0;
	addr += sizeof(char);
	for(int idx = 0; idx < param_count; idx++ ) {
		OutputParam output;
		param_idx = *(char*)addr;
		addr += sizeof(char);
		int len = strlen(addr);
		output.name = new char(len+1);
		memcpy(output.name, addr, len+1);
		addr += len + 1;
		output.type = *(int*)addr;
		addr += sizeof(int);
		output.size = *(int*)addr;
		addr += sizeof(int);
		output.value = new char[output.size];
		memcpy(output.value, addr, output.size);
		addr += output.size;
		outParams->insert(make_pair(idx, output));
	}
	return outParams;
}