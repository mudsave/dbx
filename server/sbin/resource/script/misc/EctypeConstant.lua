--[[EctypeConstant.lua
描述：
	副本系统常量定义
]]

-- 副本地图起始ID，从一万开始，跟静态地图ID分开
EctypeMap_StartID = 10000

-- 连环副本最大环数
RingEctype_MaxRingNum = 4

-- 副本积分
EctypeIntegral =
{
	-- 物件
	Object		= 3,
	Patrol		= 2,
	Effect		= 1,
}

-- 帮会副本奖励
FactionEctypeReward = 
{
	[1] = {0, 12},
	[2] = {13, 24},
	[3] = {25, 36},
	[4] = {36, 100},
}

RescueHulaoPassTime =
{
	[10] = {0, 4},
	[20] = {5, 6},
	[30] = {7, 8},
	[100] = {9, 10},
}