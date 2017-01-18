-- common.constant.EctypeConstant.lua

-- 副本类型
EctypeType =
{
	-- 普通副本，无需保存进度，退出副本再进会重新开始
	Common        = 1,
	-- 日常副本，会保存进度到数据库
	Daily         = 2,
	-- 周常副本，会保存进度到数据库
	Weekly        = 3,
	-- 连环副本，会保存进度到数据库
	Ring          = 4,
	-- 帮会副本，无需保存进度，退出副本再进会重新开始
	Faction       = 5,
}

-- 副本进入类型
EctypeEnterType =
{
	-- 单人进入
	Single = 1,
	-- 组队进入
	Team   = 2,
}

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