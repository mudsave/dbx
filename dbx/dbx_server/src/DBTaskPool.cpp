#include "DBTaskPool.h"


DBTaskPool::DBTaskPool()
{

}

DBTaskPool::~DBTaskPool()
{

}

// 根据p_taskNum创建线程池
bool DBTaskPool::InitTasks(int p_taskNum)
{
    return true;
}

ITask *DBTaskPool::CreateThread()
{
    return NULL;
}