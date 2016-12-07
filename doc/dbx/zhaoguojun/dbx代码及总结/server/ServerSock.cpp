
#include "ServerSock.h"

void CSock::on_connect(int fd, void* bufferevent_ptr, const char* ip, unsigned short port){
	m_port->on_connect(fd, ip, port);
	m_fdbe.insert(make_pair(fd, bufferevent_ptr));
}
void CSock::on_close(int fd){
	m_port->on_close(fd);
	m_fdbe.erase(fd);
}
void CSock::on_recv(void* data, int len, int fd){
	m_port->on_recv(data, len, fd);
}
int CSock::send(int fd, void* data, int len){
	struct bufferevent *bev = (struct bufferevent*)(m_fdbe[fd]);
	int rt = bufferevent_write(bev, data, len);
	if (rt == -1){
		printf("ERROR: bufferevent_write\n");
	}
	return rt;
}
int CSock::listen(const char* ip, unsigned short port){
	int listen_fd;
	struct sockaddr_in server_addr;
	memset(&server_addr, 0, sizeof(server_addr));
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(port);
	if (ip == NULL){
		server_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	}else{
		inet_pton(AF_INET, ip, &(server_addr.sin_addr));
	}
	listen_fd = socket(AF_INET, SOCK_STREAM, 0);
	evutil_make_listen_socket_reuseable(listen_fd);
	int rt = bind(listen_fd, (sockaddr *)&server_addr, sizeof(server_addr));
	if (rt == -1){
		perror("bind");
		return -1;
	}
	rt = ::listen(listen_fd, 10);
	if (rt == -1){
		perror("listen");
		return -1;
	}
	evutil_make_socket_nonblocking(listen_fd);

	m_base  = event_base_new();
	struct event *listen_event;
	listen_event = event_new(m_base, listen_fd, EV_READ|EV_PERSIST, accept_cb, (void*)this);
	event_add(listen_event, NULL);
	event_base_dispatch(m_base);
	return 0;
}

void  accept_cb(evutil_socket_t listen_fd, short what, void* arg) {
	CSock* sock = (CSock*)arg;
	int fd;
	struct sockaddr_in addr;
	socklen_t len = sizeof(addr);
	fd = accept(listen_fd, (sockaddr*)&addr, &len);
	if (fd == -1){
		perror("accept");
		exit(-1);
	}
	struct bufferevent *bev = bufferevent_socket_new(sock->m_base, fd, BEV_OPT_CLOSE_ON_FREE);
	bufferevent_setcb(bev, read_cb, write_cb, error_cb, arg);
	bufferevent_enable(bev, EV_READ|EV_WRITE|EV_PERSIST);

	unsigned short port = ntohs(addr.sin_port);
	char* ip = new char[INET_ADDRSTRLEN];
	inet_ntop(AF_INET, &(addr.sin_addr), ip, INET_ADDRSTRLEN);
	sock->on_connect(fd, (void*)bev, ip, port);
}


void read_cb(struct bufferevent *bev, void* arg){
	CSock* sock = (CSock*)arg;
	int fd = bufferevent_getfd(bev);
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
		sock->on_recv(content, msg_length, fd);
	}
}

void write_cb(struct bufferevent *bev, void* arg){
	struct evbuffer* evb = bufferevent_get_output(bev);
}

void error_cb(struct bufferevent *bev, short events, void *ctx){
	CSock* sock = (CSock*)ctx;
	if (events & BEV_EVENT_EOF){
		int fd = bufferevent_getfd(bev);
		sock->on_close(fd);
		bufferevent_free(bev);
	}
}
