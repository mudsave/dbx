--[[Player.lua
√Ë ˆ£∫
	ÕÊº“¿‡
--]]

PlayerStatus = 
{
	ePlayerInit,
	ePlayerLoading,
	eEntityNormal
}

Player = class(Entity)

function Player:__init()
	self._dbId = nil
	self._status = ePlayerInit
end

function Player:__release()
end

function Player:setStatus()
end

function Player:getStatus()
end

function Player:setDBID(dbId)
	self._dbId = dbId
end

function Player:getDBID()
	return self._dbId
end