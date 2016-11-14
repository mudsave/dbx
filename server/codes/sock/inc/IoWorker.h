/**
 * filename : IoWorker.h
 */

#ifndef __IO_WORKER_H_
#define __IO_WORKER_H_

// 异步IO事件
#define ASYN_IO_READ			0x1
#define ASYN_IO_WRITE			0x2
#define ASYN_IO_CLOSE			0x4
#define ASYN_IO_ALL				(ASYN_IO_READ | ASYN_IO_WRITE | ASYN_IO_CLOSE)

class IIoTask
{
public:
	virtual HRESULT DoIo(HANDLE hContext, int result) = 0;
};

class IIoWorker
{
public:
	// 注册异步（重叠）IO任务
	virtual HRESULT RegAsynIoTask(IIoTask* pTask, HANDLE hContext, int hIo) = 0;

	// 指定响应事件
	virtual HRESULT AttachIoEvents(HRESULT hIokey, DWORD dwEvts) = 0;

	// 将事件分离
	virtual HRESULT DetachIoEvents(HRESULT hIokey, DWORD dwEvts) = 0;

	// 注销异步（重叠）IO任务
	virtual HRESULT UnregIoTask(HRESULT hIokey) = 0;
	
	// 查询是否注册了指定事件
	virtual HRESULT HasIoEvents(HRESULT hIokey, DWORD dwEvts) = 0;
};

#endif
