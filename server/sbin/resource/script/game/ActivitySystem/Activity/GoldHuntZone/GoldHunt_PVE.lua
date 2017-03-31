--[[GoldHunt_PVE.lua
描述：
	猎金场活动目标杀怪(活动系统)
--]]

GoldHunt_PVE = class(ActivityTarget)

function GoldHunt_PVE:__init(param)
	
	self._targetID = nil
	--self._param = param
	--self:addWatcher("onScriptDone")
end

function GoldHunt_PK:setTargetID(monsterDBID)
		self._targetID = monsterDBID
end

function GoldHunt_PK:getTargetID()
		return self._targetID
end


function GoldHunt_PVE:onMonsterKilled(DBIDs)
	local score = 0
	for _,DBID in pairs(DBIDs) do
		score = score + (GoldHuntZone_MonsterReward[DBID] or 0)
	end
	--
	local player = self._entity
	local handler = player:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	local data = handler:getPriData(activityID)
	local curScore = data.curScore
	curScore = curScore + score

	--结算
	local count = #GoldHuntZoneIconValue
	local maxScore = GoldHuntZoneIconValue[count][1]
	if curScore > maxScore then
		curScore = maxScore
	end
	data.curScore = curScore
	g_goldHuntMgr:setIconValue(player, curScore)
	g_goldHuntMgr:informClientScore(player)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 13,  score)
	g_eventMgr:fireRemoteEvent(event, player)
end

function GoldHunt_PVE:removeWatchers()
	--self:removeWatcher("onScriptDone")
end
