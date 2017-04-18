/**
 * filename : Entity.cpp
 * desc : 实体（视野管理部分）
 */

#include "lindef.h"
#include "vsdef.h"
#include "world.h"
#include "MoveManager.h"
#include "Entity.h"
#include "MapManager.h"
#include "Scene.h"

bool CoEntity::move(short x, short y, int flags)
{
	if (x == 0 && y == 0)
	{
		return false;
	}
	GridVct target(x, y);
	return move(&target, flags);
}

bool CoEntity::move(const GridVct* pDest, int flags)
{
	if (!m_pScene)
	{
		TRACE0_ERROR("Entity move failed: the scene is not exist!!!\n");
		return false;
	}
	if (pDest == 0 && !m_pScene->inMap(*pDest))
	{
		TRACE0_ERROR("Entity move failed: the target pos is not correct!!!\n");
		return false;
	}
	if (m_speed <= 0)
	{
		TRACE0_ERROR("Entity move failed: the entity move speed is error!!!\n");
		return false;
	}
	if (m_position.x == pDest->x && m_position.y == pDest->y)
	{
		return true;
	}
	BYTE buf[(MAX_PATH_LEN - 1) * sizeof(GridVct) + sizeof(_PropPosData)];
	_PropPosData* pPos = (_PropPosData*)buf;
	short len = 0;
	POINT *pPath = NULL;
	GridVct moveTo(*pDest);
	if (!g_MapManager.findPath(m_sceneInfo.mapId, m_position, moveTo, flags, pPath, len))
	{
		TRACE0_ERROR("Entity move failed: then entity not find path!!!\n");
		return false;
	}

	if (len <= 0)
	{
		TRACE0_WARNING("Entity move failed: the path len is error\n");
		return false;
	}
	if (len >= MAX_PATH_LEN)
	{
		len = MAX_PATH_LEN;
		TRACE0_ERROR("Entity move warning:the path len is too long\n");
	}
	GridVct *tPath = pPos->path;
	for (int i = 0; i <= len; i++)
	{
		GridVct s_src((short)pPath[i].x, (short)pPath[i].y);
		*tPath = s_src;
		++tPath;
	}
	pPos->bMove = true;
	pPos->len = len;
	pPos->idx = 0;
	pPos->delay = 0;
	pPos->step = 0;
	pPos->endPath = true;
	SetPropData(UNIT_POS, (const void *)buf, sizeof(_PropPosData) + (len - 1) * sizeof(GridVct));
	m_dTimeOrigin = ::GetTickCount();
	if (!m_Move)
	{
		g_MoveManager.AddMoveEntity(m_hand);
	}
	return true;
}

void CoEntity::moveByPath(lua_State* pState, _PropPosData* pPropPosData)
{
	int t_idx = lua_gettop(pState);
	static BYTE* p = new BYTE[(MAX_PATH_LEN * 8) * sizeof(GridVct) + sizeof(_PropPosData)];
	_PropPosData* pPosData = (_PropPosData*)p;
	int len = sizeof(_PropPosData) - sizeof(GridVct);
	::memcpy(pPosData, pPropPosData, len);
	if(lua_istable(pState,t_idx))
	{
		short index = 0;
		bool lock = true;
		lua_pushnil(pState);
		while (lua_next(pState, -2))
		{
			if (lock)
			{
				pPosData->path[index].x = (short) lua_tonumber(pState, -1);
				lock = false;
			}
			else
			{
				pPosData->path[index].y = (short) lua_tonumber(pState, -1);
				lock = true;
				++index;
			}
			lua_pop(pState, 1);
		}
	}
	lua_pop(pState, 1);
	moveByPath(pPosData);
}

void CoEntity::moveByPath(_PropPosData* pPosData)
{
	if (!pPosData->bMove)
	{
		setPosition(pPosData->path[0]);
		if (m_Move)
		{
			resetMove();
			g_MoveManager.RemoveMoveEntity(m_hand);
		}
		return;
	}

	if (pPosData->len < 1)
	{
		TRACE2_WARNING("[CoEntity:MoveByPath] WARNING: entity(%d) move path too less, len < %i\n", m_hand, pPosData->len);
		return;
	}

	if (pPosData->len > MAX_PATH_LEN)
	{
		TRACE2_ERROR("[CoEntity:MoveByPath] WARNING: entity(%d) move path too long, len=%i\n", m_hand, pPosData->len);
	}
	if (!m_Move)
	{
		g_MoveManager.AddMoveEntity(m_hand);
		resetMove();
		m_bDelayEnable = (pPosData->delay > 0);
		m_dTimeOrigin = ::GetTickCount();
	}
	else
	{
		m_bDelayEnable = false;
	}
	// 更新位置
	setPosition(pPosData->path[0]);
	// 更新路径并通知客户端
	SetPropData(UNIT_POS, (void *)pPosData, sizeof(_PropPosData) + (pPosData->len - 1) * sizeof(GridVct));
}

void CoEntity::onMove()
{
	static float fTileWidth = 64.0 ;
	_PropPosData* pPosData = (_PropPosData*)m_propSet.p[UNIT_POS].val.dataVal;
	DWORD dwNow = ::GetTickCount();
	m_clipping += dwNow - m_dTimeOrigin;
	m_dTimeOrigin = dwNow;
	m_stepTime = 1.0 / (float)(m_speed / 100.0);
	if (!m_bDelayEnable)
	{
		if (pPosData->delay > 0 && pPosData->idx >= 1)
		{
			m_bDelayEnable = true;
		}
	}
	else
	{
		// 延迟失效时间
		float startTime = pPosData->delay * m_stepTime * fTileWidth;
		if (m_clipping - startTime >= 0)
		{
			m_clipping -= startTime;
			pPosData->delay = 0;
			m_bDelayEnable = false;
		}
	}
	if (!m_bDelayEnable && m_clipping >= m_stepTime)
	{
		bool bTileChanged = false ;
		int nPathLen = pPosData->len - 1;
		// 是否应该走完当前Tile
		while(m_clipping >= m_stepTime * (fTileWidth - m_nStrideStep))
		{
			m_clipping -= m_stepTime * (fTileWidth - m_nStrideStep);
			m_nStrideStep = 0;
			pPosData->idx++;
			bTileChanged = true;
			if (pPosData->idx > nPathLen)
			{
				break;
			}
		}
		if (pPosData->idx <= nPathLen)
		{
			if (bTileChanged)
			{
				setPosition(pPosData->path[pPosData->idx]);
				if (getPropType() == eClsTypePlayer){
					static LuaFunctor<TypeNull, int> tileChange(g_world.getLuaState(), "ManagedApp.onTileChange");
					tileChange( TypeNull::nil(), getHandle() );
				}
			}
			while(m_clipping >= m_stepTime)
			{
				++m_nStrideStep;
				m_clipping -= m_stepTime;
			}
		}
		else
		{
			if (m_Move)
			{
				resetMove();
				setPosition(pPosData->path[pPosData->idx - 1]);
				g_MoveManager.RemoveMoveEntity(m_hand);
			}
		}
	}
}

void CoEntity::moveFollowEntity(lua_State* pState, short offset, _PropPosData* pPropPosData)
{
	MovePath path;
	path.clear();

	// 倒数第一个参数，路径数组
	int t_idx = lua_gettop(pState);
	handle petID = lua_tointeger(pState, t_idx);

	if(lua_istable(pState, t_idx - 1))
	{
		lua_pushnil(pState);
		while (lua_next(pState, t_idx - 1))
		{
			path.push_back((short) lua_tointeger(pState, -1));
			lua_pop(pState, 1);
		}
		lua_pop(pState,1);
	}

	vector<handle> vecEntityList;
	vecEntityList.clear();
	//倒数第二个参数，跟随者数组
	if(lua_istable(pState, t_idx - 2))
	{
		lua_pushnil(pState);
		while (lua_next(pState, t_idx - 2))
		{
			vecEntityList.push_back((handle) lua_tointeger(pState, -1));
			lua_pop(pState, 1);
		}
		lua_pop(pState, 1);
	}

	static BYTE* p = new BYTE[(MAX_PATH_LEN * 4) * sizeof(GridVct) + sizeof(_PropPosData)];
	_PropPosData* pPosData = (_PropPosData*)p;
	int len = sizeof(_PropPosData) - sizeof(GridVct);
	::memcpy(pPosData, pPropPosData, len);

	CoEntity* pFollowed = this;
	short followedDelay = 0;
	bool bFilled = false;
	for (size_t i = 0; i < vecEntityList.size(); i++)
	{
		short moveDelay = 0;
		CoEntity* pFollow = _EntityFromHandle(vecEntityList[i]);
		//modify the pet pos with player
		if (petID == vecEntityList[i])
		{
			++offset;
		}
		//printf("move follow ................offset:%d\n", offset);
		pFollow->calcMovePath(offset, path, moveDelay, bFilled);
		//printf("move follow end.............\n");
		// 只有队长才显示坐骑
		offset = (offset > 1) ?  1 : offset;
		if (path.size() >= 2)
		{
			// 计算路径长度
			pPosData->len = (int)(path.size() / 2);
			pPosData->delay = (moveDelay < 0) ? 0 : (followedDelay + moveDelay);

			// 实体移动
			pFollow->fillMovePath(path, pPosData);
			followedDelay += pPosData->delay;
		}
		pFollowed = pFollow;
		if (path.size() == 0)
		{
			// 队员不移动，添加当前路径点，便于计算其跟随者的路径
			GridVct curPos = pFollowed->getPosition();
			path.push_front(curPos.y);
			path.push_front(curPos.x);
		}
	}
}

void CoEntity::stopMove(short x, short y )
{
	GridVct pos;
	if (x == 0 && y == 0)
	{
		pos = getPosition();
	}
	else
	{
		pos.x = x;
		pos.y = y;
	}
	if (m_Move)
	{
			resetMove();
			g_MoveManager.RemoveMoveEntity(m_hand);
	}
	_PropPosData data;
	data.bMove = false;
	data.len = 1;
	data.idx = 0;
	data.delay = 0;
	data.step = 0;
	data.endPath = true;
	data.path[0] = pos;
	SetPropData(UNIT_POS, (const void *)&data, sizeof(data));
	if (x == 0 && y == 0)
	{
		return;
	}
	else
	{
		setPosition(pos);
	}
}

short CoEntity::correctMovePath(short x, short y)
{
	short realIdx = -1;
	GridVct curPos;
	curPos.x = x;
	curPos.y = y;
	GridVct realPos = curPos;
	_PropPosData* pPosData = (_PropPosData*)m_propSet.p[UNIT_POS].val.dataVal;

	if (m_position != curPos)
	{
		short curIdx = pPosData->idx;
		short difIdx = 0;

		// 往后找
		for(int i = curIdx + 1; i < pPosData->len; i++)
		{
			if ( pPosData->path[i] == curPos ) 
			{
				realIdx = i;
				difIdx = realIdx - curIdx;
				break;
			}
		}

		if (difIdx != 1)
		{
			// 往前找
			for(int i = curIdx - 1; i >= 0; i--)
			{
				if ( pPosData->path[i] == curPos ) 
				{
					realIdx = (difIdx == 0) ? i : ( (difIdx > curIdx - i) ? i : realIdx );
					break;
				}
			}
		}
	}
	else
	{
		realIdx = (pPosData->idx == pPosData->len) ? (pPosData->idx - 1) : pPosData->idx;
	}

	if (realIdx != -1)
	{
		// 当前路径点以客户端为准
		pPosData->idx = realIdx;
		realPos = pPosData->path[realIdx];
	}
	// 校正位置
	setPosition(realPos);

	return realIdx;
}

short CoEntity::correctFollowMovePath( short refIdx, short refPathLen )
{
	short realIdx = -1;

	if (refIdx >= 0)
	{
		_PropPosData* pPosData = (_PropPosData*)m_propSet.p[UNIT_POS].val.dataVal;
		short delay = refPathLen - pPosData->len;

		if (refIdx == 0)
		{
			realIdx = 0;
		}
		else if (refIdx < delay + 1)
		{
			m_bDelayEnable = (pPosData->delay > 0) ? true : false;
			realIdx = (m_Move && m_bDelayEnable) ? 1: 0;
		}
		else
		{
			realIdx = refIdx - delay;
		}

		realIdx = (realIdx < 0) ? 0 : realIdx;
		realIdx = (realIdx >= pPosData->len) ? (pPosData->len - 1) : realIdx;
		pPosData->idx = realIdx;
		setPosition(pPosData->path[realIdx]);
	}

	return realIdx;
}

void CoEntity::calcMovePath( short offset, MovePath& path, short& moveDelay, bool bFilled )
{
	short nPos = 0;
	size_t oldPathLen = path.size();

	GridVct curPos = getPathByCurIndex(0);
	GridVct nextPos = getPathByCurIndex(1);
	GridVct pos = (m_Move && !m_bDelayEnable) ? nextPos : curPos;
	for (size_t idx = 0; idx < path.size(); idx += 2)
	{
		short x = path[idx];
		short y = path[idx + 1];
		short dx = ::abs(pos.x - x);
		short dy = ::abs(pos.y - y);
		if (dx > offset || dy > offset)
		{
			nPos = (idx >= 2) ? (idx - 2) : 0;
			break;
		}
	}
	path.erase(path.begin(), path.begin() + nPos);
	if (path.size() >= 2 && ((pos.x != path[0]) || (pos.y != path[1])) )
	{
		path.push_front(pos.y);
		path.push_front(pos.x);
		// 防止出现不连续路径
		fillMovePathByDistance(path, bFilled);
	}
	if (m_Move && !m_bDelayEnable && curPos != nextPos)
	{
		path.push_front(curPos.y);
		path.push_front(curPos.x);
	}
	while (path.size() >= 2 && offset > 0)
	{
		// 删掉末尾路径点
		path.pop_back();
		path.pop_back();
		--offset;
	}

	// 计算延迟
	moveDelay = (oldPathLen - path.size()) / 2;
}

void CoEntity::fillMovePath( MovePath &path, _PropPosData* pPosData )
{
	for (short i = 0; i < pPosData->len; ++i)
	{
		pPosData->path[i].x = path[i*2];
		pPosData->path[i].y = path[i*2+1];
		//printf("fill move path.......:%d, %d \n", path[i*2], path[i*2+1]);
	}
	moveByPath(pPosData);
}

void CoEntity::fillMovePathByDistance( MovePath& path, bool bFilled)
{
	if (path.size() >= 4)
	{
		// 路径前两路径点相差3~4TILE内, 采用寻路算法来计算两路径点间的路径
		bool bDiscard = false;
		short dx = ::abs(path[2] - path[0]);
		short dy = ::abs(path[3] - path[1]);
		//printf("distance...........%d,%d\n", dx, dy);
		if ( bFilled || ( (!bFilled && (dx >= 2 && dx <= 4)) || (dy >= 2 && dy <= 4) ) )
		{
			POINT* pPath = 0;
			short nPathLen = 0;
			int nBlockOption = BLOCK_OPTION_GROUND | BLOCK_OPTION_FLY;
			GridVct pos1(path[0], path[1]);
			GridVct pos2(path[2], path[3]);
			//printf("fill move path by distance.....pos1:%d,%d pos2:%d,%d\n", pos1.x, pos1.y, pos2.x, pos2.y);
			if (g_MapManager.findPath(m_sceneInfo.mapId, pos1, pos2, nBlockOption, pPath, nPathLen))
			{
				path.pop_front();
				path.pop_front();
					// 插入新路径点
				for (int i = nPathLen - 2; (nPathLen >= 3 && i >= 0); i--)
				{
					path.push_front(pPath[i].y);
					path.push_front(pPath[i].x);
				}
			}
			else
			{
				bDiscard = true;
			}
		}
		else if ( dx > 4 || dy > 4 )
		{
			bDiscard = true;
		}
		if (bDiscard)
		{
			// 没搜寻到路径或差距太大，直接丢弃第一个路径点
			path.pop_front();
			path.pop_front();
		}
	}
}

short CoEntity::getPathLen() const
{
	_PropPosData const* pPosData = (_PropPosData const*)m_propSet.p[UNIT_POS].val.dataVal;
	return pPosData->len;
}

GridVct CoEntity::getPathByCurIndex( short index )
{
	_PropPosData const* pPosData = (_PropPosData const*)m_propSet.p[UNIT_POS].val.dataVal;
	short idx = pPosData->idx + index;
	idx = (idx < 0) ? 0 : idx;
	idx = (idx > pPosData->len - 1) ? (pPosData->len - 1) : idx;
	return pPosData->path[idx];
}

void CoEntity::resetMove()
{
	m_nStrideStep = 0;
	m_dTimeOrigin = 0;
	m_clipping = 0;
	m_bDelayEnable = false;
}

void CoEntity::setMoveSpeed(short speed)
{
	m_speed = speed;
	SetPropNumber(UNIT_MOVE_SPEED,speed);
}

short CoEntity::getMoveSpeed()
{
	return m_speed;
}
