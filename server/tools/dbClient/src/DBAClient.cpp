#include "IDBAClient.h"
#include "Client.h"
#include <list>
#include <algorithm>

// This is an example of an exported function.
IInitClient* CreateClient(IDBANetEvent* pNetEvent,std::string serverAddr,int iPort)
{

	CClient* pClient=CClient::InstancePtr();
	CClient::setDBNetEvent(pNetEvent);
    pClient->ConnectDBX(serverAddr, iPort);
	return dynamic_cast<IInitClient*>(pClient);

}
