--[[DekaronSchoolReward.lua
	描述：门派闯关奖励
--]]

DekaronSchoolReward = {}


local tDekaronSchoolRewardDB = 
{	
	[8001] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8002] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8003] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8004] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8005] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8006] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8007] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8008] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8009] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8010] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8011] = 
	{
		items = {
			{itemID = 3031006, weight = 10},
			{itemID = 3062101, weight = 10},
		},
	},
	[8012] = 
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
function DekaronSchoolReward.randItem(fightID)
	local maxWeight = 0
	local weightCount = 0
	local itemCofig = tDekaronSchoolRewardDB[fightID].items
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