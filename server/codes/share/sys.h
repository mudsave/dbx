/**
 * filename	: sys.h
 * desc		: 系统函数
 */

#ifndef __SYS_H__
#define __SYS_H__

/// 设置文件标志
inline bool SetFileOpt(int fd, int flags)
{
	int val = fcntl(fd, F_GETFL, 0);
	val |= flags;
	if ( fcntl(fd, F_SETFL, val) == -1 )
		return false;
	else
		return true;
}

/// 获取sock信息（local和remote地址）
inline bool GetSockInfo(int s, char* srcBuf, int slen, char* desBuf, int dlen)
{
	struct sockaddr_in addr;
	socklen_t length = sizeof(addr);

	// local info
	if (srcBuf)
	{
		if ( getsockname(s, (struct sockaddr*)&addr, &length) == -1 )
		{
			return false;
		}
		inet_ntop(AF_INET, &(addr.sin_addr), srcBuf, slen);
	}

	// remote info
	if (desBuf)
	{
		if ( getpeername(s, (struct sockaddr*)&addr, &length) == -1 )
		{
			return false;
		}
		inet_ntop(AF_INET, &(addr.sin_addr), desBuf, dlen);
	}

	return true;
}

/// 获取系统错误信息
inline const char* GetLastErrorInfo(char* pBuff, int size)
{
	strncpy(pBuff, strerror(errno), size);
	return pBuff;
}

/// 获取时间戳
inline long GetTickCount()
{
	static int clocktick = 0;
	if(clocktick == 0)
		clocktick = 1000 / ::sysconf(_SC_CLK_TCK);

	return times(NULL) * clocktick;
}

/// 精确的sleep
inline void Sleep(int ms)
{
	struct timespec req, rem;
	req.tv_sec = ms /1000;
	req.tv_nsec = (ms % 1000) * 1000000;

	while(nanosleep(&req, &rem) && errno == EINTR)
		req = rem;
}

#endif
