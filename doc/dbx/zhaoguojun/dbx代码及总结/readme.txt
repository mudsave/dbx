

1, 字符转义
char t1[100];
char t2[] = {'\n', '\'', '\\', 10, 0, 'A'};
unsigned long l1 = mysql_real_escape_string(&mysql, t1, t2, sizeof(t2));
t1结果 \n\'\\\n\0A

2, char varchar binary varbinary 的数据库返回类型都是  MYSQL_TYPE_STRING
	所以 2进制的数据不能在服务器里转换成 2进制了， 只能通过字符串传到客户端。

3, 关于字段的长度 
	MYSQL_FIELD  的 length，返回的是表格定义时的长度
	unsigned long *mysql_fetch_lengths(MYSQL_RES *result) 返回实际字段的长度

4, 当mysql_store_result() 的结果为NULL 时，不能说明还没有结果集了，也可能是不产生结果集的操作，
	如 insert，delete。

5，结果集的协议里，添加了一些冗余非必需字段，诸如：第几个结果集第几行第几列。可来用作调试和校验信息。

6，对于存储过程的查询 采用老版本的查询方式，采用mysql的第一套api。
	对于sql 语句的查询，采用mysql的第二套api，不支持多条语句一起查询。优势：有类型检查，长度检查，
	提供返回结果类型转换， 容错性较强，传参数方便。

7， c++层面支持的数据类型有：char, int, long long, float, string


8, 网络模块使用libevent，基本功能是 监听、建立连接、通知上层有消息到达、发送消息，
由于libevent自带缓冲区，所以不需要自己为每个连接维护缓冲区。


9, 客户端向服务器发送数据的协议buffer:
	buffer长度(int 包括自己)
	operationID(int)
	queueID(char)
	参数个数(char)
	类型(char)(1, 0)
	长度(int) sql,sp
	[1](char) 参数类型(char) 参数长度(int) value
	[2](char) 参数类型(char) 参数长度(int) value

10, 服务器向客户端发送的结果集协议

总长度
长度
ResultInfo
长度
MapFieldSets
长度
MapRecordSets
长度
MapOutputParamSet

buff 结构
field sets buffer(MapFieldSets)
	结果集数(char)
	结果集1(char)--结果集1字段数(char)--偏移地址1(int)
	结果集2--结果集2字段数--偏移地址2
	...
	[1](char)[1](char)字段1(struct)--[1][2]字段2
	...

record sets buffer(MapRecordSets)
	结果集数(char)
	结果集1(char)--记录row(int)--字段数(char)--偏移地址1(int)
	结果集2--记录row--字段数--偏移地址2
	...
	[1](char)[1](int)[1](int)Record--[1][1][2]Record
	...

Output Param(MapOutputParamSet)
	输出参数
	[1]参数1--[2]参数2



11, 调用方式:
(1) lua中存储过程查询
mysql_param4 = {
	sp = "get_role_info",
	[1] = "z1",
	[2] = "@id",
	[3] = "@model_id",
}
mysql_query(mysql_param4, 0)

(2) lua sql语句查询
mysql_param1 = {
	sql = "select AccountID, Name, ShowParts from role where ID = ? ",
	[1] = 669,
}
mysql_query(mysql_param1, 0)

(3) c++ 调用方式:
CQueryClient *query_client = new CQueryClient;
const char sql[]  = "select * from mind where `roleID` = ?;"; 
query_client->buildSqlQuery(sql, 0);
query_client->addParams(176);
query_client->executeQuery();


待完善的地方：
只是初步实现功能而已，离正式运行还差得远，还需不断的改进

0, 相关内存释放，没仔细处理
1，各种错误和异常的捕获，以及处理
2，结构还不好，需进一步调整
