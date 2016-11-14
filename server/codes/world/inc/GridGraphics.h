// 
#ifndef __GRID_GRAPHICS_H_
#define __GRID_GRAPHICS_H_

// 线段
class CGridLine
{
public:
	virtual ~CGridLine(){}
	// 枚举线段上的点
	int Line(int x0, int y0, int x1, int y1);
protected:
	// 找到一个点
	virtual int OnPoint(int x, int y) = 0;
	// 返回非0中断枚举
};
// 圆环
class CGridCircle
{
public:
	virtual ~CGridCircle(){}
	// 枚举圆上的点
	int Circle(int x0, int y0, int radius);
protected:
	virtual int OnPoint(int x, int y) = 0;
	int m_x0;
	int m_y0;
	int m_radius;
private:
	int CirclePoints(int x, int y);
};
// 圆面
class CGridDisk
{
public:
	virtual ~CGridDisk(){}
	int Disk(int x0, int y0, int radius);
protected:
	// 扫描线
	virtual int OnLine(int x1, int x2, int y) = 0;
	virtual int CirclePoints(int x, int y, int begin);
	int m_x0;
	int m_y0;
	int m_radius;
};
// 月牙形
class CGridCrescent : public CGridDisk
{
public:
	virtual ~CGridCrescent(){}
	int Crescent(int x0, int y0, int x1, int y1, int radius);
protected:
	virtual int CirclePoints(int x, int y, int begin);
	int m_x1;
	int m_y1;
private:
	int ScanLine(int left, int right, int y);
};

#define GRID_DISTANCE_LIMIT	512	// 可正确计算的距离极大值

// 通过查表得到两网格之间的距离，若实际距离>=可计算极大值则返回 GRID_DISTANCE_LIMIT
int GridDistance(int x1, int y1, int x2, int y2);

#endif // ndef __GRID_GRAPHICS_H_
