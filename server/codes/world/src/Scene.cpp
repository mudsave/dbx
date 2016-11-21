
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
	int nMin = (xOrg < nRad) ? 0 : xOrg - nRad;
	int nMax = (xOrg + nRad > m_mapSize.x) ? m_mapSize.x - 1 : (xOrg + nRad);
	nMin = nMin / X_FIELD_LEN;
	nMax = nMax / X_FIELD_LEN;
    
	int yOrg = ptCenter.y;
	int yMin = (yOrg < nRad) ? 0 : (yOrg - nRad);
	int yMax = (yOrg + nRad > m_mapSize.y) ? (m_mapSize.y - 1) : (yOrg + nRad);

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
                	pEntity->getPropType() == classType))
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

//产生随机可用Tile
bool CoScene::FindEmptyTile(int mapId, const GridVct& ptCenter, int nRad, GridVct &ptResult,
	const GridVct* pPtExclude)
{
	if(mapId<0 || mapId >= MAX_MAP_COUNT)
    	return false;
	if(!g_MapManager.IsValidMap(mapId))
    	return false;
	CMapInfo* mapConfig = g_MapManager.GetMap(mapId);
    int nDia = nRad * 2 + 1;
    GridVct ptLoc;
    int nRandX = rand() % nDia;	
    for(int i = 0; i < nDia; i++)
    {
        nRandX++;
        if(nRandX >= nDia)
            nRandX = 0;
        ptLoc.x = ptCenter.x - nRad + nRandX;
        int nRandY = rand() % nDia;
        for(int j = 0; j < nDia; j++)
        {
            nRandY++;
            if(nRandY >= nDia)
                nRandY = 0;
            ptLoc.y = ptCenter.y - nRad + nRandY;
            if (
				(ptLoc.x != ptCenter.x || ptLoc.y != ptCenter.y)
				&& (!pPtExclude || (ptLoc.x != pPtExclude->x || ptLoc.y != pPtExclude->y))
				&& (ptLoc.x < mapConfig->GetXTileLen() && ptLoc.y < mapConfig->GetYTileLen())
				) 
            {
                int lFlag = g_MapManager.GetMap(mapId)->GetFlags(ptLoc.x, ptLoc.y);
                if(lFlag == 0)
                {
                    ptResult.x = ptLoc.x;
                    ptResult.y = ptLoc.y;
                    return true;
                }
            }
        }		
    }    
    return false;
}

GridVct CoScene::FindRandomTile(int mapId)
{
	CMapInfo* mapConfig = g_MapManager.GetMap(mapId);
    int lenX = mapConfig->GetXTileLen();
    int lenY = mapConfig->GetYTileLen();
	GridVct center(lenX / 2, lenY / 2);
	GridVct gv(0, 0);
    int radius = lenX > lenY ? lenX : lenY;
	FindEmptyTile(mapId, center, radius, gv, NULL);
    return gv;
}
