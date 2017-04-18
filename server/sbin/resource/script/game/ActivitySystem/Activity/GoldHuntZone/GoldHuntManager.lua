--[[GoldHuntManager.lua
	描述：猎金场管理
--]]

local monsterTargetIndex = 1
local ItemTargetIndex = 2
local pkTargetIndex = 3
local maxPlayerCount = 100
GoldHuntManager = class(EventSetDoer, Singleton)

local FightIDs ={}--[ID]=monsterID or pked ID
local loserIDs = {}
local rankResults 
local CurRankList = {}--{name="",score = 0}
local FinalPos = {}--[DBID]={ID=activityID,x=0,y=0}
function GoldHuntManager:__init()
	self._doer = {
		--[GoodsEvents_SS_ItemRemoved]			= GoldHuntManager.onItemRemoved,
		[FightEvents_SS_FightEnd_afterClient]	= GoldHuntManager.onFightEnd,
		[PK_CS_Invite]							= GoldHuntManager.onPk,
		[ActivityEvent_BS_GoldHunt_RankResults] = GoldHuntManager.onGetRankResults,
		[FrameEvents_SS_leaveScene]				= GoldHuntManager.onLeaveScene,
		[ActivityEvent_CS_GoldHunt_leave]		= GoldHuntManager.onGetLeaveCmd,
	}
	self.curRoleCount_1 = 0
	self.curRoleCount_2 = 0
	self.curRoleCount_3 = 0
	self.openStatus = false
end

function GoldHuntManager:__release()
	
	
end

function GoldHuntManager:_orderScoreAndSend(player)
	local scene = player:getScene()
	local roleList = scene:getEntityList()
	local bChanged = false
	--以前没排过
	if #CurRankList == 0 then
		--排序
		local i =0
		local selectedRoleIds = {}
		local orderedIds = {}
		while i < GoldHuntZone_ClientRankLimit do
			local max = 0
			local name = ""
			local ID = 0
			for roleID,role in pairs(roleList) do
				if instanceof(role, Player) and (not selectedRoleIds[roleID])then
					local handler = role:getHandler(HandlerDef_Activity)
					local curTotal = handler:getGoldHuntData().totalScore
					if  curTotal > max then
						max = curTotal
						name = role:getName()
						ID = roleID
					end
				end
			end
			if ID > 0 then
				table.insert(CurRankList,{name = name, score = max})
				selectedRoleIds[ID] = true
			--选完了
			else
				break
			end
			i = i + 1
		end
		bChanged = true
	--以前排过
	else
		local handler = player:getHandler(HandlerDef_Activity)
		local curTotal = handler:getGoldHuntData().totalScore
		--先看名单里有没有我,有的话剔除
		local myIndex = 0
		local myName = player:getName()
		for index , info in ipairs (CurRankList) do
			if info.name == myName then
				myIndex = index
				break
			end
		end
		if myIndex > 0 then
			table.remove(CurRankList,myIndex)
		end
		--重新给玩家定位，看是否在排名内
		myIndex = 0
		for index , info in ipairs (CurRankList) do
			local score = info.score
			if curTotal > score then
				bChanged = true
				myIndex = index
				break
			end
		end
		
		--有替换的
		if myIndex > 0 then
			table.insert(CurRankList,myIndex,{name = player:getName(), score = curTotal})
			local curCount = #CurRankList
			--删除排名之后的
			if curCount > GoldHuntZone_ClientRankLimit then
				local count = curCount - GoldHuntZone_ClientRankLimit
				local i = 0
				while i < count do
					table.remove(CurRankList)
					i = i + 1
				end
			end
		else
			--直接放最后
			if #CurRankList < GoldHuntZone_ClientRankLimit then
				table.insert(CurRankList,{name = player:getName(), score = curTotal})
				bChanged = true
			end
		end
	end
	--通知客户端
	if bChanged then
		local event = Event.getEvent(ActivityEvent_SC_GoldHunt_CurRank, CurRankList)
		-- RemoteEventProxy.broadcast(event,g_serverId)
		g_eventMgr:broadcastEvent(event,g_serverId)
	end
end

function GoldHuntManager:commitScore(player)
	if not g_sceneMgr:isInGoldHuntScene(player) then
		return
	end
	local handler = player:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	local data = handler:getPriData(activityID)
	if data.curScore == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 23)
	g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	local curTotal = handler:getGoldHuntData().totalScore
	curTotal = curTotal + data.curScore
	handler:getGoldHuntData().totalScore = curTotal
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 22, data.curScore, data.curScore)
	g_eventMgr:fireRemoteEvent(event, player)	
	LuaDBAccess.updateGoldHuntActivity(player)
	self:setIconValue(player,data.curScore)
	self:informClientScore(player)
	self:_orderScoreAndSend(player)
	data.curScore = 0
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
	if curScore <= limit then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 3)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	--进入战斗
	local roles1 = {}
	table.insert(roles1,player)
	local petID = player:getFightPetID()
	if petID then
		local pet = g_entityMgr:getPet(petID)
		table.insert(roles1,pet)
	end

	local roles2 = {}
	table.insert(roles2,tgPlayer)
	petID = tgPlayer:getFightPetID()
	if petID then
		local pet = g_entityMgr:getPet(petID)
		table.insert(roles2,pet)
	end

	local fightID = g_fightMgr:startPvpFight(roles1, roles2, nil,FightBussinessType.GoldHunt)
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
	local petID = player:getFightPetID()
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
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 12)
			g_eventMgr:fireRemoteEvent(event, player)
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

	local roleID = FightIDs[fightID]
	if not roleID then
		return
	end

	local role = g_entityMgr:getPlayerByID(roleID)
	if role then
		isPVE = false
	else
		isPVE = true
	end
	
	local winner, loser
	for playerID, isWin in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player  then
			local isPass = g_sceneMgr:isInGoldHuntScene(player)
			--活动已结束
			if not isPass then
				FightIDs[fightID] = nil
				local prevPos = player:getPrevPos()
				g_sceneMgr:doSwitchScence(player:getID(),prevPos[1],prevPos[2],prevPos[3])
				return
			else
				--满血满蓝
				print("满血满蓝",player:getLevel())
				if player:getLevel() <= FullMaxHpMpLevel then
					local maxHP = player:getAttrValue(player_max_hp)
					player:setHP(maxHP)
					local maxMP = player:getAttrValue(player_max_mp)
					player:setMP(maxMP)
				end
				--赋值winner,loser
				  --胜利
				if isWin then
					winner = player
					if isPVE then
						break
					end
				  --失败
				else
					if isPVE then
						local monsterID = FightIDs[fightID]
						local npc = g_entityMgr:getNpc(monsterID)
						npc:setStatus(ePlayerNormal)
						FightIDs[fightID] = nil
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
	if not winner then
		loserIDs[fightID] = loser:getID()
		return
	end
	local handler = winner:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	if not activityID then
		FightIDs[fightID] = nil
		return
	end

	local activity = g_activityMgr:getActivity(activityID)
	if not activity then
		FightIDs[fightID] = nil
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
		if not loser then
			loser = g_entityMgr:getPlayerByID(loserIDs[fightID])
			local maxHP = loser:getAttrValue(player_max_hp)
			local maxMP = loser:getAttrValue(player_max_mp)
			loser:setHP(maxHP)		
			loser:setMP(maxMP)
			loserIDs[fightID] = nil
		end
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
	if level >= levelInfo1[1] and level <= levelInfo1[2] then
		activityID = gGoldHuntID1
	elseif level >= levelInfo2[1] and level <= levelInfo2[2] then
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
	if not self.openStatus then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 18)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	local level = player:getLevel()
	if level < 30 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 19)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID > 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 20)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	local activityID = 4
	if level < 40 then
		activityID = 4
	elseif level < 50 then
		activityID = 5
	else
		activityID = 6
	end
	local bResult = g_sceneMgr:enterGoldHuntScene(activityID, player, x , y)
	if not bResult then
		return
	end
	FinalPos[player:getDBID()] = nil
	if level < 40 then
		if self.curRoleCount_1 < maxPlayerCount then
			self.curRoleCount_1 = self.curRoleCount_1 + 1
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 21)
			g_eventMgr:fireRemoteEvent(event, player)
			return
		end
	elseif level < 50 then
		if self.curRoleCount_2 < maxPlayerCount then
			self.curRoleCount_2 = self.curRoleCount_2 + 1
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 21)
			g_eventMgr:fireRemoteEvent(event, player)
			return
		end
	else
		if self.curRoleCount_3 < maxPlayerCount then
			self.curRoleCount_3 = self.curRoleCount_3 + 1
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt, 21)
			g_eventMgr:fireRemoteEvent(event, player)
			return
		end
	end
	--发送进入事件(倒计时和总积分和階段)
	local activity = g_activityMgr:getActivity(activityID) 
	local phaseID = activity:getPhaseID()
	local handler = player:getHandler(HandlerDef_Activity)
	local goldHuntData = handler:getGoldHuntData()

	local now = os.time()
	local date = os.date("*t")
	local endTime = ActivityDB[activityID].endTime
	date.hour = endTime.hour
	date.min = endTime.min
	date.sec = 0
	local endTimeTick = os.time(date)
	local leftTime = endTimeTick - now
	local event = Event.getEvent(ActivityEvent_SC_GoldHunt_enter, leftTime , goldHuntData.totalScore, CurRankList,phaseID)
	g_eventMgr:fireRemoteEvent(event, player)
	self:setIconValue(player,1,true)--初始化值
	--初始化
	
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

	local count = 1
	return GoldHuntZoneIconValue[count][2]
end

function GoldHuntManager:setIconValue(player ,score, isSet)
	local peer = player:getPeer()
	local cur = getPropValue(peer, PLAYER_GOLD_HUNT_MINE)
	local iconValue = self:getIconValue(score)
	if iconValue ~= cur or isSet then
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
			ghData.rank = rec.rank-- -1表示没名次
			ghData.isPrized = rec.isPrized -- -1表示没参加 0表示没领
			ghData.totalScore = rec.score
			break
		end
		
	end
	
end

function GoldHuntManager:_giveReward(player, reward)

	local dropMgr = DropManager.getInstance()
	local isChanged = false
	if reward.exp and reward.exp > 0 then
		local temp_xp_ratio = player:getAttrValue(player_xp_ratio)
		local tempExp = math.floor(reward.exp * temp_xp_ratio / 100)
		player:addXp(tempExp)
		dropMgr:sendRewardMessageTip(player, 2, tempExp)
		isChanged = true
	end

	if reward.money and reward.money > 0 then
		local money = reward.money + player:getMoney()
		player:setMoney(money)
		dropMgr:sendRewardMessageTip(player, 3, reward.money)
		isChanged = true
	end

	if reward.tao and reward.tao > 0 then
		local tao = reward.tao + player:getAttrValue(player_tao)
		player:setAttrValue(player_tao, tao)
		dropMgr:sendRewardMessageTip(player, 5, reward.tao)
		isChanged = true
	end
	if isChanged then
		player:flushPropBatch()
	end
end

function  GoldHuntManager:onGetRankResults(event)
	local params = event:getParams()
	local results = params[1]
	rankResults = results
	local rank3Names = {}
	for _,rs in ipairs(rankResults) do
		if rs.rank <= 3 then
			table.insert(rank3Names,rs.name..",")
		else
			break
		end
	end
	--
	table.clear(CurRankList)
	--发布前3广播
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GoldHunt,8,unpack(rank3Names))
	-- RemoteEventProxy.broadcast(event, g_serverId)
	g_eventMgr:broadcastEvent(event,g_serverId)
	--给在线玩家发排名奖
	for _,rs in ipairs(rankResults) do
		local dbID = rs.roleID
		local rank = rs.rank
		local player = g_entityMgr:getPlayerByDBID(dbID)
		if player then
			local handler = player:getHandler(HandlerDef_Activity)
			local reward
			for _,rewardInfo in ipairs(GoldHuntZone_Reward) do
				--在某段排名内
				if rewardInfo.rank and (rank <= rewardInfo.rank) then
					handler:getGoldHuntData().isPrized = 1
					LuaDBAccess.updateGoldHuntActivity(player)
					self:_giveReward(player,rewardInfo)
					break
				end
				--排名外
				if not rewardInfo.rank then
					handler:getGoldHuntData().isPrized = 1
					LuaDBAccess.updateGoldHuntActivity(player)
					self:_giveReward(player,rewardInfo)
					break
				end
			end
			
		end
	end
	--给在剩下在线玩家发参与奖
	for playerID, player in pairs(g_entityMgr:getPlayers()) do
		local handler = player:getHandler(HandlerDef_Activity)
		local isPrized =  handler:getGoldHuntData().isPrized
		local totalScore =  handler:getGoldHuntData().totalScore
		if isPrized and (isPrized ~= 1) then
			if 	totalScore and (totalScore > 0) then
				local reward = GoldHuntZone_Reward[#GoldHuntZone_Reward]
				self:_giveReward(player,reward)
			end
		end
	end

end

function GoldHuntManager:onLeaveScene(event)
	local params = event:getParams()
	local role = params[1]
	local scene = params[2]
	if not instanceof(role,Player) then
		return
	end

	if not g_sceneMgr:isGoldHuntScene(scene) then
		return
	end
	self:setIconValue(role,0,true)--初始化值
	local event = Event.getEvent(ActivityEvent_SC_GoldHunt_leave, -1)
	g_eventMgr:fireRemoteEvent(event, role)
end

function GoldHuntManager:onGetLeaveCmd(event)
	local roleID = event.playerID
	if not roleID then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	if not g_sceneMgr:isInGoldHuntScene(player) then
		return
	end
	local prevPos = player:getPrevPos()
	g_sceneMgr:doSwitchScence(roleID,prevPos[1],prevPos[2],prevPos[3])

	FinalPos[player:getDBID()] = nil
end

function GoldHuntManager:onOffline(player,activityID)
	if not (activityID == gGoldHuntID1 or activityID == gGoldHuntID2 or activityID == gGoldHuntID3 )then
		return
	end
	if not g_sceneMgr:isInGoldHuntScene(player) then
		return
	end
	local handler = player:getHandler(HandlerDef_Activity)
	local activityID = handler:getGoldHuntData().ID
	local mapID ,x,y = player:getCurPos()
	FinalPos[player:getDBID()] = {ID = activityID,x=x,y=y}
end

function GoldHuntManager:onOnline(player)

end

function GoldHuntManager:clearFinalPos()
	self.curRoleCount_1 = 0
	self.curRoleCount_2 = 0
	self.curRoleCount_3 = 0
	self.openStatus = false
	table.clear(FinalPos)
end

function GoldHuntManager:openActivity()
	self.curRoleCount_1 = 0
	self.curRoleCount_2 = 0
	self.curRoleCount_3 = 0
	self.openStatus = true
	table.clear(FinalPos)
end

function GoldHuntManager.getInstance()
	return GoldHuntManager()
end

EventManager.getInstance():addEventListener(GoldHuntManager.getInstance())
