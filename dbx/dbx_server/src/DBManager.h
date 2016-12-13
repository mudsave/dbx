#ifndef __DBMANAGER_H__
#define __DBMANAGER_H__

#include "NetworkInterface.h"

class DBManager
{
public:
	DBManager(unsigned short p_port = 3000);

	HRESULT Running();
    void RunOut();

protected:
	NetworkInterface m_networkInterface;
};


#endif // __DBMANAGER_H__
