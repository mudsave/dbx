#include "GridGraphics.h"
#include "types.h"

int CGridLine::Line(int x0, int y0, int x1, int y1)
{
	int xStep, yStep;
	int dxAbc, dx = x1 - x0;
	int dyAbc, dy = y1 - y0;
	if(dx >= 0)
	{
		xStep = 1;
		dxAbc = dx;
	}
	else
	{
		xStep = -1;
		dxAbc = -dx;
	}
	if(dy >= 0)
	{
		yStep = 1;
		dyAbc = dy;
	}
	else
	{
		yStep = -1;
		dyAbc = -dy;
	}
	int x = x0;
	int y = y0;
	int d, incr, incr2;
	if(OnPoint(x, y))
	{
		return 1;
	}
	if(dxAbc >= dyAbc)
	{
		incr = dyAbc << 1;
		incr2 = (dyAbc - dxAbc) << 1;
		d = incr - dxAbc;
		while(x != x1)
		{
			x += xStep;
			if(d < 0 || (d == 0 && dx >= 0))
			{
				d += incr;
			}
			else
			{
				d += incr2;
				y += yStep;
			}
			if(OnPoint(x, y))
			{
				return 1;
			}
		}
	}
	else
	{
		incr = dxAbc << 1;
		incr2 = (dxAbc - dyAbc) << 1;
		d = incr - dyAbc;
		while(y != y1)
		{
			y += yStep;
			if(d < 0 || (d == 0 && dy >= 0))
			{
				d += incr;
			}
			else
			{
				d += incr2;
				x += xStep;
			}
			if(OnPoint(x, y)) 
			{
				return 1;
			}
		}
	}
	return 0;
}

int CGridCircle::Circle(int x0, int y0, int radius)
{
	m_x0 = x0; m_y0 = y0;
	m_radius = radius;
	if(radius == 0)
	{
		return OnPoint(m_x0, m_y0);
	}
	int x = 0;
	int y = radius;
	int d = 1 - radius;
	int deltaE = 3;
	int deltaSE = -2 * radius + 5;
	while(y >= x)
	{
		if(CirclePoints(x, y)) 
		{
			return 1;
		}
		if(d < 0)
		{
			d += deltaE;
			deltaE += 2;
			deltaSE += 2;
		}
		else
		{
			d += deltaSE;
			deltaE += 2;
			deltaSE += 4;
			y--;
		}
		x++;
	}
	return 0;
}

int CGridCircle::CirclePoints(int x, int y)
{
	if(x != y && OnPoint(m_x0 - x, m_y0 - y)) 
	{
		return 1;
	}
	if(x != 0 && OnPoint(m_x0 + x, m_y0 - y))
	{
		return 1;
	}
	if(x != 0 && OnPoint(m_x0 - y, m_y0 - x)) 
	{
		return 1;
	}
	if(x != y && OnPoint(m_x0 + y, m_y0 - x))
	{
		return 1;
	}
	if(x != y && OnPoint(m_x0 - y, m_y0 + x)) 
	{
		return 1;
	}
	if(x != 0 && OnPoint(m_x0 + y, m_y0 + x)) 
	{
		return 1;
	}
	if(x != 0 && OnPoint(m_x0 - x, m_y0 + y))
	{
		return 1;
	}
	if(x != y && OnPoint(m_x0 + x, m_y0 + y)) 
	{
		return 1;
	}
	return 0;
}

int CGridDisk::Disk(int x0, int y0, int radius)
{
	m_x0 = x0; m_y0 = y0;
	m_radius = radius;
	int x = 0;
	int y = radius;
	int d = 1 - radius;
	int deltaE = 3;
	int deltaSE = -2 * radius + 5;
	while(y >= x)
	{
		if(CirclePoints(x, y, d >= 0))
		{
			return 1;
		}
		if(d < 0)
		{
			d += deltaE;
			deltaE += 2;
			deltaSE += 2;
		}
		else
		{
			d += deltaSE;
			deltaE += 2;
			deltaSE += 4;
			y--;
		}
		x++;
	}
	return 0;
}

int CGridDisk::CirclePoints(int x, int y, int begin)
{
	if(begin)
	{
		if(OnLine(m_x0 - x, m_x0 + x, m_y0 - y))
		{
			return 1;
		}
		if(y != 0 && OnLine(m_x0 - x, m_x0 + x, m_y0 + y))
		{
			return 1;
		}
	}
	if(x != y)
	{
		if(OnLine(m_x0 - y, m_x0 + y, m_y0 - x)) 
		{
			return 1;
		}
		if(x != 0 && OnLine(m_x0 - y, m_x0 + y, m_y0 + x)) 
		{
			return 1;
		}
	}
	return 0;
}

WORD _g_distanceMap[GRID_DISTANCE_LIMIT][GRID_DISTANCE_LIMIT];

class CDistanceCircleCallback : public CGridCircle
{
public:
	virtual ~CDistanceCircleCallback(){}
	virtual int OnPoint(int x, int y)
	{
		if(x < m_x0 || y < m_y0) 
		{
			return 0;
		}
		//assert(x >= 0 && x < GRID_DISTANCE_LIMIT && y >= 0 && y < GRID_DISTANCE_LIMIT);
		_g_distanceMap[y][x] = m_radius;
		return 0;
	}
};

struct _InitGridGraphics
{
	_InitGridGraphics()
	{
		CDistanceCircleCallback circle;
		for(int i = 1; i < GRID_DISTANCE_LIMIT; i++)
		{
			circle.Circle(0, 0, i);
		}
		// 填补遗漏的网格
		for(int y = 1; y < GRID_DISTANCE_LIMIT; y++)
		{
			for(int x = 1; x < GRID_DISTANCE_LIMIT; x++)
			{
				if(_g_distanceMap[y][x] == 0)
				{
					if(_g_distanceMap[y][x + 1])
					{
						_g_distanceMap[y][x] = _g_distanceMap[y][x + 1];
					}
					else
					{
						_g_distanceMap[y][x] = GRID_DISTANCE_LIMIT;
					}
				}
			}
		}
	}
};
_InitGridGraphics _g_initGridGraphics;

inline int GridDistance(int x1, int y1, int x2, int y2)
{
	int x = x2 - x1;
	if(x < 0) x = -x;
	int y = y2 - y1;
	if(y < 0) y = -y;
	if(x >= GRID_DISTANCE_LIMIT || y >= GRID_DISTANCE_LIMIT)
	{
		return GRID_DISTANCE_LIMIT;
	}
	return _g_distanceMap[y][x];
}

int CGridCrescent::Crescent(int x0, int y0, int x1, int y1, int radius)
{
	m_x1 = x1; m_y1 = y1;
	Disk(x0, y0, radius);
	//...
	return 0;
}

int CGridCrescent::CirclePoints(int x, int y, int begin)
{
	if(begin)
	{
		if(ScanLine(m_x0 - x, m_x0 + x, m_y0 - y))
		{
			return 1;
		}
		if(y != 0)
		{
			if(ScanLine(m_x0 - x, m_x0 + x, m_y0 + y)) 
			{
				return 1;
			}
		}
	}
	if(x != y)
	{
		if(ScanLine(m_x0 - y, m_x0 + y, m_y0 - x))
		{
			return 1;
		}
		if(x != 0 && ScanLine(m_x0 - y, m_x0 + y, m_y0 + x))
		{
			return 1;
		}
	}
	return 0;
}

int CGridCrescent::ScanLine(int left, int right, int y)
{
	int x0, x1;
	int bBegin = 0;
	for(int i = left; i <= right; i++)
	{
		if(::GridDistance(i, y, m_x1, m_y1) > m_radius)
		{
			if(!bBegin)
			{
				x0 = i;
				bBegin = 1;
			}
			x1 = i;
		}
		else if(bBegin)
		{
			if(OnLine(x0, x1, y)) 
			{
				return 1;
			}
			bBegin = 0;
		}
	}
	if(bBegin && OnLine(x0, x1, y))
	{
		return 1;
	}
	return 0;
}

