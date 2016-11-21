--[[EntityManager.lua
描述：
	实体管理
--]]

EntityManager = class(nil, Singleton)

function EntityManager:__init()
	self.playerList = {}
	self.playerDBIDList = {}

	self.mineNpcList = {}
	self.npcList = {}
end

function EntityManager:__release()
	self.playerList = nil
	self.playerDBIDList = nil

	self.mineNpcList = nil
	self.npcList = nil
end

function EntityManager:addPlayer(player)
	local id = player:getID()
	local dbId = player:getDBID()
	if self.playerList[playerID] then
		print("EntityManager:addPlayer() error, id = ", playerID)
		return
	end
	self.playerList[playerID] = player
	self.playerDBIDList[dbId] = player
end

function EntityManager:removePlayer(playerID)
	if not self.playerList[playerID] then
		return
	end
	local player = self.playerList[playerID]
	local dbId = player:getDBID()
	self.playerList[playerID] = nil
	self.playerDBIDList[dbId] = nil
	release(player)
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

--添加Npc对象
function EntityManager:addNpc(npc)
	local npcID = npc:getID()
	if not self.npcList[npcID] then
		self.npcList[npcID] = npc
	end

end

--删除Npc对象
function EntityManager:removeNpc(npcID)
	if self.npcList[npcID] then
		self.npcList[npcID] = nil
	end
end

--添加Pet对象
function EntityManager:addPet(pet)
	local petID = pet:getID()
	if not self.petList[petID] then
		self.petList[petID] = pet
	end
end

--删除Pet对象
function EntityManager:removePet(petID)
	if self.petList[petID] then
		self.petList[petID] = nil
	end
end

--添加场景明雷对象
function EntityManager:addMineNpc(mineNpc)
	local mineNpcID = mineNpc:getID()
	if not self.mineNpcList[mineNpcID] then
		self.mineNpcList[mineNpcID] = mineNpc
	end
end

--删除场景明雷对象
function EntityManager:removeMineNpc(mineNpcID)
	if self.mineNpcList[mineNpcID] then
		self.mineNpcList[mineNpcID] = nil
	end
end


EntityManager.getInstance = function()
	return EntityManager()
end