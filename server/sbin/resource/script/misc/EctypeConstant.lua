--[[EctypeConstant.lua
描述：
	副本系统常量定义
]]

-- 副本类型
EctypeType =
{
	-- 普通副本，无需保存进度，退出副本再进会重新开始
	Common = 1,
	-- 日常副本，会保存进度到数据库
	Daily  = 2,
	-- 周常副本，会保存进度到数据库
	Weekly = 3,
	-- 连环副本，会保存进度到数据库
	Ring   = 4,
}

-- 副本进入类型
EctypeEnterType =
{
	-- 单人进入
	Single = 1,
	-- 组队进入
	Team   = 2,
}

-- 副本地图起始ID，从一万开始，跟静态地图ID分开
EctypeMap_StartID = 10000

-- 连环副本最大环数
RingEctype_MaxRingNum = 4
