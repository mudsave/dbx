
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
    TRACE0_L2("DBX start...\n");

    g_dbxServerConfig.LoadConfig("dbxServer.xml");

    ParseMainCommandArgs(argc, argv);

    const int DBX_PORT = 3000;
    HRESULT result = DBManager::InstancePtr()->Running(DBX_PORT);
    if(result == S_OK)
    {
        TRACE0_L2("Dbx stop [ normal ].\n");
    }
    else
    {
        TRACE0_L2("Dbx stop [ timeout ].\n");
    }

    GenerateSignalThread();

    Sleep(1000 * 5);
    DBManager::InstancePtr()->RunOut();
    Sleep(1000 * 5);
	return 0;
}

