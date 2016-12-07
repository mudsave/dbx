
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

int lua_query(lua_State* L) {
	lua_getfield(L, LUA_GLOBALSINDEX, "query");
	lua_call(L, 0, 0);
	return 0;
}

int main() {
	load_lua();
	CDBClient *client = CDBClient::GetInstance();
	char ip[] = "172.16.2.218";
	client->connect(ip, 1027);

	lua_query(g_luaDB.m_lua_state);
	sleep(5);
	client->on_return();
	client->close();
	return 0;
}