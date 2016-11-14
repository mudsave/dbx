#ifndef _MAP_MANAGER_H__
#define _MAP_MANAGER_H__

#include "MapInfo.h"
#include "PathFinder.h"
#include<map>


class CMapManager
{
	public:
		CMapManager();

		~CMapManager();

		CMapInfo* CreateMap(DWORD mapID, char* pFileName);

		bool IsValidMap(DWORD mapID);

		CMapInfo* GetMap(DWORD mapID);

		bool findPath(short mapID, const GridVct& ptFrom, const GridVct& ptTo, int nBlockOption, POINT*& pPaths, short& nPathLen);
		
		void Clear();

	private:
    	PathFinder<CMapInfo> m_pathFinder;
		std::map<DWORD, CMapInfo*> m_mapMapInfos;
};

extern CMapManager g_MapManager;

#endif
