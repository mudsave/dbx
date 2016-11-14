/**
 * filename : client.cpp
 */

#include "lindef.h"
#include <sys/poll.h>

int main(int argc, const char* argv[])
{
	if ( argc != 4 )
	{
		printf("--error params:serverIP, port, bufSize\n");
		return 1;
	}

	printf("--client is running..\n\n");

	const char* ip = argv[1];
	int port = atoi(argv[2]);
	int len = atoi(argv[3]);

	struct sockaddr_in addr;
	addr.sin_family = AF_INET;
	inet_pton(AF_INET, ip, &addr.sin_addr);
	addr.sin_port = htons(port);

	int s = socket(AF_INET, SOCK_STREAM, 0);
	VERIFY_SYS(s >= 0);

	int oldLen = 0;
	int oldLen_len = sizeof(oldLen);
	getsockopt( s, SOL_SOCKET, SO_SNDBUF,  &oldLen, (socklen_t*)&oldLen_len );
	printf("--old send buff size = %d\n", oldLen);
	getsockopt( s, SOL_SOCKET, SO_RCVBUF,  &oldLen, (socklen_t*)&oldLen_len );
	printf("--old recv buff size = %d\n", oldLen);

	setsockopt( s, SOL_SOCKET, SO_SNDBUF,  &len, sizeof(len) );
	setsockopt( s, SOL_SOCKET, SO_RCVBUF,  &len, sizeof(len) );

	getsockopt( s, SOL_SOCKET, SO_SNDBUF,  &oldLen, (socklen_t*)&oldLen_len );
	printf("--new send buff size = %d\n", oldLen);
	getsockopt( s, SOL_SOCKET, SO_RCVBUF,  &oldLen, (socklen_t*)&oldLen_len );
	printf("--new recv buff size = %d\n\n", oldLen);

	int ret = connect( s, (struct sockaddr*)&addr, sizeof(addr) );
	VERIFY_SYS(ret == 0);
	printf("--connect %s:%d ok\n", ip, port);

	VERIFY_SYS( SetFileOpt(s, O_NONBLOCK) );
	printf("--set s noblock mode\n\n");

	printf("press any key to loop operation..\n");
	getchar();

	while(1)
	{
		printf("\npress s to send(), r to recv(), p to poll(), w to shutdown(SHUT_WR), c to shutdown(SHUT_RD), others to exit loop..\n");
		int c = getchar();

		if ( c == 's' )
		{
			getchar();
			char buf_s[1024] = {0};
			int n = send(s, buf_s, 1024, MSG_NOSIGNAL);
			if ( n > 0 ) printf("--try to send 1024 bytes, but send %d bytes\n", n);
			else if ( n == 0 ) printf("--try to send 1024 bytes, but send %d bytes\n", n);
			else
			{
				printf("--try to send 1024 bytes, but send error :\n");
				printf("\terrno = %i, str = %s\n", errno, strerror(errno));
			}
			continue;
		}

		if ( c == 'r' )
		{
			getchar();
			char buf_r[1024] = {0};
			int m = recv(s, buf_r, 1024, 0);
			if ( m > 0 ) printf("--try to recv 1024 bytes, but recv %d bytes\n", m);
			else if ( m == 0 ) printf("--try to recv 1024 bytes, but recv %d bytes\n", m);
			else
			{
				printf("--try to recv 1024 bytes, but recv error :\n");
				printf("\terrno = %i, str = %s\n", errno, strerror(errno));
			}
			continue;
		}

		if ( c == 'p' )
		{
			getchar();
			struct pollfd fds[1]; fds[0].fd = s; fds[0].events = POLLIN | POLLOUT | POLLRDHUP;
			int ret = poll(fds, 1, 100);
			if ( ret > 0 )
			{
				printf("--try to poll, the result is :\n");

				if (fds[0].revents & POLLIN)	printf("\tPOLL IN is ok\n");
				if (fds[0].revents & POLLOUT)	printf("\tPOLL OUT is ok\n");
				if (fds[0].revents & POLLRDHUP)	printf("\tPOLL RDHUP is ok\n");

				if (fds[0].revents & POLLHUP)	printf("\tPOLL HUP is ok\n");
				if (fds[0].revents & POLLERR)	printf("\tPOLL ERR is ok\n");
			}
			else if ( ret == 0 ) printf("--try to poll, but timeout");
			else
			{
				printf("--try to poll, but error :\n");
				printf("\terrno = %i, str = %s\n", errno, strerror(errno));
			}
			continue;
		}
		
		if ( c == 'w' )
		{
			getchar();
			int ret = shutdown(s, SHUT_WR);
			if ( ret == 0 ) printf("--try to shutdown(SHUT_WR), is ok\n");
			if ( ret == -1 )
			{
				printf("--try to shutdown(SHUT_WR), is error :\n");
				printf("\terrno = %i, str = %s\n", errno, strerror(errno));
			}
			continue;
		}

		if ( c == 'c' )
		{
			getchar();
			int ret = shutdown(s, SHUT_RD);
			if ( ret == 0 ) printf("--try to shutdown(SHUT_RD), is ok\n");
			if ( ret == -1 )
			{
				printf("--try to shutdown(SHUT_RD), is error :\n");
				printf("\terrno = %i, str = %s\n", errno, strerror(errno));
			}
			continue;
		}

		if ( c != '\n' ) getchar();

		break;
	}

	printf("--loop is over, press any key to exit..\n");
	getchar();

	close(s);
	return 0;
}
