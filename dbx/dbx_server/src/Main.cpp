
//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

#include "DBManager.h"
#include "DBXConfig.h"

void ParseMainCommandArgs(int argc, char *argv[])
{
}

int main(int argc, char *argv[])
{
	InitTraceServer(true);
    TRACE0_L0("DBX start...\n");

    ParseMainCommandArgs(argc, argv);

    g_dbxConfig.LoadConfig("DBServer.xml");

    const int DBX_PORT = 3000;
    HRESULT result = DBManager::InstancePtr()->Running(DBX_PORT);
    if(result == S_OK)
    {
        TRACE0_L0("Dbx stop [ normal ].\n");
    }
    else
    {
        TRACE0_L0("Dbx stop [ timeout ].\n");
    }
    
    GlobalThreadsPool()->Running();

    GenerateSignalThread();

    Sleep(1000 * 5);
    DBManager::InstancePtr()->Finalise();
    Sleep(1000 * 5);
	return 0;
}

