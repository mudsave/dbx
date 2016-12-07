
#ifndef _DBObject_h
#define _DBObject_h

#include "mysql.h"
#include "DBShare.h"
#include <string.h>
#include <iostream>

using namespace std;

class CDBObject {
public:
	CDBObject(CMysqlQuery*, int);
	~CDBObject();
	void destroy();
	void result_info();
	int buildSpBuffer(char** buffer, MYSQL* mysql);

	//客户端查询信息
	CMysqlQuery* m_query;
	typedef list<char*> ListOutputParam;
	//传出参数列表
	ListOutputParam m_listop;

	int m_fd;
	char m_queueID;
	int m_operationID;
	int m_errno;
	char* m_error_msg;
	//结果集信息(不传给客户端)
	MapResultInfo m_mapResultInfo;

	//字段信息集
	MapFieldSets m_field_sets;
	int m_fieldSetsSize;
	//传出参数集
	MapOutputParamSet m_output_param_set;
	int m_outputParamsSize;
	//数据库记录集
	MapRecordSets m_record_sets;
	int m_recordSetsSize;

};


#endif
