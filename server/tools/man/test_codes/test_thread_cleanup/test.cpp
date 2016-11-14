/**
 * filename : test.cpp
 *
 * desc : pthread_cancel()，导致的退出，竟然是清理堆栈的，让我有点吃惊
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <lindef.h>

void cleanup(void* pContext)
{
	pid_t tid = gettid();
	printf("call cleanup() in thread %i\n", tid);

	return;
}

struct MM
{
	MM()
	{
		printf("construct MM\n");
	}

	~MM()
	{
		printf("destruct MM\n");
	}
};

void* thr_fn(void* arg)
{
	pid_t tid = gettid();
	pthread_detach(pthread_self());

	int oldtype = 0;
	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, &oldtype);
	printf("old type = %i\n", oldtype);
	printf("new type = %i\n", PTHREAD_CANCEL_DEFERRED);

	MM mm;
	pthread_cleanup_push(cleanup, 0);
	while(1)
	{
		static int icount = 1;
		printf("--thr_fn() call %i in thread %i\n", icount++, tid);
		sleep(5);
	}
	pthread_cleanup_pop(0);

	printf("thr_fn is end\n");

	return (void*)1;
}

int main(int argc, const char* argv[])
{
	void* ret;
	pthread_t tid;
	pthread_create(&tid, NULL, thr_fn, NULL);
	pthread_detach(tid);
	
	sleep(30);

	printf("--main thread sleep 10 end\n");

	pthread_cancel(tid);

	printf("--sleep 2s\n");

	sleep(60 * 2);

	return 0;
}
