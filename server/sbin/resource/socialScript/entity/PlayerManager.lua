--[[PlayerManager.lua

	Function: The manager of player
	Author: Caesar

--]]


PlayerManager = class(nil, Singleton)
local instance


function PlayerManager:__init()
	self._roleDBID = nil
	self._playerByDBID = {}--所有在线玩家表
	self._playerByName = {}
	self._playersLoadedByDBID = {}
	self._playersLoadedByName = {}
	
	--已经加载过的群信息
    self._groupsLoadedByDBID = {}
	self._groupsLoadedByName = {}
end

function PlayerManager:addPlayer(player)
	local playerDBID = player:getDBID()
	if self._playerByDBID[playerDBID] then
		self._playerByDBID[playerDBID] = player
		self._playerByName[player:getName()] = player
	else
		self._playerByDBID[playerDBID] = player
		self._playerByName[player:getName()] = player
		self._playersLoadedByName[player:getName()] = player
		self._playersLoadedByDBID[playerDBID] = player
	end
	
end

function PlayerManager:removePlayer(playerDBID)
	local player = self._playerByDBID[playerDBID]
	if player then
		self._playerByDBID[playerDBID] = nil
		self._playerByName[player:getName()] = nil
	end
end


--得到在线Player对象
function PlayerManager:getPlayerByDBID(dbID)
	return self._playerByDBID[dbID]
end

function PlayerManager:getPlayerByName(name)
	return self._playerByName[name]
end

function PlayerManager:getOnlinePlayers()

	return self._playerByDBID
	
end


function PlayerManager:addLoadedPlayer( player )
	self._playersLoadedByDBID[player:getDBID()] = player
end

function PlayerManager:getLoadedPlayerByDBID(DBID)
	return self._playersLoadedByDBID[DBID]
end

function PlayerManager:getLoadedPlayerByName(name )
	return self._playersLoadedByName[name]
end





function PlayerManager:getLoadedGroupByDBID( groupDBID )
	return self._groupsLoadedByDBID[groupDBID]
end

function PlayerManager:getLoadedGroupByName( groupName )
	return self._groupsLoadedByName[groupName]
end

function PlayerManager:deleteLoadedGroup( groupDBID )
	self._groupsLoadedByDBID[groupDBID] = nil
end

function PlayerManager:addLoadedGroup( group )
	self._groupsLoadedByDBID[group:getDBID()] = group
	self._groupsLoadedByName[group:getName()] = group
end


function PlayerManager:setRoleDBID( roleDBID )
	self._roleDBID = roleDBID
end

function PlayerManager:getRoleDBID(  )
	return self._roleDBID
end

PlayerManager.getInstance = function()
	instance = instance or PlayerManager()
	return instance
end