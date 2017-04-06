--[[PlayerFactory.lua

	Function: The factory of creating player
	Author: Caesar

--]]

require "base.base"
require "entity.Player"
require "entity.FriendHandler"
require "entity.GroupHandler"
require "entity.FactionHandler"
require "entity.HandlerDef"
require "entity.SystemSetHandler"

PlayerFactory = class(nil, Singleton)
local instance

function PlayerFactory:__init()
end

function PlayerFactory:createPlayer(info)
	local player = Player()
	player:setGatewayId(info.gateId)
	player:setClientLink(info.clientLink)
	player:setDBID(info.DBID)
	player:setName(info.name)
	player:setSchool(info.school)
	player:setLevel(info.level)
	player:setSex(info.sex)
	player:setModelID(info.modelID)
	player:setCurHeadTex(info.curHeadTex)
	player:setCurBodyTex(info.curBodyTex)
	player:setOfflineDate(info.offlineDate)
	player:setVigor(info.vigor)
	player:setID(info.roleID)
	player:addHandler(HandlerDef_Friend,FriendHandler(player))
	player:addHandler(HandlerDef_Group,GroupHandler(player))
	player:addHandler(HandlerDef_Faction,FactionHandler(player))

	player:getHandler(HandlerDef_Friend):setAutoHideChatWin(info.autoHideChatWin)
	player:getHandler(HandlerDef_Faction):setFactionMoney(info.factionMoney)
	player:getHandler(HandlerDef_Faction):setFactionHistoryMoney(info.factionHistoryMoney)
    player:getHandler(HandlerDef_Faction):initializeFactionDBID(info.factionDBID)
	player:getHandler(HandlerDef_Faction):initializeWeekContribute(info.lastWeekFactionContribute,info.thisWeekFactionContribute,info.offlineDate)
	player:getHandler(HandlerDef_Faction):setFactionConfiguration(info.factionConfiguration)

	if time.isSameDay(player:getOfflineDate()) then
		player:getHandler(HandlerDef_Faction):setFactionContributeIntraday(info.intradayFactionContribute)
	else
		player:getHandler(HandlerDef_Faction):setFactionContributeIntraday(0)
	end

	player:addHandler(HandlerDef_SystemSet, SystemSetHandler(player))
	return player

end


PlayerFactory.getInstance = function()
	instance = instance or PlayerFactory()
	return instance
end
