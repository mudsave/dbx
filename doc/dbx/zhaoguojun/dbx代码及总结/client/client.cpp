
#include "DBShare.h"
#include "DBClient.h"
extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}
#include "LuaApi.h"

using namespace std;

CLuaDB g_luaDB;

void load_lua(){
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);
	lua_pushcfunction(L, mysql_query);
	lua_setglobal(L, "mysql_query");
	luaL_dofile(L, "client.lua");
	g_luaDB.set_state(L);
}

int query() {
	CQueryClient *query_client = new CQueryClient;
	const char sql[]  = "select * from mind where `roleID` = ?;"; 
	query_client->buildSqlQuery(sql, 0);
	query_client->addParams(176);
	query_client->executeQuery();
}


int main() {
	load_lua();
	CDBClient *client = CDBClient::GetInstance();
	char ip[] = "172.16.2.218";
	client->connect(ip, 1027);

	query();
	sleep(5);
	client->on_return();
	client->close();
	return 0;
}