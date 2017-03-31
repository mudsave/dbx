
#include <sys/types.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <stdio.h>
#include <string.h>

#include "lindef.h"
#include "Sock.h"
#include "lua.hpp"
#include "client.h"
#include "luaUtils.h"

#include "admin.h"

using namespace std;

static const char *errorJson = "{\"result\":-1}";

static void HttpCompleted(void *cls, struct MHD_Connection *connection,
		void **con_cls, enum MHD_RequestTerminationCode toe)
{
	if(0 == *con_cls)
		return;
	printf("End connection:%p\n", connection);
	ConContext* context = (ConContext*)(*con_cls);
	g_admin.rmContext(context);
	delete context;
	*con_cls = 0;
}

static int sendResult(struct MHD_Connection *connection, const char *page, int status_code)
{
	int ret;
	struct MHD_Response *response;
	response = MHD_create_response_from_buffer (strlen(page), (void *)page,
				MHD_RESPMEM_MUST_COPY);
	if (!response)
		return MHD_NO;
	MHD_add_response_header(response, MHD_HTTP_HEADER_CONTENT_TYPE, "text/json");
	ret = MHD_queue_response(connection, status_code, response);
	MHD_destroy_response(response);
	return ret;
}

static int getParams(void *cls, enum MHD_ValueKind, const char* key, const char* value)
{
	MsgRequest* msg = (MsgRequest*)cls;
	//重复参数会替换
	msg->params.insert(make_pair<string, string>(string(key), string(value)));
	return  MHD_YES;
}

static int HttpAccess(void *cls, struct MHD_Connection *connection,	
		const char *url, const char *method,
		const char *version, const char *upload_data,
		size_t *upload_data_size, void **con_cls
		)
{
	if (0 == *con_cls)
	{
		static int count = 0;
		printf("\n*****\nNew Connection:%p\n", connection);
		printf("\turl:%s\n", url);
		printf("\tmethod:%s\n", method);
		count++;
		ConContext* context = new ConContext(count);	
		*con_cls = (void*)context;
		g_admin.addContext(context);
		return MHD_YES;
	}
	printf("$ con_cls:%p\n", *con_cls);
	ConContext *context = (ConContext*) *con_cls;
	/*
	封装request信息
	先主线程投递任务
	MHD_suspend_connection(connection);
	等待被唤醒 MHD_resume_connection(connection);
	拿到result 封装成response
	*/
	context->connection = connection;
	MsgRequest *msg = new MsgRequest();
	msg->url = string(url);
	msg->method = string(method);
	if (0 == strcasecmp(method, "GET")) {
		MHD_get_connection_values(connection, MHD_GET_ARGUMENT_KIND, getParams, (void*)msg);
	}
	if (0 == strcasecmp(method, "POST")) {
		MHD_get_connection_values(connection, MHD_POSTDATA_KIND, getParams, (void*)msg);
	}
	context->request = msg;
	g_admin.m_pThreadsPool->QueueTask(context, (void*)context, 0);
	g_admin.m_pThreadsPool->RegTimer(&g_admin, (HANDLE)context, 0, 1000, 0, "request timeout!");
	MHD_suspend_connection(connection);
	context->wait();
	MHD_resume_connection(connection);
	MsgResponse* rmsg = context->response;
	if (rmsg != NULL){
		if (rmsg->result != -1){
			return sendResult(connection, rmsg->response, MHD_HTTP_OK);
			delete rmsg;
		}
	}
	return sendResult(connection, errorJson, MHD_HTTP_OK);	
}

bool CAdmin::init(short _port)
{
	m_pThreadsPool = GlobalThreadsPool();
	daemon = MHD_start_daemon(
			MHD_USE_SELECT_INTERNALLY | MHD_USE_SUSPEND_RESUME,
			_port,
			NULL, NULL,
			HttpAccess, (void*)this,
			MHD_OPTION_NOTIFY_COMPLETED, HttpCompleted, NULL,
			//MHD_OPTION_THREAD_POOL_SIZE, 5,
			MHD_OPTION_END	
			);
	return (0 != daemon);
}

bool CAdmin::start()
{
}

bool CAdmin::stop()
{
	map<int, ConContext*>::iterator iter = m_contexts.begin();
	while(iter != m_contexts.end())
	{
		iter->second->post();
		delete iter->second;
		m_contexts.erase(iter++);
	}
	MHD_stop_daemon(daemon);
}

ConContext* CAdmin::getContext(int id)
{
	map<int, ConContext*>::iterator iter = m_contexts.find(id);
	if(iter == m_contexts.end())
		return NULL;
	return iter->second;
}

void CAdmin::addContext(ConContext* context)
{
	m_contexts.insert(make_pair<int, ConContext*>(context->id, context));
}

void CAdmin::rmContext(ConContext* context)
{
	m_contexts.erase(context->id);
}

HRESULT CAdmin::Do(HANDLE hContext)
{
	ConContext* con = (ConContext*) hContext;
	if(0 != getContext(con->id))
	{
		MsgResponse *msg = new MsgResponse(-1, 0);
		con->response = msg;
		con->post();
		return S_OK;
	}
	return S_FALSE;
}

HRESULT ConContext::Do(HANDLE hContext)
{
	ConContext* con = (ConContext*) hContext;
	if(0 != g_admin.getContext(con->id))
	{
		con->process();
		return S_OK;
	}
	return S_FALSE;
}

int ConContext::process()
{
	lua_State* L = g_client.getLuaState();
	pushRequest(L, request, id);
}

