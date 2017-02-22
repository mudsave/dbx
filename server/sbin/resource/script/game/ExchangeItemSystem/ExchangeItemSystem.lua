--[[ExchangeItemSystem.lua
描述：
	兑换物品系统
]]

local success,errMsg = pcall(require,"game.ExchangeItemSystem.ExchangeItemManager")
if not success then
	print("syntax error",errMsg)
end


ExchangeItemSystem = class(EventSetDoer, Singleton)

function ExchangeItemSystem:__init()
	self._doer = {
		[ExchangeItemEvent_CS_doExchange] = ExchangeItemSystem.doExchange,
	}
end


function ExchangeItemSystem:doExchange(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	local tempInfo = params[1]
	local commitID = params[2]
	g_exchangeItemMgr:doExchange(player,tempInfo,commitID)
end

function ExchangeItemSystem.getInstance()
	return ExchangeItemSystem()
end

EventManager:getInstance():addEventListener(ExchangeItemSystem.getInstance())

