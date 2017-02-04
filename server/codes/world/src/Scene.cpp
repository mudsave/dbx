
#include "lindef.h"
#include "vsdef.h"
#include "world.h"
#include "Entity.h"
#include "MapInfo.h"
#include "Scene.h"
#include "MapManager.h"
#include "GridGraphics.h"

extern CWorld g_world;
extern CMapManager g_MapManager;
handle CoScene::s_entitiesBuf[_MaxEnumCount];
#define X_FIELD_LEN 50
#define Radius_limit 5

CoScene::CoScene(short sWordId, short mapId, SceneType type, CMapInfo* pMapInfo):
	m_SceneInfo(sWordId, mapId, type), m_pMapInfo(pMapInfo), m_unitCount(0),
    m_mapSize(pMapInfo->GetXTileLen(), pMapInfo->GetYTileLen())
{
	m_yAxis.count = m_mapSize.y;
	m_yAxis.p = new _AxisPt[m_mapSize.y];
	int xsize = (m_mapSize.x + X_FIELD_LEN - 1) / X_FIELD_LEN;
	for(int i=0; i < m_mapSize.y; i++)
	{
		m_yAxis.p[i].count = xsize;
		m_yAxis.p[i].p = new _EntitySet[xsize];
	}
}

CoScene::~CoScene()
{
}

void CoScene::attachUnit(CoEntity* pEntity)
{
	short x = pEntity->X();
	short y = pEntity->Y();
	handle hand = pEntity->getHandle();
	if(inMap(x,y))
	{
		int n = x / X_FIELD_LEN;
		m_yAxis.p[y].p[n].insert(hand);
		m_unitCount++;
	}
	else
	{
		TRACE2_L0("[CoScene::AttachUnit] unit position out of range, unitId=%d,\
		mapId=%d\n", hand, m_SceneInfo.mapId);
	}
}

void CoScene::detachUnit(CoEntity* pEntity)
{
    short x = pEntity->X();
	short y = pEntity->Y();
	handle hand = pEntity->getHandle();
	if(inMap(x,y))
	{
		m_yAxis.p[y].p[x / X_FIELD_LEN].erase(hand);
		m_unitCount--;
	}else
	{
		TRACE2_L0("[CoScene::AttachUnit] unit position out of range, unitId=%d,\
		mapId=%d\n", hand, m_SceneInfo.mapId);
	}
}

void CoScene::moveUnit(CoEntity* pEntity, const GridVct& last)
{
    short x = pEntity->X();
    short y = pEntity->Y();
    int nOld = last.x / X_FIELD_LEN;
    int nNew = x / X_FIELD_LEN;
    if(y == last.y && nOld == nNew) return;
	handle hand= pEntity->getHandle();
	if(inMap(x,y))
	{
		m_yAxis.p[y].p[nNew].insert(hand);
        m_unitCount++;
	}
	else
	{
		TRACE2_L0("[CoScene::MoveUnit] unit position out of range,unitId=%d,\
		mapId=%d\n", hand, m_SceneInfo.mapId);
	}
	if(inMap(last))
	{
		m_yAxis.p[last.y].p[nOld].erase(hand);
        m_unitCount--;
	}
}

bool CoScene::posValidate(int x, int y, int flag)
{
	if(m_pMapInfo){
		int flags = m_pMapInfo->GetFlags(x, y);
		return (flags == 0);
	}
	return false;
}

int CoScene::getDistance(const GridVct* p1, const GridVct* p2)
{
	return GridDistance(p1->x, p1->y, p2->x, p2->y);
}

handle* CoScene::getEntities(const GridVct& ptCenter, short nRad, int& nHandleCount, short classType)
{
	int xOrg = ptCenter.x;
	int nMin = (xOrg <= nRad) ? 0 : xOrg - nRad;
	int nMax = (xOrg + nRad >= m_mapSize.x) ? m_mapSize.x - 1 : (xOrg + nRad);
	nMin = nMin / X_FIELD_LEN;
	nMax = nMax / X_FIELD_LEN;

	int yOrg = ptCenter.y;
	int yMin = (yOrg <= nRad) ? 0 : (yOrg - nRad);
	int yMax = (yOrg + nRad >= m_mapSize.y) ? (m_mapSize.y - 1) : (yOrg + nRad);

	int count = 0;
	for(int y = yMin; y <= yMax; y++)
	{
		for(int n = nMin; n <= nMax; n++)
		{
            _EntitySet::iterator it = m_yAxis.p[y].p[n].begin();
			_EntitySet::iterator ite = m_yAxis.p[y].p[n].end();
			for(; it != ite; ++it)
			{
				handle hand = *it;
				CoEntity* pEntity = _EntityFromHandle(hand);
				if(!pEntity) continue;
				int dist = ::GridDistance(pEntity->X(), pEntity->Y(), xOrg, yOrg);
				if(dist <= nRad && (classType == eClsTypeNone ||
                	pEntity->getType() == classType))
				{
					if(count == _MaxEnumCount)
					{
						nHandleCount = count;
						return s_entitiesBuf;
					}
					s_entitiesBuf[count++] = hand;
				}
			}
		}
	}
	nHandleCount = count;
	return s_entitiesBuf;
}

CoScene* CoScene::Create(SceneType type, short mapId, char* fname)
{
	if(mapId < 0 || mapId >= MAX_MAP_COUNT)
    	return NULL;
    CMapInfo* pMapInfo = g_MapManager.CreateMap(mapId, fname);
    if (!pMapInfo)
    	return NULL;
	CoScene* pScene = new CoScene(g_world.getWorldId(), mapId, type, pMapInfo);
    ASSERT_(pScene);
    return pScene;
}

bool CoScene::PosValidate(short mapId, int x, int y)
{
	if(mapId<0 || mapId >= MAX_MAP_COUNT)
    	return false;
	if(!g_MapManager.IsValidMap(mapId))
    	return false;
	int flags = g_MapManager.GetMap(mapId)->GetFlags(x, y);
	return (flags == 0);
}

GridVct CoScene::FindRandomTile(int mapId)
{
	GridVct gv(0, 0);
	CMapInfo* mapConfig = g_MapManager.GetMap(mapId);
	if (!mapConfig)
	{
		TRACE1_L0("map %d can not find!", mapId);
		return gv;
	}
    int xlen = mapConfig->GetXTileLen();
    int ylen = mapConfig->GetYTileLen();
	int count = 0;
	while(1)
	{
		if (count++ >= 500)
			break;
		int x=0, y=0;		
		x = random() % xlen;
		y = random() % ylen;
		if(mapConfig->GetFlags(x, y) == 0)
		{
			gv.x = x;
			gv.y = y;
			break;
		}
	}
	return gv;
}

GridVct CoScene::getRandomPos(int centerX,int centerY,int radius,int mapID)
{
	if(radius > Radius_limit)
	{
		radius = Radius_limit;
	}
	int xOrg = centerX;
	int yOrg = centerY;
	int yMin = yOrg - radius;
	if(yMin < 0) yMin = 0;
	int yMax = yOrg + radius;
	

	int nMin = xOrg - radius;
	if(nMin < 0) nMin = 0;
	
	int nMax = xOrg + radius;
	
	

	vector<GridVct> v;
	
	for(int y = yMin; y <= yMax; y++)
	{
		for(int n = nMin; n <= nMax; n++)
		{
			
			bool flag = posValidate( n, y,0);
			if (flag)
			{
				v.push_back(GridVct(n,y));
				
			}
			
			
		}
	}
	int count = v.size();
	if (count> 0)
	{
		int nRand = rand() % (count);
		return v[nRand-1];
	}
	else
	{
		return GridVct(centerX,centerY);
	}
	

}