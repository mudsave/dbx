--[[GoldHuntZoneConstant.lua
描述:对猎金场常量的定义
]]

GoldHuntZone_MineReward = {			--场景物件积分
	[10026] = 10,
	[10027] = 20,
	[10028] = 30,
	[10029] = 40,
	[10030] = 50,
}

GoldHuntZone_MonsterReward = {			--守卫怪物积分
	[39052] = 50,
	[39053] = 100,
	
}
GoldHuntZoneIconValue = {--[score]=value	--积分不同图标不同
	{600, 1},
	{1000 , 2},
	{1500 , 3},
	{2000 , 4},
}
GoldHuntZone_PK_punish ={			--资源损失数量范围40%-60%
	percent = {40,60},
	attackPunish = 2,			--发起pk放资源损失2倍
}
GoldHuntZone_PKed_limit = 3			--pk上限后进入保护
GoldHuntZone_Protected_iconValue = 0
GoldHuntZone_mine_protect_limit = 30		--少于30%资源不能被pk
GoldHuntZone_MineCollectLimit = {3,4}		--物件可采集次数
GoldHuntZone_MapPlayerLimit	= 300		--地图最大人数
GoldHuntZone_ReadyPeriodBeforeEnd = 3--min
GoldHuntZone_RankLimit	= 100
GoldHuntZone_ClientRankLimit	= 5
GoldHuntZone_Reward = {				--排名奖励分段
	{rank=3,exp = 10,money = 10,tao = 10},
	{rank=10,exp = 8,money = 8,tao = 8},
	{rank=50,exp = 6,money = 6,tao = 6},
	{rank=100,exp = 4,money = 4,tao = 4},
	{exp = 2,money = 2,tao = 2},
}
--GoldHuntZone_scoreNpcID = 39053


