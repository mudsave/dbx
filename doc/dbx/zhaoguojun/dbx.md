
###DBAServer
	dbx的入口，初始化，启动
	无需验证用户的身份
###DBAMsgServer
	event 管理
	eventHandler 管理
	event 触发
###DBARecordSet
	结果
		map<int,int> type;
		map<int,void*> value;
		map<int,char*> name;
	结果集
	结果集管理
###DBALogServer
	打印错误信息
###DBASession
监听客户端，建立连接
- session

		ILinkPort*		m_pLinkPort;
		IThreadsPool*	m_pThreadPool;
	一个LinkPort 代表一个和MYSQL客户端的连接
- SessionMsgClient

	一个eventHandler,负责发结果到客户端

		onHandleEvent(AppMsg* pMsg)
		先获得结果集RecordSet,然后将结果集转化为ResultMsg

	



###DBAAccess
- 负责和dbEngine交互

		case _MYSQL:
			static CMysqlAdapter s_MysqlAdapter;
			return dynamic_cast<IDBAdapter*> (&s_MysqlAdapter);
- 解析数据库配置文件

		pAdapter->init(pSPResult,pDBState,res,serverFilename,ProcedureFilename);
- 解析从脚本传来的sql参数或存储过程参数

		SQLPARAM CMysqlAdapter::getSPROCEDUREPARAM();
		SPROCEDURECONFIG CMysqlAdapter::getSPROCEDURECONFIG();
- 执行sql 和 存储过程
	
		DBMsgClient.cpp
			case C_DOACTION:
				m_pDBAdapter->callSP(pMsg);	
			case C_DOSQL:
				m_pDBAdapter->callSQL(pMsg);		
- 获得错误信息
- 封装从dbEngine返回的结果，并返回给客户端

		struct SOUTPUTDATA{
			char szVariableName[MAX_PARAMNAME_LEN];	// 输出变量名
			int  nSize;								// 数据长度
			int  nDataSource;						// 数据源
			int	 nDataType;							// 数据类型
		};
		
CMySqlDBResult::sendResult(int spId,char *pOutData, int nOutLen,MAPRESETDATA &map_Res,MAPOUTDATA &map_Out)
pOutData 真实的数据
nOutLen 真是数据的长度
map_Res	结果集（key，value的类型）没有数据
map_Out	传出参数（key，value的类型）没有数据

CMySqlDBResult::translateRes(int** indexList,char* outRes,int nOutLen,MAPRESETDATA &map_Res)
indexList 一个RecordSet的int标识的数组


###消息的格式
	class ObjDoMsg {
		int ObjectId;
		int Param[1];
	};
	1个字段对应4个值，(int)name的长度，(char*)name，(int)value的长度,(char*)value
	struct AppMsg{
		unsigned short msgLen;		//消息长度
		unsigned char msgFlags;		//消息标志位
		unsigned char msgCls;		//消息类别
		unsigned short msgId;		//消息id
		long context;   			//消息的内容
	};
	class CResultMsg : public AppMsg{
		int		m_nAttriIndex;  //属性参数起始
		int		m_nAttriNameCount;
		int		m_nAttriCount;
		int		m_nTempObjId;  //响应的流水号
		int		m_nSessionId;	//session号
		int		m_spId;			//存储过程ID号
		bool	m_bEnd;	
		bool	m_bNeedCallback;
		short	m_nLevel;
		ObjDoMsg*		m_pObjDoMsg;
	};
	class CSSResultMsg :public CResultMsg;
	class CCSResultMsg :public CResultMsg;
	class CSCResultMsg :public CResultMsg;
	
###问题
SessionMsgClient.cpp 157行 175行 50行

##线程

##### MsgServer 中的1个线程

用于别人向自己投递消息，并触发消息

##### Session 中2个的线程

1,接收客户端的消息

2,监听

##### 每个world服有3个线程

1，主线程

2，个连接dbx

	while(true) {
		if(!m_bLink) {
			if (m_pLinkCtrl) m_pLinkCtrl->Connect(m_strServerAddr.c_str(),m_lPort,this,0);
		}
		Sleep(5000);
	}
3，接受dbx返回的消息，并把结果集注入到脚本中

####DBAClient中的线程
接受来自dbx的消息CSCResultMsg，将CSCResultMsg 解析成lua中的表。

##数据转换流程
来自lua中的参数，封装成CCSResultMsg，发送到DBSession

	pMsg->msgId=C_DOACTION;
	pMsg->msgId=C_DOSQL;

DBSession 中的接收消息的线程，将Msg投递到MsgServer中接收消息的线程

MsgServer中接收消息的线程,触发消息，在DBAAccess中执行，也就是将消息解析成msyql的命令，通过mysql的api执行命令。执行的过程中是同步的，获得返回结果，并包装成pResMsg->context=CSSRESMSG 投递到MsgServer

CLuaArray::setResult();

对lua中的表进行3次遍历：

- 第1次 计算所有变量名字符串的长度
- 第2次 计算所有值的长度
- 第3次 memcpy key和value

lua 
- 

		local params = {{}}
		params[1]["spName"] = "sp_test"
		params[1]["dataBase"] = 1
		params[1]["sort"] = "id,name"
		params[1]["id"] = id
		params[1]["name"] = name
c++
- 

		CSCResultMsg* m_pData;

转换细节：
在c++中先计算所有参数的大小：key字符串的长度，key字符串的值，value的长度，value的值。
然后malloc CSCResultMsg。
然后将key-value 设置到CSCResultMsg。

mysql api参数

####执行sql

		struct SQLPARAM {
			DWORD dwCmdID;
			DWORD dwQueueIndex;
			DWORD dwDataBaseID;
			DWORD dwLevel;
			LPCSTR pszSQL;
			int nSqlLen;
		};

		CMysqlAdapter::getSPROCEDUREPARAM()从消息中获取sql参数
		CMysqlAdapter::getSPROCEDURECONFIG()从消息中获取存储过程参数

####执行存储过程

1,从xml读配置

2,从消息里读配置

###class ObjDoMsg 
	int ObjectId;
	int Param[1];
setParam(int ParamType,void* pParam );
ParamType 添加的参数的类型（大小）
pParam 值的地址
添加一个新参数

char* MoveParam(void *pCurParam,int* pParamType,int paramCount,int step);
pCurParam 参数值起始地址
pParamType 参数类型其实地址
pCurParam 参数数量
step 参数类型的大小
返回新的值的首地址

int getParamLen(int* pParamType,int paramCount);
获得 值 区域的大小

void* getParam(int* pParamType/*out*/,int index/*from 0*/)
返回值 第 index 个参数

###返回数据流程
CAsynObject::OnExecuteSQL(void)
m_pSqlOuter->setOutRes(m_ProcedureConfig.listResultSet);
m_pSqlOuter->ExecuteSQL();
m_pSqlOuter->OnResultSQL();
先存每个字段的类型信息
SOUTPUTDATA sspbindparam;
m_CurrResSet.push_back(sspbindparam);

然后再存具体的每个字段
SSPBINDPARAM value;
TLIST_PARAM listonrdset;
listonrdset.push_back(value);
listResetResult.push_back(listonrdset);

然后将上一步的list，进一步打平成 LPSTR m_pszOutData;











从 c++ 到lua 传数据，直接序列化后，传入到lua中。












