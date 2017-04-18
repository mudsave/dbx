--[[SkyFallBoxUtils.lua
	天降宝盒相关设定
--]]

--战斗胜利后获得宝盒的概率
rewardProbability = 45
--活动所能获得宝盒的上限
rewardBoxLimit = 50
--能参与活动的等级限制
roleLevelLimit = 10

SkyFallBoxUtils = {}

-- 经验
function SkyFallBoxUtils.getExpForLevel(itemLevel)
	return itemLevel * 3 + 10

end

-- 道行
function SkyFallBoxUtils.getTaoPrizeForLevel(itemLevel)
	return itemLevel * 3 + 10

end

-- 潜能
function SkyFallBoxUtils.getPotPrizeForLevel(itemLevel)
	return itemLevel * 3 + 10

end

-- 历练
function SkyFallBoxUtils.getExpointForLevel(itemLevel)
	return itemLevel * 3 + 10

end

-- 金钱
function SkyFallBoxUtils.getMoneyForLevel(itemLevel)
	return itemLevel * 3 + 10

end

--天降宝盒所含物品种类
skyFallBoxRewardClass =
{	
	{Name = SkyFallBoxUtils.getExpForLevel, weight = 20, valueName = player_xp, msgID =2},						--经验
	{Name = SkyFallBoxUtils.getMoneyForLevel, weight = 20, valueName = 'Money', msgID =3},						--金钱
	{Name = SkyFallBoxUtils.getTaoPrizeForLevel, weight = 20, valueName = player_tao, msgID =5},				--道行
	{Name = SkyFallBoxUtils.getPotPrizeForLevel, weight = 20, valueName = player_pot, msgID =7},				--潜能
	{Name = SkyFallBoxUtils.getExpointForLevel, weight = 20, valueName = player_expoint, msgID =12},			--历练
} 