--[[BeastUtils.lua
描述:工具类
]]

BeastBlessUtils = {}

-- 随机NPC
function BeastBlessUtils.randNpc(tValues)
	-- print("___>",toString(tValues))
	-- 计算最大权重
	local maxWeight = 0
	local weightCount = 0
	for _,event in pairs(tValues) do
		maxWeight =	maxWeight + 100
	end
	-- print("maxWeight:",maxWeight)
	local weight = math.random(maxWeight)
	-- print("weight:",weight)
	-- 触发的事件选择  
	for _,npcID in pairs(tValues) do
		weightCount = weightCount + 100
		-- print("weightCount:",weightCount)
		if weightCount >=  weight then
			return npcID
		end
	end
	print("error -->BeastBlessUtils.randNpc ")
end

-- 随机奖励物品
function BeastBlessUtils.randItem(itemCofig)
	local maxWeight = 0
	local weightCount = 0
	-- 计算最大权重
	for _,items in pairs(itemCofig) do
		maxWeight =	maxWeight + items.weight
	end
	local weight = math.random(maxWeight)
	
	for _,items in pairs(itemCofig) do
		weightCount = weightCount + items.weight
		if weightCount >=  weight then
			return items.itemID
		end
	end
end

-- 基础值公式
function BeastBlessUtils.getPlayerBaseRewardFormula(playerLVl,value)
	return (playerLVl*10 + value)
end

function BeastBlessUtils.getPetBaseRewardFormula(playerLvl,petLvl,value)

end
-- 额外击杀指定小怪的奖励公式
-- 击杀绑银小仙时绑银
function BeastBlessUtils.getSubMoneyFormula(subMoney,value)
	return subMoney + 200 
end

-- 击杀经验小仙时经验增加
function BeastBlessUtils.getExpFormula(playerExp,value)
	return playerExp*(value*0.5)
end

-- 击杀道行小仙时道行增加
function BeastBlessUtils.getTaoFormula(playerTao,value)
	return playerTao*(value*0.5)
end

-- 同一回合内击杀多个同类型小怪公式
-- 绑银
function BeastBlessUtils.getDSubMoneyFormula(subMoney,value)
	return subMoney + 200 
end
-- 经验
function BeastBlessUtils.getDExpFormula(playerExp,value)
	return playerExp*(value*0.2)
end

-- 道行
function BeastBlessUtils.getDTaoFormula(playerTao,value)
	return playerTao*(value*0.2)
end

-- 获得物品的几率
function BeastBlessUtils.getDItemFormula(ItemValue,nValue,mValue)
	return ItemValue + nValue*5 + mValue*10
end

-- 击杀守护童子时绑银减少
function BeastBlessUtils.getDecSubMoneyFormula(subMoney,value)
	local dec = value*100
	if dec - subMoney >= 0 then
		return 0 - subMoney
	end
	return 0 - dec
end
