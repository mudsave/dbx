--[[EntityFactory.lua
描述：
	实体工厂
--]]

EntityFactory = class(nil, Singleton)

function EntityFactory:__init()
end

function EntityFactory:createPlayer(roleId, gatewayId, hClientLink, hGateLink)
	local player = Player(roleId, gatewayId, hClientLink, hGateLink)
	return player
end

EntityFactory.getInstance = function()
	return EntityFactory()
end