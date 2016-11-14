/**
 * filename : trace.h
 * desc : 目前只支持服务器端的trace，不支持远程客户端获取trace信息
 */

#ifndef __TRACE_H_
#define __TRACE_H_

__BEGIN_SYS_DECLS

HRESULT InitTraceServer(bool bOutputDebugWnd = true, const char* pszOutputFile = NULL);
void _Trace(int iClass, const char* pszFormat, ...);

__END_SYS_DECLS

/// TRACE分类
#define TRACE_CLS_NORMAL	-1					// 正常TRACE
#define TRACE_CLS_WARNING	-2					// 警告TRACE
#define TRACE_CLS_ERROR		-3					// 错误TRACE
#define TRACE_CLS_DEFAULT	0					// 默认TRACE类型
#ifndef TRACE_CLS_CUSTOM
#define TRACE_CLS_CUSTOM	TRACE_CLS_DEFAULT	// 各个模块可定义不同的类型（小于65536的正整数）
#endif

/// TRACE函数
#ifndef _TRACE_FUNCTION
#define _TRACE_FUNCTION		_Trace
#endif

/// TRACE分类(DEBUG情况下)
#if DEBUG_L >= 1
#define __MAKE_TRACE_CLS(num, cls)	(((num + 1) << 16) | (cls & 0xffff))
#else
#define __MAKE_TRACE_CLS(num, cls)	cls
#endif

/// TRACE正常进度信息
#define TRACE0_NORMAL(szFormat)							_TRACE_FUNCTION(__MAKE_TRACE_CLS(0, TRACE_CLS_NORMAL), szFormat)
#define TRACE1_NORMAL(szFormat, p1)						_TRACE_FUNCTION(__MAKE_TRACE_CLS(1, TRACE_CLS_NORMAL), szFormat, p1)
#define TRACE2_NORMAL(szFormat, p1, p2)					_TRACE_FUNCTION(__MAKE_TRACE_CLS(2, TRACE_CLS_NORMAL), szFormat, p1, p2)
#define TRACE3_NORMAL(szFormat, p1, p2, p3)				_TRACE_FUNCTION(__MAKE_TRACE_CLS(3, TRACE_CLS_NORMAL), szFormat, p1, p2, p3)
#define TRACE4_NORMAL(szFormat, p1, p2, p3, p4)			_TRACE_FUNCTION(__MAKE_TRACE_CLS(4, TRACE_CLS_NORMAL), szFormat, p1, p2, p3, p4)
#define TRACE5_NORMAL(szFormat, p1, p2, p3, p4, p5)		_TRACE_FUNCTION(__MAKE_TRACE_CLS(5, TRACE_CLS_NORMAL), szFormat, p1, p2, p3, p4, p5)

/// TRACE警告信息
#define TRACE0_WARNING(szFormat)						_TRACE_FUNCTION(__MAKE_TRACE_CLS(0, TRACE_CLS_WARNING), szFormat)
#define TRACE1_WARNING(szFormat, p1)					_TRACE_FUNCTION(__MAKE_TRACE_CLS(1, TRACE_CLS_WARNING), szFormat, p1)
#define TRACE2_WARNING(szFormat, p1, p2)				_TRACE_FUNCTION(__MAKE_TRACE_CLS(2, TRACE_CLS_WARNING), szFormat, p1, p2)
#define TRACE3_WARNING(szFormat, p1, p2, p3)			_TRACE_FUNCTION(__MAKE_TRACE_CLS(3, TRACE_CLS_WARNING), szFormat, p1, p2, p3)
#define TRACE4_WARNING(szFormat, p1, p2, p3, p4)		_TRACE_FUNCTION(__MAKE_TRACE_CLS(4, TRACE_CLS_WARNING), szFormat, p1, p2, p3, p4)
#define TRACE5_WARNING(szFormat, p1, p2, p3, p4, p5)	_TRACE_FUNCTION(__MAKE_TRACE_CLS(5, TRACE_CLS_WARNING), szFormat, p1, p2, p3, p4, p5)

/// TRACE错误信息
#define TRACE0_ERROR(szFormat)							_TRACE_FUNCTION(__MAKE_TRACE_CLS(0, TRACE_CLS_ERROR), szFormat)
#define TRACE1_ERROR(szFormat, p1)						_TRACE_FUNCTION(__MAKE_TRACE_CLS(1, TRACE_CLS_ERROR), szFormat, p1)
#define TRACE2_ERROR(szFormat, p1, p2)					_TRACE_FUNCTION(__MAKE_TRACE_CLS(2, TRACE_CLS_ERROR), szFormat, p1, p2)
#define TRACE3_ERROR(szFormat, p1, p2, p3)				_TRACE_FUNCTION(__MAKE_TRACE_CLS(3, TRACE_CLS_ERROR), szFormat, p1, p2, p3)
#define TRACE4_ERROR(szFormat, p1, p2, p3, p4)			_TRACE_FUNCTION(__MAKE_TRACE_CLS(4, TRACE_CLS_ERROR), szFormat, p1, p2, p3, p4)
#define TRACE5_ERROR(szFormat, p1, p2, p3, p4, p5)		_TRACE_FUNCTION(__MAKE_TRACE_CLS(5, TRACE_CLS_ERROR), szFormat, p1, p2, p3, p4, p5)

/// TRACE始终有效
#define TRACE0_L0(szFormat)								_TRACE_FUNCTION(__MAKE_TRACE_CLS(0, TRACE_CLS_CUSTOM), szFormat)
#define TRACE1_L0(szFormat, p1)							_TRACE_FUNCTION(__MAKE_TRACE_CLS(1, TRACE_CLS_CUSTOM), szFormat, p1)
#define TRACE2_L0(szFormat, p1, p2)						_TRACE_FUNCTION(__MAKE_TRACE_CLS(2, TRACE_CLS_CUSTOM), szFormat, p1, p2)
#define TRACE3_L0(szFormat, p1, p2, p3)					_TRACE_FUNCTION(__MAKE_TRACE_CLS(3, TRACE_CLS_CUSTOM), szFormat, p1, p2, p3)
#define TRACE4_L0(szFormat, p1, p2, p3, p4)				_TRACE_FUNCTION(__MAKE_TRACE_CLS(4, TRACE_CLS_CUSTOM), szFormat, p1, p2, p3, p4)
#define TRACE5_L0(szFormat, p1, p2, p3, p4, p5)			_TRACE_FUNCTION(__MAKE_TRACE_CLS(5, TRACE_CLS_CUSTOM), szFormat, p1, p2, p3, p4, p5)


/// 以下根据预编译宏DEBUG_L的值决定是否屏蔽TRACE
#if DEBUG_L >= 1	// 测试发布级别以上才有效的TRACE（DEBUG_L == 0为发布版）
#define TRACE0_L1								TRACE0_L0
#define TRACE1_L1								TRACE1_L0
#define TRACE2_L1								TRACE2_L0
#define TRACE3_L1								TRACE3_L0
#define TRACE4_L1								TRACE4_L0
#define TRACE5_L1								TRACE5_L0
#else
#define TRACE0_L1(szFormat)						(void)0
#define TRACE1_L1(szFormat, p1)					(void)0
#define TRACE2_L1(szFormat, p1, p2)				(void)0
#define TRACE3_L1(szFormat, p1, p2, p3)			(void)0
#define TRACE4_L1(szFormat, p1, p2, p3, p4)		(void)0
#define TRACE5_L1(szFormat, p1, p2, p3, p4, p5)	(void)0
#endif

#if DEBUG_L >= 2	// 集成调试级别以上才有效的TRACE
#define TRACE0_L2								TRACE0_L0
#define TRACE1_L2								TRACE1_L0
#define TRACE2_L2								TRACE2_L0
#define TRACE3_L2								TRACE3_L0
#define TRACE4_L2								TRACE4_L0
#define TRACE5_L2								TRACE5_L0
#else
#define TRACE0_L2(szFormat)						(void)0
#define TRACE1_L2(szFormat, p1)					(void)0
#define TRACE2_L2(szFormat, p1, p2)				(void)0
#define TRACE3_L2(szFormat, p1, p2, p3)			(void)0
#define TRACE4_L2(szFormat, p1, p2, p3, p4)		(void)0
#define TRACE5_L2(szFormat, p1, p2, p3, p4, p5)	(void)0
#endif

#if DEBUG_L >= 3	// 模块调试级别以上才有效的TRACE
#define TRACE0_L3								TRACE0_L0
#define TRACE1_L3								TRACE1_L0
#define TRACE2_L3								TRACE2_L0
#define TRACE3_L3								TRACE3_L0
#define TRACE4_L3								TRACE4_L0
#define TRACE5_L3								TRACE5_L0
#else
#define TRACE0_L3(szFormat)						(void)0
#define TRACE1_L3(szFormat, p1)					(void)0
#define TRACE2_L3(szFormat, p1, p2)				(void)0
#define TRACE3_L3(szFormat, p1, p2, p3)			(void)0
#define TRACE4_L3(szFormat, p1, p2, p3, p4)		(void)0
#define TRACE5_L3(szFormat, p1, p2, p3, p4, p5)	(void)0
#endif

#if DEBUG_L >= 4	// 详细调试级别以上才有效的TRACE
#define TRACE0_L4								TRACE0_L0
#define TRACE1_L4								TRACE1_L0
#define TRACE2_L4								TRACE2_L0
#define TRACE3_L4								TRACE3_L0
#define TRACE4_L4								TRACE4_L0
#define TRACE5_L4								TRACE5_L0
#else
#define TRACE0_L4(szFormat)						(void)0
#define TRACE1_L4(szFormat, p1)					(void)0
#define TRACE2_L4(szFormat, p1, p2)				(void)0
#define TRACE3_L4(szFormat, p1, p2, p3)			(void)0
#define TRACE4_L4(szFormat, p1, p2, p3, p4)		(void)0
#define TRACE5_L4(szFormat, p1, p2, p3, p4, p5)	(void)0
#endif

#endif
