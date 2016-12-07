


#include "ClientSock.h"

void* connect_db(void* p_sock){
	CClientSock* sock = (CClientSock*)p_sock;
	sock->connect();
}

void CClientSock::on_connect(int fd, const char* ip, unsigned short port){
	printf("[%s][%d]<%d> connected!\n", ip, port, fd);
}

void CClientSock::on_close(){
	puts("client closed!");
}

void CClientSock::on_recv(void* data, int len){
	m_out_mutex.Lock();
	m_output.push_back(data);
	m_map_output.insert(make_pair(data, len));
	m_out_mutex.Unlock();
}

void CClientSock::on_send(struct bufferevent *bev){
	void* item = NULL;
	int len = 0;
	m_in_mutex.Lock();
	if (m_input.size() > 0){
		item = m_input.front();
		m_input.pop_front();
		len = m_map_input[item];
		m_map_input.erase(item);
	}
	m_in_mutex.Unlock();
	if (!item) return;
	int rt = bufferevent_write(bev, &len, sizeof(len));
	if (rt == -1){
		printf("ERROR: bufferevent_write\n");
	}
	rt = bufferevent_write(bev, item, len);
	if (rt == -1){
		printf("ERROR: bufferevent_write\n");
	}
}

int CClientSock::fetch_result(void** result, int* len){
	void* tmp = NULL;
	int tmp_t = 0;
	m_out_mutex.Lock();
	if (m_output.size() > 0){
		tmp = m_output.front();
		m_output.pop_front();
		tmp_t = m_map_output[tmp];
		m_map_output.erase(tmp);
	}
	m_out_mutex.Unlock();
	*result = tmp;
	*len = tmp_t;
	if (tmp){
		return 1;
	}else {
		return 0;
	}
}

int CClientSock::send(void* data, int len) {
	m_in_mutex.Lock();
	m_input.push_back(data);
	m_map_input.insert(make_pair(data, len));
	m_in_mutex.Unlock();
}

int CClientSock::connect(char* ip, unsigned short port) {
	m_ip = ip;
	m_port = port;
	pthread_t tid;
	pthread_create(&tid, NULL, connect_db, (void*)this);
}

int CClientSock::connect(){
	struct sockaddr_in server_addr;
	int sockfd;
	memset(&server_addr, 0, sizeof(server_addr) );
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(m_port);
	if (m_ip == NULL){
		server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	}else{
		inet_pton(AF_INET, m_ip, &(server_addr.sin_addr));
	}
	sockfd = socket(AF_INET, SOCK_STREAM, 0);

	int rt = ::connect(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr) );
	if (rt == -1){
		perror("connect");
		exit(-1);
	}
	evutil_make_socket_nonblocking(sockfd);
	struct event_base* base  = event_base_new();
	struct bufferevent *bev = bufferevent_socket_new(base, sockfd, BEV_OPT_CLOSE_ON_FREE);
	bufferevent_setcb(bev, read_cb, write_cb, error_cb, (void*)this);
	bufferevent_enable(bev, EV_READ|EV_WRITE|EV_PERSIST);

	short t_port = ntohs(server_addr.sin_port);
	char* t_ip = new char[INET_ADDRSTRLEN];
	inet_ntop(AF_INET, &(server_addr.sin_addr), t_ip, INET_ADDRSTRLEN);	
	on_connect(sockfd, t_ip, t_port);

	event_base_dispatch(base);
}

void read_cb(struct bufferevent *bev, void* arg){
	CClientSock* sock = (CClientSock*)arg;
	struct evbuffer* evb = bufferevent_get_input(bev);
	int min_size, msg_length;
	while(1){
		min_size = sizeof(int);
		if (evbuffer_get_length(evb) < min_size)
			break;
		msg_length = 0;
		evbuffer_copyout(evb, &msg_length, sizeof(int));
		min_size += msg_length;
		if (evbuffer_get_length(evb) < min_size)
			break;
		evbuffer_drain(evb, sizeof(int));
		char* content = new char[msg_length];
		evbuffer_remove(evb, content, msg_length);
		sock->on_recv(content, msg_length);
	}
}

void write_cb(struct bufferevent *bev, void* arg){
	CClientSock* sock = (CClientSock*)arg;
	sock->on_send(bev);
	bufferevent_enable(bev, EV_WRITE|EV_PERSIST);
}

void error_cb(struct bufferevent *bev, short events, void *ctx){
	CClientSock* sock = (CClientSock*)ctx;
	if (events & BEV_EVENT_EOF){
		int fd = bufferevent_getfd(bev);
		sock->on_close();
		bufferevent_free(bev);
	}
}
