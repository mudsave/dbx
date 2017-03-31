--[[GoldHunt_Collect.lua
描述：
	猎金场活动目标采矿(活动系统)
--]]

GoldHunt_Collect = class(ActivityTarget)

function GoldHunt_Collect:__init(param)
	
	self._targetID = nil
	--self._param = param
	--self:addWatcher("onScriptDone")
end

function GoldHunt_Collect:setTargetID(itemID)
		self._targetID = itemID
end

function GoldHunt_Collect:getTargetID()
		return self._targetID
end


function GoldHunt_Collect:onCollectDone(mineConfigID)
	local player = self._entity
	local handler = player:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	local data = handler:getPriData(activityID)
	local curScore = data.curScore
	local addedScore = GoldHuntZone_MineReward[mineConfigID]
	data.curScore = curScore + addedScore
	g_goldHuntMgr:setIconValue(player, data.curScore)
	g_goldHuntMgr:informClientScore(player)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 14, mineConfigID ,addedScore)
	g_eventMgr:fireRemoteEvent(event, player)
end

function GoldHunt_Collect:removeWatchers()
	--self:removeWatcher("onScriptDone")
end
