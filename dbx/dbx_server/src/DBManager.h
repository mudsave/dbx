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
    void finalise();

    void CallSP(AppMsg *m_appMsg);
    void CallSQL(AppMsg *m_appMsg);

protected:
    void InitDB();

protected:
	NetworkInterface m_networkInterface;
};


#endif // __DBMANAGER_H_
