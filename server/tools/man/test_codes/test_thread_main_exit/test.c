#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

void* thr_fn(void* arg)
{
	while(1)
	{
		static int icount = 1;
		printf("--thr_fn() call in %i\n", icount++);
		sleep(1);
		if ( icount == 20 )
			break;
	}

	return (void*)1;
}

int main(int argc, const char* argv[])
{
	void* ret;
	pthread_t tid;
	pthread_create(&tid, NULL, thr_fn, NULL);
	
	sleep(10);

	printf("--main thread sleep 10 end\n");

	pthread_exit((void*)-1);

	printf("--pthread_exit int main thread end\n");

	pthread_join(tid, &ret);
	printf("--thr_fn thread release %i\n", (long)ret);

	return 88;
}
