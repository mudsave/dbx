#ifndef __MOVE_MANAGER_H__
#define __MOVE_MANAGER_H__

#include<map>

class MoveManager : public ITask
{
public:
	MoveManager();

	virtual ~MoveManager();

public:
	virtual HRESULT Do(HANDLE hContext);

public:
	void AddMoveEntity(handle hand);

	void RemoveMoveEntity(handle hand);

private:
	typedef std::map<handle, bool> _EntityMap;
	_EntityMap m_mapEntitys;

	HANDLE m_hMoveTimer;
};

extern MoveManager g_MoveManager;

#endif
