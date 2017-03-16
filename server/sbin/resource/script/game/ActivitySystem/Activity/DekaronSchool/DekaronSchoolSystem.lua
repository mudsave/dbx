--[[DekaronSchoolSystem.lua
门派闯关系统
]]

DekaronSchoolSystem = class(EventSetDoer, Singleton)

function DekaronSchoolSystem:__init()
	self._doer = 
	{
		[FightEvents_SS_FightEnd_afterClient]	= DekaronSchoolSystem.onFightEnd,
	}
end

-- 这里是门派闯关战斗结束
function DekaronSchoolSystem:onFightEnd(event)
	local params			= event:getParams()
	local fightEndResults	= params[1]	--战斗结果
	local scriptID			= params[2]	--脚本ID
	local monsterDBIDs		= params[3]	--怪物信息
	local fightID			= params[4]	--战斗ID
	local fightInfo			= params[5]	--战斗信息
	local bWin = false
	local player = nil
	-- 如果没有这个配置
	local ScriptFightInfo = ScriptFightDB[scriptID]
	if not ScriptFightInfo then
		return
	end
	for playerID,isWin in pairs(fightEndResults) do
		bWin = isWin
		player = g_entityMgr:getPlayerByID(playerID)
		if instanceof(player,Player) then
			break
		end
	end
	if player then
		local teamHandler = player:getHandler(HandlerDef_Team)
		local teamID = teamHandler:getTeamID()
		local team = g_teamMgr:getTeam(teamID)
		if team then
			local activityTarget = team:getDekaronActivityTarget()
			if activityTarget then
				local rewardID = ScriptFightInfo.LuckyRewardID
				activityTarget:onScriptDone(scriptID,bWin,monsterDBIDs,rewardID)
			end
		end
	end
end


function DekaronSchoolSystem.getInstance()
	return DekaronSchoolSystem()
end

EventManager.getInstance():addEventListener(DekaronSchoolSystem.getInstance())