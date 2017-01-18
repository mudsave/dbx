--[[TreasureUtils.lua

]]

TreasureUtils = {}

-- 随机事件库 得到其中的一个事件种类 [1] ID [2]权重值 得到[1]
function TreasureUtils.randTreasureEvent(tTriggerEvent)
	-- 计算最大权重
	local maxWeight = 0
	print(toString(tTriggerEvent))
	for _,event in pairs(tTriggerEvent) do
		--print("event.Weight",toString(event.Weight))
		maxWeight =	maxWeight + event.Weight
	end
	local eventWeight = math.random(maxWeight)
	-- 触发的事件选择  
	local weightCount = 0
	for _,event in pairs(tTriggerEvent) do
		weightCount = weightCount +  event.Weight
		if  eventWeight <= weightCount then
			print("event表",toString(event))
			return event
		end
	end
	print("Treasure Eorr Event Trigger")
end

-- 随机事件库 得到其中的一个事件种类  每个权重的值都一样
function TreasureUtils.randTreasureEventEx(tTriggerEvent)
	-- 计算最大权重
	local maxWeight = 0
	for _,event in pairs(tTriggerEvent) do
		maxWeight =	maxWeight + 100
	end
	local eventWeight = math.random(maxWeight)
	 -- 触发的事件选择  
	local weightCount = 0
	for _,event in pairs(tTriggerEvent) do
		weightCount = weightCount + 100
		if  eventWeight <= weightCount then
			return event
		end
	end
	print("Treasure Eorr Event Trigger")
end

-- 取范围中的值
function TreasureUtils.rangeTreasureValue(tValue)
	local value = math.random(tValue.MinValue,tValue.MaxValue)
	--local value = math.rand(tValue.MinValue,tValue.MaxValue)
	value = math.floor(value)
	return value
end

-- 随机产生一个 1 或 -1 的数
function TreasureUtils.RandSign()
	local range = 10000
	local randiSign = math.random(range)
	local randiSign = randiSign > range/2 and 1 or -1
	return randiSign
end

-- 随机产生一个附近可用的坐标
function TreasureUtils.RandNearPosition(mapID,curPosX,curPosY,posionRange)
	print("curPosX,curPosY",curPosX,curPosY)
	local xChange = 0
	local changeSucc = false
	local xPos = curPosX
	local yPos = curPosY
	local nearPosX = curPosX
	local nearPosY = curPosY
	repeat
		-- 50次
		xChange = xChange + 1
		if xChange > 50 then
			print(xChange)
			changeSucc = true
			break
		end
		-- 随机一个 -1 和 1 的数
		local dirX = TreasureUtils.RandSign()
		local dirY = TreasureUtils.RandSign()
		-- 在范围里随机一个值 计算在范围附近的值
		local xRand = math.random(posionRange)*dirX
		local yRand = math.random(posionRange)*dirY
		
		-- 取整
		xRand = math.floor(xRand)
		yRand = math.floor(yRand)
		
		nearPosX = curPosX + xRand*dirX 
		nearPosY = curPosY + yRand*dirY
		print("nearPosX,nearPosY",nearPosX,nearPosY)
		-- 循环50次	
	until not (g_sceneMgr:isPosValidate(mapID,nearPosX,nearPosY))
	
	if changeSucc then
		nearPosX = xPos
		nearPosY = yPos
	end
	
	return nearPosX,nearPosY
end

-- 判断是否在方形区域里
-- 只要判断该点的横坐标和纵坐标是否夹在矩形的左右边和上下边之间
function TreasureUtils.positionInRange(srcPosX,srcPosY,curPosX,curPosY,range)
	-- 计算出四个值
	local maxPosX = srcPosX + range
	local minPosX = srcPosX - range
	local maxPosY = srcPosY + range
	local minPosY = srcPosY - range
	if maxPosX > curPosX and maxPosY > curPosY 
	and minPosX < curPosX and minPosY < curPosY then
		return true
	end
	return false
end

-- 根据等级限制 生成新的随机 表
function TreasureUtils.RandNewTableByLevelLimit(target,resTable)
	local newTable = {}
	local curLevel = target:getLevel()
	for _,event in pairs(resTable) do
		if curLevel >= event.limitLevel then
			table.insert(newTable,event)
		end
	end
	return newTable
end

function TreasureUtils.RandNewTableByLevelLimitEx(target,floatLvl,resTable)
	local newTable = {}	
	local curLevel = target:getLevel()
	local minLvl = curLevel - floatLvl
	local MaxLvl = curLevel + floatLvl
	for _,event in pairs(resTable) do
		if MaxLvl >= event.limitLevel and minLvl <= event.limitLevel then
			table.insert(newTable,event)
		end
	end
	return newTable
end

