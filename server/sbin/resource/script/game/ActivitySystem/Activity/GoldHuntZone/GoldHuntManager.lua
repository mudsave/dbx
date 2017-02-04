--[[GoldHuntManager.lua
	描述：猎金场管理
--]]

local monsterTargetIndex = 1
local ItemTargetIndex = 2
local pkTargetIndex = 3

GoldHuntManager = class(EventSetDoer, Singleton)

local FightIDs ={}--[ID]=monsterID or pked ID


function GoldHuntManager:__init()
	self._doer = {
		--[GoodsEvents_SS_ItemRemoved]			= GoldHuntManager.onItemRemoved,
		[FightEvents_SS_FightEnd_afterClient]	= GoldHuntManager.onFightEnd,
		[PK_CS_Invite]							= GoldHuntManager.onPk,
	}
	
end

function GoldHuntManager:__release()
	
	
end

function GoldHuntManager:commitScore(player)
	if not g_sceneMgr:isInGoldHuntScene(player) then
		return
	end
	local handler = player:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	local data = handler:getPriData(activityID)
	if data.curScore == 0 then
		return
	end
	local curTotal = handler:getGoldHuntData().totalScore
	curTotal = curTotal + data.curScore
	handler:getGoldHuntData().totalScore = curTotal
	data.curScore = 0
	LuaDBAccess.updateGoldHuntActivity(player)
	self:setIconValue(player,data.curScore)
	self:informClientScore(player)
end

function GoldHuntManager:informClientScore(player)
	if not g_sceneMgr:isInGoldHuntScene(player) then
		return
	end
	local handler = player:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	local data = handler:getPriData(activityID)
	local curTotal = handler:getGoldHuntData().totalScore
	
	local event = Event.getEvent(ActivityEvent_SC_GoldHunt_informScore, curTotal, data.curScore)
	g_eventMgr:fireRemoteEvent(event, player)
end

function GoldHuntManager:onPk(event)
	local roleID = event.playerID
	--校验pk条件
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	if not g_sceneMgr:isInGoldHuntScene(player) then
		return
	end

	if player:getStatus() == ePlayerFight then
		return
	end

	local params = event:getParams()
	local targetID = params[1]
	local tgPlayer = g_entityMgr:getPlayerByID(targetID)
	if not tgPlayer then
		return
	end

	if not g_sceneMgr:isInGoldHuntScene(tgPlayer) then
		return
	end

	if tgPlayer:getStatus() == ePlayerFight then
		return
	end
		--是否到达被掠夺次数
	local handler = tgPlayer:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	local data = handler:getPriData(activityID)
	local curPkedCount = data.pkedCount
	if curPkedCount >= GoldHuntZone_PKed_limit then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 1)
		g_eventMgr:fireRemoteEvent(event, player)
		event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 2, tostring(GoldHuntZone_PKed_limit))
		g_eventMgr:fireRemoteEvent(event, tgPlayer)
		return
	end
		--是否少于30%总积分
	local curScore = data.curScore
	
	local limit = GoldHuntZoneIconValue[1][1]
	if curScore < limit then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 3)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	--进入战斗
	local roles1 = {}
	table.insert(roles1,player)
	local petID = player:getFollowPetID()
	if petID then
		local pet = g_entityMgr:getPet(petID)
		table.insert(roles1,pet)
	end

	local roles2 = {}
	table.insert(roles2,tgPlayer)
	petID = tgPlayer:getFollowPetID()
	if petID then
		local pet = g_entityMgr:getPet(petID)
		table.insert(roles2,pet)
	end

	local fightID = g_fightMgr:startPvpFight(roles1, roles2, 2,FightBussinessType.GoldHunt)
	FightIDs[fightID] = targetID

	curPkedCount = curPkedCount + 1
	data.pkedCount = curPkedCount
	if curPkedCount >= GoldHuntZone_PKed_limit then
		local peer = tgPlayer:getPeer()
		setPropValue(peer, PLAYER_GOLD_HUNT_MINE, GoldHuntZone_Protected_iconValue)
		tgPlayer:flushPropBatch()
	end

	--通知客户端
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 4, tgPlayer:getName())
	g_eventMgr:fireRemoteEvent(event, player)
	event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 5, player:getName())
	g_eventMgr:fireRemoteEvent(event, tgPlayer)
end

function GoldHuntManager:doGoldHuntPVEFight(player, param, npcID)

	--加宠物
	local finalList = {}
	table.insert(finalList,player)
	local petID = player:getFollowPetID()
	if petID then
		local pet = g_entityMgr:getPet(petID)
		table.insert(finalList,pet)
	end
	
	local bPass = g_fightMgr:checkStartScriptFight(finalList, param.scriptID,  param.mapID)
	local curNpc = g_entityMgr:getNpc(npcID)
	if bPass then
		if curNpc:getStatus() ~= ePlayerFight then
			curNpc:setStatus(ePlayerFight)
			local fightID = g_fightMgr:startScriptFight(finalList, param.scriptID,  param.mapID)
			FightIDs[fightID] = npcID
		end
	end
end

function  GoldHuntManager:canCollectMine(player,mineConfigID)

	local handler = player:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	local data = handler:getPriData(activityID)
	local curScore = data.curScore
	local addedScore = GoldHuntZone_MineReward[mineConfigID]
	curScore = curScore + addedScore
	local count = #GoldHuntZoneIconValue
	local maxScore = GoldHuntZoneIconValue[count][1]
	if curScore > maxScore then
		return false
	else
		return true
	end
end
function GoldHuntManager:onItemCollected(mineID,mineConfigID,playerID,isRemoved)
	
	local player = g_entityMgr:getPlayerByID(playerID)
	if not g_sceneMgr:isInGoldHuntScene(player) then
		return
	end

	local handler = player:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	if not activityID then
		return
	end

	local activity = g_activityMgr:getActivity(activityID)
	if not activity then
		return
	end

	if isRemoved then
		activity:removeMine(mineID)
	end
	local targets = handler:getTargetsById(activityID)
	local target = targets[ItemTargetIndex]
	target:onCollectDone(mineConfigID)

end

function GoldHuntManager:onFightEnd(event)
	local params = event:getParams()
	local results = params[1]
	local monsterDBIDs = params[3]
	local fightID = params[4]
	local isPVE = false

	if monsterDBIDs and #monsterDBIDs>0 then
		isPVE = true
	else
		isPVE = false
	end

	local winner, loser
	for playerID, isWin in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player  then
			local isPass = g_sceneMgr:isInGoldHuntScene(player)
			if not isPass then
				return
			else
				--满血满蓝
				if player:getLevel() <= FullMaxHpMpLevel then
					local maxHP = player:getAttrValue(player_max_hp)
					player:setHP(maxHP)
					local maxMP = player:getAttrValue(player_max_mp)
					player:setMP(maxMP)
				end
				--赋值
				if isWin then
					winner = player
					if isPVE then
						break
					end
				else
					if isPVE then
						return
					end
					loser = player
				end

				if winner and loser then
					break
				end
			end
		end
	end

	local handler = winner:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	if not activityID then
		return
	end

	local activity = g_activityMgr:getActivity(activityID)
	if not activity then
		return
	end
	
	local targets = handler:getTargetsById(activityID)
	--打怪
	if isPVE then
		local target = targets[monsterTargetIndex]
		target:onMonsterKilled(monsterDBIDs)
		--从活动中删除
		local monsterID = FightIDs[fightID]
		activity:removeMonster(monsterID)
		--从场景删除
		local npc = g_entityMgr:getNpc(monsterID)
		local scene = npc:getScene()
		scene:detachEntity(npc)
		g_entityMgr:removeNpc(monsterID)

	--pk
	else
		local targetID = FightIDs[fightID]
		local target = targets[pkTargetIndex]
		target:onPKDone(winner ,loser, targetID)
	end

	FightIDs[fightID] = nil
end

function GoldHuntManager:getPlayerActivityID(player)
	local level = player:getLevel()
	
	local levelInfo1 = GoldHuntZoneActivityDB1[gGoldHuntID1].min_maxPlayerLevel
	local levelInfo2 = GoldHuntZoneActivityDB2[gGoldHuntID2].min_maxPlayerLevel
	local levelInfo3 = GoldHuntZoneActivityDB3[gGoldHuntID3].min_maxPlayerLevel
	local activityID
	if level >= levelInfo1[1] and level < levelInfo1[2] then
		activityID = gGoldHuntID1
	elseif level >= levelInfo2[1] and level < levelInfo2[2] then
		activityID = gGoldHuntID2
	elseif level >= levelInfo3[1] and level <= levelInfo3[2] then
		activityID = gGoldHuntID3
	else
		print("活动配置出错，玩家等级=",level)
		return nil
	end
	return activityID
end

function GoldHuntManager:enterHuntZone(player,posInfo)
	
	local x,y = posInfo.x,posInfo.y
	
	local activity
	
	local activityID = self:getPlayerActivityID(player)
	if not activityID then
		return
	end
	g_sceneMgr:enterGoldHuntScene(activityID, player, x , y)
	
	--初始化
	local handler = player:getHandler(HandlerDef_Activity)
	local goldHuntData = handler:getGoldHuntData()
	goldHuntData.ID = activityID
	
	local monsterTarget = GoldHunt_PVE()
	monsterTarget:setEntity(player)
	local itemTarget = GoldHunt_Collect()
	itemTarget:setEntity(player)
	local pkTarget = GoldHunt_PK()
	pkTarget:setEntity(player)

	handler:setPriDataById(activityID,{curScore = 0,pkedCount = 0})
	
	local targetsInfo = handler:getTargetsById(activityID)
	if targetsInfo then
		for _, target in pairs(targetsInfo) do
			release(target)
		end
	end
	handler:addActivityTarget(activityID, monsterTargetIndex, monsterTarget)
	handler:addActivityTarget(activityID, ItemTargetIndex, itemTarget)
	handler:addActivityTarget(activityID, pkTargetIndex, pkTarget)

end

function GoldHuntManager:getIconValue(score)
	for _, info in ipairs(GoldHuntZoneIconValue) do
		local grade = info[1]
		local iconValue = info[2]
		if score <= grade then
			return iconValue
		end
	end

	local count = GoldHuntZoneIconValue
	return GoldHuntZoneIconValue[count][2]
end

function GoldHuntManager:setIconValue(player ,score)
	local peer = player:getPeer()
	local cur = getPropValue(peer, PLAYER_GOLD_HUNT_MINE)
	local iconValue = self:getIconValue(score)
	if iconValue ~= cur then
		setPropValue(peer, PLAYER_GOLD_HUNT_MINE, iconValue)
		player:flushPropBatch()
	end
end

function GoldHuntManager:loadGoldHunt(player,recordList)
	if not recordList then
		return
	end
	local handler = player:getHandler(HandlerDef_Activity)
	local ghData = handler:getGoldHuntData()
	for _,rec in pairs(recordList) do
		if rec then
			ghData.rank = rec.rank
			ghData.isPrized = rec.isPrized -- -1表示没参加 
			break
		end
		
	end
end

function GoldHuntManager.getInstance()
	return GoldHuntManager()
end

EventManager.getInstance():addEventListener(GoldHuntManager.getInstance())