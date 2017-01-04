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

    void CallSP(AppMsg *m_appMsg);
    void CallSQL(AppMsg *m_appMsg);

protected:
    void InitDB();

protected:
	NetworkInterface m_networkInterface;
    IThreadsPool *m_threadsPoll;
};


#endif // __DBMANAGER_H_
