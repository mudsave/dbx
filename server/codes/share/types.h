/**
 * filename	: types.h
 * desc		: 系统中自定义的类型 
 */

#ifndef __TYPES_H__
#define __TYPES_H__

/* 基本类型
 * BYTE		1字节
 * WORD		2字节
 * DWORD	4字节
 * HANDLE	8字节
 */
typedef unsigned char		BYTE;
typedef unsigned short		WORD;
typedef unsigned int		DWORD;
typedef void*				HANDLE;
typedef int					HRESULT;

/// 系统返回结果
enum HResult
{
	S_OK			=	((HRESULT)0x00000000),			// 成功，值为0
	S_FALSE			=	((HRESULT)0x00000001),			// 成功，但值为1
	E_FAIL			=	((HRESULT)0x80004005),			// 未定义错误
	E_NOTIMPL		=	((HRESULT)0x80004001),			// 接口未实现
	E_PENDING		=	((HRESULT)0x8000000A),			// 操作被挂起
	E_ABORT			=	((HRESULT)0x80004004),			// 操作被取消
};

#define SUCCEEDED(Status)	((HRESULT)(Status) >= 0)

#define FAILED(Status)		((HRESULT)(Status) < 0)

#endif
