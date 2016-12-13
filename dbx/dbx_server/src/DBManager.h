#ifndef __DBMANAGER_H__
#define __DBMANAGER_H__

#include "NetworkInterface.h"

class DBManager
{
public:
	DBManager();

    HRESULT Running(int p_port = 3000);
    void RunOut();

protected:
	NetworkInterface m_networkInterface;
    IThreadsPool *m_threadsPoll;
};


#endif // __DBMANAGER_H__
