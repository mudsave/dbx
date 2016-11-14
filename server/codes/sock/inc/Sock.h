/**
 * filename : Sock.h
 */

#ifndef __SOCK_H_
#define __SOCK_H_

/// 任务特性标志位
enum TaskTrait
{
	TASK_LONG_TIME = 0x10,		/**<
								长时间任务（比如会被阻塞的），对于这样的任务，线程池会交给
								辅助线程去处理，所以任务逻辑需要考虑与工作者线程同步
								*/
	TASK_LAST_TASK = 0x1000		/**<
								置有此标志的任务将被排在最后执行，该任务一旦开始执行，线程池将
								不再允许异步任务进入队列。此标志在进程退出时使用，目的是为了避免
								异步队列中出现无效指针
								*/
};

/// 任务接口
/**
这里的任务定义为递交给线程执行的一段程序。根据任务执行时机不同，有
@arg 异步任务	稍候执行的任务
@arg 定时任务	在预定时间（周期性）执行的任务
@note
根据任务特性的不同，任务可能在不同的线程中执行，参考 IThreadsPool 介绍。
*/
class ITask
{
public:
	/// 调用此方法执行任务逻辑
	virtual HRESULT Do(HANDLE hContext) = 0;
	/**<
	@param hContext	[in]注册（排队）任务时传入的任务上下文值
	@return			返回成功或者失败
	@note
	此方法的调用线程由任务特性标志决定
	*/
};

/// 线程池的工作状态
enum _WorkerState
{
	WORKER_INIT,
	WORKER_RUNNING,
	WORKER_CLOSING,
	WORKER_CLOSED
};

/// 线程池接口
/**
线程池对象管理一个工作者线程（可以是主线程）和多个辅助线程。
基于线程池的应用程序，用户一般不用自行创建线程，其中大部分逻辑操作在主线程中完成，
如果递交任务时置有某些特殊标志位（比如 #TASK_LONG_TIME ），任务将会在辅助线程中执行。
*/
class IThreadsPool
{
public:
	/// 排队异步任务，此方法可由任意线程调用
	virtual HRESULT QueueTask(ITask* pTask, HANDLE hContext, DWORD dwFlags) = 0;
	/**<
	@param pTask	任务回调接口
	@param hContext	[in]任务上下文
	@param dwFlags	任务特性标志位（组合），TaskTrait 类型
	@note
	异步任务排队一次，则在工作者线程中执行一次；
	注意存在2个队列，一个用于本工作者线程，另一个用于跨线程排队
	*/

	/// 注册定时器
	virtual HANDLE RegTimer(ITask* pTask, HANDLE hContext, DWORD dwFlags, unsigned int uiElapse, unsigned int uiPeriod, const char* pDebugInfo = "default debug info") = 0;
	/**<
	@param ulElapse	到第一次触发时需延时的毫秒数，为0表示立刻触发（异步）
	@param ulPeriod	指出在第一次触发之后周期性触发的间隔时间，为0表示不再触发
	@return			返回定时器句柄，NULL 表示注册失败
	@note
	如果参数 ulPeriod 为0，在触发一次之后会定时器会自动被注销，这种情况下注意避免重复注销同一个定时器
	@warning
	受整数表示范围限制，定时器的延时和周期都不能超过49天
	*/

	/// 注销定时器
	virtual HRESULT UnregTimer(HANDLE hTimer) = 0;
	/**<
	@param hTimer	注册时返回的一个成功值（非负值）
	@warning
	对于同一个定时器句柄不允许重复注销
	*/

	/// 工作函数
	virtual HRESULT Running() = 0;
	/**<
	@note
	此函数运行直到线程池关闭才会返回
	*/

	/// 关闭线程池中所有线程，此方法可由任意线程调用
	virtual void Shutdown(int timeout = 5 * 1000) = 0;
	/**<
	@param timeout	调用之后等待的毫秒数，如果超时强行退出
	@note
	当所有子线程已停止，所有任务已执行完成，所有定时器已被注销时，线程池关闭操作才能完成
	@warning
	应该在关闭操作完成之后释放对象
	*/

	/// 清空ThreadsPool中，所有已经申请的资源
	virtual void Clear() = 0;
};

/// 建立连接选项
enum LinkOption
{
	LISTEN_NEXT = 0x1,			/**< 如果端口被占用，就尝试监听下一个端口直至成功 */
	KEEP_ALIVE = 0x2,			/**< 启用连接保活选项 */
	REUSE_ADDR = 0x4,			/**< 启用地址复用 */
};

/// 关闭连接选项
enum CloseLinkOption
{
	CLOSE_UNGRACEFUL = 0x1,		/**< 单方关闭连接，不等待对方返回关闭消息 */
	CLOSE_RELEASE = 0x2			/**< 立刻关闭连接并释放连接资源 */
};

/// 通讯端口回调接口
class IPortSink
{
public:
	/// 连接关闭事件
	virtual void OnClose(HRESULT reason) = 0;
	/**<
	@param reason	S_OK，表明不会再收到对方数据，此时应该停止发送数据并调用 ILinkPort::Close，正式关闭；@n
					E_FAIL，说明连接已中断（不必调用 ILinkPort::Close ）；@n
					S_FALSE，说明己方之前调用过 ILinkPort::Close （传0标志位），但对方回应超时
	*/

	/// 有新的数据（消息）到达
	virtual int OnRecv(int iSize, BYTE* pData /* = NULL */) = 0;
	/**< 
	@param iSize	在流模式下为接收缓冲区中当前数据总长度，消息模式下为接收缓冲区中第一个消息的长度
	@param pData	[in]可能为 NULL，不为 NULL 时，用户可以直接从 pData 顺序读取数据（消息）
	@return			如果用户通过 pData 获取数据，则返回已从 pData 读取的数据长度，这个值在流模式下
					>=0且<=iSize，消息模式下要么为 iSize 要么为0（暂时不处理消息）；@n
					如果用户通过 ILinkPort::Recv 方法来获取数据，则应该始终返回0
	@note
	不管 pData 是否为 NULL，用户都可以使用 ILinkPort::Recv 来获取数据，但要注意一次 
	IPortSink::OnRecv 调用中不可同时使用两种获取数据的方法
	*/
};

/// 数据通讯端口
/**
每个连接对应一个端口对象，支持流和消息模式
*/
class ILinkPort
{
public:
	/// 发送数据（消息）
	virtual HRESULT Send(const BYTE* pData, int len) = 0;
	/**<
	@note
	如果无法立刻发送则缓冲在发送缓冲区中
	*/

	/// 从接收缓冲区中收取数据（消息）
	virtual HRESULT Recv(BYTE* pBuf, int len) = 0;
	/**<
	@param pBuf		[out]用于存储接收到的数据
	@param len		要获取的数据（消息）长度
	*/

	/// 得到接收缓冲区中的数据
	virtual HRESULT Peek(BYTE* pBuf, int len) = 0;
	/**<
	@param len		要获取的数据长度
	@note
	此操作用于查看接收缓冲区中的数据，它并不删除这些数据，此方法只用于流模式
	*/

	/// 获取远端地址
	virtual HRESULT GetRemoteAddr(char* pAddrBuf, int len, int* pPort) = 0;
	/**<
	@param pAddrBuf	[out]输出远端IP地址（10进制点分式）
	@param len		地址缓冲区长度，单位为 char 
	@param pPort	[out]输出远端端口
	@return			参数错误时返回失败
	如果是主动发起连接，返回的地址和发起时传入的地址相同
	*/

	/// 设置接收缓冲区大小
	virtual HRESULT SetRecvBufSize(int iSize) = 0;
	/**<
	@note
	当接收缓冲区满时将暂停接收数据直到有空闲的缓冲区空间
	*/

	/// 得到当前滞留在接收缓冲区中的数据量
	virtual int GetRecvingSize() = 0;

	/// 得到当前滞留在发送缓冲区中的数据量
	virtual int GetSendingSize() = 0;

	/// 关闭连接
	virtual HRESULT Close(DWORD dwFlags) = 0;
	/**<
	@param dwFlags	 关闭连接选项， CloseLinkOption 类型
	@note
	调用将通知对方我方要关闭连接（不再发送数据）；若没有传递特殊标志，调用者应该进入 CLOSEING 状态，
	并等待对方回应
	断开连接有3种方式：@n
	@arg 协商关闭，一方（或双方）调用 ILinkPort::Close 参数传0）来通知对方，然后等待对方的 
	IPortSink::OnClose 通知；另一方在收到 IPortSink::OnClose 通知（reason 值为 S_OK ）后，若自己处在
	CONNECTED 状态，则应该调用 ILinkPort::Close 回应，若是处在 CLOSEING 状态（说明之前也调用了 
	ILinkPort::Close ）则可直接退出
	@arg 单方关闭，主动方调用 ILinkPort::Close （参数传 #CLOSE_UNGRACEFUL ），然后即可退出
	@arg 异常关闭，网络异常断开时，双方都收到 IPortSink::OnClose 通知，且 reason 值为 E_FAIL

	第一种方式如果没有超时不会导致数据丢失；@n
	第二种方式，在己方发送关闭消息之后和对方收到关闭消息之前这段时间里对方发送的数据将被丢弃；@n
	第三种情况以及超时的第一种情况，无法判断在连接中断之前发送的数据是否已丢失
	*/
};

/// 连接回调接口
class ILinkSink
{
public:
	/// 收到连接或返回连接结果
	virtual IPortSink* OnConnects(int operaterId, ILinkPort* pPort, HRESULT result) = 0;
	/**<
	@param result	S_OK 表示连接是可用的@n
					E_FAIL 表示连接失败，这种情况下不应该缓存 pPort 指针，
					此时仅 ILinkPort::GetRemoteAddr 方法有效
	@return			如果返回 NULL 该连接将被自动单方关闭
	@note
	pPort对象由实现者负责释放
	*/
};

/// 连接控制接口
/**
本接口中的方法可由任意线程调用
*/
class ILinkCtrl
{
public:
	/// 监听端口
	virtual HRESULT Listen(const char* pszLocalAddr, int* piPort, ILinkSink* pSink, DWORD dwFlags) = 0;
	/**<
	@param pszLocalAddr	要监听的本机地址，若监听本地任意地址，则 pszLocalAddr 传递 NULL
	@param piPort		传入要监听的端口，如果这个端口被占用，且指出 #LISTEN_NEXT 标识，
						则自动查找下一个未被占用的端口并在 piPort 输出，否则调用返回失败
	*/

	/// 发起连接请求
	virtual HRESULT Connect(const char* pszRemoteAddr, int iPort, ILinkSink* pSink, DWORD dwFlags) = 0;
	/**<
	@retval S_OK		表示连接已发出，通过 ILinkSink::OnConnects 异步返回连接结果
	*/

	/// 关闭控制对象
	virtual void CloseCtrl() = 0;
	/**<
	@note
	此方法仅取消所有监听操作和未决的连接请求，对于已建立好的连接，用户应另行逐个关闭
	@warning
	如果不是在工作者线程中调用此方法，应注意避免死锁，因为工作者线程是在一个临界区里调用 
	ILinkSink::OnConnects 方法的，而 ILinkCtrl::CloseCtrl 方法也要进入该临界区才能操作完成
	*/
};

///////////////////////////////////////////////////////////////////////////////////////////////////////
// 接口API
__BEGIN_SYS_DECLS

/// 全局线程池对象
#define CLS_THREADS_POLL		0
#define CLS_THREADS_EPOLL		1
IThreadsPool* GlobalThreadsPool(int clsid = CLS_THREADS_POLL);
/**<
@param clsid	线程模型类ID，第一次调用时根据此参数创建全局对象，之后的调用将被忽略
@return			返回接口指针
@note
clsid = 0, poll worker
clsid = 1, epoll worker
*/

/// 创建连接控制对象
ILinkCtrl* CreateLinkCtrl();

/// 开启一个线程来执行pTask
void GenerateWorker(ITask* pTask, HANDLE hContext);

/// 开启信号线程
void GenerateSignalThread();

/// 设置每次recv的缓冲区大小
bool SetRecvBufLevel(int level);

/// 设置清理函数的回调
typedef void (*Fun_Cleanup)();
void SetCleanup(Fun_Cleanup pf);

__END_SYS_DECLS

#endif
