/**
 * filename : Entity.cpp
 * desc : 实体（视野管理部分）
 */

#include "lindef.h"
#include "vsdef.h"
#include "LinkContext.h"
#include "world.h"
#include "MoveManager.h"
#include "Entity.h"
#include "Scene.h"
#include "GridGraphics.h"
#include "MapManager.h"

CoEntity::CoEntity() :
	m_clientLink(0), m_gatewayLink(0), m_gatewayId(-1),
	m_dbid(-1),
	m_logicType(eLogicNone), m_propType(eClsTypeNone),
	m_direction(-1), m_speed(-1),
	m_pScene(NULL),
	m_inSync(false), m_firstCast(true), m_autoCast(false)
{
	m_hand = s_hMgr.createHandle(this);
	resetMove();
}

CoEntity::~CoEntity(void)
{
	s_hMgr.closeHandle(m_hand);
}

void CoEntity::release()
{
	delete this;
}

void CoEntity::setPosition(int x, int y)
{ 
	GridVct pos;
	pos.x = x;
	pos.y = y;
	setPosition(pos);
}

void CoEntity::setPosition(const GridVct& pos)
{ 
	if ( pos.x != m_position.x || pos.y != m_position.y )
	{	
		GridVct last = m_position;
		m_position = pos; 
		PosChanged(last); 
	}
}

void CoEntity::clearMyAround()
{
	for( handle h = m_myAround.begin(); h != (handle)INVALID_HANDLE; h = m_myAround.next() )
	{
		CoEntity* pEntity = _EntityFromHandle(h); ASSERT_(pEntity);
		if ( pEntity )
		{
			pEntity->removeWatcher(m_hand);
		}
	}
	m_myAround.clear();
}

void CoEntity::clearAroundMe()
{
	if ( m_aroundMe.size() > 0 )
	{
		AppMsg* pMsg = genExitMessage();
		for( handle h = m_aroundMe.begin(); h != (handle)INVALID_HANDLE; h = m_aroundMe.next() )
		{
			CoEntity* pEntity = _EntityFromHandle(h);
			ASSERT_( pEntity );
			ASSERT_( pEntity->inSync() );
			if ( pEntity && pEntity->inSync() )
			{
				pEntity->flushMessage(pMsg);
				pEntity->removeWatchee(m_hand);
			}
		}
		m_aroundMe.clear();
	}
}

bool CoEntity::adjustSights(handle hand)
{
	CoEntity* pEntity = _EntityFromHandle(hand); ASSERT_(pEntity);
	if(!pEntity) return false;
	if ( m_inSync )
	{
		if ( addWatchee(hand) )
		{
			bcEntityEnter(hand);
			pEntity->addWatcher(m_hand);
		}
	}
	if ( pEntity->inSync() )
	{
		if( pEntity->addWatchee(m_hand) )
		{
			pEntity->bcEntityEnter(m_hand);
			addWatcher(hand);
		}
	}
	return true;
}

void CoEntity::adjustSights(handle* pEntityList, int len)
{
	for( int i = 0; i < len; i++ )
	{
		if ( pEntityList[i] != m_hand )
		{
			adjustSights(pEntityList[i]);
		}
	}
}

AppMsg* CoEntity::genExitMessage()
{
	_MsgWC_PropSetExit* pMsg = (_MsgWC_PropSetExit*)s_propUpdateBuf;
	pMsg->msgFlags = 0;
	pMsg->msgCls = MSG_CLS_PROP;
	pMsg->msgId = MSG_C_W_PROPSET_EXIT;
	pMsg->unitCount = 1;
	pMsg->units[0] = m_hand;
	pMsg->msgLen = sizeof(_MsgWC_PropSetExit) + sizeof(unsigned int);
	return pMsg;
}

AppMsg* CoEntity::genPropUpdateMessage(int propId)
{
	_MsgWC_PropsUpdate* pMsg = (_MsgWC_PropsUpdate*)s_propUpdateBuf;
	pMsg->msgFlags = 0;
	pMsg->msgCls = MSG_CLS_PROP;
	pMsg->msgId = MSG_C_W_PROPS_UPDATE;
	pMsg->context = 0;
	pMsg->unitCount = 1;
	int offset = sizeof(_MsgWC_PropsUpdate);
	*(unsigned int*)(s_propUpdateBuf + offset) = m_hand;
	offset += sizeof(unsigned int);
	s_propUpdateBuf[offset++] = 1;
	s_propUpdateBuf[offset++] = (BYTE)propId;
	// int size = m_propSet.p[propId].val.Save(s_propUpdateBuf + offset, _MaxMsgLength - offset, 0);
	// if ( size < 0 ) return NULL;
	// offset += size;
	pMsg->msgLen = offset;
	return pMsg;
}

void CoEntity::flushMessage(const AppMsg* pMsg)
{
	if ( m_inSync )
	{
		g_world.sendMsgToClient(m_gatewayLink, m_clientLink, pMsg);
	}
}

bool CoEntity::bcAMessage(const AppMsg* pMsg, bool bPublic)
{
	flushMessage(pMsg);
	if ( bPublic )
	{
		int count = 0;
		for( handle h = m_aroundMe.begin(); h != (handle)INVALID_HANDLE; )
		{
			CoEntity* pEntity = _EntityFromHandle(h);
			ASSERT_( pEntity );
			ASSERT_( pEntity->inSync() );
			if( pEntity && pEntity->inSync() )
			{
				bool toErease = GridDistance( X(), Y(), pEntity->X(), pEntity->Y() ) > _SyncRadius;
				if( toErease )
				{
					s_exitList[count++] = pEntity;
					h = m_aroundMe.erase();
				}
				else
				{
					pEntity->flushMessage(pMsg);
					h = m_aroundMe.next();
				}
			}
			else
			{
				h = m_aroundMe.erase();
			}
		}
		if(count > 0)
		{
			AppMsg* pExitMsg = genExitMessage();
			if( pExitMsg )
			{
				for( int i = 0; i < count; i++ )
				{
					CoEntity* pEntity = s_exitList[i];
					pEntity->flushMessage(pExitMsg);
					pEntity->removeWatchee(m_hand);
				}
			}
		}
	}
	return true;
}

bool CoEntity::bcMyEnter()
{
	_MsgWC_PropSetEnter* pMsg = (_MsgWC_PropSetEnter*)s_propUpdateBuf;
	pMsg->msgFlags = 0;
	pMsg->msgCls = MSG_CLS_PROP;
	pMsg->msgId = MSG_C_W_PROPSET_ENTER;
	pMsg->isMe = (char)1;
	pMsg->unitId = m_hand;
	pMsg->dbId = m_dbid;
	pMsg->scene = m_sceneInfo;
	pMsg->pos = m_position;
	pMsg->dir = m_direction;
	pMsg->status = 0;
	pMsg->entityType = m_logicType;
	pMsg->propSetId = m_propType;
	pMsg->propCount = 0;
	int offset = sizeof(_MsgWC_PropSetEnter);
	int head = offset;
	/*
	for( int i = 0; i < m_propSet.count; i++ )
	{
		// todo
	}
	*/
	ASSERT_( offset > head );
	pMsg->msgLen = offset;
	flushMessage(pMsg);
	return true;
}

bool CoEntity::bcSceneSwitch()
{
	_MsgWC_SceneSwitch* pMsg = (_MsgWC_SceneSwitch*)s_propUpdateBuf;
	pMsg->msgFlags = 0;
	pMsg->msgCls = MSG_CLS_PROP;
	pMsg->msgId = MSG_C_W_SCENE_SWITCH;
	pMsg->unitId = m_hand;
	pMsg->scene = m_sceneInfo;
	pMsg->pos = m_position;
	pMsg->dir = m_direction;
	pMsg->status = 0;
	pMsg->msgLen  = sizeof(_MsgWC_SceneSwitch);
	flushMessage(pMsg);
	return true;
}

bool CoEntity::bcEntityEnter(handle hand)
{
	CoEntity* pEntity = _EntityFromHandle(hand); ASSERT_(pEntity);
	if(!pEntity) return false;
	_MsgWC_PropSetEnter* pMsg = (_MsgWC_PropSetEnter*)s_propUpdateBuf;
	pMsg->msgFlags = 0;
	pMsg->msgCls = MSG_CLS_PROP;
	pMsg->msgId = MSG_C_W_PROPSET_ENTER;
	pMsg->isMe = (char)0;
	pMsg->unitId = hand;
	pMsg->dbId = pEntity->m_dbid;
	pMsg->scene = pEntity->m_sceneInfo;
	pMsg->pos = pEntity->m_position;
	pMsg->dir = pEntity->m_direction;
	pMsg->status = 0;
	pMsg->entityType = pEntity->m_logicType;
	pMsg->propSetId = pEntity->m_propType;
	pMsg->propCount = 0;
	int offset = sizeof(_MsgWC_PropSetEnter);
	int head = offset;
	/*
	for(int i = 0; i < pEntity->m_publicProps.count; i++)
	{
		// todo
	}
	*/
	if ( offset > head )
	{
		pMsg->msgLen = offset;
		flushMessage(pMsg);
	}
	return true;
}

bool CoEntity::bcEntityExit(handle* exitList, long count)
{
	_MsgWC_PropSetExit* pMsg = (_MsgWC_PropSetExit*)s_propUpdateBuf;
	pMsg->msgFlags = 0;
	pMsg->msgCls = MSG_CLS_PROP;
	pMsg->msgId = MSG_C_W_PROPSET_EXIT;
	pMsg->unitCount = 0;
	int offset = sizeof(_MsgWC_PropSetExit);
	int head = offset;
	for(int i = 0; i < count; i++)
	{
		handle hand = exitList[i];
		if ( offset + 2 * (sizeof(unsigned int) + 1) > _MaxMsgLength )
		{
			pMsg->msgLen = offset;
			flushMessage(pMsg);
			pMsg->unitCount = 0;
			offset = head;
		}
		*(unsigned int*)(s_propUpdateBuf + offset) = hand;
		offset += sizeof(unsigned int);
		pMsg->unitCount++;
	}
	if ( offset > head )
	{
		pMsg->msgLen = offset;
		flushMessage(pMsg);
	}
	return true;
}

bool CoEntity::bcPropUpdates()
{
	return true;
}

bool CoEntity::enterScene(CoScene* pScene, const GridVct* pInit)
{
	if ( m_pScene == pScene ) return true;
	if ( !pScene || !pInit || !pScene->inMap(*pInit) ) return false;

	m_pScene = pScene;
	m_sceneInfo = m_pScene->getSceneInfo();

	_PropPosData data;
	data.bMove = false;
	data.len = 1; 
	data.idx = 0; 
	data.path[0] = *pInit;
	// SetPropData(UINT_POS, (BYTE*)&data, sizeof(data));
	m_position = *pInit;

	for( int i = 0; i < _SyncRingCount; i++ )
	{
		m_ringOrg[i] = *pInit;
	}

	m_pScene->attachUnit(this);

	if ( m_gatewayLink && m_clientLink )
	{
		m_inSync = true;
		if ( m_firstCast )
		{
			bcMyEnter();
			m_firstCast = false;
			m_autoCast = true;
		}
		else
		{
			bcSceneSwitch();
		}
	}
	else
	{
		if ( m_firstCast )
		{
			m_firstCast = false;
			m_autoCast = true;
		}
	}

	int count = 0;
	handle* pHandle = m_pScene->getEntities(m_position, _SyncRadius, count);
	if ( pHandle && count > 0 )
	{
		adjustSights(pHandle, count);
	}

	return true;
}

bool CoEntity::quitScene()
{
	if ( !m_pScene ) return true;

	m_pScene->detachUnit(this);
	m_pScene = NULL;

	clearAroundMe();
	if ( m_inSync )
	{
		clearMyAround();
		m_inSync = false;
	}

	return true;
}

void CoEntity::PosChanged(GridVct& old)
{
	if ( !m_pScene )
	{
		TRACE1_L0("CoEntity::PosChanged FATAL ERROR: entity(%i) is not in a scene\n", m_hand);
		return;
	}

	m_pScene->moveUnit(this, old);
	
	int m = 0;
	int radius = 0;
	int x = m_position.x;
	int y = m_position.y;
	for( ; m < _SyncRingCount; m++ )
	{
		GridVct pt1(x, y);
		GridVct pt2(m_ringOrg[m].x, m_ringOrg[m].y);
		if ( m_pScene->getDistance(&pt1, &pt2) <= s_ringRadius[m] >> 2 ) break;
		radius = s_ringRadius[m];
	}

	if ( radius > 0 )
	{
		int count = 0;
		handle* pHandle = m_pScene->getEntities(m_position, radius, count);
		if ( pHandle && count > 0 ) 
		{
			adjustSights(pHandle, count);
		}
		for( int i = 0; i < m; i++ )
		{
			m_ringOrg[i].x = x; 
			m_ringOrg[i].y = y;
		}
	}
}

void CoEntity::PropValChanged(int propId)
{
	// todo
}

HRESULT CoEntity::InitPropSet(int type)
{
	// todo
	return S_OK;
}

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
	//if (pDest == 0 && !m_pScene->inMap(*pDest))
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
	//SetPropData(UINT_POS, buf, sizeof(_PropPosData) + (len - 1) * sizeof(GridVct));
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
	static BYTE* p = new BYTE[(MAX_PATH_LEN * 4) * sizeof(GridVct) + sizeof(_PropPosData)];
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
				index ++;
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
			
	if (pPosData->len > MAX_PATH_LEN + 8)
	{
		TRACE2_WARNING("[CoEntity:MoveByPath] WARNING: entity(%d) move path too long, len=%i\n", m_hand, pPosData->len);
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
	//SetPropData(UINT_POS, pPosData, sizeof(_PropPosData) + (pPosData->len - 1) * sizeof(GridVct));
}

void CoEntity::onMove()
{
	static float fTileWidth = 64.0 ;
	//_PropPosData* pPosData = (_PropPosData*)m_propSet.p[UINT_POS].val.dataVal;
	_PropPosData* pPosData = 0;
	DWORD dwNow = GetTickCount();
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
			}
			while(m_clipping >= m_stepTime)
			{
				++m_nStrideStep;
				m_clipping -= m_stepTime;
			}
		}
	}
	else
	{
		if (m_Move)
		{
			resetMove();
			g_MoveManager.RemoveMoveEntity(m_hand);
		}
	}
}

void CoEntity::moveFollowEntity(lua_State* pState, short offset, _PropPosData* pPropPosData)
{
	MovePath path;
	path.clear(); 

	// 倒数第一个参数，路径数组
	int t_idx = lua_gettop(pState);
	if(lua_istable(pState, t_idx))
	{
		lua_pushnil(pState);
		while (lua_next(pState, t_idx))
		{
			path.push_back((short) lua_tointeger(pState, -1));
			lua_pop(pState, 1);
		}
		lua_pop(pState,1);
	}
	
	vector<handle> vecEntityList;
	vecEntityList.clear();
	//倒数第二个参数，跟随者数组
	if(lua_istable(pState, t_idx - 1))
	{
		lua_pushnil(pState);
		while (lua_next(pState, t_idx - 1))
		{
			lua_pushnil(pState);
			while (lua_next(pState, t_idx - 1))
			{
				vecEntityList.push_back((handle) lua_tointeger(pState, -1));
				lua_pop(pState, 1);
			}
			lua_pop(pState, 1);
		}
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
		pFollow->calcMovePath(offset, path, moveDelay, bFilled);
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
	if (x == 0 && y == 0)
	{
		return;
	}
	else
	{
		GridVct grid(x, y);
		setPosition(grid);
	}
	if (m_Move)
	{
		resetMove();
		g_MoveManager.RemoveMoveEntity(m_hand);
	}
}

short CoEntity::correctMovePath(short x, short y)
{
	short realIdx = -1;
	GridVct curPos(x, y);
	GridVct realPos = curPos;
//	_PropPosData* pPosData = (_PropPosData)m_propSet.p[UINT_POS].val.dataVal;
	_PropPosData* pPosData = 0;
	if (m_position != curPos)
	{
		short curIdx = pPosData->idx;
		short difIdx = 0;
		//往后找
		for (int i = curIdx + 1; i < pPosData->len; ++i)
		{
			if (pPosData->path[i] == curPos)
			{
				realIdx = i;
				difIdx = realIdx - curIdx;
				break;
			}
		}
		//往前找
		if (difIdx != 1)
		{
			for(int i = curIdx - 1; i >= 0; i--)
			{
				if ( pPosData->path[i] == curPos ) 
				{
					realIdx = (difIdx == 0) ? i : ((difIdx > curIdx - i) ? i : realIdx);
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
		pPosData->idx = realIdx;
		realPos = pPosData->path[realIdx];
	}
	setPosition(realPos);
	return realIdx;
}

short CoEntity::correctFollowMovePath( short refIdx, short refPathLen )
{
	short realIdx = 0;
	if (refIdx >= 0)
	{
		//_PropPosData* pPosData = (_PropPosData*)m_propSet.p[UINT_POS].val.dataVal;
		_PropPosData* pPosData = 0;
		short delay = refPathLen - pPosData->len;
		if (refIdx == 0)
		{
			realIdx = 0;
		}
		else if (refIdx < delay + 1)
		{
			m_bDelayEnable = pPosData->delay > 0;
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
		short y = path[idx];
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
		offset--;
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
	}
	moveByPath(pPosData);
}

void CoEntity::fillMovePathByDistance( MovePath& path, bool bFilled )
{
	if (path.size() >= 4)
	{
		// 路径前两路径点相差2~4TILE内, 采用寻路算法来计算两路径点间的路径
		bool bDiscard = false;
		short dx = ::abs(path[2] - path[0]);
		short dy = ::abs(path[3] - path[1]);
		if ( bFilled || ( (!bFilled && (dx >= 2 && dx <= 4)) || (dy >= 2 && dy <= 4) ) )
		{
			//POINT* pPath = 0;
			//int nPathLen = 0;
			//if (g_MapManager.findPath(m_sceneInfo.mapId, GridVct(path[0], path[1]), GridVct(path[2], path[3]), true, true, pPath, nPathLen))
			//{
			//	path.pop_front();
			//	path.pop_front();
				// 插入新路径点
			//	for (int i = nPathLen - 2; (nPathLen >= 3 && i >= 0); i--)
			//	{
			//		path.push_front(pPath[i].y);
			//		path.push_front(pPath[i].x);
			//	}
			//}
			//else
			//{
			//	bDiscard = true;
			//}
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
	//_PropPosData const* pPosData = (_PropPosData const*)m_propSet.p[UINT_POS].val.dataVal;
	//return pPosData->len;
	return 0;
}

GridVct CoEntity::getPathByCurIndex( short index )
{
	//_PropPosData const* pPosData = (_PropPosData const*)m_propSet.p[UINT_POS].val.dataVal;
	//short idx = pPosData->idx + index;
	//idx = (idx < 0) ? 0 : idx;
	//idx = (idx > pPosData->len - 1) ? (pPosData->len - 1) : idx;
	//return pPosData->path[idx];
	return GridVct(0, 0);
}

void CoEntity::resetMove()
{
	m_nStrideStep = 0;
	m_dTimeOrigin = 0;
	m_clipping = 0;
	m_bDelayEnable = false;
}

bool CoEntity::isInView(handle hand) const
{
	DWORD count = 0;
	//handle* pHandle = m_pScene->getEntities(m_position, _SyncRadius, count);
	handle* pHandle = 0;
	if (pHandle == 0)
	{
		return false;
	}
	for (DWORD i = 0; i < count; ++i)
	{
		if (pHandle[i] == hand)
		{
			return true;
		}
	}
	return false;
}

CoEntity* CoEntity::Create(EntityType type, EntityPropType propType)
{
	CoEntity* pEntity = new CoEntity();
	pEntity->m_logicType = type;
	pEntity->m_propType = propType;
	pEntity->InitPropSet(propType);
	return pEntity;
}

HandleMgr		CoEntity::s_hMgr;
short			CoEntity::s_ringRadius[_SyncRingCount] = { 8, 16 };
int				CoEntity::s_entityCounter[MAX_CLASS_TYPE];
char			CoEntity::s_propUpdateBuf[_MaxMsgLength];
CoEntity*		CoEntity::s_exitList[_MaxEnumCount];

_PropPosData	g_PosData;
