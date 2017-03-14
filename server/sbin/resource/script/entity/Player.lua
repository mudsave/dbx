--[[Player.lua
描述：
	玩家核心数据
--]]

Player = class(Entity, Timer)

function Player:__init(roleId, gatewayId, hClientLink, hGateLink)
	self._accountID		= nil
	self._dbId			= roleId
	self._gatewayId		= gatewayId
	self._hClientLink	= hClientLink
	self._hGateLink		= hGateLink
	self._status		= ePlayerNone
	self._fightID		= nil
	self._version		= nil
	self._isClosedInfight = false --是否是战斗中强X,配合ePlayerInactiveFight状态使用
	self:__init_basic()
	self:__init_logic()
end

function Player:__release()
	self._accountID		= nil
	self._dbId			= nil
	self._gatewayId		= nil
	self._hClientLink	= nil
	self._hGateLink		= nil
	self._status		= nil
	self._fightID		= nil
	self._version		= nil
	self._isClosedInfight = nil

	self:__release_logic()
	self:__release_basic()

end

function Player:setAccountID(id)
	self._accountID = id
end

function Player:getAccountID()
	return self._accountID 
end

function Player:getDBID()
	return self._dbId
end

function Player:getGateLink()
	return self._hGateLink
end

function Player:getClientLink()
	return self._hClientLink
end

function Player:setGateLink(link)
	self._hGateLink = link
	self._peer:setGateLink(link)
end

function Player:setClientLink(link)
	self._hClientLink = link
	self._peer:setClientLink(link)
end

function Player:setGatewayID(ID)
	self._gatewayId = ID
	self._peer:setGatewayID(gatewayId)	
end

function Player:getGatewayID()
	return self._gatewayId 
end

function Player:setFightServerID(fightID)
	self._fightID = fightID
end

function Player:getFightServerID()
	return self._fightID
end

function Player:setIsFightClose(isClose)
	self._isClosedInfight = isClose
end

function Player:getIsFightClose()
	return self._isClosedInfight
end

function Player:setVersion(version)
	self._version = version
end

function Player:getVersion()
	return self._version
end

require "entity.PlayerBasic"
require "entity.PlayerLogic"
