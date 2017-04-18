--[[TreasureManager.lua
描述:对宝藏的管理
]]

TreasureManager = class(Singleton, Timer)

function TreasureManager:__init()
	--	对宝藏放置放置怪物的记录
	self.placeMonsterList = {}
	-- 计算时间 开启一分钟定时器
	self.checkPMonsterTimerID = g_timerMgr:regTimer(self, 60*1000, 60*1000, "计时placeMonster")
end

function TreasureManager:addPlaceMonster(treasurePlaceMonster)
	self.placeMonsterList[treasurePlaceMonster:getID()] = treasurePlaceMonster
end

function TreasureManager:getPlaceMonster(npcID)
	return self.placeMonsterList[npcID]
end

function TreasureManager:getPlaceMonsterList()
	return self.placeMonsterList
end
-- 记录的数据是
function TreasureManager:update()
	-- 到了时间就移除
	if self.placeMonsterList then
		for _,placeMonster in pairs(self.placeMonsterList) do
			if placeMonster:updateTime() < 0 then
				-- 移除放置的怪的对象
				self.placeMonsterList[treasurePlaceMonster:getID()] = nil
				release(placeMonster)
			end
		end
	end
end

function TreasureManager:removePlaceMoster(npcID)
	local treasurePlaceMonster = self.placeMonsterList[npcID]
	if treasurePlaceMonster then
		treasurePlaceMonster:removeNpc()
		self.placeMonsterList[npcID] = nil
		release(placeMonster)
	end
end

function TreasureManager:createTreasure(player,treasureID,guid)

	local treasureHandler = player:getHandler(HandlerDef_Treasure)
	local isTrue,treasure = treasureHandler:findTreasure(guid)
	if isTrue then
		-- print("已经有了宝藏")
		return false
	end
	-- print("$ $"..player:getID().."有了一个"..treasureID.."宝藏,唯一值:"..guid)
	local treasure= Treasure(player,treasureID)
	
	-- 创建成功
	if not treasure then
		return 
	end
	-- 设置宝藏和物品的联系点
	treasure:setGuid(guid)
	-- 随机生成宝藏地图的位置
	treasure:generateRandMapData()
	-- 改变物品提示
	-- 记录到handler的记录表
	treasureHandler:addTreasure(treasure)
	return true
end

-- 通过数据库传来的信息创建宝藏
function TreasureManager:createTreasureFromDB(player,treasuresRecord)
	if not treasuresRecord then
		return false
	end
	for _,context in pairs(treasuresRecord) do
		-- 找到对应宝藏图
		-- print("数据条-----",toString(context))
		item = g_itemMgr:getItemByPosition(player,context.containerID,context.packIndex,context.gridIndex)
		if item then
			local treasure= Treasure(player,context.treasureID)
			-- 属性的设定
			treasure:setGuid(item:getGuid())
			treasure:setMapData(context)
			-- 记录到handler的记录表
			local treasureHandler = player:getHandler(HandlerDef_Treasure)
			treasureHandler:addTreasure(treasure)
			-- 把tip的状态给客户端
			treasure:toNotifyUpdateClientInfo()
		end
	end
end

-- 存储到数据库
function TreasureManager:saveTreasureDate(player)
	local treasureHandler = player:getHandler(HandlerDef_Treasure)
	treasureHandler:saveTreasureDate()
end


function TreasureManager.getInstance()
	return TreasureManager()
end


