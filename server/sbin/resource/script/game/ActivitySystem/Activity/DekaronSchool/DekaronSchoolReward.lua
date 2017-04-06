--[[DekaronSchoolReward.lua
	描述：门派闯关奖励
--]]

DekaronSchoolReward = {}


local tDekaronSchoolRewardDB = 
{	
	[8021] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8022] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8023] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8024] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8025] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8026] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8031] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8032] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8033] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8034] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8035] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8036] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8041] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8042] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8043] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8044] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8045] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8046] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8051] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8052] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8053] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8054] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8055] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8056] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8061] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8062] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8063] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8064] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8065] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8066] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8071] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8072] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8073] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8074] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8075] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
	[8076] = 
	{
		items = {
			{itemID = 1021004, weight = 10},
			{itemID = 1021005, weight = 10},
		},
	},
}

--闯关门派怪物对应积分
schoolActivityIntegralDB =
{	--[怪物ID] = 门派闯关积分
	[50060] = 5,
	[50061] = 1,
	[50062] = 1,
	[50063] = 2,
	[50064] = 2,
	[50065] = 3,
	[50066] = 3,
	[50067] = 5,

	[50070] = 5,
	[50071] = 1,
	[50072] = 1,
	[50073] = 2,
	[50074] = 2,
	[50075] = 3,
	[50076] = 3,
	[50077] = 5,

	[50080] = 5,
	[50081] = 1,
	[50082] = 1,
	[50083] = 2,
	[50084] = 2,
	[50085] = 3,
	[50086] = 3,
	[50087] = 5,

	[50090] = 5,
	[50091] = 1,
	[50092] = 1,
	[50093] = 2,
	[50094] = 2,
	[50095] = 3,
	[50096] = 3,
	[50097] = 5,

	[50100] = 5,
	[50101] = 1,
	[50102] = 1,
	[50103] = 2,
	[50104] = 2,
	[50105] = 3,
	[50106] = 3,
	[50107] = 5,

	[50110] = 5,
	[50111] = 1,
	[50112] = 1,
	[50113] = 2,
	[50114] = 2,
	[50115] = 3,
	[50116] = 3,
	[50117] = 5,
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