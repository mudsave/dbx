#ifndef __MAP_INFO_H_
#define __MAP_INFO_H_

#include "SceneCoord.h"

enum _BlockFlag
{
	GRID_BLK_1 = 0x10,			/**< 静态 编辑器时定义 行走阻碍*/
	GRID_BLK_2 = 0x20,			/**< 静态 编辑器时定义 飞行阻碍*/
	GRID_BLK_3 = 0x40,			/**< 静态 编辑器时定义 技能阻碍*/
};

class CMapInfo
{
public:
	CMapInfo(void);

	~CMapInfo(void);

	bool Init(DWORD mapId, char* pFileName);

	int GetFlags(int x, int y)
	{
		if(x < 0 || x >= m_xLen || y < 0 || y >= m_yLen) 
		{
			return -1;
		}
		POINT ptTile;
		POINT ptPixel;
		ptTile.x = x; 
		ptTile.y = y;
		m_sceneCo.tile2Pixel(ptTile, ptPixel);
		if(ptPixel.x < 0 || ptPixel.x >= m_sceneCo.getMapWidth() || ptPixel.y < 0 || ptPixel.y >= m_sceneCo.getMapHeight()) 
		{
			return -1;
		}
		return m_pInfoBuf[y * m_xLen + x] & 0xf0;
	}

	int GetType(int x, int y)
	{
		if(x < 0 || x >= m_xLen || y < 0 || y >= m_yLen) 
		{
			return -1;
		}
		POINT ptTile;
		POINT ptPixel;
		ptTile.x = x; 
		ptTile.y = y;
		m_sceneCo.tile2Pixel(ptTile, ptPixel);
		if(ptPixel.x < 0 || ptPixel.x >= m_sceneCo.getMapWidth() || ptPixel.y < 0 || ptPixel.y >= m_sceneCo.getMapHeight())
		{
			return -1;
		}
		return m_pInfoBuf[y * m_xLen + x] & 0xf;
	}

	int GetXTileLen()
	{
		return m_xLen;
	}

	int GetYTileLen()
	{
		return m_yLen;
	}

	// 是否有阻挡
	bool IsBlock(POINT ptPos, int nBlockOption);

private:
	bool LoadBlock(FILE* pFile, POINT ptTileLeftTop, int nTileRow, int nTileCol);

	WORD LoadTileInfo(FILE* pFile);

	void InitBlockInfo(int nTileRow, int nTileCol);

private:
	int m_xLen;			// tile

	int m_yLen;			

	DWORD m_mapId;

	BYTE* m_pInfoBuf;

	SceneCoord m_sceneCo;

	short m_nVersion;
};


#endif
