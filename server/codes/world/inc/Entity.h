/**
 * filename : Entity.h
 * desc : 实体（视野管理部分）
 */

#ifndef __ENTITY_H_
#define __ENTITY_H_

#include "LuaFunctor.h"
#include "HandleMgr.h"
#include "PropertySet.h"

#include <time.h>
#include <set>
#include <list>
#include <deque>
#include <vector>
#include <ext/hash_map>
using __gnu_cxx::hash_map;

class CoScene;

#define _SyncRadius 16

#define _SyncRingCount 2

#define _MaxEnumCount 4096



#define _EntityFromHandle(h) ( (CoEntity*)( CoEntity::s_hMgr.getHandleData(h) ) )

typedef HashTable<> _AroundSet;
typedef std::deque<short> MovePath;

class CoEntity:public PropertySet
{
public:
    CoEntity();
    ~CoEntity();

public:
	HRESULT InitPropSet(int propSet);
	void release();

public:
	bool inSync(){ return m_inSync; }

public:
	short X(){ return m_position.x; }
	short Y(){ return m_position.y; }
	void setIsFirstCast(bool bOk){ m_firstCast = bOk; };
public:
	handle getHandle(){ return m_hand; }
	int getDBID(){ return m_dbid; }
	EntityType getType(){ return m_logicType; }
	EntityPropType getPropType(){ return m_propType; }
	GridVct getPosition(){ return m_position; }
	char getDirection(){ return m_direction; }
	bool getAutoCast(){ return m_autoCast; }


public:
	void setDBID(int dbId){ m_dbid = dbId; }
	void setPosition(int x, int y);
	void setPosition(const GridVct& pos);
	void setDirection(char direction){ m_direction = direction; }
	void setAutoCast(bool toCast){ m_autoCast = toCast; }
	void setGateLink(handle hGate){ m_gatewayLink = hGate;}
    void setGatewayID(short gatewayId){m_gatewayId = gatewayId;}
	void setClientLink(handle hClient){ m_clientLink = hClient;}

public:
	bool addWatchee(handle hand){ return m_myAround.insert(hand); }
	bool removeWatchee(handle hand){ return m_myAround.erase(hand); }
	bool addWatcher(handle hand){ return m_aroundMe.insert(hand); }
	bool removeWatcher(handle hand){ return m_aroundMe.erase(hand); }

public:
	void clearAroundMe();
	void clearMyAround();
	bool adjustSights(handle hand);
	void adjustSights(handle* pEntityList, int len);

public:
	AppMsg* genExitMessage();
	AppMsg* genPropUpdateMessage(int propId);
	int serializePath(char *p);

public:
	void flushMessage(const AppMsg* pMsg);
	bool bcAMessage(const AppMsg* pMsg, bool pub = true);
	bool bcAMessageToGroup(const AppMsg* pMsg,bool toSelf = true);

public:
	bool bcMyEnter();
	bool bcSceneSwitch();
	bool bcEntityEnter(handle hand);
	bool bcEntityExit(handle* exitList, long count);
	bool bcPropUpdates(handle hSendTo=0);
	bool bcAllProps(handle hSendTo);

public:
	bool enterScene(CoScene* pScene, short x, short y);
	bool quitScene();

public:
	void onMove();

private:
	void PosChanged(GridVct& old);

public:
	virtual void PropValChanged(int propId);

	//path relation function
public:
	short correctMovePath(short x, short y);
	short correctFollowMovePath(short refIdx, short refPathLen);
	void calcMovePath(short offset, MovePath& path, short& moveDelay, bool bFilled);
	void fillMovePath(MovePath& path, _PropPosData* pPosData);
	short getPathLen() const;

private:
	GridVct getPathByCurIndex(short index);
	void fillMovePathByDistance(MovePath& path, bool bFilled);

	//move relation function
public:
	void moveByPath(lua_State* pState, _PropPosData* pPosData);
	bool move(short x = 0, short y = 0, int flags = 0x10);
	void moveFollowEntity(lua_State* pState, short offset, _PropPosData* pPropPosData);
	void stopMove(short x = 0, short y = 0);
	void setIsMove(bool value)
	{
		m_Move = value;
	}
	short getMoveSpeed();
	void setMoveSpeed(short sp);

private:
	void moveByPath(_PropPosData* pPosData);

	bool move(const GridVct* pDest, int flags = 0x10);

	void resetMove();

	bool getIsMove()
	{
		return m_Move;
	}

	//view relation function
public:
	bool isInView(handle hand) const;

public:
    PeerHandle* getAroundMe(int& peer_count);

public:
	handle					m_clientLink;
	handle					m_gatewayLink;
	short					m_gatewayId;

public:
	handle					m_hand;
	int						m_dbid;
	EntityType				m_logicType;
	EntityPropType			m_propType;
	GridVct					m_position;
	char					m_direction;
	short					m_speed;
	CoScene*				m_pScene;
	_PropSceneData			m_sceneInfo;

public:
	_AroundSet				m_myAround;
	_AroundSet				m_aroundMe;
	GridVct					m_ringOrg[_SyncRingCount];

public:
	bool					m_inSync;
	bool					m_firstCast;
	bool					m_autoCast;

public:
	static HandleMgr		s_hMgr;
	static short			s_ringRadius[_SyncRingCount];
	static int				s_entityCounter[MAX_CLASS_TYPE];
	static char				s_propUpdateBuf[_MaxMsgLength];
	static CoEntity*		s_exitList[_MaxEnumCount];

	//move relation variable
private:
	float					m_clipping;
	float					m_stepTime;
	DWORD					m_dTimeOrigin;
	short					m_nStrideStep;
	bool					m_bDelayEnable;
	bool					m_Move;

public:
	static CoEntity* Create(EntityType type, EntityPropType propType);
};

extern _PropPosData g_PosData;

#endif
