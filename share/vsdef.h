/**
 * filename : vsdef.h
 * desc : the common part of client and server
 */

#ifndef __VS_DEF_H_
#define __VS_DEF_H_

#define MAX_PATH_LEN 16

enum SceneType
{
	ePublicScene,
	ePrivateScene
};

enum EntityType
{
	eLogicNone = 0,
	eLogicPlayer,
	eLogicNpc,
	eLogicPet,
	eLogicMonster,
	eLogicFollow,
	eLogicMineNpc,
	eLogicMpw,
	eLogicMagic,
	eLogicFarmLand,
	eLogicCrop,
	eLogicGoodsNpc,
	eLogicEctypeNpc,
	eLogicEctypePatrolNpc,
	eLogicEctypeObject,
	MAX_LOGIC_TYPE
};

enum EntityPropType
{
	eClsTypeNone = 0,
	eClsTypePlayer,
	eClsTypeNpc,
	eClsTypePet,
	eClsTypeMpw,
	eClsTypeMagic,
	eClsTypeFarmLand,
	eClsTypeCrop,
	MAX_CLASS_TYPE
};

enum _UnitPropId
{
	UNIT_STATUS,
	UNIT_POS,
	UNIT_MOVE_SPEED,
	UNIT_BASE,
};

enum PlayerStatus
{
	ePlayerNone,
	ePlayerLoading,
	ePlayerNormal,
	ePlayerFight,
	ePlayerInactive,
	ePlayerInactiveFight,
	ePlayerClosing,
	ePlayerClosed
};

enum WorldIdsDivision
{
	eWorldStart = 0,
	eWorldEnd = 99,
	eFightStart = 100,
	eFightEnd = 199,
	eSocial = 200,
};

#define IS_WORLD_SERVER(id) (id >= eWorldStart && id <= eWorldEnd)
#define IS_FIGHT_SERVER(id) (id >= eFightStart && id <= eFightEnd)
#define IS_SOCIAL_SERVER(id) (id == eSocial)

#pragma pack(push, 1)

struct GridVct
{
	short x;
	short y;
	GridVct() : x(0), y(0){}
	GridVct(short sX, short sY) : x(sX), y(sY){}
	GridVct(const GridVct& gridVect)
	{
		if ( this == &gridVect ) return;
		x = gridVect.x;
		y = gridVect.y;
	}
	void operator=(const GridVct& gridVect)
	{
		if ( this == &gridVect ) return;
		x = gridVect.x;
		y = gridVect.y;
	}
	bool operator!=(const GridVct& gridVect)
	{
		return !operator==(gridVect);
	}
	bool operator==(const GridVct& gridVect)
	{
		if ( this == &gridVect ) return true;
		return x == gridVect.x && y == gridVect.y;
	}
};

struct _PropSceneData
{
	short wldId;
	short mapId;
	short sceneType;
	_PropSceneData(short wId = -1, short mId = -1, short sType = ePublicScene) :
		wldId(wId), mapId(mId), sceneType(sType){}
};

struct _PropPosData
{
	bool bMove;
	short len;
	short idx;
	short delay;
	short step;
	bool endPath;
	GridVct path[1];
};

//最大的位置数据信息长度
#define PosDataLen (sizeof(_PropPosData) + (MAX_PATH_LEN - 1) * sizeof(GridVct) * 8)


#pragma pack(pop)

#include "msgdef.h"

#endif
