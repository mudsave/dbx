--[[FormulaReward.lua
    --奖励公式
--]]
FormulaReward = {}

--增加经验
function FormulaReward.addXp(level)
	return (level - 1)*5 + 10
end

--增加金币
function FormulaReward.addMoney(level)
	return (level - 1)*20 + 10
end

--增加绑银
function FormulaReward.addSubMoney(level)
	return (level - 1)*5 + 17
end

--增加潜能
function FormulaReward.addPot(level)
	return (level - 1)*2 + 16
end

--增加历练
function FormulaReward.addExpoint(level)
	return (level - 1)*2 + 15
end