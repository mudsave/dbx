--[[TreasurePlaceMonster.lua
描述：为了对宝藏放置的npc的应用进行的二次的包装
]]

TreasurePlaceMonster = class()

function TreasurePlaceMonster:__init(roleDBID,tEventID)
	-- 谁放置的
	self.roleDBID = roleDBID
	-- 存在的时间
	self.times = TreasurePlaceMonsterTime
	-- npc 的ID
	self.placeNpcID = nil
	-- npc DBID
	self.placeNpcDBID = nil
	-- 正在战斗的人物 判断是否有玩家已经在进入其中战斗
	self.fightPlayer = nil
	-- 奖励事件的ID
	self.tEventID = tEventID
end

-- 奖励事件的ID
function TreasurePlaceMonster:getTEventID()
	return self.tEventID
end

function TreasurePlaceMonster:__release()
end

function TreasurePlaceMonster:getPlacePlayerDBID()
	return self.roleDBID
end

function TreasurePlaceMonster:getFightPlayer()
	return self.fightPlayer
end

function TreasurePlaceMonster:setFightPlayer(fightPlayer)
	self.fightPlayer = fightPlayer
end

function TreasurePlaceMonster:getID()
	return self.placeNpcID
end

function TreasurePlaceMonster:getDBID()
	return self.placeNpcDBID
end

function TreasurePlaceMonster:setPlaceMonsterInfo(npcInfo)
	self.placeNpcDBID = npcInfo.npcDBID
	-- 获取场景
	local scence = g_sceneMgr:getSceneByID(npcInfo.mapID)
	local placeNpc = scence:loadTreasureNpc(npcInfo)
	print("放置npc的地图是和坐标是",toString(npcInfo))
	print("动态npcID",self.placeNpcID)
	self.placeNpcID = placeNpc:getID()
	return self.placeNpcID
end

-- 时间减少为0时消失
function TreasurePlaceMonster:updateTime()
	self.times = self.times - 1
	if self.times < 0 then
		self:removeNpc()
	end
	return self.times
end

function TreasurePlaceMonster:removeNpc()
	local placeNpc =  g_entityMgr:getNpc(self.placeNpcID)
	if not placeNpc then
		print("移除宝藏npc有错误")
	end	
	local scene = placeNpc:getScene()
	scene:detachEntity(placeNpc)
	g_entityMgr:removeNpc(self.placeNpcID)
	release(placeNpc)
end
