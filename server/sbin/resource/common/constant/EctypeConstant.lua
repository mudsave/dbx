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
	-- 驰援虎牢关帮会副本，无需保存进度，退出副本再进会重新开始
	HulaoPass     = 6,
}

-- 副本进入类型
EctypeEnterType =
{
	-- 单人进入
	Single = 1,
	-- 组队进入
	Team   = 2,
}
