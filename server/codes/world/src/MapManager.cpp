#include "lindef.h"
#include "MapManager.h"

#define MAX_MAP_COUNT			1024

CMapManager g_MapManager;


CMapManager::CMapManager()
{

}

CMapManager::~CMapManager()
{
	Clear();
}

CMapInfo* CMapManager::CreateMap(short mapID, char* pFileName)
{
	ASSERT_(pFileName);
	if (mapID == 0 || mapID > MAX_MAP_COUNT )
	{
		TRACE1_ERROR("CMapManager CreateMap failed! The mapID(%d) is not valid.\n", mapID);
		return 0;
	}
	CMapInfo* pMapInfo = GetMap(mapID);
	if (pMapInfo != 0)
	{
		return pMapInfo;
	}
	pMapInfo = new CMapInfo();
	if (!pMapInfo->Init(mapID, pFileName))
	{
		delete pMapInfo;
		return 0;
	}
	m_mapMapInfos.insert( std::map<short, CMapInfo*>::value_type(mapID, pMapInfo) );
	return pMapInfo;
}

bool CMapManager::IsValidMap(short mapID)
{
	return GetMap(mapID) != 0;
}

CMapInfo* CMapManager::GetMap(short mapID)
{
	std::map<short, CMapInfo*>::iterator iter = m_mapMapInfos.find(mapID);
	if (iter != m_mapMapInfos.end())
	 {
		 return iter->second;
	 }
	return 0;
}

void CMapManager::Clear()
{
	std::map<short, CMapInfo*>::iterator iter = m_mapMapInfos.begin();
	for(; iter != m_mapMapInfos.end(); ++iter )
	{
		delete iter->second;
	}
	 m_mapMapInfos.clear();
}

// 搜索地图路径
bool CMapManager::findPath(short mapID, const GridVct& ptFrom, const GridVct& ptTo, int nBlockOption, POINT*& pPaths, short& nPathLen)
{
	if (!IsValidMap(mapID))
	{
		TRACE1_ERROR("CSceneMap findPath failed: the mapID(%d) is error!!!\n", mapID);
		return false;
	}
	POINT ptStart, ptEnd;

	ptStart.x = ptFrom.x;
	ptStart.y = ptFrom.y;
	ptEnd.x   = ptTo.x;
	ptEnd.y   = ptTo.y;

	CMapInfo* pMap = GetMap(mapID);
    m_pathFinder.SetMapInfo(pMap->GetXTileLen(), pMap->GetYTileLen(), pMap);
	m_pathFinder.FindPath(ptStart, ptEnd, nBlockOption, pPaths, nPathLen, SEARCH_OPTION_ONLY_ASTAR);

	if (nPathLen == 0)
	{
		TRACE0_L1("CSceneMap::findPath error: find move path failed!\n");
		return false;
	}
	return true;
}
