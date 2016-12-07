
#include "SqlOuter.h"

CSqlOuter::CSqlOuter(){}

void CSqlOuter::Init(){
	if ( mysql_library_init(0, NULL, NULL) ) {
		puts("ERROR: mysql_library_init error !");
		exit(-1);
	}

	if ( !mysql_init(&m_mysql) ) {
		puts("ERROR: mysql_init error !");
		exit(-1);
	}
	if ( !mysql_real_connect(&m_mysql, g_scheme.serverIp, g_scheme.usrName,
			g_scheme.passWd, g_scheme.dbName, 0, NULL, CLIENT_MULTI_STATEMENTS) )
	{
		puts("ERROR: connect failed!");
		printf("%s\n", mysql_error(&m_mysql));
	}
}

bool CSqlOuter::IsAlive() {
	if ( mysql_ping(&m_mysql) == 0) {
		return  true;
	}else {
		return false;
	}
}

CSqlOuter::~CSqlOuter() {
	mysql_close(&m_mysql);
	mysql_library_end();
}

int CSqlOuter::Execute(CDBObject* pobj) {
	if (pobj->m_query->m_actionType == 1) {
		Execute_sp(pobj);
	}else {
		Execute_sql(pobj);
	}
}

int CSqlOuter::Execute_sql(CDBObject* pobj) {
	CMysqlQuery* queryObj = pobj->m_query;
	int param_num = queryObj->m_params.size();
	const char* sql = (const char*)queryObj->m_sqlCommand;
	int sql_size = queryObj->m_sqlCommandSize;
	map_mysqlParam& query_params = queryObj->m_params;

	int param_count, column_count;
	MYSQL_STMT *stmt;
	MYSQL_RES *prepare_meta_result;
	MYSQL_FIELD *fields;
	MYSQL_BIND bind[PARAMSNUM];
	unsigned long stmt_length[PARAMSNUM];
	my_bool stmt_is_null[PARAMSNUM];
	// char stmt_char[PARAMSNUM];
	// int stmt_int[PARAMSNUM];
	// long long stmt_longlong[PARAMSNUM];
	// float stmt_float[PARAMSNUM];
	char stmt_string[PARAMSNUM][512];

	stmt = mysql_stmt_init(&m_mysql);
	if (!stmt) {
		fprintf(stderr, " mysql_stmt_init()\n");
		exit(0);
	}
	if (mysql_stmt_prepare(stmt, sql, sql_size)) {
		fprintf(stderr, " mysql_stmt_prepare()\n");
		fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
		exit(0);
	}
	param_count= mysql_stmt_param_count(stmt);
	if (param_count != param_num) {
		fprintf(stderr, "ERROR:satement params not match!\n");
	}
	prepare_meta_result = mysql_stmt_result_metadata(stmt);
	column_count= mysql_num_fields(prepare_meta_result);
	fields = mysql_fetch_fields(prepare_meta_result);
	FillFields(column_count, fields, pobj, 0);

	memset(bind, 0, sizeof(bind));
	int idx = 1;
	for(; idx <= param_num; idx++) {
		MysqlParam& param = query_params[idx];
		switch(param.type) {
			case PARAMCHAR:
				bind[idx-1].buffer_type = MYSQL_TYPE_TINY;
				bind[idx-1].buffer = param.value;
				bind[idx-1].is_null = (my_bool*)0;
				break;
			case PARAMINT:
				bind[idx-1].buffer_type = MYSQL_TYPE_LONG;
				bind[idx-1].buffer = param.value;
				bind[idx-1].is_null = (my_bool*)0;
				break;
			case PARAMBIGINT:
				bind[idx-1].buffer_type = MYSQL_TYPE_LONGLONG;
				bind[idx-1].buffer = param.value;
				bind[idx-1].is_null = (my_bool*)0;
				break;
			case PARAMFLOAT:
				bind[idx-1].buffer_type = MYSQL_TYPE_FLOAT;
				bind[idx-1].buffer = param.value;
				bind[idx-1].is_null = (my_bool*)0;
				break;
			case PARAMSTRING:
				bind[idx-1].buffer_type = MYSQL_TYPE_STRING;
				bind[idx-1].buffer = param.value;
				bind[idx-1].is_null = (my_bool*)0;
				bind[idx-1].buffer_length = param.size;
				stmt_length[idx-1] = param.size;
				bind[idx-1].length = &stmt_length[idx-1];
				break;
			case PARAMBIN:
				bind[idx-1].buffer_type = MYSQL_TYPE_STRING;
				bind[idx-1].buffer = param.value;
				bind[idx-1].is_null = (my_bool*)0;
				bind[idx-1].buffer_length = param.size;
				stmt_length[idx-1] = param.size;
				bind[idx-1].length = &stmt_length[idx-1];
				break;
			default:
				fprintf(stderr, "ERROR: invalid TYPE!");
				break;
		}

	}
	if (mysql_stmt_bind_param(stmt, bind)) {
		fprintf(stderr, "ERROR: mysql_stmt_bind_param");
		fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
		exit(0);
	}
	if (mysql_stmt_execute(stmt)) {
		fprintf(stderr, "ERROR: mysql_stmt_execute");
		fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
		exit(0);
	}

	fields = mysql_fetch_fields(prepare_meta_result);
	memset(bind, 0, sizeof(bind));
	for (int i=0; i < column_count; i++){
		bind[i].buffer_type = fields[i].type;
		switch(fields[i].type) {
			case MYSQL_TYPE_TINY:
				bind[i].buffer = (void*)new char(0);
				bind[i].is_null = &stmt_is_null[i];
				bind[i].length = &stmt_length[i];
				break;
			case MYSQL_TYPE_LONG:
				bind[i].buffer = (void*)new int(0);
				bind[i].is_null = &stmt_is_null[i];
				bind[i].length = &stmt_length[i];
				break;
			case MYSQL_TYPE_FLOAT:
				bind[i].buffer = (void*)new float(0);
				bind[i].is_null = &stmt_is_null[i];
				bind[i].length = &stmt_length[i];
				break;
			case MYSQL_TYPE_LONGLONG:
				bind[i].buffer = (void*)new long long(0);
				bind[i].is_null = &stmt_is_null[i];
				bind[i].length = &stmt_length[i];
				break;
			case MYSQL_TYPE_STRING:
			case MYSQL_TYPE_VAR_STRING:
				bind[i].buffer = (void*)stmt_string[i];
				bind[i].buffer_length = 512;
				bind[i].is_null = &stmt_is_null[i];
				bind[i].length = &stmt_length[i];
				break;
			default:
				break;
		}
	}
	if (mysql_stmt_bind_result(stmt, bind)) {
		fprintf(stderr, " mysql_stmt_bind_result() failed\n");
		fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
		exit(0);
	}
	if (mysql_stmt_store_result(stmt)) {
		fprintf(stderr, " mysql_stmt_store_result() failed\n");
		fprintf(stderr, " %s\n", mysql_stmt_error(stmt));
		exit(0);
	}

	int row_count = 0;
	MapRecordSet record_set;
	while (!mysql_stmt_fetch(stmt)) {
		MapRecordRow record_row;
		for(int i=0; i < column_count; i++) {
			Record rd;
			switch(bind[i].buffer_type) {
				case MYSQL_TYPE_TINY:
					rd.size = sizeof(char);
					rd.value = new char(0);
					memcpy(rd.value, bind[i].buffer, rd.size);
					break;
				case MYSQL_TYPE_LONG:
					rd.size = sizeof(int);
					rd.value = (char*)new int(0);
					memcpy(rd.value, bind[i].buffer, rd.size);
					break;
				case MYSQL_TYPE_FLOAT:
					rd.size = sizeof(float);
					rd.value = (char*)new float(0);
					memcpy(rd.value, bind[i].buffer, rd.size);
					break;
				case MYSQL_TYPE_LONGLONG:
					rd.size = sizeof(long long);
					rd.value = (char*)new long long(0);
					memcpy(rd.value, bind[i].buffer, rd.size);
					break;
				case MYSQL_TYPE_STRING:
				case MYSQL_TYPE_VAR_STRING: {
					rd.size = stmt_length[i];
					rd.value = new char[rd.size];
					memcpy(rd.value, bind[i].buffer, rd.size);
					break;
					}
				default:
					break;
			}
			record_row.insert( make_pair(i, rd) );
			pobj->m_recordSetsSize += sizeof(rd.size) + rd.size;
		}
		record_set.insert( make_pair(row_count, record_row) );
		row_count++;
	}
	_RowFields tRowFields(row_count, column_count);
	pobj->m_mapResultInfo.insert(make_pair(0, tRowFields));
	pobj->m_record_sets.insert( make_pair(0, record_set) );
	return 0;
}

int CSqlOuter::Execute_sp(CDBObject* pobj) {
	char* sp;
	int sp_len = pobj->buildSpBuffer(&sp, &m_mysql);
	char tmp[sp_len+1];
	memcpy(tmp, sp, sp_len);
	tmp[sp_len] = 0;
	printf("%s\n", tmp);
	MYSQL_RES *mysql_res;
	MYSQL_FIELD *fields;
	MYSQL_ROW row;
	unsigned long *lengths;
	int field_num=0, rt=0, idx=0, row_num=0;
	int record_set_idx = 0;
	if ( mysql_real_query(&m_mysql, sp, sp_len) ){
		printf("ERROR query:%s\n", mysql_error(&m_mysql));
		return -1;
	}
	do {
		MapRecordSet record_set;
		mysql_res = mysql_store_result(&m_mysql);
		if (mysql_res == NULL) {
			if (mysql_field_count(&m_mysql) == 0 ) {
				printf("LOG:no result, %lld rows affected\n",
						mysql_affected_rows(&m_mysql));
			}else {
				printf("ERROR: store result:%s\n", mysql_error(&m_mysql));
				break;
			}
		}
		else {
			field_num = mysql_num_fields(mysql_res);
			fields = mysql_fetch_fields(mysql_res);
			FillFields(field_num, fields, pobj, record_set_idx);
			row_num = 0;
			row = mysql_fetch_row(mysql_res);
			lengths = mysql_fetch_lengths(mysql_res);
			while (row) {
				//to-do error
				MapRecordRow record_row;
				for(idx = 0; idx < field_num; idx++) {
					Record rd;
					//to-do row[idx] == NULL
					if (row[idx] == NULL) {
						rd.size = 0;
						rd.value = 0;
						continue;
					}
					char tmp[50];
					memset(tmp, 0, 50);
					switch(fields[idx].type){
						case MYSQL_TYPE_TINY:{
							strncpy(tmp, row[idx], lengths[idx]);
							rd.size = sizeof(char);
							rd.value = new char(atoi(tmp));
							break;
						}
						case MYSQL_TYPE_LONG:{
							strncpy(tmp, row[idx], lengths[idx]);
							rd.size = sizeof(int);
							rd.value = (char*) new int(atoi(tmp));
							break;
						}
						case MYSQL_TYPE_FLOAT:{
							strncpy(tmp, row[idx], lengths[idx]);
							rd.size = sizeof(float);
							rd.value = (char*) new float(atof(tmp));
							break;
						}
						case MYSQL_TYPE_LONGLONG:{
							strncpy(tmp, row[idx], lengths[idx]);
							rd.size = sizeof(long long);
							rd.value = (char*) new long long(atoll(tmp));
							break;
						}
						case MYSQL_TYPE_STRING:
						case MYSQL_TYPE_VAR_STRING:{
							rd.size = lengths[idx];
							rd.value = new char[rd.size];
							strncpy(rd.value, row[idx], rd.size);
							break;
						}
					}
					record_row.insert( make_pair(idx, rd) );
					pobj->m_recordSetsSize += sizeof(rd.size) + rd.size;
				}
				record_set.insert( make_pair(row_num, record_row) );
				row = mysql_fetch_row(mysql_res);
				row_num++;
			}
			_RowFields tRowFields(row_num, field_num);
			pobj->m_mapResultInfo.insert(make_pair(record_set_idx, tRowFields));
			pobj->m_record_sets.insert( make_pair(record_set_idx, record_set) );
			mysql_free_result(mysql_res);
		}
		record_set_idx++;
		rt = mysql_next_result(&m_mysql);
		if (rt > 0) {
			//to-do error
			printf("ERROR next result:%s\n", mysql_error(&m_mysql));
			return -1;
		}
	}while(rt == 0);
	FetchOutputParams(pobj);
	return 0;
}

int CSqlOuter::FetchOutputParams(CDBObject* pobj) {
	char str1[] = "select ";
	char str2[] = ", ";
	CDBObject::ListOutputParam& outputs = pobj->m_listop;
	CDBObject::ListOutputParam::iterator iter = outputs.begin();
	int count = strlen(str1);
	for(; iter != outputs.end(); iter++) {
		count += strlen(*iter) + strlen(str2);
	}
	char *buffer = new char[count];
	void *addr = (void*)buffer;
	addr = mempcpy(addr, str1, strlen(str1));
	iter = outputs.begin();
	for(; iter != outputs.end(); iter++) {
		addr = mempcpy(addr, *iter, strlen(*iter));
		addr = mempcpy(addr, str2, strlen(str2));
	}
	buffer[count-2] = ';';
	buffer[count-1] = 0;
	printf("[OutPut]%s\n", buffer);

	MYSQL_RES *mysql_result;
	MYSQL_FIELD *mysql_filed;
	MYSQL_ROW row;
	unsigned int field_count;
	unsigned long * lengths;

	if( mysql_real_query(&m_mysql, buffer, strlen(buffer)) ){
		printf("ERROR:mysql_query\n");
		printf("%s\n", mysql_error(&m_mysql));
		exit(-1);
	}
	mysql_result = mysql_store_result(&m_mysql);
	mysql_filed = mysql_fetch_fields(mysql_result);
	field_count = mysql_num_fields(mysql_result);
	row = mysql_fetch_row(mysql_result);
	if (!row){
		mysql_free_result(mysql_result);
		return 0; 
	}
	lengths = mysql_fetch_lengths(mysql_result);
	for(int idx = 0; idx < field_count; idx++) {
		//printf("%s[%d]<%lld>%s\n", mysql_filed[idx].name, idx, lengths[idx], row[idx]);
		OutputParam output;
		int name_size = strlen(mysql_filed[idx].name) + 1;
		output.name = new char(name_size);
		memcpy(output.name, mysql_filed[idx].name, name_size);
		output.name[name_size] = 0;
		char tmp[50];
		memset(tmp, 0, 50);
		switch(mysql_filed[idx].type){
			case MYSQL_TYPE_TINY:{
				output.type = DB_TYPE_CHAR;
				strncpy(tmp, row[idx], lengths[idx]);
				output.size = sizeof(char);
				output.value = new char(atoi(tmp));
				break;
			}
			case MYSQL_TYPE_LONG:{
				output.type = DB_TYPE_INT;
				strncpy(tmp, row[idx], lengths[idx]);
				output.size = sizeof(int);
				output.value = (char*) new int(atoi(tmp));
				break;
			}
			case MYSQL_TYPE_FLOAT:{
				output.type = DB_TYPE_FLOAT;
				strncpy(tmp, row[idx], lengths[idx]);
				output.size = sizeof(float);
				output.value = (char*) new float(atof(tmp));
				break;
			}
			case MYSQL_TYPE_LONGLONG:{
				output.type = DB_TYPE_LONGLONG;
				strncpy(tmp, row[idx], lengths[idx]);
				output.size = sizeof(long long);
				output.value = (char*) new long long(atoll(tmp));
				break;
			}
			case MYSQL_TYPE_STRING:
			case MYSQL_TYPE_VAR_STRING:{
				output.type = DB_TYPE_TIMESTAP;
				output.size = lengths[idx];
				output.value = new char[output.size];
				strncpy(output.value, row[idx], output.size);
				break;
			}
		}
		pobj->m_outputParamsSize += name_size + 2*sizeof(int) + output.size;
		pobj->m_output_param_set.insert(make_pair(idx, output));
	}
	mysql_free_result(mysql_result);
	return 0;
}


void CSqlOuter::FillFields(int num, MYSQL_FIELD* fields, CDBObject* pobj, int idx) {
	int buffSize = 0;
	int i = 0;
	int name_len = 0;
	MapFieldSet field_set;
	for(; i < num; i++) {
		Field field;
		name_len = fields[i].name_length + 1;
		field.name = new char[name_len];
		memset(field.name, 0, name_len);
		strncpy(field.name, fields[i].name, name_len-1);
		field.name[name_len] = 0;
		switch (fields[i].type) {
			case MYSQL_TYPE_TINY:
				field.type = DB_TYPE_CHAR;
				break;
			case MYSQL_TYPE_LONG:
				field.type = DB_TYPE_INT;
				break;
			case MYSQL_TYPE_FLOAT:
				field.type = DB_TYPE_FLOAT;
				break;
			case MYSQL_TYPE_LONGLONG:
				field.type = DB_TYPE_LONGLONG;
				break;
			case MYSQL_TYPE_STRING:
			case MYSQL_TYPE_VAR_STRING:
				field.type = DB_TYPE_STRING;
				break;
			case MYSQL_TYPE_TIMESTAMP:
				field.type = DB_TYPE_TIMESTAP;
				break;
		}
		field_set.insert(make_pair(i, field));
		buffSize += name_len + sizeof(field.type);
	}
	pobj->m_fieldSetsSize += buffSize;
	pobj->m_field_sets.insert( make_pair(idx, field_set) );
}







