/**
 * file name : single.cpp 
 *
 * desc : 
 *		测试几个关于线程的信号函数：
 *			int pthread_sigmask( int how, const sigset_t* set, sigset_t oset )
 *			int sigwait( const sigset_t* set, int* signop )
 *			int pthread_kill( pthread_t thread, int signo )
 *
 *		测试handler和sigwait并存的情况：单线程环境（结论是，两者并不冲突）
 */

#include <lindef.h>

void sig_usr(int signo)
{
	if ( signo == SIGQUIT )
	{
		printf("--SIGQUIT is coming in sig_usr()\n");
	}
	else
	{
		printf("--error signo in sig_usr()\n");
	}
}

int main(int argc, const char** argv)
{
	printf("the process of single starts...\n");

	sighandler_t ret = signal(SIGQUIT, sig_usr);
	VERIFY_SYS( ret != SIG_ERR );

	printf("the SIGQUIT signal hanlder is set\n");

	printf("--to recv a SIGQUIT, and press Enter to continue\n");
	getchar();

	sigset_t waitmask;
	sigemptyset(&waitmask);
	sigaddset(&waitmask, SIGQUIT);

	printf("built a waitmask\n");

	int err, signo;
	while(1)
	{
		printf("sigwait is prepared\n");
		err = sigwait(&waitmask, &signo);
		if ( err != 0 )
		{
			printf("--sigwait error\n");
		}

		if ( signo == SIGQUIT )
		{
			printf("--SIGQUIT is coming in sigwait()\n");
		}

		printf("--sigwait ends, to recv a SIGQUIT, and press Enter to continue again\n");
		getchar();
	}

	signal(SIGQUIT, ret);

	return 0;
}
