--[[BuffSystem.lua
描述：
	玩家buff系统
--]]

require "game.BuffSystem.BuffManager"
require "game.BuffSystem.Buff"

BuffSystem = class(EventSetDoer, Singleton)

function BuffSystem:__init()
	self._doer = {
		[BuffEvents_CS_CancelBuff]				= BuffSystem.onCancelBuff,
		[FightEvents_SS_FightEnd_afterClient]	= BuffSystem.onFightEnd,
	}
end

function BuffSystem:onCancelBuff(event)
	local params = event:getParams()
	local playerID = params[1]
	local buffID = params[2]
	local player = g_entityMgr:getPlayerByID(playerID)
	g_buffMgr:cancelBuff(player, buffID)
end

-- 战斗结束
function BuffSystem:onFightEnd(event)
	local params = event:getParams()
	local fightEndResults = params[1]
	for playerID, fightResult in pairs(fightEndResults) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			g_buffMgr:onFightEnd(player)
		end
		local pet = g_entityMgr:getPet(playerID)
		if pet then
			g_buffMgr:onFightEnd(pet)
		end
	end
end


function BuffSystem.getInstance()
	return BuffSystem()
end

EventManager.getInstance():addEventListener(BuffSystem.getInstance())
