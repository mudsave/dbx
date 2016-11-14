/*******************************************************************
** 文件名:	PathFinder.h
** 版  权:	(C) 深圳未名网络技术有限公司 2008 - All Rights Reserved
** 创建人:	achen
** 日  期:	2008/04/17
** 版  本:	1.0
** 描  述:	
** 应  用:  	

**************************** 修改记录 ******************************
** 修改人: 
** 日  期: 
** 描  述: 
********************************************************************/

#ifndef __PATH_FINDER_H__
#define __PATH_FINDER_H__

#define MAX_FINDPATH_LEN 768  

#include <assert.h>
#include <functional>
#include <map>
#include "lindef.h"
#include "vsdef.h"
#include "SceneCoord.h"

/**
@name : 路径搜索模块
@brief: 功能:
			提供一份地图数据,该数据维护了地图中所有Tile的信息，例如哪些Tile是可通行的，哪些Tile是阻挡的。
			然后传入起点和终点坐标,该模块负责搜索从起点到终点的路径。
		算法:
			搜索路径最常用的算法是A*算法,但是出于性能考虑,这里采用一种更简单的方法实现,
			该方法的基本思路是,首先总是尝试直接向终点逼近，当遇到阻挡的Tile时沿着阻挡Tile绕转，直到重新回到直路上
			经过这个过程最终总是可以找到从起点到终点的有效路径，虽然这条路径不是最短的.
			最后一个步骤会对这条路径进行优化，使之看起来更自然

		Function:
			Provide a map data, it maintains a table for the information of all tiles in it.
			The most important information is which tiles is passable and others is blocked.
			Then,Give the coordinate of the start-point and the coordinate of the end-point,
			This module can find the path from start-point to end-point and around tiles which is blocked.
		Algorithm:
			To implement this function, usually people used an algorithm called A STAR(A*).
			But now,for some performance reason,I will implement it with a more clever method. 
			In our method,I always try to approach to the end-point straightly,I call it straightway.
			And when meet blocked tiles, I around it try to find sideway until it come back to the straightway.
			After this process,the path from start-point to end-point can always be found,though,it not a shortest path.
			Finally, I optimize the snaky path that i found and let it seem more natural.
*/

// 搜路选项
enum
{
	SEARCH_OPTION_ONLY_ASTAR =0x00,  
};

//TILE阻挡选项
enum
{
	BLOCK_OPTION_NULL   = 0x00,   //无阻档
	BLOCK_OPTION_GROUND = 0x01,   //地形阻挡
	BLOCK_OPTION_FLY    = 0x02,   //飞行阻挡
};

#define DIR_MAX 8

//////////////////////////////////////////////////////////////////////////
/**
@name : 搜路模板
@brief: 该搜路模板基于地图Tile实现,依赖一个判断地图Tile是否阻挡的函数
        使用方法:
		class CMap
		{
		public:
		    bool IsBlock(POINT pt);   // 必须实现IsBlock方法,如果名字不叫IsBlock可以在SetMapInfo时修改
		....
		};

		CMap m_Map;
		PathFinder<CMap>  m_PathFinder;
		m_PathFinder.SetMapInfo(m_Map.GetWidth(),m_Map.GetHeight(),&m_Map,mem_fun1(&CMap::IsBlock));
		POINT * pPath = 0;
		int nPathLen  = 0;
		if ( m_PathFinder.FindPath(ptStart,ptEnd,pPath,nPathLen) )
*/
//////////////////////////////////////////////////////////////////////////

template
< 
	class    _Map,                                                  // 地图 
	int      MAX_PATH_SIZE   = 768 ,                                // 最大路径长度
	int      MAX_SEARCH_AREA = 768                                   // 最大搜索面积
>
class PathFinder
{
public:
	struct TILE_TAG;

	/**
	@name           : 设置地图信息 
	@brief          : 调用FindPath之前请设置地图信息,该函数可以重复调用,所以可以在多个地图上搜索路径
	@param nMapWidth: 地图宽度
	@param nMapHeigh: 地图高度
	@param pMap     : 地图对象指针
	@param isBlock  : 判断地表是否阻挡的函数,如果地图对象判断阻挡的函数是IsBlock则该参数不用传
	@return         : 
	*/
	bool SetMapInfo(DWORD nMapWidth,DWORD nMapHeight,_Map * pMap);

	/**
	@name			: 搜索路径
	@brief			: 
	@param ptStart  : 起点坐标
	@param ptEnd    : 终点坐标
	@param pPathRet : 返回的路径点
	@param nPathLen : 返回路径长度
	@param nOption  : 搜路选项,是否优化路径
	@param nMaxStep : 最多搜索的步数,如果太远就放弃 (这个参数有两个意义 1.有时候只需要搜出最近几步的路,并不一定非要到达目标点 2.默认设为1024,防止出现死循环)
	@return         : 返回搜路是否成功 
	*/
	bool FindPath(const POINT & ptStart,const POINT & ptEnd, const int& nBlockOption,POINT *& pPath,short & nPathLen,int nOption = SEARCH_OPTION_ONLY_ASTAR,int nMaxStep = MAX_PATH_SIZE);

	// 构造函数
	PathFinder() : m_pNearestTile(0), m_pMap(0),m_nFind(0),m_nSearchOption(0),m_nMaxStep(MAX_PATH_SIZE),m_nStepCount(0)
	{
		m_TileTags = new TILE_TAG[MAX_SEARCH_AREA*MAX_SEARCH_AREA];
		memset(m_TileTags,0,sizeof(TILE_TAG)*MAX_SEARCH_AREA*MAX_SEARCH_AREA);
	}

	// 释构函数
	virtual ~PathFinder()
	{
		if ( m_TileTags ) { delete []m_TileTags;m_TileTags = 0;}
	}

protected:
	//////////////////////////////////////////////////////////////////////////
	// 采用A*算法搜索路径
	bool FindAStar(const POINT & ptStart,const POINT & ptEnd ,const int& nBlockOption);

	// 获取Tile信息
	inline TILE_TAG * GetTileTag(const POINT & ptTile);

	// 从TAG的指针获得Tile的坐标
	inline void TileToPoint(TILE_TAG * pTag,POINT &ptTile);

	// 判断某个Tile是否被访问过
	inline bool IsTileVisited(TILE_TAG * pTag,int nDir);

	// 取得某方向上下一个点的坐标
	inline void MoveNext(const POINT & ptTile,int dir,POINT & ptNext);

	// 根据走路的Tile,回朔完整路径
	int BuildPath(POINT * pPathBuffer,int nBufSize,bool nReverse,bool optmize=true);

public:
	//////////////////////////////////////////////////////////////////////////
	struct TILE_TAG
	{
		TILE_TAG  *      pParent;		// 上一个Tile指针
		unsigned short   nFindID;       // 当前搜路记号,每次搜路自动加1,这样可以避免每次都清一遍内存,当搜路频繁时每次都memset一下是非常低效的事情
		union
		{
			struct	// 环绕算法使用的数据
			{
				unsigned char    nMoveDir;      // 经过该点时的方向
				bool             bAround;       // 标识绕转的路线,这段路线后面需要进行优化
			};
			struct  // A*算法使用的数据
			{  
				unsigned short   nStep;			// 从起始点到该点的步数	
			};
		};
	};

protected:

	TILE_TAG*			 m_TileTags;								  // 用来记录搜路过程中走过的Tile的信息 
	POINT				 m_PathTemp[4][MAX_PATH_SIZE];                 // 用来存储返回的路径
	POINT                m_ptStart;                                   // 本次搜路的起始点
	POINT                m_ptEnd;                                     // 本次搜路的结束点
	TILE_TAG*            m_pNearestTile;                              // 最接近的点s
	DWORD				 m_nMapWidth;                                 // 地图宽度
	DWORD				 m_nMapHeight;                                // 地图高度

	_Map      *          m_pMap;                                      // 地图指针
//	_BlockTestFunc       m_BlockFunc;                                 // 阻挡判断函数
	unsigned short       m_nFind;                                     // 当前搜路的标示
	int                  m_nSearchOption;                             // 搜路选项
	int                  m_nMaxStep;                                  // 最大搜路步数
	int                  m_nStepCount;                                // 当前搜索的步数
};


// 沿直路靠近目标点
#define  TEMPLATE_DECLARE		template<class _Map,int MAX_PATH_SIZE,int MAX_SEARCH_AREA>
#define  PATH_FINDER_DECLARE	PathFinder<_Map,MAX_PATH_SIZE,MAX_SEARCH_AREA>

//////////////////////////////////////////////////////////////////////////
/**
@name           : 设置地图信息 
@brief          : 调用FindPath之前请设置地图信息,该函数可以重复调用,所以可以在多个地图上搜索路径
@param nMapWidth: 地图宽度
@param nMapHeigh: 地图高度
@param pMap     : 地图对象指针
@param isBlock  : 判断地表是否阻挡的函数,如果地图对象判断阻挡的函数是IsBlock则该参数不用传
@return         : 
*/
//////////////////////////////////////////////////////////////////////////
TEMPLATE_DECLARE
bool PATH_FINDER_DECLARE::SetMapInfo(DWORD nMapWidth,DWORD nMapHeight,_Map * pMap)
{
	m_nMapWidth = nMapWidth;
	m_nMapHeight= nMapHeight;

	m_pMap = pMap;
	
	return true;
}

//////////////////////////////////////////////////////////////////////////
/**
@name			: 搜索路径
@brief			: 
@param ptStart  : 起点坐标
@param ptEnd    : 终点坐标
@param pPathRet : 返回的路径点
@param nPathLen : 返回路径长度
@param nOption  : 搜路选项,是否优化路径
@return         : 返回搜路是否成功 
*/
//////////////////////////////////////////////////////////////////////////
TEMPLATE_DECLARE
bool PATH_FINDER_DECLARE::FindPath(const POINT & ptStart,const POINT & ptEnd,const int& nBlockOption,POINT *& pPath,short & nPathLen,int nOption,int nMaxStep)
{
	pPath = 0;
	nPathLen = 0;

	m_nSearchOption = nOption;
	m_nMaxStep      = nMaxStep;

    //////////////////////////////////////////////////////////////////////////
	// 只启用A*
	if ( SEARCH_OPTION_ONLY_ASTAR & nOption )
	{
		FindAStar(ptStart,ptEnd,nBlockOption);
		nPathLen = BuildPath(m_PathTemp[0],MAX_FINDPATH_LEN,true,false);
		pPath = &(m_PathTemp[0][MAX_FINDPATH_LEN-nPathLen]);
		return nPathLen > 0;		
	}
	return false;
}

//////////////////////////////////////////////////////////////////////////
/**
@name			: 采用A*算法搜索路径
@brief			: 
@param ptStart  : 起点坐标
@param ptEnd    : 终点坐标
@return         : 返回搜路是否成功 
*/
//////////////////////////////////////////////////////////////////////////
TEMPLATE_DECLARE
bool PATH_FINDER_DECLARE::FindAStar(const POINT & ptStart,const POINT & ptEnd,const int & nBlockOption)
{
	++m_nFind;
	m_ptStart = ptStart;
	m_ptEnd   = ptEnd;

	m_pNearestTile = 0;
	m_nStepCount   = 0;
	int nNearestDist = 10000000;

	POINT ptTile = ptStart;
	POINT ptNext;

	// 待搜索列表
	typedef  std::multimap<DWORD,POINT>      OPEN_LIST; 
	static   OPEN_LIST								 m_openList;							  
	
	static   POINT          ptTileArray[DIR_MAX];
	static   int        	nDistArray[DIR_MAX];

	// 最好初始化工作
	m_openList.clear();
	m_openList.insert( OPEN_LIST::value_type(0,ptStart) );
	
	TILE_TAG * pStart = GetTileTag(ptStart);
	if ( pStart )
	{
		pStart->pParent = 0;
		pStart->nFindID = m_nFind;
		pStart->nStep   = 0;
	}

	while( ++m_nStepCount<=m_nMaxStep )
	{
		// 已经没有点可以尝试了
		if ( m_openList.empty() )
		{
			return false;
		}

		// 从OPEN_LIST中取出积分最小的点优先尝试
		OPEN_LIST::iterator it = m_openList.begin();
		ptTile = it->second;
		m_openList.erase( it );

		TILE_TAG * pCurrent = GetTileTag(ptTile);
		if ( pCurrent==0 )
			continue;

		// 到达目标点
		if ( ptTile.x == ptEnd.x && ptTile.y == ptEnd.y )
		{
			m_pNearestTile = pCurrent;
			return true;
		}

		int block_num  = 0;
		int visited_num= 0;
		int step       = pCurrent->nStep + 1;

		// 将周围8个方向的点压入OPEN_LIST
		for ( int dir=0;dir<DIR_MAX;++dir )
		{
			MoveNext( ptTile,dir,ptNext );
			nDistArray[dir] = -1;

			TILE_TAG * pTag = GetTileTag(ptNext);
			if ( pTag==0 || pTag==pCurrent->pParent )
				continue;

			// 已经搜索过的
			if ( pTag->nFindID==m_nFind )
			{
				if ( pTag->nStep > step )
				{
					pTag->pParent = pCurrent;
					pTag->nStep   = step;
				}else
				{
					++visited_num;
					continue;
				}
			}

			if ( m_pMap->IsBlock(ptNext,nBlockOption))
			{
				++block_num;
				continue;
			}

			// 添加到OPEN列表
			pTag->nFindID = m_nFind;
			pTag->pParent = pCurrent;
			pTag->nStep   = step;			

			ptTileArray[dir] = ptNext;
			nDistArray[dir]  = abs( ptNext.x-ptEnd.x ) + abs( ptNext.y-ptEnd.y );
			if ( nDistArray[dir]<nNearestDist )
			{
				m_pNearestTile = pTag;
				nNearestDist = nDistArray[dir];
			}
		}

		for ( int i=0;i<DIR_MAX;++i )
		{
			if ( nDistArray[i]>=0 )
			{
				// 评估公式 = 离目标点的距离*a + 周围占位块数*b + 周围已搜索的点*c + 已经走过的步数*d
				unsigned score = nDistArray[i] + block_num + visited_num + step*2 + (i%2)*2;
				OPEN_LIST::value_type val(score,ptTileArray[i]);
				m_openList.insert( val );
			}
		}
	}

	return false;
}

//////////////////////////////////////////////////////////////////////////
/**
@name         : 获取Tile信息
@brief        : 由于Tile的信息是临时保存在m_TileTags里,该段数据每次搜路都可能覆写一遍,所以取的时候要做个映射
@brief        : 设定一个最大搜路范围的好处是: 
@brief        :     1.当地图非常大时(例如1024*1024),如果维护一个和地图同样大小的数组会很消耗内存
@brief        :     2.m_TileTags的大小和地图大小无关,这样所有的地图可以共用一个搜路器,可以更多的节省内存
@return       : 如果是不合法的Tile或则已经超过了最大的搜路范围则返回0,否则返回Tile信息指针
*/
//////////////////////////////////////////////////////////////////////////
TEMPLATE_DECLARE
typename PATH_FINDER_DECLARE::TILE_TAG * PATH_FINDER_DECLARE::GetTileTag(const POINT & ptTile)
{
	// 是否超出边界
	if ( ptTile.x < 0 || (DWORD)ptTile.x >= m_nMapWidth )
	{
		return 0;
	}

	if ( ptTile.y < 0 || (DWORD)ptTile.y >= m_nMapHeight )
	{
		return 0;
	}

	// 映射到Tag数组
	int x = (ptTile.x - m_ptStart.x) + (MAX_SEARCH_AREA>>1);
	int y = (ptTile.y - m_ptStart.y) + (MAX_SEARCH_AREA>>1);

	if ( x<0 || y<0 || x>=MAX_SEARCH_AREA || y>=MAX_SEARCH_AREA )
	{
		return 0;
	}

	return &(m_TileTags[y*MAX_SEARCH_AREA+x]);
}

//////////////////////////////////////////////////////////////////////////
/**
@name         : 从TAG的指针获得Tile的坐标 (GetTileTag的逆操作)
@brief        : 从TAG的指针转换到Tile坐标可以直接通过指针到m_TileTags[0]的偏移折算出来
@param  pTag  : 传入TILE_TAG指针
@param ptTile : 返回该指针对应的Tile坐标
@return       : 
*/
//////////////////////////////////////////////////////////////////////////
TEMPLATE_DECLARE
void PATH_FINDER_DECLARE::TileToPoint(TILE_TAG * pTag,POINT &ptTile)
{
	int offset = pTag - m_TileTags;

	// 这里有除法运算,但如果MAX_SEARCH_AREA取值合适,编译器会进行优化
	ptTile.x = m_ptStart.x - (MAX_SEARCH_AREA>>1) + (offset%MAX_SEARCH_AREA);
	ptTile.y = m_ptStart.y - (MAX_SEARCH_AREA>>1) + (offset/MAX_SEARCH_AREA);
}

//////////////////////////////////////////////////////////////////////////
/**
@name         : 判断某个Tile是否被访问过
@brief        : 这个函数主要用于规避绕转时的死循环
@param  pTag  : Tile的信息指针 
@param  nDir  : 如果两次经过同一个Tile但是经过的方向不同则应被允许,所以这里需要传入待测试的方向
@return       : 
*/ 
//////////////////////////////////////////////////////////////////////////
TEMPLATE_DECLARE
bool PATH_FINDER_DECLARE::IsTileVisited(TILE_TAG * pTag,int nDir)
{
	return pTag->nFindID==m_nFind && (pTag->nMoveDir & (0x01 << nDir));
}

//////////////////////////////////////////////////////////////////////////
/**
@name         : 沿给定方向移动一步
@brief        : 
@param ptTile : 当前坐标
@param dir    : 前进方向
@param ptNext : 返回下一步坐标
@return       : 
*/
//////////////////////////////////////////////////////////////////////////
TEMPLATE_DECLARE
void PATH_FINDER_DECLARE::MoveNext(const POINT & ptTile,int dir,POINT & ptNext)
{
	static int s_DirNextTable[8][2] =
	{
		{1,0},  // 方向定义 : 东  (angle:0)
		{1,-1}, // 方向定义 : 东北(angle:45)
		{0,-1}, // 方向定义 : 北  (angle:90)
		{-1,-1},// 方向定义 : 西北(angle:135)
		{-1,0}, // 方向定义 : 西  (angle:180)
		{-1,1}, // 方向定义 : 西南(angle:225)
		{0,1},  // 方向定义 : 南  (angle:270)
		{1,1},  // 方向定义 : 东南(angle:315)	
	};

	assert(dir>=0 && dir <8 );

	ptNext.x = ptTile.x + s_DirNextTable[dir][0];
	ptNext.y = ptTile.y + s_DirNextTable[dir][1];
}

//////////////////////////////////////////////////////////////////////////
/**
@name         : 根据走过的Tile,回朔完整路径
@brief        : 因为搜路时我们经过某些Tile,当时并不知道是否能到达目的地,无从记录,所以到达后要反过来回朔一遍才能把路径找出来
@param pPathBuffer : 用来存路径的缓冲区
@param nBufSize    : 缓冲区大小
@param nReverse    : 是否把路径反过来存,因为是回溯,所以默认应该反过来存
@return       : 
*/ 
//////////////////////////////////////////////////////////////////////////
TEMPLATE_DECLARE
int PATH_FINDER_DECLARE::BuildPath(POINT * pPathBuffer,int nBufSize,bool nReverse,bool optmize)
{
	int   nBarrier = 0;
	int   nPathLen = 0; 
	POINT ptTile;

	while(m_pNearestTile && nPathLen<nBufSize)
	{
		TileToPoint(m_pNearestTile,ptTile);

		// 绕转的Tile优化,不要频繁转向
		if ( optmize )
		{
			if ( m_pNearestTile->bAround && nPathLen>=2 )
			{
				POINT ptPreTile = nReverse ? pPathBuffer[nBufSize-1-nPathLen+2] : pPathBuffer[nPathLen-2];
				if ( abs(ptPreTile.x-ptTile.x)<=1 && abs(ptPreTile.y-ptTile.y)<=1 )
				{
					nPathLen-=1;
				}
			}
		}

		// 把路点放到缓冲区里
		if ( nReverse )
		{
			pPathBuffer[nBufSize-1-nPathLen] = ptTile;
		}
		else
		{
			pPathBuffer[nPathLen] = ptTile;
		}

		m_pNearestTile = m_pNearestTile->pParent;
		++nPathLen;

		// 检测死循环
		if ( ++nBarrier>=nBufSize)
		{
			assert("find path error! detected a closed-loop when buiding the path.");
			return 0;  
		}
	}

	return nPathLen;
}

#endif//__PATH_FINDER_H__
