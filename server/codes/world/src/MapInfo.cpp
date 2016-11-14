#include "lindef.h"
#include "MapInfo.h"
#include "DataChunk.h"
#include "PathFinder.h"

#define SERVER_DATA_FILE_PATH		"../resource/map"

#define GRID_WIDTH			1024
#define GRID_HEIGHT			512

enum 
{
	tValid =						0x0001,

	tGroundBlock_Surface =			0x0010,

	tFlyBlock_Surface =				0x0020,

	tSpreadBlock_Surface =			0x0040,

	tGroundBlock_Entity =			0x2000,
	
	tSpreadBlock_Entity =			0x4000,

	tFlyBlock_Entity =              0x8000,

	tGroundBlock = (tGroundBlock_Surface | tGroundBlock_Entity),

	tFlyBlock = (tFlyBlock_Surface | tFlyBlock_Entity),

	tSpreadBlock = (tSpreadBlock_Surface | tSpreadBlock_Entity)
};

CMapInfo::CMapInfo(void)
{
	m_xLen = m_yLen = 0;
	m_pInfoBuf = NULL;
	m_mapId = 0;
}

CMapInfo::~CMapInfo(void)
{
	if(m_pInfoBuf) 
	{
		delete[] m_pInfoBuf;
	}
	m_pInfoBuf = 0;
}

bool CMapInfo::Init(DWORD mapId, char* pFileName)
{
	if(m_mapId > 0)
	{
		return true;
	}
	char szFileName[260] = {"0"};
	::sprintf(szFileName, "%s/%s", SERVER_DATA_FILE_PATH, pFileName);

	FILE* pFile = ::fopen(szFileName, "rb");
	if(!pFile)
	{
		TRACE2_ERROR("[CMapInfo::init] open map file %s failed, mapId=%i\n", szFileName, mapId);
		return false;
	}
	DataChunk dataChunk;
	DataChunk::SectionChunk *pChunk = dataChunk.BeginChunk(pFile);
	int nGridRow;
	int nGridCol;
	int nWidth;
    int nHeight;
	DWORD* pMapTable = NULL;
	while(pChunk)
	{
		switch(pChunk->m_dwType)
		{
			case 'MINF':
			{
				nWidth = *(DWORD*)pChunk->m_pData;
				nHeight = *(DWORD*)((BYTE*)pChunk->m_pData + sizeof(DWORD));

				nGridRow = (nHeight - 1) / GRID_HEIGHT + 1;
				nGridCol = (nWidth - 1) / GRID_WIDTH + 1;
				break;
			}
			case 'MIDX':
			{
				pMapTable = new DWORD[nGridRow * nGridCol];
				::memcpy(pMapTable, pChunk->m_pData, pChunk->m_dwDataSize);
				break;
			}
			case 'MVER':
			{
				::memcpy(&m_nVersion, pChunk->m_pData, sizeof(short));
				break;
			}
			case 'MWPT':
				break;
		}
		pChunk = dataChunk.NextChunk(pFile);
	}
	nWidth = (nWidth / TILE_WIDTH) * TILE_WIDTH;
	nHeight = (nHeight / TILE_HEIGHT) * TILE_HEIGHT;
	m_sceneCo.create(nWidth, nHeight);
	
	//init block info
	m_xLen = m_sceneCo.getMatrixWidth();
	m_yLen = m_sceneCo.getMatrixHeight();
	m_pInfoBuf = new BYTE[m_yLen * m_xLen];
	memset(m_pInfoBuf, 0, m_yLen * m_xLen);

	int nCols = m_sceneCo.getAbstractW(nWidth);
	int nRows = m_sceneCo.getAbstractH(nHeight);
	//Kirk: very important
	InitBlockInfo(nRows, nCols * 2);
	
	int nTileRow = GRID_HEIGHT / TILE_HEIGHT;
	int nTileCol = GRID_WIDTH / (TILE_WIDTH / 2);
	POINT ptTileLeftTop;
	POINT ptLeftTop;
	for(int row = 0; row < nGridRow; row++)
	{
		for(int col = 0; col < nGridCol; col++)
		{
			ptLeftTop.x = col * GRID_WIDTH;
			ptLeftTop.y = row * GRID_HEIGHT;

			m_sceneCo.pixel2Tile(ptLeftTop, ptTileLeftTop);
			::fseek(pFile, pMapTable[row * nGridCol + col], SEEK_SET);
			if(!LoadBlock(pFile, ptTileLeftTop, nTileRow, nTileCol))
			{
				if(pMapTable) 
				{
					delete[] pMapTable;
				}
				::fclose(pFile);
				return false;
			}
		}
	}
	if(pMapTable)
	{
		delete[] pMapTable;
	}
	::fclose(pFile);

	m_mapId = mapId;
	return true;
}

bool CMapInfo::LoadBlock(FILE* pFile, POINT ptTileLeftTop, int nTileRow, int nTileCol)
{
	POINT ptCurTile = ptTileLeftTop;
	bool bIsEmptyTile = false;
	int nCount = 0;

	for(int row = 0; row < nTileRow; row++)
	{
		ptCurTile.x = ptTileLeftTop.x + row;
		ptCurTile.y = ptTileLeftTop.y - row;
		for(int col=0; col < nTileCol; col++)
		{
			if(nCount == 0)
			{
				BYTE btyData;
				::fread(&btyData, sizeof(BYTE), 1, pFile);
				if(btyData & 0x80)
				{
					bIsEmptyTile = false;
					nCount = btyData - 128 + 1;
				}
				else
				{
					bIsEmptyTile = true;
					nCount = btyData + 1;
				}
			}
			if(ptCurTile.x >=0 && ptCurTile.x < m_xLen && ptCurTile.y >=0 && ptCurTile.y < m_yLen && (m_pInfoBuf[ptCurTile.y * m_xLen + ptCurTile.x] & tValid) != 0)
			{
				if (m_nVersion >= 5)
				{
					DWORD sortIndex;
					if(!::fread(&sortIndex, sizeof(DWORD), 1, pFile))
					{
						return false;
					}
				}
				if(!bIsEmptyTile)
				{
					WORD info = LoadTileInfo(pFile);
					if(info == (WORD)-1)
					{
						return false;
					}
					BYTE flags = info & tGroundBlock ? GRID_BLK_1 : 0;
					flags |= info & tFlyBlock ? GRID_BLK_2 : 0;
					flags |= info & tSpreadBlock ? GRID_BLK_3 : 0;
					m_pInfoBuf[ptCurTile.y * m_xLen + ptCurTile.x] = m_pInfoBuf[ptCurTile.y * m_xLen + ptCurTile.x]|flags |(info&0xf) ;
				}
				nCount--;
			}
			ptCurTile.x += !(col & 1);
			ptCurTile.y += col & 1;
		}
	}
	return true;
}

WORD CMapInfo::LoadTileInfo(FILE* pFile)
{
	WORD nFlags;
	::fread(&nFlags, sizeof(WORD), 1, pFile);

	BYTE nItemCount;
	::fread(&nItemCount, sizeof(BYTE), 1, pFile);
	
	for(BYTE i = 0; i < nItemCount; i++)
	{
		
		BYTE entityType;
		if(!fread(&entityType,1,1,pFile))
		{
			return -1;
		}

		BYTE resType;
		if(!fread(&resType,1,1,pFile))
		{
			return -1;
		}

		DWORD sortIndex;
		if(m_nVersion>=2)
		{			
			if(!fread(&sortIndex,sizeof(DWORD),1,pFile))
			{
				return -1;
			}
		}
		short nHeightLevel;
		if(m_nVersion>=4)
		{
 			if(!fread(&nHeightLevel, sizeof(short),1,pFile))
			{
 				return -1;
			}
		}

		BYTE scope;
		if (m_nVersion >= 5)
		{
			if(!fread(&scope, sizeof(scope),1,pFile))
			{
				return -1;			
			}	
		}
		BYTE length;
		if(!fread(&length,1,1,pFile))
		{
			return -1;
		}
#if DEBUG
		//以下代码是用来DEBUG时用的，只需要注释，不要删除
		//BYTE data[256];
		//if(!fread(data,1,length,fp))
		//		return -1;
		//data[length] = 0;
		//TRACE1_L0("%s\n",(char*)data);
#endif

 		if(fseek(pFile, length, SEEK_CUR)!=0)
		{
  			return -1;
		}
	}
	return nFlags;
}

void CMapInfo::InitBlockInfo(int nTileRow, int nTileCol)
{
	POINT ptLeftTop  = {0, 0};
	POINT ptTileLeftTop;
	m_sceneCo.pixel2Tile(ptLeftTop, ptTileLeftTop);
	POINT ptCurTile;
	for (int row=0; row<nTileRow; row++)
	{
		ptCurTile.x = ptTileLeftTop.x + row;
		ptCurTile.y = ptTileLeftTop.y - row;
		for (int col=0; col<nTileCol; col++)
		{
			if(ptCurTile.x >=0 && ptCurTile.x < m_xLen && ptCurTile.y >=0 && ptCurTile.y < m_yLen)
			{
					m_pInfoBuf[ptCurTile.y * m_xLen + ptCurTile.x]	= tValid;		
			}
			ptCurTile.x += !(col&1);
			ptCurTile.y += col&1;
		}
	}
}

// 是否有阻挡
bool CMapInfo::IsBlock(POINT ptPos, int nBlockOption)
{
    int nFlags = GetFlags(ptPos.x, ptPos.y);
    if(nBlockOption & BLOCK_OPTION_GROUND)
    {
        return (nFlags & GRID_BLK_1) != 0;
    }
    if(nBlockOption & BLOCK_OPTION_FLY)
    {
        return (nFlags & GRID_BLK_2) != 0;
    }
	return false;
}
