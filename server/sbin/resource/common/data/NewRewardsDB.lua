--[[NewRewardsDB.lua
描述：
	新手在线奖励物品配置
]]

NOVICEREWARD_MAXTIMES = 10
NoviceRewardExtractionTimer =
{--秒
	180,
	350,
	600,
	1200,
	1800,
	2400,
	3000,
	3600,
	4200,
	4800,
}


NewRewardsDB = {
	[1] = {
			{materialID = 3011001 ,number = 20},
			{materialID = 3012001 ,number = 20},
			{materialID = 3024001 ,number = 10},
		},
	[2] = {
			{materialID = 1011002 ,number = 20},
			{materialID = 1012002 ,number = 20},
			{materialID = 3025003 ,number = 2},
		},
	[3] = {
			{materialID = 3013003 ,number = 1},
			{materialID = 3013004 ,number = 1},
			{materialID = 3013005 ,number = 1},
		},
	[4] = {
			{materialID = 3013003 ,number = 1},
			{materialID = 3013004 ,number = 1},
			{materialID = 3021002 ,number = 5},
		},
	[5] = {
			{materialID = 3022001 ,number = 5},
			{materialID = 3022002 ,number = 5},
			{materialID = 3023001 ,number = 5},
		},
	[6] = {
			{materialID = 3011013 ,number = 20},
			{materialID = 3012012 ,number = 20},
			{materialID = 3021013 ,number = 1},
		},
	[7] = {
			{materialID = 3024006 ,number = 1},
			{materialID = 3024008 ,number = 1},
			{materialID = 3024013 ,number = 1},
		},
	[8] = {
			{materialID = 3025005 ,number = 5},
			{materialID = 1026004 ,number = 1},
			{materialID = 1026005 ,number = 1},
		},
	[9] = {
			{materialID = 1062204 ,number = 1},
			{materialID = 1031002 ,number = 20},
			{materialID = 3031003 ,number = 1},
		},
	[10] = {
			{materialID = 3029001 ,number = 1},
			{materialID = 3027003 ,number = 1},
			{materialID = 3027004 ,number = 1},
		},
}