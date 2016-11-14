#ifndef __SceneCoord_H__
#define __SceneCoord_H__
#include<string.h>
#include "vsdef.h"

#define Ceil(PixelPos, GridLength)	((PixelPos + GridLength - 1) / GridLength)
#define Floor(PixelPos, GridLength)	(PixelPos / GridLength)

#define TILE_WIDTH			64
#define TILE_HEIGHT			32

#define IN
#define OUT

inline bool IntersectRect(RECT* prcDst, const RECT* prcSrc1, const RECT* prcSrc2)
{
	prcDst->left = prcSrc1->left < prcSrc2->left ? prcSrc2->left : prcSrc1->left;
	prcDst->right = prcSrc1->right < prcSrc2->right ? prcSrc1->right : prcSrc2->right;
	prcDst->top = prcSrc1->top < prcSrc2->top ? prcSrc2->top : prcSrc1->top;
	prcDst->bottom = prcSrc1->bottom < prcSrc2->bottom ? prcSrc1->bottom : prcSrc2->bottom;
	if(prcDst->right <= prcDst->left || prcDst->bottom <= prcDst->top)
	{
		prcDst->left = prcDst->right = prcDst->top = prcDst->bottom = 0;
		return false;
	}
	return true;
}


class SceneCoord
{
public:
	void tile2Pixel(IN const POINT& ptTile, OUT POINT& ptTileCenter) const
	{
		ptTileCenter.x = (ptTile.x + ptTile.y - m_yOff)  * TILE_WIDTH / 2;
		ptTileCenter.y = (ptTile.x - ptTile.y + m_yOff)  * TILE_HEIGHT / 2;
	}
	void pixel2Tile(IN const POINT& ptWorld, OUT POINT& ptTile) const
	{
		const static int OffsetX[5] = { 0, 1, 1, 1, 2};
		const static int OffsetY[5] = { 0, 1, 0,-1, 0};

		int kx = ptWorld.x / TILE_WIDTH;
		int ky = ptWorld.y / TILE_HEIGHT;
		int off = m_TilePoint[ptWorld.y & (TILE_HEIGHT - 1)][ptWorld.x & (TILE_WIDTH - 1)];
		ptTile.x = kx + ky + OffsetX[off];
		ptTile.y = kx - ky + OffsetY[off] + m_yOff;
	}

	RECT pixelRectToAreaTileRect(RECT rc) const
	{
		IntersectRect(&rc, &m_rcMap, &rc);

		rc.left = (Ceil(rc.left, TILE_WIDTH)) * TILE_WIDTH;
		rc.top = (Ceil(rc.top, TILE_HEIGHT)) * TILE_HEIGHT;
		rc.right  = Ceil(rc.right,TILE_WIDTH) * TILE_WIDTH;
		rc.bottom = Ceil(rc.bottom,TILE_HEIGHT) * TILE_HEIGHT;

		RECT rcTileArea;
		pixel2Tile((const POINT&)rc, (POINT&)rcTileArea);
		rcTileArea.right = Ceil(rc.right - rc.left, TILE_WIDTH);
		rcTileArea.bottom = Ceil(rc.bottom - rc.top, TILE_HEIGHT);
		if (rcTileArea.top + rcTileArea.right >= m_nMatrixHeight)
		{
			rcTileArea.right = m_nMatrixHeight - rcTileArea.top - 1;
		}
		if (rcTileArea.top < rcTileArea.bottom - 1)
		{
			rcTileArea.bottom = rcTileArea.top + 1;
		}

		return rcTileArea;
	}

	RECT _pixelRectToAreaTileRect(RECT rc) const
	{
		RECT rcTileArea;
		pixel2Tile((const POINT&)rc, (POINT&)rcTileArea);
		rcTileArea.right = Ceil(rc.right - rc.left, TILE_WIDTH);
		rcTileArea.bottom = Ceil(rc.bottom - rc.top, TILE_HEIGHT);
		return rcTileArea;	
	}

	bool create(int nWidth, int nHeight)
	{
		int nRows = getAbstractH(nHeight);
		int nCols = getAbstractW(nWidth);

		m_rcMap.right = nWidth;
		m_rcMap.bottom = nHeight;

		m_yOff = nRows - 1;
		m_nMatrixWidth = nRows + nCols;
		m_nMatrixHeight = m_nMatrixWidth - 1;
		return true;
	}

	int getAbstractW(int nWidth)
	{
		return Ceil(nWidth, TILE_WIDTH);
	}
	int getAbstractH(int nHeight)
	{
		return Ceil(nHeight, TILE_HEIGHT); 
	}
	int getMatrixWidth()
	{
		return m_nMatrixWidth;
	}
	int getMatrixHeight()
	{
		return m_nMatrixHeight;
	}
	int getMapWidth()
	{
		return m_rcMap.right;
	}
	int getMapHeight()
	{
		return m_rcMap.bottom;
	}
	RECT& getMapRect()
	{
		return m_rcMap;
	}
	SceneCoord()
	{
		m_yOff = 0;
		m_nMatrixWidth = m_nMatrixHeight = 0;
		memset(&m_rcMap, 0, sizeof(m_rcMap));
	}
	~SceneCoord()
	{
		
	}
	const static char m_TilePoint[TILE_HEIGHT][TILE_WIDTH];
private:
	int		m_yOff;
	RECT	m_rcMap;
	int		m_nMatrixWidth;
	int		m_nMatrixHeight;
};

#endif
