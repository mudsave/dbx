--[[BeastBlessRewardDB.lua
瑞兽奖励
]]
--[[
	playerExp	角色经验
	playerTao	角色道行
	subMoney	绑银
	pot			潜能
	combatNum	战绩
	
	petExp		宠物经验
	petTao		宠物道行
]]

tBeastBlessRewardDB = 
{	
	[1] = 
	{
		valueRewards =    ---基础奖励数值，搭配BeastBlessUtils.lua实现公式配置（与玩家等级有关）
		{
			playerExp = 12500,
			subMoney = 25000,
			playerTao = 15,
			pot = 2500,
			petExp = 9500,
			petTao = 17,
		},
		items =   --正常奖励状态下的高级道具奖励，在以下几种随机一样
		{
			{itemID = 1071018, weight = 10},
			{itemID = 1071040, weight = 10},
			{itemID = 3120003, weight = 10},
			{itemID = 3110143, weight = 10},
		},
		specialItem = {itemID = 3022002}, --银票、侠义奖励物品（获得5次正常奖励后只能获得侠义奖励）
	}
}