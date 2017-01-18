/*
Written by wangshufeng
*/

//#include "trace.h"
#include "lindef.h"
#include "Sock.h"

#include "DBManager.h"
#include "DBXConfig.h"

void ParseMainCommandArgs(int argc, char *argv[])
{
}

void CleanUp()
{
    TRACE0_L0("DBX CleanUp...\n");
    DBManager::InstancePtr()->Shutdown();
}

int main(int argc, char *argv[])
{
	InitTraceServer(true);
    TRACE0_L0("DBX start...\n");
    ParseMainCommandArgs(argc, argv);
    g_dbxConfig.LoadConfig("DBServer.xml");
    GenerateSignalThread();
    SetCleanup(CleanUp);

    const int DBX_PORT = 3000;  // todo£º·Åµ½DBServer.xmlÅäÖÃ
    if (!DBManager::InstancePtr()->Initialize(DBX_PORT))
    {
        TRACE0_ERROR("DBManager::Initialize(): initialization failed!\n");
        DBManager::InstancePtr()->Finalise();

        Sleep(1000 * 5);
        return -1;
    }

    HRESULT result = DBManager::InstancePtr()->Run();
    if (result == S_OK)
    {
        TRACE0_L0("Dbx stop [ normal ].\n");
    }
    else
    {
        TRACE0_L0("Dbx stop [ timeout ].\n");
    }

    Sleep(1000 * 5);
	return 0;
}

