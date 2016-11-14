/**
 * filename	: lindef.h
 * desc		: linux系统头文件
 */

#ifndef __LINDEF_H__
#define __LINDEF_H__

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <unistd.h>

#define DEBUG_L		2			/* debug level for our system */
#define NDEBUG					/* for assert */

#include <assert.h>
#include <error.h>
#include <errno.h>
#include <time.h>				/* for struct tm */
#include <fcntl.h>

#include <signal.h>
#include <pthread.h>
#include <semaphore.h>

#include <sys/types.h>
#include <sys/time.h>			/* for struct timeval */
#include <sys/times.h>			/* for struct tms and clock_t */
#include <sys/syscall.h>		/* for system call  */

#include <sys/socket.h>			/* for socket */
#include <netinet/in.h>
#include <arpa/inet.h>

#include "types.h"
#include "macros.h"
#include "debug.h"
#include "sys.h"
#include "thread.h"
#include "FixSizeMemMgr.h"
#include "HandleMgr.h"
#include "HashTable.h"
#include "misc.h"

/// 来自sock模块
#include "trace.h"

#endif
