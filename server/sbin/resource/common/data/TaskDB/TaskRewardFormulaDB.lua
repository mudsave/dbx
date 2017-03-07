--[[TaskRewardFormula.lua
	循环任务公式奖励配置
--]]
-- 师门任务公式奖励
MasterRewardFormula = {}
--经验
function MasterRewardFormula.addXp(curRing, level)
	if level >= 1 and level <= 39 then
		return math.floor(((curRing - 5)*100 + 500)*(level - 10)*0.5)
	elseif level >= 40 and level <= 59 then
		return math.floor(((curRing - 5)*100 + 500)*(level - 8)*0.7)
	elseif level >= 60 and level <= 150 then
		return math.floor(((curRing - 5)*100 + 500)*(level - 8)*0.7)
	end
end

-- 道行
function MasterRewardFormula.addTao(curRing, level)
	if level >= 1 and level <= 39 then
		return math.floor(2*curRing*(level - 19)*0.7)
	elseif level >= 40 and level <= 59 then
		return math.floor(5*curRing*(level - 39)*0.8)
	elseif level >= 60 and level <= 150 then
		return math.floor(5*curRing*(level - 39)*0.8)
	end
end

-- 潜能
function MasterRewardFormula.addPot(curRing, level)
	if level >= 1 and level <= 39 then
		return math.floor((curRing + 50)*(level - 19)*70)
	elseif level >= 40 and level <= 59 then
		return math.floor((curRing + 80)*(level - 39)*120)
	elseif level >= 60 and level <= 150 then
		return math.floor((curRing + 80)*(level - 39)*120)
	end
end

-- 绑银
function MasterRewardFormula.addSubMoney(curRing, level)
	if level >= 1 and level <= 39 then
		return math.floor(500*curRing*(level - 19))
	elseif level >= 40 and level <= 59 then
		return math.floor(800*curRing*(level - 39))
	elseif level >= 60 and level <= 150 then
		return math.floor(800*curRing*(level - 39))
	end
end

-- 试炼任务奖励公式
TrialRewardFormula = {}
-- 经验
function TrialRewardFormula.addXp(curRing, level)
	if level >= 1 and level <= 59 then
		return math.floor(((curRing - 100)*30 + (level - 20)*curRing)*0.5 + 2000)
	elseif level >= 60 and level <= 79 then
		return math.floor(((curRing - 100)*30 + (level - 20)*curRing)*0.5 + 2000)
	elseif level >= 80 and level <= 150 then
		return math.floor(((curRing - 100)*30 + (level - 20)*curRing)*0.5 + 2000)
	end
end

-- 道行
function TrialRewardFormula.addTao(curRing, level)
	if level >= 1 and level <= 59 then
		return math.floor((curRing + 5)*(level - 39)*0.7)
	elseif level >= 60 and level <= 79 then
		return math.floor((curRing + 5)*(level - 39)*0.7)
	elseif level >= 80 and level <= 150 then
		return math.floor((curRing + 5)*(level - 39)*0.7)
	end
end

-- 潜能
function TrialRewardFormula.addPot(curRing, level)
	if level >= 1 and level <= 59 then
		return math.floor((curRing + 20)*(level - 39)*3)
	elseif level >= 60 and level <= 79 then
		return math.floor((curRing + 20)*(level - 39)*3)
	elseif level >= 80 and level <= 150 then
		return math.floor((curRing + 20)*(level - 39)*3)
	end
end

-- 绑银
function TrialRewardFormula.addSubMoney(curRing, level)
	if level >= 1 and level <= 59 then
		return math.floor(50*curRing*(level - 39)*0.7)
	elseif level >= 60 and level <= 79 then
		return math.floor(50*curRing*(level - 39)*0.7)
	elseif level >= 80 and level <= 150 then
		return math.floor(50*curRing*(level - 39)*0.7)
	end
end

-- 宠物经验
function TrialRewardFormula.addPetXp(curRing, level, petLevel)
	if not petLevel then
		return
	end
	if level >= 1 and level <= 59 then
		return math.floor(((curRing - 100)*30+(math.abs(level - petLevel)-5)*curRing+1000)*0.5+2000)
	elseif level >= 60 and level <= 79 then
		return math.floor(((curRing - 100)*30+(math.abs(level - petLevel)-5)*curRing+1000)*0.5+2000)
	elseif level >= 80 and level <= 150 then
		return math.floor(((curRing - 100)*30+(math.abs(level - petLevel)-5)*curRing+1000)*0.5+2000)
	end
end

-- 宠物道行
function TrialRewardFormula.addPetTao(curRing, level, petLevel)
	if not petLevel then
		return
	end
	if level >= 1 and level <= 59 then
		return math.floor(((curRing - 5)*math.abs(level - petLevel)+50)*0.6)
	elseif level >= 60 and level <= 79 then
		return math.floor(((curRing - 5)*math.abs(level - petLevel)+50)*0.6)
	elseif level >= 80 and level <= 150 then
		return math.floor(((curRing - 5)*math.abs(level - petLevel)+50)*0.6)
	end
end
--]]
-- 帮会公式奖励
FactionRewardFormula = {}

-- 道行
function FactionRewardFormula.addTao(equipLevel, equipQuality)
	return equipLevel*equipQuality
end

-- 潜能
function FactionRewardFormula.addPot(equipLevel, equipQuality)
	return equipLevel*equipQuality
end


RewardFormula = {}
function RewardFormula.addTao(curRing, level)
	return curRing * 5 + level
end

-- 通天塔任务奖励公式
BabelRewardFormula = {}

-- 经验公式
function BabelRewardFormula.addXp(level, layer)
	return (level + layer) * 10
end

-- 道行公式
function BabelRewardFormula.addTao(level, layer)
	return (level + layer) * 5
end

-- 宠物经验
function BabelRewardFormula.addPetXp(level, layer)
	return (level + layer) * 10
end

-- 宠物道行
function BabelRewardFormula.addPetTao(level, layer)
	return (level + layer) * 5
end