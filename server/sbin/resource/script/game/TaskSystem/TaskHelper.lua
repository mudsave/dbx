--[[TaskHelper.lua
描述：
	任务帮助(任务系统)
--]]


--权重函数
function FunWeight(t)
	local index = 1
	local tempTable = {}
	local info = {}
	local sum = 0
	local tempvalue = 0
	for idx,value in pairs(t) do
		info = {idx = idx,value = value}
		tempTable[index] = info
		index = index + 1
		sum = sum + value
	end
	local curWeight = 0
	local value = math.random(sum)
	for index, info in ipairs(tempTable) do
		if value >= curWeight and value <= curWeight +  info.value then
			return info.idx
		end
		curWeight = curWeight + info.value
	end
end

-- 里面的小的再进行权重随机
function FunTaskWeight(config)
	local totalWeight = 0
	for _,info in ipairs(config) do
		totalWeight = totalWeight + (info.weight or 0)
	end
	local rand = math.random(totalWeight)
	local curWeight = 0

	for index,info in ipairs(config) do

		if rand >= curWeight and rand <= curWeight +  info.weight then
			return index
		end
		curWeight = curWeight + info.weight
	end
end

-- 等级区间
function GetLevelIndex(player, data)
	local level = player:getLevel()
	local leveIdx
	for index, section in pairs(data) do
		if level >= section[1] and level <= section[2] then
			leveIdx = index
			break
		end
	end
	return leveIdx
end

-- 环数区间
function GetRingIndex(player ,data, taskID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local curRing = taskHandler:getCurrentRing(taskID)
	for index, ringSection in pairs(data) do
		if curRing >= ringSection[1] and curRing <= ringSection[2] then
			ringIdx = index
			break
		end
	end
	return ringIdx
end