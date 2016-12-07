
#include "DBServer.h"


CDBServer::CDBServer(){
	m_sock = new CSock(this);
	m_engine = CDBEngine::GetInstance();
	m_engine->Create(this);
}

CDBServer::~CDBServer(){
	//delete m_sock;
	CDBEngine::Release();
	//to-do release memory
	m_sock = NULL;
	m_engine = NULL;
}

int CDBServer::listen(const char* ip, unsigned short port){
	m_sock->listen(ip, port);
	return 0;
}

void CDBServer::on_connect(int fd, const char* ip, unsigned short port){
	printf("[%s][%d]<%d> connected!\n", ip, port, fd);
}

void CDBServer::on_close(int fd){
	printf("%d disconnected!\n", fd);
}

void CDBServer::on_recv(void* data, int len, int fd){
	m_query = new CMysqlQuery();
	char* addr = (char*)data;

	int int_tmp = 0;
	char char_tmp = 0;
	int int_size = sizeof(int);
	int char_size = sizeof(char);
	int_tmp = *(int*)addr;
	addr += int_size;
	m_query->m_operationID = int_tmp;

	int_tmp = *(int*)addr;
	addr += int_size;
	m_query->m_queueID = int_tmp;

	char_tmp = *(char*)addr;
	addr += char_size;
	char param_sum = char_tmp;

	char_tmp = *(char*)addr;
	addr += char_size;
	m_query->m_actionType = char_tmp;

	int_tmp = *(int*)addr;
	addr += int_size;
	m_query->m_sqlCommandSize = int_tmp;
	m_query->m_sqlCommand = (void*)new char[int_tmp];
	memcpy(m_query->m_sqlCommand, addr, int_tmp);
	addr += int_tmp;

	int i = 1;
	for(;i <= param_sum; i++) {
		MysqlParam param;
		char_tmp = *(char*)addr;
		addr += char_size;
		param.key = char_tmp;

		char_tmp = *(char*)addr;
		addr += char_size;
		param.type = char_tmp;

		int_tmp = *(int*)addr;
		addr += int_size;
		param.size = int_tmp;

		param.value = (void*) new char[param.size];
		memcpy(param.value, addr, param.size);
		addr += param.size;
		m_query->m_params.insert(make_pair(param.key, param));
	}
	m_query->show();
	execute(fd);
}

int CDBServer::send(int fd, void* data, int len) {
	m_sock->send(fd, data, len);
}

int CDBServer::execute(int fd) {
	m_engine->Query(m_query, fd);
	m_engine->Drive();
}
