
#ifndef _SHARE_H
#define _SHARE_H

#include <map>

#include <pthread.h>
#include <semaphore.h>

#include <sys/time.h>
#include <sys/times.h>
#include <assert.h>
#include <error.h>
#include <errno.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <list>
#include <map>
#include <algorithm>
#include <string>

using namespace std;

// client -> server
enum DataType {
	PARAMCHAR		=1,
	PARAMINT		=2,
	PARAMBIGINT		=3,
	PARAMFLOAT		=4,
	PARAMSTRING 	=5,
	PARAMBIN 		=6,
	PARAMTABLE  	=7,
	PARAMEND 		=8
};

//server -> client
enum dbx_mysql_type {
	DB_TYPE_CHAR		=1,
	DB_TYPE_INT			=2,
	DB_TYPE_FLOAT		=3,
	DB_TYPE_LONGLONG	=4,
	DB_TYPE_STRING		=5,
	DB_TYPE_TIMESTAP	=6
};

struct MysqlParam {
	char key;
	char type;
	int size;
	void* value;
	MysqlParam(){
		key = 0;
		type = 0;
		size = 0;
		value = NULL;
	}
};

class DBResult;

typedef map<int, MysqlParam> map_mysqlParam;

class CMysqlQuery {
public:
	int m_operationID;
	int m_queueID;
	char m_actionType;//0 sql 1 sp
	int m_sqlCommandSize;
	void* m_sqlCommand;
	map_mysqlParam m_params;

	int show() {
		puts("----------------");
		puts("QUERY Content:");
		printf("operation id: %d\n", m_operationID);
		printf("queue id: %d\n", m_queueID);
		if (m_actionType) {
			printf("action type:procedure\n");
		}else {
			printf("action type:sql\n");
		}
		char buffer[m_sqlCommandSize + 1];
		memcpy(buffer, m_sqlCommand, m_sqlCommandSize);
		buffer[m_sqlCommandSize] = 0;
		printf("%s\n", buffer);
		map_mysqlParam::iterator iter = m_params.begin();

		char tmp[50];
		for (; iter != m_params.end(); iter++) {
			MysqlParam& param = iter->second;
			char type = param.type;
			switch(type) {
				case PARAMCHAR:
					memset(tmp, 0, 50);
					sprintf(tmp, "%d", *(char*)param.value);
					printf("[%d]<%s>:%s\n", param.key, "char", tmp);
					break;
				case PARAMINT:
					memset(tmp, 0, 50);
					sprintf(tmp, "%d", *(int*)param.value);
					printf("[%d]<%s>:%s\n", param.key, "int", tmp);
					break;
				case PARAMBIGINT:
					memset(tmp, 0, 50);
					sprintf(tmp, "%lld", *(long long*)param.value);
					printf("[%d]<%s>:%s\n", param.key, "long long", tmp);
					break;
				case PARAMFLOAT:
					memset(tmp, 0, 50);
					sprintf(tmp, "%f", *(float*)param.value);
					printf("[%d]<%s>:%s\n", param.key, "float", tmp);
					break;
				case PARAMTABLE:
					printf("[%d]<%s>:%s\n", param.key, "table", "");
					break;
				case PARAMBIN:
					printf("[%d]<%s>:%s\n", param.key, "binary", "");
					break;
				case PARAMSTRING: {
					char tmp_str[param.size+1];
					memcpy(tmp_str, param.value, param.size);
					tmp_str[param.size] = 0;
					printf("[%d]<%s>:%s\n", param.key, "string", tmp_str);
					break;
				}
			}
		}
		puts("----------------");
		return 0;
	}
};

struct Field {
	int type;
	char* name;
	Field():name(NULL){}
};

struct OutputParam {
	char* name;
	int type;
	int size;
	char* value;
	OutputParam():name(NULL), value(NULL){}
};

struct Record {
	int size;
	char* value;
	Record():value(NULL) {}
};

typedef map<int, Field> MapFieldSet;
typedef map<int, MapFieldSet> MapFieldSets;

typedef map<int, OutputParam> MapOutputParamSet;

typedef map<int, Record> MapRecordRow;
typedef map<int, MapRecordRow> MapRecordSet;
typedef map<int, MapRecordSet> MapRecordSets;

struct ResultInfo{
	int m_operationID;
	int m_errno;
	int len;
	char* m_error_msg;
};

struct _RowFields {
	int rows;
	int fields;
	_RowFields(int _row, int _fields):rows(_row), fields(_fields){}
	_RowFields(){}
};
typedef map<int, _RowFields> MapResultInfo;

class IDBCallback{
public:
	virtual void do_return(DBResult*) = 0;
};

class Mutex {
	public:
		Mutex(bool recursive = true) {
			if(recursive) {
				pthread_mutexattr_t attr;
				::pthread_mutexattr_init(&attr);
				::pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE_NP);
				::pthread_mutex_init(&m_mutex, &attr);
				::pthread_mutexattr_destroy(&attr);
			}
			else {
				::pthread_mutex_init(&m_mutex, NULL);
			}
		}
		~Mutex(){ ::pthread_mutex_destroy(&m_mutex); }
		void Lock(){ ::pthread_mutex_lock(&m_mutex); }
		void Unlock(){ ::pthread_mutex_unlock(&m_mutex); }
	private:
		pthread_mutex_t m_mutex;
};

class Semaphore {
sem_t m_sem;
public:
	Semaphore(int initCount = 0) {
		int ret = ::sem_init(&m_sem, 0, initCount);
	}
	~Semaphore(){ ::sem_destroy(&m_sem); }
	bool Wait(unsigned long timeOut = 0xffffffff) {
		int ret = 0;
		if(timeOut == 0xffffffff) {
			while(1) {
				ret == ::sem_wait(&m_sem);
				if(ret == 0) {
					return true;
				}
			}
		}
		else {
			timespec ts;
			ret = ::clock_gettime(CLOCK_REALTIME, &ts);
			ts.tv_sec += timeOut / 1000;
			ts.tv_nsec += (timeOut %1000) * 1000000;
			if(ts.tv_nsec >= 1000000000) {
				ts.tv_sec += 1;
				ts.tv_nsec -= 1000000000;
			}
			while(1) {
				ret = ::sem_timedwait(&m_sem, &ts);
				if(ret == 0) return true;
				if(errno == EINTR) continue;
				return false;
			}
		}
		return false;
	}
	void Post() {
		int ret = ::sem_post(&m_sem);
	}
};

class RecordSets {
public:
	static void print_field_sets(MapFieldSets& sets) {
		int set_sum = sets.size();
		MapFieldSets::iterator iter = sets.begin();
		for(; iter != sets.end(); iter++) {
			printf("field set: %d\n", iter->first);
			MapFieldSet& set = iter->second;
			MapFieldSet::iterator record_iter = set.begin();
			for(; record_iter != set.end(); record_iter++) {
				printf("%s  ", record_iter->second.name);
			}
			printf("\n");
		}
	}
	static void print_record_sets(MapRecordSets& sets, MapFieldSets& field_sets){
		MapRecordSets::iterator set_iter = sets.begin();
		for(; set_iter != sets.end(); set_iter++) {
			MapRecordSet& set = set_iter->second;
			MapFieldSet& field_set = field_sets[set_iter->first];
			MapRecordSet::iterator row_iter = set.begin();
			for(; row_iter != set.end(); row_iter++) {
				MapRecordRow& row = row_iter->second;
				MapRecordRow::iterator record_iter = row.begin();
				for(; record_iter != row.end(); record_iter++) {
					Record& record = record_iter->second;
					printf("[%d][%d][%d]:", set_iter->first, row_iter->first, record_iter->first);
					switch(field_set[record_iter->first].type){
						case DB_TYPE_CHAR:
							printf(" %d", *(char*)record.value);
							break;
						case DB_TYPE_INT:
							printf(" %d", *(int*)record.value);
							break;
						case DB_TYPE_FLOAT:
							printf(" %f", *(float*)record.value);
							break;
						case DB_TYPE_LONGLONG:
							printf(" %lld", *(long long*)record.value);
							break;
						case DB_TYPE_STRING:{
							char buffer[record.size + 1];
							memcpy(buffer, record.value, record.size);
							buffer[record.size] = 0;
							printf(" %s", buffer);
							break;
						}
					}
					printf("\n");
				}
			}
		}
	}
static void print_output_params(MapOutputParamSet& set) {
	int param_count = set.size();
	for(int idx = 0; idx < param_count; idx ++){
		OutputParam& output = set[idx];
		printf("[%d]<%s>", idx, output.name);
		switch (output.type){
			case DB_TYPE_CHAR:
				printf(" %d", *(char*)output.value);
				break;
			case DB_TYPE_INT:
				printf(" %d", *(int*)output.value);
				break;
			case DB_TYPE_FLOAT:
				printf(" %f", *(float*)output.value);
				break;
			case DB_TYPE_LONGLONG:
				printf(" %lld", *(long long*)output.value);
				break;
			case DB_TYPE_STRING:{
				char buffer[output.size + 1];
				memcpy(buffer, output.value, output.size);
				buffer[output.size] = 0;
				printf(" %s", buffer);
				break;				
			}	
		}
		printf("\n");
	}
}

	static void release_field_sets(MapFieldSets& sets) {
		MapFieldSets::iterator iter = sets.begin();
		for(; iter != sets.end(); iter++) {
			MapFieldSet& set = iter->second;
			MapFieldSet::iterator record_iter = set.begin();
			for(; record_iter != set.end();record_iter++) {
				delete[] record_iter->second.name;
				set.erase(record_iter);
			}
			sets.erase(iter);
		}	
	}

	static void release_record_sets(MapRecordSets& sets){
		MapRecordSets::iterator set_iter = sets.begin();
		for(; set_iter != sets.end(); set_iter++) {
			MapRecordSet& set = set_iter->second;
			MapRecordSet::iterator row_iter = set.begin();
			for(; row_iter != set.end(); row_iter++) {
				MapRecordRow& row = row_iter->second;
				MapRecordRow::iterator record_iter = row.begin();
				for(; record_iter != row.end(); record_iter++) {
					Record& record = record_iter->second;
					delete[] record.value;
					row.erase(record_iter);
				}
				set.erase(row_iter);
			}
			sets.erase(set_iter);
		}
	}

};


struct DBResult {
	ResultInfo* m_info;
	MapFieldSets* m_fields;
	MapRecordSets* m_records;
	MapOutputParamSet* m_outputs;

	void show(){
		printf("\n&&&\noperation id: %d\n", m_info->m_operationID);
		printf("error no: %d\n", m_info->m_errno);
		char tmp[m_info->len+1];
		tmp[m_info->len+1] = 0;
		memcpy(tmp, m_info->m_error_msg, m_info->len);
		printf("error msg: %s\n", tmp);
		puts("&&&");
		RecordSets::print_field_sets(*m_fields);
		RecordSets::print_record_sets(*m_records, *m_fields);
		RecordSets::print_output_params(*m_outputs);
	}
};

#endif