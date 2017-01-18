--[[EquipPlayingConstant.lua
描述：
	装备玩法常量定义
]]

-- 装备改造等级上限
EquipRemouldMaxLevel = 10

--装备制作消耗折扣
EquipDiscount = 0.8

EquipMakeAddattrType = 
{
	SpellsOutput = 1,
	PhysicalOutput = 2,
	PhysicalNucleus = 3,
	HighSpeedControl = 4,
	Random = 5,
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