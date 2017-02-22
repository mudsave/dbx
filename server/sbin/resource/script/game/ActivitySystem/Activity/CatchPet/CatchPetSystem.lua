--[[CatchPetSystem.lua
	捕宠活动业务系统
--]]

require "game.ActivitySystem.Activity.CatchPet.CatchPet"
require "game.ActivitySystem.Activity.CatchPet.CatchPetManager"
CatchPetSystem = class(EventSetDoer, Singleton)

function CatchPetSystem:__init()
	self._doer = 
	{
		[ActivityEvent_CS_EnterPatrolFight]				= CatchPetSystem.onEnterPatrolFight,
		-- 战斗结束前移除NPC
		[FightEvents_SS_FightEnd_beforeClient]			= CatchPetSystem.onFightEndBefor,
		-- 战斗结束后活动结束切换场景
		[FightEvents_SS_FightEnd_afterClient]			= CatchPetSystem.onFightEndAfter,
	}
end

function CatchPetSystem:onEnterPatrolFight(event)
	local params = event:getParams()
	local roleID = params[1]
	local patrolNpcID = params[2]
	if not roleID then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	local patrolNpc = g_entityMgr:getPatrolNpc(patrolNpcID)
	if not patrolNpc then
		return
	end
	local catchPet = patrolNpc:getCatchPet()
	if catchPet and not patrolNpc:getOwnerID() then
		patrolNpc:setOwnerID(player:getID())
		local scriptID = patrolNpc:getScriptID()
		local fightID = self:startPatrolFight(player, scriptID)
		-- 在当前副本当中记录战斗ID 和 巡逻NPC运行ID
		catchPet:attachPatrolNpc(fightID, patrolNpcID)
		local moveHandler = patrolNpc:getHandler(HandlerDef_Move)
		moveHandler:DoStopMove()
	end
end

function CatchPetSystem:startPatrolFight(player, scriptID)
	local playerList = {}
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		if teamHandler:isLeader() then
			playerList = teamHandler:getTeamPlayerList()
		elseif teamHandler:isStepOutState() then
			table.insert(playerList,player)
		end
	else
		table.insert(playerList,player)
	end
	--加宠物
	local finalList = {}
	for k,player in ipairs(playerList) do
		table.insert(finalList,player)
		local petID = player:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			table.insert(finalList,pet)
		end
	end
	local fightID = g_fightMgr:startScriptFight(finalList, scriptID, nil, FightBussinessType.ActivityPatrol)
	return fightID
end

function CatchPetSystem:onFightEndBefor(event)
	local params = event:getParams()
	local fightEndResults = params[1]
	local scriptID = params[2]
	local fightID = params[4]
	local result = false
	-- 判断玩家战斗或者胜利
	for playerID,isWin in pairs(fightEndResults) do
		result = isWin
		break
	end
	g_catchPetMgr:onFightEndBefor(fightID, result, fightEndResults)
end

-- 战斗结束后，判断活动是否关闭，如果关闭，在传送玩家
function CatchPetSystem:onFightEndAfter(event)
	local params = event:getParams()
	local fightEndResults = params[1]
	local scriptID = params[2]
	local fightID = params[4]
	local result = false
	
	g_catchPetMgr:onFightEndAfter(fightID, result, fightEndResults)
end

function CatchPetSystem.getInstance()
	return CatchPetSystem()
end

EventManager.getInstance():addEventListener(CatchPetSystem.getInstance())
