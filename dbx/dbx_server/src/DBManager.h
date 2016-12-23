#ifndef __DBMANAGER_H_
#define __DBMANAGER_H_

#include "lindef.h"
#include "Sock.h"

#include "NetworkInterface.h"
#include "Singleton.h"

class DBManager: public Singleton<DBManager>
{
public:
    DBManager();

    HRESULT Running(int p_port = 3000);
    void RunOut();

protected:
	NetworkInterface m_networkInterface;
    IThreadsPool *m_threadsPoll;
};


#endif // __DBMANAGER_H_
