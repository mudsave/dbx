--[[EquipPlayingConstant.lua
描述：
	装备玩法常量定义
]]

-- 装备玩法类型
EquipPlaying =
{
	-- 装备制作
	EquipMake      = 1,
	-- 装备拆解
	EquipAnalyse   = 2,
	-- 装备改造
	EquipRemould   = 3,
	-- 装备属性重置
	AttrReset      = 4,
	-- 装备属性强化
	AttrImprove    = 5,
	-- 装备炼化
	EquipRefining  = 6,
	-- 饰品制作
	AdornMake      = 7,
	-- 饰品合成
	AdornSynthetic = 8,
}

-- 装备改造等级上限
EquipRemouldMaxLevel = 10

--装备制作消耗折扣
EquipDiscount = 0.8

--装备改造与回退
EquipRemouldType = 
{
	remould = 1,
	rollBack = 2,
}

--装备改造属性颜色
EquipRemouldColour = 
{
	null = 0,
	White = 1,
	Blue = 2,
	Pink = 3,
	Gold = 4,
	Green = 5,
}

EquipMakeAddattrType = 
{
	SpellsOutput = 1,
	PhysicalOutput = 2,
	PhysicalNucleus = 3,
	HighSpeedControl = 4,
	Random = 5,
}

EquipRefiningphase = 
{
	win_phase = 1,
	thu_phase = 2,
	ice_phase = 3,
	soi_phase = 4,
	fir_phase = 5,
	poi_phase = 6,
}

--套装件数
Suit = {
	twoPieceSuit	= 2,
	fourPieceSuit	= 4,
	sixPieceSuit	= 6,
}

--装备属性颜色
EquipAttrColor = {
	-- 蓝
	Blue   = 1,
	-- 粉
	Pink = 2,
	-- 金
	Gold   = 3,
	-- 绿
	Green  = 4,
}

--装备属性位置对于属性颜色
AttrPositionToColor =
{
	[1] = EquipAttrColor.Blue,
	[2] = EquipAttrColor.Blue,
	[3] = EquipAttrColor.Blue,
	[4] = EquipAttrColor.Pink,
	[5] = EquipAttrColor.Gold,
	[6] = EquipAttrColor.Green,
}