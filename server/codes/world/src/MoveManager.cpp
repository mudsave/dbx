#include "lindef.h"
#include "vsdef.h"
#include "Sock.h"
#include "Entity.h"
#include "MoveManager.h"
#include "world.h"

enum MoveTaskHandles
{
	eMoveHandle = 1,
};

enum MoveTaskIntervals
{
	eMoveInterval = 200,
};

MoveManager::MoveManager()
{
	m_hMoveTimer = 0;
	IThreadsPool* pThread = GlobalThreadsPool();
	m_hMoveTimer = pThread->RegTimer(this, (HANDLE)eMoveHandle, 0, eMoveInterval, eMoveInterval, "MoveManager move timer");
	ASSERT_(m_hMoveTimer);
}

MoveManager::~MoveManager()
{
	m_mapEntitys.clear();
	if (m_hMoveTimer)
	{
		IThreadsPool* pThread = GlobalThreadsPool();
		pThread->UnregTimer(m_hMoveTimer);
		m_hMoveTimer = 0;
	}
}

HRESULT MoveManager::Do(HANDLE hContext)
{
	switch((int)(long)hContext)
	{
		case eMoveHandle:
			{
				_EntityMap::iterator iter = m_mapEntitys.begin();
				for (; iter != m_mapEntitys.end(); ++iter)
				{
					CoEntity* pEntity = _EntityFromHandle(iter->first);
					if (pEntity)
					{
						pEntity->onMove();
					}
				}
				break;
			}
		default:
			break;
	}
	return S_OK;
}

void MoveManager::AddMoveEntity(handle hand)
{
	CoEntity* pEntity = _EntityFromHandle(hand);
	if (!pEntity)
	{
		TRACE0_WARNING("MoveManager add move entity failed: the hand entity is null!!!\n");
		return;
	}
	m_mapEntitys[hand] = true;
	pEntity->setIsMove(true);

	//通知脚本层实体开始移动了
	lua_State* pState = g_world.getLuaState();
	if (pState)
	{
		static LuaFunctor<TypeNull, handle> fStartMove(pState, "ManagedApp.EntityStartMove");
		if (!fStartMove(TypeNull::nil(), hand))
		{
			TRACE2_WARNING("MoveManager Robot.apiEntityStartMove failed: because of %s, entity handle(%d)\n", fStartMove.getLastError(), hand);
		}
	}
}

void MoveManager::RemoveMoveEntity(handle hand)
{
	 CoEntity* pEntity = _EntityFromHandle(hand);
	 if (!pEntity)
	 {
		 TRACE0_WARNING("MoveManager remove  move entity failed: the hand entity is null!!!\n");
		 return;
	 }
	 pEntity->setIsMove(false);
	 m_mapEntitys.erase(hand);
	//通知脚本层实体停止移动了
	lua_State* pState = g_world.getLuaState();
	if (pState)
	{
		  static LuaFunctor<TypeNull, handle> fEndMove(pState, "ManagedApp.EntityEndMove");
		  if (!fEndMove(TypeNull::nil(), hand))
		  {
				TRACE2_WARNING("MoveManager Robot.apiEntityEndMove failed: because of %s, entity handle(%d)\n", fEndMove.getLastError(), hand);
		  }
	}
}

MoveManager g_MoveManager;
