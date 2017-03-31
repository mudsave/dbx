
#define HTTP_GET 1
#define HTTP_POST 2
#define HTTP_OTHER 0

#include "luaUtils.h"

int pushRequest(lua_State* L, MsgRequest* msg, int id)
{
	const char* str;
	lua_getglobal(L, "printError");
	lua_getglobal(L, "processRequest");
	lua_newtable(L);
	lua_pushliteral(L, "id");
	lua_pushnumber(L, id);
	lua_rawset(L, -3);
	lua_pushliteral(L, "url");
	str = (msg->url).c_str();
	lua_pushlstring(L, str, strlen(str));
	lua_rawset(L, -3);
	lua_pushliteral(L, "method");
	if(strcasecmp((msg->method).c_str(), "GET") == 0)
		lua_pushnumber(L, HTTP_GET);
	else if(strcasecmp((msg->method).c_str(), "POST") == 0)
		lua_pushnumber(L, HTTP_POST);
	else
		lua_pushnumber(L, 0);
	lua_rawset(L, -3);
	map<string, string>& params = msg->params;
	int argc = params.size();
	map<string, string>::iterator iter = params.begin();
	for(; iter != params.end(); iter++)
	{
		str = (iter->first).c_str();
		lua_pushlstring(L, str, strlen(str));
		str = (iter->second).c_str();
		lua_pushlstring(L, str, strlen(str));
		lua_rawset(L, -3);
	}
	int rt = lua_pcall(L, 1, 0, -3);
	if(rt)
	{
		printf ("pushRequest error![%d]\n", rt);
		return -1;
	}
}

int onResponse(lua_State* L)
{
	int id = (int)luaL_checknumber(L, 1);
	ConContext* context = g_admin.getContext(id);
	if(0 == context)
		return 0;
	MsgResponse* msg = new MsgResponse;
	int result = (int)luaL_checknumber(L, 2);
	msg->result = result;
	size_t len = 0;
	const char* json = lua_tolstring(L, 3, &len);
	char* tmp = new char[len+1]; 
	tmp[len]=0;
	memcpy(tmp, json, len);
	msg->response = tmp;
	context->response = msg;
	//printf ("[result] id=%d, result=%d, json=%s\n", id, result, tmp);
	context->post();
	return 0;
}

int pushFunc(lua_State* L)
{
	lua_pushcfunction(L, onResponse);
	lua_setglobal(L, "onResponse");
}

