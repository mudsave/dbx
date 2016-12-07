

#include "DBObject.h"

CDBObject::CDBObject(CMysqlQuery* p_query, int fd) {
	m_fd = fd;
	m_queueID = p_query->m_queueID;
	m_query = p_query;

	m_fieldSetsSize = 0;
	m_outputParamsSize = 0;
	m_recordSetsSize = 0;

	m_operationID = p_query->m_operationID;
	m_errno = 0;
	char tmp[] = "Normal";
	m_error_msg = new char[strlen(tmp)+1];
	memcpy(m_error_msg, tmp, strlen(tmp)+1);
}

CDBObject::~CDBObject() {
}

void CDBObject::result_info() {
	printf("\n&&&\noperation id: %d\n", m_operationID);
	printf("error no: %d\n", m_errno);
	printf("error msg: %s\n", m_error_msg);
	puts("&&&");
	RecordSets::print_field_sets(m_field_sets);
	RecordSets::print_record_sets(m_record_sets, m_field_sets);
	RecordSets::print_output_params(m_output_param_set);
}

int CDBObject::buildSpBuffer(char** buffer, MYSQL* mysql) {
	char str1[] = "CALL ";
	char str2[] = "( ";
	char str3[] = " );";
	char str4[] = ", ";
	int length = strlen(str1) + strlen(str2) + strlen(str3);
	length += m_query->m_sqlCommandSize;
	map_mysqlParam::iterator iter = m_query->m_params.begin();
	for(; iter != m_query->m_params.end(); iter++) {
		MysqlParam& param = iter->second;
		switch(param.type) {
			case PARAMCHAR:
				length += 1;
				break;
			case PARAMINT:
				length += 11;
				break;
			case PARAMBIGINT:
				length += 20;
				break;
			case PARAMFLOAT:
				length += 50;
				break;
			case PARAMSTRING:
				length += param.size;
				break;
			case PARAMBIN:
				length += param.size*2;
				break;
		}
	}

	char* sql = new char[length];
	memset(sql, 0, length);
	void* addr = sql;
	addr = mempcpy(addr, str1, strlen(str1));
	addr = mempcpy(addr, m_query->m_sqlCommand, m_query->m_sqlCommandSize);
	addr = mempcpy(addr, str2, strlen(str2));
	int param_size = m_query->m_params.size();
	int i = 1;
	char tmp[50];
	for (; i<=param_size; i++) {
		MysqlParam& param = m_query->m_params[i];
		memset(tmp, 0, 50);
		switch(param.type) {
			case PARAMCHAR:{
				char tmp_t = *(char*)(param.value);
				sprintf(tmp, "%d", tmp_t);
				addr = mempcpy(addr, tmp, strlen(tmp));
				break;
			}
			case PARAMINT:{
				int tmp_t = *(int*)param.value;
				sprintf(tmp, "%d", tmp_t);
				addr = mempcpy(addr, tmp, strlen(tmp));
				break;
			}
			case PARAMBIGINT:{
				long long tmp_t = *(long long*)param.value;
				sprintf(tmp, "%lld", tmp_t);
				addr = mempcpy(addr, tmp, strlen(tmp));
				break;
			}
			case PARAMFLOAT:{
				float tmp_t = *(float*)param.value;
				sprintf(tmp, "%f", tmp_t);
				addr = mempcpy(addr, tmp, strlen(tmp));
				break;
			}
			case PARAMSTRING:{
				char *tmp_buffer = NULL;
				int buffer_size = 0;
				int size = 0;
				char first_char = *(char*)param.value;
				if (first_char == '@'){
					char *output = new char[param.size + 1];
					memcpy(output, param.value, param.size);
					output[param.size] = 0;
					m_listop.push_back(output);
					size = mysql_real_escape_string(mysql, (char*)addr, (const char*)param.value, param.size);
				}
				else {
					buffer_size = param.size + 2;
					tmp_buffer = new char[buffer_size];
					void *tmp = (void*)tmp_buffer;
					char quote = '"';
					tmp = mempcpy(tmp, &quote, 1);
					tmp = mempcpy(tmp, param.value, param.size);
					tmp = mempcpy(tmp, &quote, 1);
					//size = mysql_real_escape_string(mysql, (char*)addr, (const char*)tmp_buffer, buffer_size);
					memcpy(addr, tmp_buffer, buffer_size);
					size = buffer_size;
					delete[] tmp_buffer;
				}
				addr = (void*)( (char*)addr + size );
				break;
			}
			case PARAMBIN:{
				int size = mysql_hex_string((char*)addr, (const char*)param.value, param.size);
				addr = (void*)( (char*)addr + size );
				break;
			}
		}
		if (i < param_size) {
			addr = mempcpy(addr, str4, strlen(str4));
		}
	}
	addr = mempcpy(addr, str3, strlen(str3));
	int len = (char*)addr - sql;
	*buffer = sql;
	return len;
}

//to-do 这个还需重新，关于内存释放的，还没处理好
void CDBObject::destroy() {
	int idx = 0;
	int j = 0;
	int tmp_len = 0;
	MapRecordSets::iterator iter = m_record_sets.begin();
	for (; iter != m_record_sets.end(); ) {
		int set_num = iter->first;
		MapFieldSet &field_set = m_field_sets[set_num];
		for (idx=0; idx<field_set.size(); idx++) {
			delete[] field_set[idx].name;
		}
		m_field_sets.erase(set_num);
		MapRecordSet &record_set =  iter->second;
		for(idx=0; idx<record_set.size(); idx++) {
			MapRecordRow &row = record_set[idx];
			for(j=0; j<row.size(); j++) {
				delete[] row[j].value;
			}
			record_set.erase(idx);
		}
		m_record_sets.erase(iter++);
	}
	MapOutputParamSet::iterator itera = m_output_param_set.begin();
	for (; itera != m_output_param_set.end(); ) {
		OutputParam &param = itera->second;
		delete[] param.name;
		delete[] param.value;
		m_output_param_set.erase(itera++);
	}
}
