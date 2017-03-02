--[[EntityManager.lua
描述：
	实体管理
--]]

EntityManager = class(nil, Singleton)

function EntityManager:__init()
	self.playerList		= {}
	self.playerDBIDList	= {}

	self.mineNpcList	= {}
	self.npcList		= {}
	self.petList		= {}
	self.goodsNpcList   = {}
	self.bossEntityList = {}
	self.updateList     = {}
	self.patrolNpcList	= {}
	self.playerNameList = {}
end

function EntityManager:__release()
	self.playerList = nil
	self.playerDBIDList = nil

	self.mineNpcList = nil
	self.npcList = nil
	self.bossEntityList = nil
	self.updateList = nil
	self.patrolNpcList = nil
end

function EntityManager:addPlayer(player)
	local playerID = player:getID()
	local dbId = player:getDBID()
	if self.playerList[playerID] then
		print("EntityManager:addPlayer() error, id = ", playerID)
		return
	end
	self.playerList[playerID] = player
	self.playerDBIDList[dbId] = player
	g_world:setPlayerCount(table.size(self.playerList))
end

function EntityManager:removePlayer(playerID)
	if not self.playerList[playerID] then
		return
	end
	local player = self.playerList[playerID]
	local dbId = player:getDBID()
	local playerName = player:getName()
	self.playerList[playerID] = nil
	self.playerDBIDList[dbId] = nil
	self.playerNameList[playerName] = nil
	release(player)
	g_world:setPlayerCount(table.size(self.playerList))
end

function EntityManager:setPlayerName(name,DBID)
	self.playerNameList[name] = DBID
end

--通过制定name获取player对象
function EntityManager:getPlayerByName(playerName) 
	local dbID = self.playerNameList[playerName]
	local player
	if dbID then
		player = self:getPlayerByDBID(dbID)
	end
	return player 
end

function EntityManager:getPlayerByID(playerID)
	return self.playerList[playerID]
end

function EntityManager:getPlayerByDBID(playerDBID)
	return self.playerDBIDList[playerDBID]
end

function EntityManager:getPlayers()
	return self.playerList
end

-- 添加Npc对象
function EntityManager:addNpc(npc)
	local npcList	= self.npcList
	local npcID		= npc and npc:getID()

	if npcID and not npcList[npcID] then
		npcList[npcID] = npc
	else
		-- local un = npcID and print(("Npc %s 重复添加"):format(npcID))
	end
end

-- 删除Npc对象
function EntityManager:removeNpc(npcID)
	local npcList	= self.npcList
	local npc		= npcID and npcList[npcID]

	if npc then
		release(npc)
		npcList[npcID] = nil
	end
end

-- 获取npc对象
function EntityManager:getNpc(npcID)
	return self.npcList[npcID]
end

-- 添加Pet对象
function EntityManager:addPet(pet)
	local petList	= self.petList
	local petID		= pet and pet:getID()

	if petID and not petList[petID] then
		petList[petID] = pet
	end
end

-- 获取Pet对象
function EntityManager:getPet(petID)
	return petID and self.petList[petID]
end

-- 删除Pet对象
function EntityManager:removePet(petID)
	local petList	= self.petList
	local pet		= petID and petList[petID]

	if pet then
		release(pet)
		petList[petID] = nil
	end
end

-- 添加场景明雷对象
function EntityManager:addMineNpc(mineNpc)
	local mineNpcList	= self.mineNpcList
	local mineNpcID		= mineNpc and mineNpc:getID()

	if mineNpcID and not mineNpcList[mineNpcID] then
		mineNpcList[mineNpcID] = mineNpc
	else
		local temp = mineNpcID and print(("%s 明雷NPC重复添加"):format(mineNpcID))
	end
end

-- 删除场景明雷对象
function EntityManager:removeMineNpc(mineNpcID)
	local mineNpcList	= self.mineNpcList
	local mineNpc		= mineNpcID and mineNpcList[mineNpcID]

	if mineNpc then
		release(mineNpc)
		mineNpcList[mineNpcID] = nil
	end
end

--获取场景明雷对象
function EntityManager:getMineNpc(mineNpcID)
	return self.mineNpcList[mineNpcID]	
end

--添加场景物件对象
function EntityManager:addGoodsNpc(goodsNpc)
	local goodsNpcID = goodsNpc:getID()
	if self.goodsNpcList[goodsNpcID] then
		print("goodsNpc重复添加，ID为",goodsNpcID)
	else
		self.goodsNpcList[goodsNpcID] = goodsNpc
	end
end

--删除场景物件实体对象
function EntityManager:removeGoodsNpc(goodsNpcID)
	if self.goodsNpcList[goodsNpcID] then
		release(self.goodsNpcList[goodsNpcID])
		self.goodsNpcList[goodsNpcID] = nil
	else
		print("当前物件已删除 ，ID为",goodsNpcID)
	end
end

--获取场景对象
function EntityManager:getGoodsNpc(goodsNpcID)
	return self.goodsNpcList[goodsNpcID]	
end

--添加全局boss,此实体绑定了玩家
function EntityManager:addBossTaskEntity(dbID, taskID, boss)
	if not self.bossEntityList[dbID] then
		self.bossEntityList[dbID] = {}
	end
	self.bossEntityList[dbID][taskID] = boss
end

function EntityManager:removeBossTaskEntityByID(dbID, taskID)
	self.bossEntityList[dbID][taskID] = nil
end

function EntityManager:getBossTaskEntityByID(dbID, taskID)
	if not self.bossEntityList[dbID] then
		return
	end
	return self.bossEntityList[dbID][taskID]
end

function EntityManager:addPatrolNpc(patrolNpc)
	local patrolNpcList = self.patrolNpcList
	local npcID = patrolNpc and patrolNpc:getID()

	if npcID and not patrolNpcList[npcID] then
		patrolNpcList[npcID] = patrolNpc
	else
		-- local un = npcID and print(("Npc %s 重复添加"):format(npcID))
	end
end

function EntityManager:getPatrolNpc(patrolNpcID)
	return self.patrolNpcList[patrolNpcID]
end

function EntityManager:removePatrolNpc(patrolNpcID)
	local patrolNpcList = self.patrolNpcList
	local patrolNpc = patrolNpcID and patrolNpcList[patrolNpcID]

	if patrolNpc then
		release(patrolNpc)
		patrolNpcList[patrolNpcID] = nil
	end
end

--添加更新实体
function EntityManager:addUpdateEntity(entity)
	table.insert(self.updateList, entity)
end

--移除更新实体
function EntityManager:removeUpdateEntity(entity)
	for index, tarEntity in pairs(self.updateList) do
		if tarEntity == entity then
			self.updateList[index] = nil
			break
		end
	end
end

--更新实体刷新
function EntityManager:minUpdate(currentTime)
	local removeList = {}
	for index, entity in pairs(self.updateList) do
		if currentTime > entity:getDetachTime() then
			local scene = entity:getScene()
			scene:detachEntity(entity)
			release(entity)
			table.insert(removeList, index)
		end
	end
	for _, index in pairs(removeList) do
		self.updateList[index] = nil
	end
end

EntityManager.getInstance = function()
	return EntityManager()
end

g_periodChecker:addUpdateListener(EntityManager.getInstance())
