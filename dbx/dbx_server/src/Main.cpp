//#include "Sock.h"
//#include "trace.h"
#include "lindef.h"

#include "DBManager.h"


int main( int argc, char *argv[] )
{
	//const unsigned short int DBX_PORT = 3000;

	InitTraceServer();

	TRACE0_L2("DBSession start...");

	DBManager app;
	app.Running();

	return 0;
}

