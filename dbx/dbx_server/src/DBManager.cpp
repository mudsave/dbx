#include "DBManager.h"

// 头文件规则有问题，存在隐性依赖，必须包含lindef.h才能正确使用trace.h等头文件，这些头文件是相互依赖的。
// 任何一个头文件的修改都会引起所有的文件重新编译，不仅仅是包含这个头文件的编译单元。隐性依赖的逻辑混乱也让使用者莫名其妙。
//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

DBManager::DBManager()
{
	m_networkInterface = NetworkInterface();
    m_threadsPoll = GlobalThreadsPool();
}

HRESULT DBManager::Running(int p_port)
{
	TRACE0_L2( "DBManager is Running...\n" );
    m_networkInterface.Listen(p_port);
    m_threadsPoll->Running();
}

void DBManager::RunOut()
{
    TRACE0_L2("DBManager had run out...\n");
}