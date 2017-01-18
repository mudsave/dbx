--[[TreasureConstant.lua
描述:对宝藏系统常量的定义
]]

-- 附近坐标点在宝藏坐标点的范围
TreasureNearPosionRange = 5

-- 玩家距离宝藏是多少时改变消息
--TreasureFarPlayer = 3
TreasureAroundPlayer	= 6
TreasureNearPlayer		= 5
TreasureInPlayer		= 4

TreasureItemFloatLvl = 10

-- 放置npc的时间 30分
TreasurePlaceMonsterTime = 60*30


-- 触发事件的类型
TreasureEventType = 
{
	-- 值奖励
	ValueReword	= 1,
	-- 物品奖励
	ItemReword	= 2,
	-- 怪物战斗
	MonsterFight= 3,
	-- 放出怪物
	PlaceMonster= 4,
}

TreasureRangeAboutPlayer = 
{
	Far		= 1,
	Around	= 2,
	Near	= 3,
	In		= 4,
}

TreasureTipsState = 
{
	-- 原始 没有点击过
	Original		= 1,
	-- 显示所在地图名字
	ShowMapName		= 2,
	-- 显示所在坐标
	ShowPosition	= 3,
}

TreasureClikState =
{
	FisrtClik = 1,
	ScondClik = 2,
}

-- 效果消息的类型
TreasureMessageType = 
{
	-- 普通的中央消息提示
	CentralMessages		= 1, 
	-- 广播消息
	BroadCastMessages	= 2,
	-- 二次消息 这是有放置怪物特有的
	SecondMessages		= 3,
	-- 特殊提示
	SepcialMessages		= 4,
}

TreasureSecondMessages = 
{
	[TreasureEventEffectType.AddMoney]		= 6001,
	[TreasureEventEffectType.AddExp]		= 6002,
	[TreasureEventEffectType.AddTao]		= 6003,
	[TreasureEventEffectType.AddPot]		= 6004,
	[TreasureEventEffectType.AddItem]		= 6005,
}

-- 中央消息提示
TreasureMessages = 
{
	[TreasureEventEffectType.AddMoney]		= {1001},
	[TreasureEventEffectType.AddExp]		= {1002},
	[TreasureEventEffectType.AddTao]		= {1003},
	[TreasureEventEffectType.AddPot]		= {1004},
	[TreasureEventEffectType.AddItem]		= {2001,2002,2003,2004},
	[TreasureEventEffectType.MonsterFight]	= {3001,3002,3003},
	[TreasureEventEffectType.PlaceMonster]	= {3201,3202,3303},
}

-- 
TreasurePlaceMonsterMessages = 
{
	[50000] = 3204,
	[50008] = 3203,
	[50016] = 3202,
	[50021] = 3201,
}

TreasureMonsterFight = 
{
	[40005] = 3003,
	[40006] = 3002,
	[40007] = 3001,
	
}

-- 广播消息
TreasureBroadCastMessages = 
{
	[TreasureEventEffectType.AddMoney]		= {5101},
	[TreasureEventEffectType.AddExp]		= {1002},
	[TreasureEventEffectType.AddTao]		= {1003},
	[TreasureEventEffectType.AddPot]		= {1004},
	[TreasureEventEffectType.AddItem]		= {2101,2102},
	[TreasureEventEffectType.MonsterFight]	= {3001,3002,3003},
	[TreasureEventEffectType.PlaceMonster]	= {3101,3102,3103},
} 

TreasureSpecialMessages = 
{
	[TreasureEventEffectType.AddMoney]		= {5001},
	[TreasureEventEffectType.AddExp]		= {1002},
	[TreasureEventEffectType.AddTao]		= {1003},
	[TreasureEventEffectType.AddPot]		= {1004},
	[TreasureEventEffectType.AddItem]		= {5002,5003},
	[TreasureEventEffectType.MonsterFight]	= {5004,5004,5006,5007},
	[TreasureEventEffectType.PlaceMonster]	= {5004,5004,5006,5007},
}


