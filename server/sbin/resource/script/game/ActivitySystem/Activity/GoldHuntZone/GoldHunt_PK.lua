--[[GoldHunt_PK.lua
描述：
	猎金场活动目标PK(活动系统)
--]]

GoldHunt_PK = class(ActivityTarget)

function GoldHunt_PK:__init(param)
	
		self._targetID = nil
	--self._param = param
	--self:addWatcher("onScriptDone")
end

function GoldHunt_PK:setTargetID(playerID)
		self._targetID = playerID
end

function GoldHunt_PK:getTargetID()
		return self._targetID
end

function GoldHunt_PK:onPKDone(winner,loser, targetID)
	local handler1 = winner:getHandler(HandlerDef_Activity)
	local activityID1 = handler1:getGoldHuntData().ID
	local data1 = handler:getPriData(activityID1)
	local curScore1 = data1.curScore

	local handler2 = loser:getHandler(HandlerDef_Activity)
	local activityID2 = handler2:getGoldHuntData().ID
	local data2 = handler:getPriData(activityID2)
	local curScore2 = data2.curScore

	local rand = math.random(GoldHuntZone_PK_punish.percent[1], GoldHuntZone_PK_punish.percent[2])
	local reward = math.floor(curScore2*(rand/100))
	--如果胜方是防守方
	if winner:getID() == targetID then
		reward = reward * 2
	end
	--胜方结算
	local count = #GoldHuntZoneIconValue
	local maxScore = GoldHuntZoneIconValue[count][1]
	curScore1 = curScore1 + reward
	if curScore1 > maxScore then
		curScore1 = maxScore
	end
	data1.curScore = curScore1
	g_goldHuntMgr:setIconValue(winner, curScore1)
	--输方结算
	curScore2 = curScore2 - reward
	if curScore2 < 0 then
		curScore2 = 0
	end
	data2.curScore = curScore2
	g_goldHuntMgr:setIconValue(loser, curScore2)
	g_goldHuntMgr:informClientScore(winner)
	g_goldHuntMgr:informClientScore(loser)

end

function GoldHunt_PK:removeWatchers()
	--self:removeWatcher("onScriptDone")
end
