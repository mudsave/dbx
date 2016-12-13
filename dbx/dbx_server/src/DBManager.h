#ifndef __DBMANAGER_H__
#define __DBMANAGER_H__

#include "NetworkInterface.h"

class DBManager
{
public:
	DBManager();

	void Running();

protected:
	NetworkInterface m_networkInterface;
};


#endif // __DBMANAGER_H__
