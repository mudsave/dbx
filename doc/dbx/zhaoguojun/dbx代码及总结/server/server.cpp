
#include "DBEngine.h"
#include "DBServer.h"
/*

int main() {
	CDBServer server;
	CDBEngine engine;
	engine.Create();

	server.getInput();
	server.execute(&engine);

	engine.Drive();

	// server.writeResult(&engine);
	engine.Close();
}



*/
int main() {
	CDBServer server;
	server.listen("172.16.2.218", 1027);
	return 0;
}