--[[GoldHuntZoneConstant.lua
描述:对猎金场常量的定义
]]

GoldHuntZone_MineReward = {
	[10011] = 10,
	[10012] = 20,
	[10013] = 30,
}

GoldHuntZone_MonsterReward = {
	[10001] = 10,
	
}
GoldHuntZoneIconValue = {--[score]=value
	{600, 1},
	{1000 , 2},
	{1500 , 3},
	{2000 , 4},
}
GoldHuntZone_PK_punish ={
	percent = {40,60},
	attackPunish = 2,
}
GoldHuntZone_PKed_limit = 3
GoldHuntZone_Protected_iconValue = 0
GoldHuntZone_mine_protect_limit = 30
GoldHuntZone_MineCollectLimit = {3,4}
GoldHuntZone_MapPlayerLimit	= 300
GoldHuntZone_ReadyPeriodBeforeEnd = 3--min
GoldHuntZone_RankLimit	= 100
GoldHuntZone_ClientRankLimit	= 5
GoldHuntZone_Reward = {
	{rank=3,exp = 10,money = 10,tao = 10},
	{rank=10,exp = 8,money = 8,tao = 8},
	{rank=50,exp = 6,money = 6,tao = 6},
	{rank=100,exp = 4,money = 4,tao = 4},
	{exp = 2,money = 2,tao = 2},
}
GoldHuntZone_scoreNpcID = 70004


