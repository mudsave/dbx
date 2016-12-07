#ifndef _DBScheme_h
#define _DBScheme_h

#include <string.h>

struct DBScheme{
	char serverIp[20];
	short port;
	char dbName[64];
	char usrName[64];
	char passWd[128];
	char queueNum; //异步队列数
	// 重试等级,小于等于此等级，则作抛包处理，大于则重试
	short dwRetryLevel;
	// 重试间隔,
	short dwRetryInternal;
	// 重试最多次数，如果超过，则作抛包处理
	short dwRetryMaxNumber;
	// 重试队列最大长度，如果超过，则不管等级，将作抛包处理
	short dwRetryQueueMaxSize;
	// 抛包等级,小于等于此等级，则作抛包处理
	short dwThrowLevel;
	// 触发抛包的队列长度
	short dwThrowQueueSize;
	DBScheme(void) {
		strcpy(serverIp, "172.16.2.218");
		port = 3306;
		strcpy(dbName, "dream");
		strcpy(usrName, "root");
		strcpy(passWd, "linux3");
		queueNum = 1;
	}
};


#endif
