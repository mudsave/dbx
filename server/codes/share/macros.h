/**
 * filename	: macros.h
 * desc		: 定义系统宏 
 */

#ifndef __MACROS_H__
#define __MACROS_H__

#ifdef __cplusplus
	#define __BEGIN_SYS_DECLS extern "C" {
	#define __END_SYS_DECLS }
#else
	#define __BEGIN_SYS_DECLS
	#define __END_SYS_DECLS
#endif

#define unused(x)			((void)(x))

#define ARRAY_LEN(arr)		(sizeof(arr) / sizeof((arr)[0]))

#define LAST_ERROR_INFO(strBuf) GetLastErrorInfo(strBuf, ARRAY_LEN(strBuf))

#define GetLastError()		errno

#define INVALID_HANDLE		NULL

// for socket
#define SOCKET				int										/* socket描述符 */
#define INVALID_SOCKET		-1										/* 无效socket */
#define SOCKET_ERROR		-1										/* socket错误 */

// for thread
#define INVALID_THREAD_ID				0xffffffff
#define gettid()						syscall(__NR_gettid)
#define GetCurrentThreadId				gettid
typedef void* (* _FN_THREAD_ROUTINE)(void* pvContext);
typedef _FN_THREAD_ROUTINE FN_THREAD_ROUTINE;
#define BEGIN_THREAD(pThreadId, pAttr, fnStartAddr, pvContext) \
	::pthread_create( \
			pThreadId, \
			pAttr, \
			(FN_THREAD_ROUTINE)(fnStartAddr), \
			(void*)(pvContext))

// for mutex 
#define DECLARE_THREAD_SAFETY_MEMBER(member)					mutable Mutex member##_mtx
#define INIT_THREAD_SAFETY_MEMBER_FAST(member)					member##_mtx(false)
#define ENTER_CRITICAL_SECTION_MEMBER(member)					{ ResGuard<> resGuarder(member##_mtx)
#define LEAVE_CRITICAL_SECTION_MEMBER							}
#define ENTER_CRITICAL_SECTION_MEMBER_STATIC(this, member)		{ ResGuard<> resGuarder(this->member##_mtx)
#define LEAVE_CRITICAL_SECTION_MEMBER_STATIC					}

// for static member mutex
#define DECLARE_THREAD_SAFETY_STATIC_MEMBER(member)				static Mutex member##_mtx
#define INIT_THREAD_SAFETY_STATIC_MEMBER(class, member)			Mutex class::member##_mtx
#define INIT_THREAD_SAFETY_STATIC_MEMBER_FAST(class, member)	Mutex class::member##_mtx(false)

// 安全删除和释放
#ifndef safeDelete
#	define safeDelete(ptr)		if ((ptr)) {delete (ptr); (ptr) = 0;}
#endif
#ifndef safeDeleteArray
#	define safeDeleteArray(ptr)	if ((ptr)) {delete[] (ptr); (ptr) = 0;}
#endif
#ifndef safeRelease
#	define safeRelease(ptr)		if ((ptr)) {(ptr)->release(); (ptr) = 0;}
#endif

#endif
