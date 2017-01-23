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

function BeastBlessUtils.addBeastToMap(curMapBeastList,mapID,beast)
	local curPosX = 0
	local curPosY = 0
	local reSetTime = 0
	repeat
		curPosX,curPosY	= g_sceneMgr:getRandomPosition(mapID)
		local isReset = true
		reSetTime = reSetTime + 1
		if reSetTime > 50 then
			break
		end
		-- 
		if curMapBeastList then
			for npcID,beast in pairs(curMapBeastList) do
				-- 其他的坐标
				local otherX,otherY = beast:getPos()
				if curPosX == otherX and curPosY == otherY then
					isReset = false
				end
			end
		end
	until isReset
	local scence = g_sceneMgr:getSceneByID(mapID)
	if npc then
		npcID = npc:getID()
	
		scence:attachEntity(npc,self.posX,self.posY)
		-- 加到beastmanager中
		return npcID
	else
		print("error -> addBeastToMap")
	end
end