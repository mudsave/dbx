/**
 * filename : debug.h
 * desc :	提供ASSERT_()
 *			提供VERIFY_SYS()
 */

#ifndef __DEBUG_H_
#define __DEBUG_H_

#ifndef ASSERT_TITLE
#define ASSERT_TITLE "--Warning"
#endif

/// _QUERY
#define _QUERY(szMsg) \
	printf(("%s - %s"), ASSERT_TITLE, szMsg); \
	abort();


/// ASSERT
#if DEBUG_L >= 2
#define ASSERT_EX(exp, szNote)	\
	if(!(exp)) \
	{ \
		char buf[512]; \
		sprintf(buf, "Verify failed\nFile %s\nLine %d: %s\nNote: %s\n", __FILE__, __LINE__, #exp, szNote); \
		_QUERY(buf); \
	}
#else
#define ASSERT_EX(exp, szNote) assert(exp);
#endif

#define ASSERT_(exp) ASSERT_EX(exp, "NULL")


/// VERIFY_SYS
#define VERIFY_SYS(exp) \
	if(!(exp)) \
	{ \
		char strBuf[256]; \
		LAST_ERROR_INFO(strBuf); \
		char buf[512]; \
		sprintf(buf, "Syscall failed\nFile %s,Line %d: %s,Note: %s\n", __FILE__, __LINE__, #exp, strBuf); \
		_QUERY(buf); \
	}

#endif
