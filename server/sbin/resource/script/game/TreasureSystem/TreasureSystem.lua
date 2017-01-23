--[[TreasureSystem.lua
描述:

]]
require "game.TreasureSystem.TreasureUtils"
require "game.TreasureSystem.Treasure"
require "game.TreasureSystem.TreasureManager"
require "game.TreasureSystem.TreasurePlaceMonster"


TreasureSystem = class(EventSetDoer, Singleton)

function TreasureSystem:__init()
	self._doer = 
	{
		[FightEvents_SS_FightEnd_afterClient]	= TreasureSystem.onFightEnd,
		[TreasureEvent_CS_SendPositionInfo]   = TreasureSystem.onGetPositionInfo,
	}
end

function TreasureSystem:onFightEnd(event)
	local params = event:getParams()
	local fightEndResults = params[1]
	local placeMonsterList = g_treasureMgr:getPlaceMonsterList()
	local bWin
	for playerID,isWin in pairs(fightEndResults) do
			bWin = isWin
			break
	end
	-- 是否是宝藏进入
	for roleID,isWin in pairs(fightEndResults) do
		for _,treasureMoster in pairs(placeMonsterList) do
			local player = treasureMoster:getFightPlayer()
			if player then 
				local playerID = player:getID()
				if playerID == roleID then
					local npcID = treasureMoster:getID()
					local npc = g_entityMgr:getNpc(npcID)
					npc:setFighting(false)
					-- 是赢 移除npc
					if bWin then
						g_treasureMgr:removePlaceMoster(npcID)
						-- 奖励释放怪的人
						local playerDBID = treasureMoster:getPlacePlayerDBID()
						local player = g_playerMgr:findPlayerByDBID(playerDBID)
						if player then
							local treasureHandler = player:getHandler(HandlerDef_Treasure)
							if treasureHandler then
								-- print("二次奖励事件")
								treasureHandler:doTriggerEventEx(treasureMoster:getTEventID(),treasureMoster:getDBID())
							end
						end
					end
					break
				end
			end
		end
	end
end


function TreasureSystem:onGetPositionInfo(event)
	local params = event:getParams()
	local playerID = event.playerID
	if not playerID then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	local tarPosition = params[1]
	local guid = params[2]
	
	local treasureHandler = player:getHandler(HandlerDef_Treasure)
	treasureHandler:setTransferPosition(guid,tarPosition)
end

function TreasureSystem.getInstance()
	return TreasureSystem()
end

EventManager.getInstance():addEventListener(TreasureSystem.getInstance())