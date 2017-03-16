--[[DekaronSchoolReward.lua
	描述：门派闯关奖励
--]]

DekaronSchoolReward = {}


local tDekaronSchoolRewardDB = 
{	
	[1] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[2] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[3] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[4] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[5] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
}


--闯关门派怪物对应积分
schoolActivityIntegralDB =
{	--[怪物ID] = 门派闯关积分
	[10011] = 5,
	[10012] = 10,
	[10013] = 15,
}



----------------------战斗结束的奖励---------------------------
-- 随机奖励物品
function DekaronSchoolReward.randItem(rewardID)
	local maxWeight = 0
	local weightCount = 0
	local itemCofig = tDekaronSchoolRewardDB[rewardID].items
	if itemCofig then
		for _,items in pairs(itemCofig) do
			maxWeight =	maxWeight + items.weight
		end
		--先判断是否有掉落
		if math.random(100) >= 50 then
			local weight = math.random(maxWeight)
			for _,items in pairs(itemCofig) do
				weightCount = weightCount + items.weight
				if weightCount >=  weight then
					return items.itemID
				end
			end
		end
	end
	return 
end


-- 经验
function DekaronSchoolReward.getFightExpFormula(playerLevel,teamIntegral)
	return (playerLevel - 2) * 300 + teamIntegral * 500
end

-- 道行
function DekaronSchoolReward.getFightTaoFormula(playerLevel,teamIntegral)
	return (playerLevel - 2) * 300 + teamIntegral * 500
end


--潜能
function DekaronSchoolReward.getFightPotFormula(playerLevel,teamIntegral)
	return (playerLevel - 2) * 300 + teamIntegral * 500
end


-----------------------活动结束的奖励---------------------------
-- 经验
function DekaronSchoolReward.getExpFormula(playerLevel,integral)
	return (playerLevel - 2) * 300 + integral * 500

end

-- 道行
function DekaronSchoolReward.getTaoFormula(playerLevel,integral)
	return (playerLevel - 2) * 300 + integral * 500
end