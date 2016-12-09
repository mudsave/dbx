#include "Sock.h"

#include "DBManager.h"

int main( int argc, char *argv[] )
{
	const unsigned short int DBX_PORT = 3000;

	DBManager app;
	app.Running();

	return 0;
}

