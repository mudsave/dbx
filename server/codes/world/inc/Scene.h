#ifndef __SCENE_H_
#define __SCENE_H_


#include "MapInfo.h"

#define _MaxEnumCount 4096
#define MAX_MAP_COUNT 1024

class CoScene
{
public:
	CoScene(short sWordId, short mapId, SceneType type, CMapInfo* pMapInfo);
    virtual ~CoScene();
    void close();
public:
	void attachUnit(CoEntity* pUnit);
	void detachUnit(CoEntity* pUnit);
	void moveUnit(CoEntity* pUnit, const GridVct& last);

public:
	bool posValidate(int x,int y,int flag);
	int getDistance(const GridVct* p1, const GridVct* p2);
	handle* getEntities(const GridVct& ptCenter, short nRad, int& nHandleCount,
    	short classType = eClsTypeNone);

public:
	static handle s_entitiesBuf[_MaxEnumCount];

private:
	typedef std::set<handle> _EntitySet;
	typedef _CountedArray<_EntitySet> _AxisPt;
	_CountedArray<_AxisPt> m_yAxis;
	_PropSceneData m_SceneInfo;
	CMapInfo* m_pMapInfo;
	int m_unitCount;
	GridVct m_mapSize;

public:
	static CoScene* Create(SceneType type, short mapId, char* fname);
	static bool PosValidate(short mapId, int x, int y, int flag);
	static bool FindEmptyTile(int mapId, const GridVct& ptCenter, int nRad, GridVct &ptResult,
    	const GridVct* pPtExclude = NULL);
public:
	bool inMap(short x, short y)
    {
    	return (x >= 0 && x < m_mapSize.x && y >= 0 && y < m_mapSize.y);
    }
	bool inMap(const GridVct& pos)
    {
    	return inMap(pos.x, pos.y);
    }
	GridVct getSize()
    {
    	return m_mapSize;
    }
    _PropSceneData& getSceneInfo()
    {
    	return m_SceneInfo;
	}
    SceneType getSceneType()
    {
    	return (SceneType)(m_SceneInfo.sceneType);
    }
};

#endif
