/**
 * file name : multiple.cpp 
 *
 * desc : 
 *		测试几个关于线程的信号函数：
 *			int pthread_sigmask( int how, const sigset_t* set, sigset_t oset )
 *			int sigwait( const sigset_t* set, int* signop )
 *			int pthread_kill( pthread_t thread, int signo )
 *
 *		测试handler和sigwait并存的情况：多线程环境（结论让我有点吃惊，竟然是优先执行handler）
 */

#include <lindef.h>

void sig_usr(int signo)
{
	pid_t tid = gettid();
	printf("--sig_usr() recv a signal(%i) in thread %i\n", signo, tid);
}

void* thr_fn(void* arg)
{
	pthread_detach(pthread_self());

	pid_t tid = gettid();
	printf("the sigwait thread starts[%i]...\n", tid);

	int err, signo;
	sigset_t mask;
	sigemptyset(&mask);
	sigaddset(&mask, SIGINT);
	sigaddset(&mask, SIGQUIT);
	while(1)
	{
		printf("--sigwait begins\n");
		err = sigwait(&mask, &signo);
		if ( err != 0 )
		{
			printf("--sigwait error\n");
		}

		if ( signo == SIGINT )
		{
			printf("--SIGINT is coming in sigwait() in thread %i\n", tid);
			break;
		}

		if ( signo == SIGQUIT )
		{
			printf("--SIGQUIT is coming in sigwait() in thread %i\n", tid);
		}

		printf("--sigwait ends and press Enter to continue again\n");
		getchar();
	}

	sleep(10);

	return (void*)88;
}

int main(int argc, const char** argv)
{
	pid_t tid = gettid();
	printf("the process of multiple starts[%i]...\n", tid);

	signal(SIGQUIT, sig_usr);
	printf("the SIGQUIT signal hanlder is set in the main thread %i\n", tid);

	printf("press Enter to block SIGQUIT in the main thread\n");
	getchar();

	sigset_t mask;
	sigemptyset(&mask);
	sigaddset(&mask, SIGINT);
	sigaddset(&mask, SIGQUIT);
	pthread_sigmask(SIG_BLOCK, &mask, NULL);
	
	printf("press Enter to start a thread of sigwait\n");
	getchar();

	pthread_t threadid;
	pthread_create(&threadid, NULL, thr_fn, 0);
	pthread_detach(threadid);

	printf("--wait for the sigwait thread\n");
	void* retcode = NULL;
	int ret = pthread_join(threadid, &retcode);
	if ( ret == 0 )
	{
		printf("\n--the sigwait thread retcode is %ld\n", (long)retcode);
	}
	else
	{
		printf("\n--phread_join error %s:%d\n", strerror(ret), ret);
	}

	pthread_exit(0);

	return 0;
}
