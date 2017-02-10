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
		valueRewards = {
			playerExp = 100,
			money = 120,
			subMoney = 200,
			playerTao = 200,
			combatNum = 200,
			pot = 300,
			petExp = 300,
			petTao = 300,
		},
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
		specialItem = {itemID = 3062101}, --侠义奖励物品
	}
}