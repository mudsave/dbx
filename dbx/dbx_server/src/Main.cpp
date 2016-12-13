//#include "Sock.h"
//#include "trace.h"
#include "lindef.h"

#include "DBManager.h"


void ParseMainCommandArgs(int argc, char *argv[])
{
}

int main(int argc, char *argv[])
{
	
	InitTraceServer(true);
    TRACE0_L2("DBX start...");

    ParseMainCommandArgs(argc, argv);

    const unsigned short int DBX_PORT = 3000;
    DBManager app(DBX_PORT);
    HRESULT result = app.Running();
    if(result == S_OK)
    {
        TRACE0_L2("Dbx stop [ normal ].");
    }
    else
    {
        TRACE0_L2("Dbx stop [ timeout ].");
    }

    Sleep(1000 * 5);
    app.RunOut();
    Sleep(1000 * 5);
	return 0;
}

