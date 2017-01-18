--[[EntityConstant.lua
描述：
	实体相关常量
--]]


--玩家最大等级
MaxPlayerLevel = 70
--玩家最大杀气值
PlayerMaxKill = 15
-- 最大钱、金银元宝数
MaxMoneyAndGoldCoin = 999999999
-- 玩家最大活力值
MaxPlayerTiredness =  100
-- 实体相性类型

-- NPC头顶功能标识
NpcFuncFlag =
{
	[1] = "set:UNLLook animation:BangHui",
	[2] = "set:UNLLook animation:BiaoJu",
	[3] = "set:UNLLook animation:CangKu",
	[4] = "set:UNLLook animation:ChuanSong",
	[5] = "set:UNLLook animation:FangJu",
	[6] = "set:UNLLook animation:JiaYuan",
	[7] = "set:UNLLook animation:JiYi",
	[8] = "set:UNLLook animation:KeZhan",
	[9] = "set:UNLLook animation:LeiTai",
	[10] = "set:UNLLook animation:ShiPing",
	[11] = "set:UNLLook animation:ShiTu",
	[12] = "set:UNLLook animation:Zhandou",
	[13] = "set:UNLLook animation:WuQi",
	[14] = "set:UNLLook animation:YaoDian",
	[15] = "set:UNLLook animation:ZaHuo",
}

-- 方向
Direction =
{
	EastSouth = 0,  -- 东南
	East      = 1,  -- 东
	EastNorth = 2,  -- 东北
	North     = 3,  -- 北
	WestNorth = 4,  -- 西北
	West      = 5,  -- 西
	WestSouth = 6,  -- 西南
	South     = 7,  -- 南
}

MineNpcType = 
{
	ConfigPath = 1,	--配置固定路径
	RandPath = 2,	--随机路径
}

GoodsNpcType = 
{
	ConfigType = 1,	--配置固定路径
}
