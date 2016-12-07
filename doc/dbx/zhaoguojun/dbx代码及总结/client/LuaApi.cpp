
#include "LuaApi.h"

int CLuaDB::set_state(lua_State* L){
	m_lua_state = L;
}

void CLuaDB::do_return(DBResult* result) {
	lua_State* L = m_lua_state;
	ResultInfo& info = *(result->m_info);
	MapRecordSets& recordSets = *(result->m_records);
	MapFieldSets& fieldSets = *(result->m_fields);
	MapOutputParamSet& outParams = *(result->m_outputs);
	int sets_num = recordSets.size();
	lua_getfield(L, LUA_GLOBALSINDEX, "print_result");
	lua_newtable(L);
	lua_pushstring(L, "operation_id");
	lua_pushnumber(L, info.m_operationID);
	lua_settable(L, -3);
	lua_pushstring(L, "error");
	lua_pushnumber(L, info.m_errno);
	lua_settable(L, -3);
	char* msg_t = new char[info.len + 1];
	memcpy(msg_t, info.m_error_msg, info.len);
	msg_t[info.len] = 0;
	lua_pushstring(L, "error_msg");
	lua_pushstring(L, msg_t);
	lua_settable(L, -3);
	delete[] msg_t;
	lua_pushstring(L, "rt_sum");
	lua_pushnumber(L, sets_num);
	lua_settable(L, -3);

	for(int idx=0; idx < sets_num; idx++) {
		lua_newtable(L);
		MapRecordSet& record_set = recordSets[idx];
		MapFieldSet& field_set = fieldSets[idx];
		int column_count = field_set.size();
		int row_count = record_set.size();
		for (int row_idx = 0; row_idx < row_count; row_idx++){
			MapRecordRow& row = record_set[row_idx];
			lua_newtable(L);
			for (int record_idx = 0; record_idx < column_count; record_idx++){
				Field& field = field_set[record_idx];
				Record& record = row[record_idx];
				lua_pushstring(L, field.name);
				switch(field.type){
					case DB_TYPE_CHAR:{
						char tmp = *(char*)record.value;
						lua_pushnumber(L, tmp);
						break;
					}
					case DB_TYPE_INT:{
						int tmp = *(int*)record.value;
						lua_pushnumber(L, tmp);
						break;
					}
					case DB_TYPE_FLOAT:{
						int tmp = *(float*)record.value;
						lua_pushnumber(L, tmp);
						break;
					}
					case DB_TYPE_LONGLONG:{
						long long tmp = *(long long*)record.value;
						lua_pushnumber(L, 0);
						break;
					}
					case DB_TYPE_STRING:{
						char buffer[record.size + 1];
						memcpy(buffer, record.value, record.size);
						buffer[record.size] = 0;
						lua_pushstring(L, buffer);
						break;
					}
				}
				lua_settable(L, -3);
			}
			lua_rawseti(L, -2, row_idx+1);
		}
		lua_rawseti(L, -2, idx+1);
	}

	lua_pushstring(L, "output_params");
	lua_newtable(L);
	int output_count = outParams.size();
	for(int idx=0; idx < output_count; idx++ ) {
		OutputParam& output = outParams[idx];
		lua_pushstring(L, output.name);
		switch(output.type){
			case DB_TYPE_CHAR:{
				char tmp = *(char*)output.value;
				lua_pushnumber(L, tmp);
				break;
			}
			case DB_TYPE_INT:{
				int tmp = *(int*)output.value;
				lua_pushnumber(L, tmp);
				break;
			}
			case DB_TYPE_FLOAT:{
				int tmp = *(float*)output.value;
				lua_pushnumber(L, tmp);
				break;
			}
			case DB_TYPE_LONGLONG:{
				long long tmp = *(long long*)output.value;
				lua_pushnumber(L, (int)tmp);
				break;
			}
			case DB_TYPE_STRING:{
				char buffer[output.size + 1];
				memcpy(buffer, output.value, output.size);
				buffer[output.size] = 0;
				lua_pushstring(L, buffer);
				break;
			}
		}
		lua_settable(L, -3);	
	}
	lua_settable(L, -3);
	lua_call(L, 1, 0);
}


int mysql_query(lua_State* pState) {
	size_t length = 0;
	int idx = 0;
	CMysqlQuery mysqlQuery;
	mysqlQuery.m_queueID = luaL_checkint(pState, -1);
	lua_pop(pState, 1);
	if (lua_istable(pState, -1)) {
		lua_pushnil(pState);
		while(lua_next(pState, -2) != 0) {
			if(lua_type(pState, -2) == LUA_TSTRING) {
				const char* str = luaL_checkstring(pState, -2);
				if (strcmp(str, "sp") == 0) {
					mysqlQuery.m_actionType = 1;
				}
				else if (strcmp(str, "sql") == 0) {
					mysqlQuery.m_actionType = 0;
				}
				str = luaL_checklstring(pState, -1, &length);
				if (str) {
					mysqlQuery.m_sqlCommand = (void*)new char[length];
					mysqlQuery.m_sqlCommandSize = length;
					memcpy(mysqlQuery.m_sqlCommand, str, length);
				}
			}
			else if(lua_type(pState, -2) == LUA_TNUMBER) {
				MysqlParam param;
				param.key = luaL_checkint(pState, -2);
				int type = lua_type(pState, -1);
				switch(type) {
					case LUA_TBOOLEAN: {
						char b1 = lua_toboolean(pState, -1);
						param.type = PARAMCHAR;
						param.size = sizeof(char);
						param.value = (void*)new char(b1);
						break;
					}
					case LUA_TNUMBER: {
						lua_Number tf = lua_tonumber(pState, -1);
						int ti = (int)tf;
						if (tf - ti != 0) {
							param.type = PARAMFLOAT;
							param.size = sizeof(float);
							param.value = (void*)new float(tf);
						}else{
							param.type = PARAMINT;
							param.size = sizeof(int);
							param.value = (void*)new int(ti);
						}
						break;
					}
					case LUA_TSTRING: {
						param.type = PARAMSTRING;
						length = 0;
						const char* str = luaL_checklstring(pState, -1, &length);
						param.size = length;
						param.value = (void*)new char[length];
						memcpy(param.value, str, length);
						break;
					}
					case LUA_TTABLE:
						break;
					case LUA_TUSERDATA:
						break;
				}
				mysqlQuery.m_params.insert(make_pair(param.key, param));
			}
			lua_pop(pState, 1);
		}
	}
	CDBClient* db_client = CDBClient::GetInstance();
	int opid = db_client->generateOperationId();
	mysqlQuery.m_operationID = opid;
	mysqlQuery.show();
	lua_pushinteger(pState, opid);
	db_client->executeQuery(&mysqlQuery, &g_luaDB);
	return 1;
}