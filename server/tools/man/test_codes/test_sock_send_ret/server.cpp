/**
 * filename : server.cpp
 */

#include "lindef.h"

int main(int argc, const char* argv[])
{
	if ( argc != 4 )
	{
		printf("--error params:serverIP, port, bufSize\n");
		return 1;
	}

	printf("server is running..\n\n");

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

	int opt_val = 1;
	setsockopt( s, SOL_SOCKET, SO_REUSEADDR, (char*)&opt_val, sizeof(opt_val) );

	int ret = 0;
	ret = bind( s, ( struct sockaddr* )&addr, sizeof(addr) );
	VERIFY_SYS( ret == 0 );
	printf("--server bind success\n");

	ret = listen( s, 5 );
	VERIFY_SYS( ret == 0 );
	printf("--server listen success\n\n");

	struct sockaddr_in addr_c;
	socklen_t addr_len = sizeof(addr_c);
	while(1)
	{
		printf("--server is going to accept a new connection，press q to exit and press enter to accept()..\n");
		int c = getchar();
		if ( c == 'q' )
		{
			getchar();
			break;
		}

		int ss = accept( s, (struct sockaddr*)&addr_c, &addr_len );
		if ( ss < 0 )
			perror("--accept error : ");
		else
		{
			char strAddr[64] = {0};
			sprintf(strAddr, "%s:%d", inet_ntoa(addr_c.sin_addr), ntohs(addr_c.sin_port));
			printf("--a client comes ( %s )\n", strAddr);

			VERIFY_SYS( SetFileOpt(ss, O_NONBLOCK) );
			printf("--set noblock mode for new client\n\n");

			char recv_buf[1024] = {0};
			while(1)
			{
				printf("press any key to send..\n");
				getchar();
				char buf_s[1024] = {0};
				int m = send(ss, buf_s, 1024, MSG_NOSIGNAL);
				if ( m > 0 ) printf("--try to send 1024 bytes, but send %d bytes\n", m);
				else if ( m == 0 ) printf("--try to send 1024 bytes, but send %d bytes\n", m);
				else
				{
					printf("--try to send 1024 bytes, but send error :\n");
					printf("\terrno = %i, str = %s\n", errno, strerror(errno));
				}


				printf("press any key to start recv..\n");
				getchar();

				int n = recv( ss, recv_buf, 1024, 0 );
				if ( n > 0 ) printf("--try to recv 1024 bytes, but recv %d bytes\n", n);
				else if ( n == 0 )
				{
					printf("--try to recv 1024 bytes, but recv eof, press any key to close()\n");
					getchar();
					close(ss);
					break;
				}
				else
				{
					if ( errno == EAGAIN )
					{
						printf("--try to recv 1024 bytes, buf recv block[%s]\n", strerror(errno));
						continue;
					}
					printf("--try to recv 1024 bytes, but recv error[%s], press any key to close()\n", strerror(errno));
					getchar();
					close(ss);
					break;
				}
			}
			printf("--a client is closed\n\n");
		}
	}

	printf("--server is over\n");

	close(s);

	return 0;
}
