/**
 * filename : Entity.cpp
 * desc : 实体（视野管理部分）
 */

#include "lindef.h"
#include "vsdef.h"
#include "LinkContext.h"
#include "world.h"
#include "Entity.h"
#include "UnitConfig.h"
#include "Scene.h"
#include "GridGraphics.h"

CoEntity::CoEntity() :
	m_clientLink(0), m_gatewayLink(0), m_gatewayId(-1),
	m_dbid(-1),
	m_logicType(eLogicNone), m_propType(eClsTypeNone),
	m_direction(-1), m_speed(-1),
	m_pScene(NULL),
	m_inSync(false), m_firstCast(true), m_autoCast(false),
	m_Move(false)
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
	pMsg->msgFlags		= 0;
	pMsg->msgCls		= MSG_CLS_PROP;
	pMsg->msgId			= MSG_C_W_PROPS_UPDATE;
	pMsg->context		= 0;
	pMsg->unitCount		= 1;

	char *p = s_propUpdateBuf + sizeof(_MsgWC_PropsUpdate);
	auxWrite(p,unsigned int,m_hand);//Set Entity ID
	auxWrite(p,char,1);				//Only one prop
	auxWrite(p,char,propId);		//Set PropID

	int size;
	if(UNIT_POS == propId)
	{
		size = serializePath(p);
	}
	else
	{
		size =  m_propSet[propId]->val.Save(p,_MaxMsgLength-(signed)(p-s_propUpdateBuf),0);
	}
	ASSERT_(size > 0);
	p += size;
	pMsg->msgLen = (signed)(p - s_propUpdateBuf);
	return pMsg;
}

int CoEntity::serializePath(char *pStart)
{
	char *p = pStart;
	const _PropPosData *pPos = (const _PropPosData *)m_propSet[UNIT_POS]->val.dataVal;

	auxWrite(p,short,0);		//数据报长度
	auxWrite(p,BYTE,pPos->bMove);
	auxWrite(p,BYTE,pPos->len);
	auxWrite(p,BYTE,pPos->idx);
	auxWrite(p,BYTE,pPos->delay);
	auxWrite(p,BYTE,pPos->step);
	auxWrite(p,BYTE,pPos->endPath);

	const GridVct *path = pPos->path;
	auxWrite(p,short,path->x);
	auxWrite(p,short,path->y);
	path++;
	for(int i = 1;i<pPos->len;i++,path++)
	{
		int dx = path->x - (path - 1)->x;
		int dy = path->y - (path - 1)->y;
		BYTE dir = 0xFF;
		if(dx < 0)
		{
			dir = dy > 0?3:((0==dy)?4:5);
		}
		else if(0 == dx)
		{
			dir = dy > 0?2:((0==dy)?0xFF:6);
		}
		else
		{
			dir = dy > 0?1:((0==dy)?0:7);
		}
		auxWrite(p,BYTE,dir);
	}
	int len = p - pStart;
	auxWrite(pStart,short,len - sizeof(short));
	return len;
}

void CoEntity::flushMessage(const AppMsg* pMsg)
{
	if ( m_inSync )
	{
		g_world.sendMsgToPeer(m_gatewayLink, m_clientLink, pMsg);
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

bool CoEntity::bcAMessageToGroup(const AppMsg* pMsg)
{
	static PeerHandle pPeers[500];
	int peer_count = 0;
	pPeers[peer_count].hGate = m_gatewayLink;
	pPeers[peer_count].hClient = m_clientLink;
	pPeers[peer_count].gatewayId = m_gatewayId;
	peer_count++;

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
				pPeers[peer_count].hGate = pEntity->m_gatewayLink;
				pPeers[peer_count].hClient = pEntity->m_clientLink;
				pPeers[peer_count].gatewayId = pEntity->m_gatewayId;
				peer_count++;
				ASSERT_(peer_count <= 500);

				h = m_aroundMe.next();
			}
		}
		else
		{
			h = m_aroundMe.erase();
		}
	}

	if (peer_count > 0)
		g_world.sendMsgToPeers(pPeers, peer_count, pMsg);
	if(count > 0)
	{
		AppMsg* pExitMsg = genExitMessage();
		if( pExitMsg )
		{
			peer_count = 0;
			for( int i = 0; i < count; i++ )
			{
				CoEntity* pEntity = s_exitList[i];
				pPeers[peer_count].hGate = pEntity->m_gatewayLink;
				pPeers[peer_count].hClient = pEntity->m_clientLink;
				pPeers[peer_count].gatewayId = pEntity->m_gatewayId;
				peer_count++;
				ASSERT_(peer_count <= 500);

				pEntity->removeWatchee(m_hand);
			}
			if (peer_count > 0)
				g_world.sendMsgToPeers(pPeers, peer_count, pExitMsg);
		}
	}
	return true;
}

#include "bytebuffer.h"
bool CoEntity::bcMyEnter()
{
	_MsgWC_PropSetEnter* pMsg = (_MsgWC_PropSetEnter*)s_propUpdateBuf;
	pMsg->msgFlags		= 0;
	pMsg->msgCls		= MSG_CLS_PROP;
	pMsg->msgId			= MSG_C_W_PROPSET_ENTER;
	pMsg->isMe			= (char)1;
	pMsg->unitId		= m_hand;
	pMsg->dbId			= m_dbid;
	pMsg->scene			= m_sceneInfo;
	pMsg->pos			= m_position;
	pMsg->dir			= m_direction;
	pMsg->status		= 0;
	pMsg->entityType	= m_logicType;
	pMsg->propSetId		= m_propType;
	pMsg->propCount		= 0;

	int offset = sizeof(_MsgWC_PropSetEnter);
	int head = offset;
	int nPropCount = 0;

	for( int i = 0; i < m_propSet.count; i++ )
	{
		_Property *property = m_propSet[i];
		if(VAR_NULL == property->val.type || 0 == property->update)
		{
			continue;
		}
		*(char *)(s_propUpdateBuf + offset)  = i,offset += sizeof(char);
		int size = 0;
		if(UNIT_POS == i)
		{
			size = serializePath(s_propUpdateBuf + offset);
		}
		else
		{
			size = property->val.Save(s_propUpdateBuf + offset,_MaxMsgLength - offset,false);
		}
		ASSERT_(size > 0);
		if(size > 0)
		{
			offset += size;
		}
		nPropCount++;
	}
	ASSERT_( offset > head );
	if(offset > head){
		pMsg->propCount = nPropCount;
		pMsg->msgLen = offset;
		flushMessage(pMsg);
	}
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
	if(!pEntity)
	{
		return false;
	}

	_MsgWC_PropSetEnter* pMsg = (_MsgWC_PropSetEnter*)s_propUpdateBuf;
	pMsg->msgFlags		= 0;
	pMsg->msgCls		= MSG_CLS_PROP;
	pMsg->msgId			= MSG_C_W_PROPSET_ENTER;
	pMsg->isMe			= (char)0;
	pMsg->unitId		= hand;
	pMsg->dbId			= pEntity->m_dbid;
	pMsg->scene			= pEntity->m_sceneInfo;
	pMsg->pos			= pEntity->m_position;
	pMsg->dir			= pEntity->m_direction;
	pMsg->status		= 0;
	pMsg->entityType	= pEntity->m_logicType;
	pMsg->propSetId		= pEntity->m_propType;
	pMsg->propCount		= 0;

	int offset = sizeof(_MsgWC_PropSetEnter);

	int nPropCount = 0;
	const _RefList &refList = CUnitConfig::Instance().GetPublicProps(pEntity->m_propType);
	for(int i=0;i<refList.count;i++)
	{
		BYTE propID = *refList[i];
		_Property *property = pEntity->m_propSet[propID];

		//we don't wanna send default or NULL value
		if(VAR_NULL == property->val.type || 0 == property->update)
		{
			continue;
		}
		//put prop id
		*(char *)(s_propUpdateBuf + offset) = propID,offset += sizeof(char);
		int size = 0;
		if(UNIT_POS == propID)
		{
			size = pEntity->serializePath(s_propUpdateBuf + offset);
		}
		else
		{
			size = property->val.Save(s_propUpdateBuf + offset,_MaxMsgLength - offset,false);
		}
		ASSERT_(size>0);
		if(size > 0){
			offset += size;
		}
		nPropCount++;
	}

	pMsg->propCount	= nPropCount;
	pMsg->msgLen	= offset;

	flushMessage(pMsg);

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

#define auxSetPropCount(p,count) (*(char *)((char *)p + sizeof(_MsgWC_PropsUpdate) + sizeof(unsigned int)) = count,\
		(char *)p + sizeof(_MsgWC_PropsUpdate) + sizeof(unsigned int) + sizeof(char))
#define auxSetEntityID(p,handle) *(unsigned int *)((char *)p + sizeof(_MsgWC_PropsUpdate)) = handle

bool CoEntity::bcPropUpdates()
{
	if(!m_inSync && m_aroundMe.empty()){
		return true;
	}
	_MsgWC_PropsUpdate* pMsg = (_MsgWC_PropsUpdate*)s_propUpdateBuf;
	pMsg->msgFlags	= 0;
	pMsg->msgCls	= MSG_CLS_PROP;
	pMsg->msgId		= MSG_C_W_PROPS_UPDATE;
	pMsg->context	= 0;
	pMsg->unitCount	= 1;	//Only one unit

	int nPropCount = 0;

	auxSetEntityID(s_propUpdateBuf,m_hand);//insert Entity ID
	char *p = auxSetPropCount(s_propUpdateBuf,0);//insert Prop Count

	const _RefList &refList = CUnitConfig::Instance().GetPublicProps(m_propType);
	for(int i = 0;i < refList.count;i++){
		BYTE propID = refList.p[i];
		_Property *property = m_propSet[propID];
		if(property->casted != property->update)
		{
			*(char *)p = propID,p += sizeof(char);
			if(UNIT_POS == propID)
			{
				p += serializePath(p);
			}
			else
			{
				p += property->val.Save(p,_MaxMsgLength - (int)(p - s_propUpdateBuf),false);
			}
			nPropCount++;
			property->casted = property->update;
		}
	}
	TRACE1_L0("there is %d public prop(s)\n",nPropCount);
	if(nPropCount > 0)
	{
		auxSetPropCount(s_propUpdateBuf,nPropCount);
		pMsg->msgLen = p - s_propUpdateBuf;
		//bcAMessage(pMsg,true);//wanna a function to broadcast message only to the public,self not included
		bcAMessageToGroup(pMsg);
	}

	if(!m_inSync)
	{
		return true;
	}
	nPropCount = 0; //prop's update message of the entity itself is divided into 2 parts
	p = auxSetPropCount(s_propUpdateBuf,0);
	for(int i = 0;i < m_propSet.count;i++){
		_Property *property = m_propSet[i];
		if(property->casted != property->update)
		{
			*(char *)p = i,p += sizeof(char);
			if(UNIT_POS == i)
			{
				p += serializePath(p);
			}
			else
			{
				p += property->val.Save(p,_MaxMsgLength - (int)(p - s_propUpdateBuf),false);
			}
			nPropCount++;
			property->casted = property->update;
		}
	}
	TRACE1_L0("there is %d private prop(s)\n",nPropCount);
	if(nPropCount > 0)
	{
		auxSetPropCount(s_propUpdateBuf,nPropCount);
		pMsg->msgLen = p - s_propUpdateBuf;
		bcAMessage(pMsg,false);
	}

	return true;
}

bool CoEntity::enterScene(CoScene* pScene, short x, short y)
{
	GridVct grid(x, y);
	if ( m_pScene == pScene ) return true;
	if ( !pScene  || !pScene->inMap(grid) ) return false;

	m_pScene = pScene;
	m_sceneInfo = m_pScene->getSceneInfo();

	static _PropPosData data =
	{
		false,	//bMove
		1,		//len
		0,		//idx
		0,		//delay
		0,		//step
		true,	//endPath
	};
	data.path[0] = grid;
	m_position = grid;

	SetPropData(UNIT_POS, (BYTE*)&data, sizeof(data));

	for( int i = 0; i < _SyncRingCount; i++ )
	{
		m_ringOrg[i] = grid;
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
	//clean update flags to ensure next flush operation won't send same copy
	for(int i = 0;i<m_propSet.count;i++)
	{
		_Property *property = m_propSet[i];
		property->casted = property->update;
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
	_Property *property = m_propSet[propId];
	property->update++;
	//如果没有开启自动同步，则属性变动后一般不立即发送同步事件
	//特殊处理的是位置信息，只要实体已经在场景中，则位置信息需要立即同步
	//可以接受属性同步的后续条件有两个
	//1，是自己可以接受同步数据
	//2，是周围有可以接受同步数据的实体
	if((m_autoCast||(UNIT_POS==propId&&!m_firstCast)) && (m_inSync||!m_aroundMe.empty()))
	{
		AppMsg *pMsg = genPropUpdateMessage(propId);
		if(pMsg){
			if (property->radius > 0)
				bcAMessageToGroup(pMsg);
			else
				bcAMessage(pMsg, false);
			property->casted = property->update;
		}
	}
}

HRESULT CoEntity::InitPropSet(int type)
{
	if(!CUnitConfig::Instance().CopyPropSet(type,m_propSet))
	{
		TRACE1_L0("[CoEntity::InitPropSet] failed PropSetID:%d\n",type);
		return E_FAIL;
	}
	return S_OK;
}

bool CoEntity::isInView(handle hand) const
{
	if (m_pScene == 0)
	{
		return false;
	}
	int count = 0;
	handle* pHandle = m_pScene->getEntities(m_position, _SyncRadius, count);
	if (pHandle == 0)
	{
		return false;
	}
	for (int i = 0; i < count; ++i)
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
