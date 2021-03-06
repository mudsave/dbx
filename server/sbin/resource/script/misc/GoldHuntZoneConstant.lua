--[[GoldHuntZoneConstant.lua
描述:对猎金场常量的定义
]]

GoldHuntZone_MineReward = {			--场景物件积分
	[10026] = 20,
	[10027] = 40,
	[10028] = 60,
	[10029] = 80,
	[10030] = 100,
}

GoldHuntZone_MonsterReward = {			--守卫怪物积分
	[39052] = 50,
	[39053] = 100,
	
}

GoldHuntZone_ResultsOfOre = {			--挖矿刷出来的怪设置
	[10030] = {odds = 10,type = "mo",monsters={ID = 39052,count = 1}},
	[10029] = {odds = 10,type = "or",times = 3 },
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
GoldHuntZone_MineCollectLimit = {1,2}		--物件可采集次数
GoldHuntZone_MapPlayerLimit	= 3		--地图最大人数
GoldHuntZone_ReadyPeriodBeforeEnd = 3--min
GoldHuntZone_RankLimit	= 100
GoldHuntZone_ClientRankLimit	= 5
GoldHuntZone_Reward = {				--排名奖励分段
	{rank=3,exp = 10000,money = 5000,tao = 3000},
	{rank=10,exp = 5000,money = 3000,tao = 2000},
	{rank=50,exp = 3000,money = 2000,tao = 1000},
	{rank=100,exp = 1000,money = 1000,tao = 500},
	{exp = 2,money = 500,tao = 200},
}
GoldHuntZone_scoreNpcID = 39053


