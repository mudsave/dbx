#ifndef __DB_MANAGER_H_
#define __DB_MANAGER_H_

#include "lindef.h"
#include "Sock.h"

#include "NetworkInterface.h"
#include "Singleton.h"

class DBManager: public Singleton<DBManager>
{
public:
    DBManager();

    bool Initialize(int p_port = 3000);
    void Finalise();

    HRESULT Run();

    void CallSP(AppMsg *m_appMsg);
    void CallSQL(AppMsg *m_appMsg);

protected:
    bool InitDB();

protected:
	NetworkInterface m_networkInterface;
};


#endif // __DB_MANAGER_H_
