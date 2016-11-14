--[[EntityManager.lua
描述：
	实体管理
--]]

EntityManager = class(nil, Singleton)

function EntityManager:__init()
	self.playerList = {}
	self.playerDBIDList = {}
end

function EntityManager:__release()
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

function EntityManager:getPlayer(playerID)
	return self.playerList[playerID]
end

function EntityManager:getPlayerByDBID(playerDBID)
	return self.playerDBIDList[playerDBID]
end

function EntityManager:getPlayers()
	return self.playerList
end

EntityManager.getInstance = function()
	return EntityManager()
end