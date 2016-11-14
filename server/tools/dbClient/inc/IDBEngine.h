/*******************************************************************
** 文件名:	e:\CoGame\DBEngine\include\IDBEngine.h
** 版  权:	(C) 深圳未名网络技术有限公司(www.weimingtech.com)
** 创建人:	隆寒辉(Forlion Lon)
** 日  期:	2007/6/20  20:50
** 版  本:	1.0
** 描  述:	数据库引擎接口文件
** 应  用:  
	
**************************** 修改记录 ******************************
** 修改人: 
** 日  期: 
** 描  述: 
********************************************************************/

#pragma once
#include <map>
#include <string>
#include <list>

using namespace std;

class CBASE {
public:
	CBASE(void* pBase):m_pBase(pBase) {
		static int temp=0;
		m_nCurTime=temp;
		temp=temp+1;
	}
	~CBASE() {

	}
	bool operator < (const CBASE &cint)const {
		return m_nCurTime<cint.m_nCurTime?true:false;
	}
	int m_nCurTime;
	void* m_pBase;
};

typedef std::multimap<CBASE/*类型*/, std::string/*数据*/> MAPOUTDATA;

struct OUTDATA
{
	MAPOUTDATA	outData;
	int			nOutDataCount;
};

typedef std::map<int,OUTDATA> MAPRESETDATA;
struct ISchemeEngine;

/// 数据库请求返回值定义
enum
{	/// .....................       /// 以上为成功的方法，只要返回值大于等于0，则表示成功
	DBRET_CODE_SUCCEED = 0,			/// 成功
	DBRET_CODE_ENGINEERROR = -1,	/// 引擎错误（返回此种错误会重试）	
	DBRET_CODE_SCHEMEERROR = -2,	/// 配置错误（不会重试）
	DBRET_CODE_EXCEPTION = -3,		/// 引擎异常（不会重试）
	DBRET_CODE_INPUTERROR = -4,		/// 外部输入错误（不会重试）
	DBRET_CODE_SPRETUR = -5,		/// 存储过程返回错误（不会重试）
	DERET_CODE_THROW = -6,			/// 被抛包（不会重试）
	/// －10 ....................	/// 小于以下值，为自定义失败值，都不会重试
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// 参数方向定义
enum
{
	PARAM_DIR_IN = 0,				/// 输入参数
	PARAM_DIR_OUT,					/// 输出参数
};

/// 参数数据类型
enum
{
	PARAM_DATATYPE_INT = 0,			/// 整型
	PARAM_DATATYPE_CHAR,			/// 字符串类型
	PARAM_DATATYPE_BIN,				/// 二进制类型
	PARAM_DATATYPE_FLOAT,			/// 浮点类型
	PARAM_DATATYPE_BOOL,			/// 布尔类型
};

/// 数据源定义
enum
{
	DATA_SOURCE_DD = 0,				/// 直通数据
	DATA_SOURCE_SP,					/// 存储过程
};

//// 最大参数名称长度
#define MAX_PARAMNAME_LEN			32

/// 存储过程返回值长度
#define SP_RETURNVALUE_SIZE			4				

/// 存储过程返回描述长度
#define SP_RETURNDESC_SIZE			256

/// QueryBuffer长度
#define QUERYBUFFER_MAX_LEN			1024 * 128

/// 返回值的宏定义
#define RETUREVAL_PARAM_DESC		"@returnvalue"

/// 返回描述的宏定义
#define RETUREDESC_PARAM_DESC		"@returndesc"

/// 数据库引擎状态信息ID
enum
{
	DBENGINE_STATEINFO_OK = 0,		/// 首次连接成功
	DBENGINE_STATEINFO_DISCONNECT,	/// 与数据库断开连接
	DBENGINE_STATEINFO_RENEWCONNECT,/// 恢复连接成功
	DBENGINE_STATEINFO_THROW,		/// 执行抛包策略
	DBENGINE_STATEINFO_EXCEPTION,	/// 数据库引擎异常
};

// 输入参数
struct SINPUTDATA
{
	char szVariableName[MAX_PARAMNAME_LEN];	// 输入变量名
	int  nSize;								// 数据长度

	SINPUTDATA(void)
	{
		memset(this, 0, sizeof(SINPUTDATA));
	}
};
typedef list< SINPUTDATA >  TLIST_INPUT;

// 存储过程参数
struct SSPPARAM {
	char szParamName[MAX_PARAMNAME_LEN];	// SP参数名称
	int	 nDataType;							// 数据类型
	int  nSize;								// 数据长度	参见PARAM_DATATYPE_INT, PARAM_DATATYPE_CHAR, PARAM_DATATYPE_BIN
	int	 nDirType;							// direction类型 
	char szInputDataName[MAX_PARAMNAME_LEN];// 对应输入数据结构成员

	SSPPARAM(void) {
		memset(this, 0, sizeof(SSPPARAM));		
	}
};
typedef list< SSPPARAM >  TLIST_SPPARAM;

// 输出数据
struct SOUTPUTDATA {
	char szVariableName[MAX_PARAMNAME_LEN];	// 输出变量名
	int  nSize;								// 数据长度
	int  nDataSource;						// 数据源,参见：DATA_SOURCE_DD,DATA_SOURCE_SP...
	int	 nDataType;							// 数据类型 参见PARAM_DATATYPE_INT, PARAM_DATATYPE_CHAR, PARAM_DATATYPE_BIN

	SOUTPUTDATA(void) {
		memset(this, 0, sizeof(SOUTPUTDATA));		
	}
};
typedef list< SOUTPUTDATA >  TLIST_OUTPUT;
typedef map<int,TLIST_OUTPUT> LISTRESET;

// 存储过程配置表
struct SPROCEDURECONFIG {
	int	 nCmdID;							// 命令ID
	char szSPName[MAX_PARAMNAME_LEN];		// 存储过程名
	int	 nLevel;							// 等级
	int  nDataBaseID;						// 数据库ID

	TLIST_INPUT		listInputData;			// 输入数据列表
	TLIST_SPPARAM	listSPParam;			// 存储过程参数列表
	TLIST_OUTPUT	listOutputData;			// 输出数据列表	
	LISTRESET	listResultSet;				// 结果集数据列表	(由存储过程决定）	

	SPROCEDURECONFIG(void) {
		nCmdID = 0;
		memset(szSPName,0, sizeof(szSPName));
		nLevel = 0;
		nDataBaseID = 0;

		listInputData.clear();
		listSPParam.clear();
		listOutputData.clear();	
		listResultSet.clear();
	}
};


/// 数据库请求返回回调接口
struct IDBRetSink {
	/** 数据库请求返回回调方法
	@param   nCmdID ：命令ＩＤ
	@param   nDBRetCode：数据库请求返回值，参考上面定义
	@param   pszDBRetDesc：数据库请求返回描述，由ＳＰ返回
	@param   nQueueIndex：队列定义
	@param   pOutData：输出数据
	@param   nOutLen：输出数据长度
	@return  
	@note     
	@warning 此对像千万不能在数据库返回前释放，否则会非法！
	@retval buffer 
	*/	
	virtual void			OnReturn(int nCmdID, int nDBRetCode, char * pszDBRetDesc, int nQueueIndex, char * pOutData, int nOutLen,MAPRESETDATA &map_Res,MAPOUTDATA &map_Out) = 0;
};

/// 数据库状态信息回调接口
struct IDBEngineStateSink {
	/** 如果数据引擎有状态信息回调给上层
	@param   nInforID：信息ID，参考上层定义
	@param   pszDesc：信息描述
	@param   
	@return  
	@note     
	@warning 
	@retval buffer 
	*/
	virtual void			OnState(int nInfoID, LPCSTR pszDesc) = 0;
};

/// 数据库引擎接口
struct IDBEngine {
	/** 释放数据库引擎
	@param   
	@param   
	@param   
	@return  
	@note     
	@warning 
	@retval buffer 
	*/	
	virtual void			Release(void) = 0;

	/** 创建数据库引擎
	@param   
	@param   
	@param   
	@return  成功返回true，失败返回false
	@note     
	@warning 
	@retval buffer 
	*/
	virtual	bool			Create(void) = 0;

	/** 增加状态信息回调接口
	@param   pSink :回调接口 
	@param   
	@param   
	@return  成功返回true，失败返回false
	@note     
	@warning 
	@retval buffer 
	*/
	virtual bool			AddStateSink(IDBEngineStateSink * pSink) = 0;

	/** 移队状态信息回调接口
	@param   pSink :回调接口 
	@param   
	@param   
	@return  成功返回true，失败返回false
	@note     
	@warning 
	@retval buffer 
	*/
	virtual bool			RemoveStateSink(IDBEngineStateSink * pSink) = 0;
	/** 执行一个存储过程
	@param   strSpName：sp name
	@param   dwQueueIndex:异步队列索引号
	@param   pszInData：输入数据
	@param   nInDataLen：输入数据长度
	@param   pDBRetSink：结果返回接口	
	@return  
	@note     
	@warning 
	@retval buffer
	*/
	virtual bool			ExecuteSP(SPROCEDURECONFIG config, DWORD dwQueueIndex, LPCSTR pszInData, int nInDataLen, IDBRetSink * pDBRetSink)=0;
	/** 执行一个存储过程
	@param   dwCmdID：cmdid
	@param   dwQueueIndex:异步队列索引号
	@param   pszInData：输入数据
	@param   nInDataLen：输入数据长度
	@param   pDBRetSink：结果返回接口	
	@return  
	@note     
	@warning 
	@retval buffer 
	*/
	virtual bool			ExecuteSP(DWORD dwCmdID, DWORD dwQueueIndex, LPCSTR pszInData, int nInDataLen, IDBRetSink * pDBRetSink) = 0;

	/** 执行一条SQL语句
	@param   dwCmdID：cmdid
	@param   dwQueueIndex:异步队列索引号
	@param   dwDataBaseID : 此条语句在何个数据库执行
	@param   dwLevel : 此条语句的重要度
	@param   pszSQL : SQL语句
	@param   nSqlLen : SQL语句长度
	@return  pDBRetSink：结果返回接口 
	@note     
	@warning 
	@retval buffer 
	*/
	virtual	bool			ExecuteSQL(DWORD dwCmdID, DWORD dwQueueIndex, DWORD dwDataBaseID, DWORD dwLevel, LPCSTR pszSQL, int nSqlLen, IDBRetSink * pDBRetSink) = 0;

	/** 如果碰到sql语句有，有二进制的参数，可以用此函数将二进制添加进去
	@param   pszTargetBuffer ： 组合后的目标buffer	
	@param   pInValue : 二进制的值
	@param   nInLen : 二进制值的长度
	@return  返回组合后的长度
	@note     
	@warning 必须保证pszTargetBuffer有nInLen * 2 + 10长的内存，否则内存会有越界的危险
	@retval buffer 
	*/
	virtual int				BulidHexString(LPSTR pTargetBuffer,LPCSTR pInValue, int nInLen) = 0;

	virtual SPROCEDURECONFIG* getProcedureConfig(int nCmdID)=0;
};

IDBEngine * CreateDBEngineProc(ISchemeEngine * pSchemeEngine, LPCSTR pszDBServerPath, LPCSTR pszDBProcedurePath);
