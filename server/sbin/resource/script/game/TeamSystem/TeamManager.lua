--[[TeamManager.lua
描述:
	组队管理
]]

TeamManager = class(nil, Singleton,Timer)
local g_timerMgr	= TimerManager.getInstance()
function TeamManager:__init()
	-- 记录所有队伍信息
	self._teams = {}
	self._lastTeamID = 0
	--队长排队列表
	self.leaderQueueList = {}
	--非队伍玩家排队列表
	self.queueList = {}
	
	--被移除玩家列表
	self.moveOutList = {}


	--上一次拒绝邀请玩家的id
	self.lastTargetID = 0


end

function TeamManager:__release()
	for teamID, _ in paris(self.teams) do
		self._teams[teamID] = nil
	end
	self._teams = nil
	self.lastTargetID = 0
	--g_timerMgr:unregTimer(self.lastID)
	--self.lastID = nil
end


--玩家下线
function TeamManager:onPlayerCheckOut(player)
	self:quitTeam(player:getID())
end

--玩家掉线
function TeamManager:onPlayerOffline(player)
end

--创建队伍
function TeamManager:createTeam(playerID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID == InvalidTeamID then
		self._lastTeamID = self._lastTeamID+1
		local team = Team(self._lastTeamID,playerID)
		table.insert(self._teams,self._lastTeamID,team)
		teamHandler:setTeamID(self._lastTeamID)

		--退出自动组队队列
		for k,queueInfo in pairs(self.queueList) do
			if playerID == queueInfo.ID then
				table.remove(self.queueList,k)
				break
			end
		end

		local event = Event.getEvent(TeamEvents_SC_CreateTeam)
		g_eventMgr:fireRemoteEvent(event,player)
		return team
	else
		print("您已经加入队伍,不能创建队伍。")
		return
	end
end

--解散队伍
function TeamManager:dissolveTeam(leaderID)
	local player = g_entityMgr:getPlayerByID(leaderID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = self._teams[teamID]
	if team:getLeaderID() == leaderID then
		local ectypeEvent = Event.getEvent(TeamEvents_SS_DissolveEctypeTeam,leaderID)
		g_eventMgr:fireEvent(ectypeEvent)
		for _,memberInfo in pairs(team:getMemberList()) do
			local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
			player:setActionState(PlayerStates.Normal)

			local teamHandler = player:getHandler(HandlerDef_Team)
			teamHandler:setTeamID(InvalidTeamID)
			local event = Event.getEvent(TeamEvents_SC_DissolveTeam)
			g_eventMgr:fireRemoteEvent(event,player)

			event = Event.getEvent(TeamEvents_SS_QuitTeam,player:getID())
			g_eventMgr:fireEvent(event)

			--解散队伍，设置回原来的速度
			if leaderID ~= memberInfo.memberID then
				player:setMoveSpeed(player:getSelfSpeed())
			end

			--自动组队队列的队员恢复自动组队状态
			for k,queueInfo in pairs(self.queueList) do
				if memberInfo.memberID == queueInfo.ID then
					queueInfo.autoTeam = true
					break
				end
			end
		end

		team:dissolve()

		self._teams[teamID] = nil
		
		--队长退出自动组队队列
		for k,queueInfo in pairs(self.leaderQueueList) do
			if leaderID == queueInfo.ID then
				table.remove(self.leaderQueueList,k)
				break
			end
		end
	else
		print("只有队长才能进行解散队伍操作。")
		return
	end
end

--邀请对方入队
function TeamManager:inviteJoinTeam(playerID,targetID)
	--根据玩家动态ID得到玩家
	local player = g_entityMgr:getPlayerByID(playerID)
	local targetPlayer = g_entityMgr:getPlayerByID(targetID)
	--如果玩家不在线，则发送消息到客户端
	if not targetPlayer then
		local event = Event.getEvent(TeamEvents_SC_targetOfflineNotify)
		g_eventMgr:fireRemoteEvent(event,player)
		return
	end
	--如果玩家真在采集，则不能邀请入队	
	local collectState = targetPlayer:getCollectState()
	if collectState then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SystemSet, 7)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	
	local systemSetHandler = targetPlayer:getHandler(HandlerDef_SystemSet) 
	if systemSetHandler then
		if systemSetHandler:getRefTeam() then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SystemSet, 4)
			g_eventMgr:fireRemoteEvent(event, player)
			return 
		end
	end
	--得到自己队伍ID
	local pTeamID = player:getHandler(HandlerDef_Team):getTeamID()
	--得到目标队伍Handler
	local tTeamHandler = targetPlayer:getHandler(HandlerDef_Team)
	--得到目标队伍ID
	local tTeamID = tTeamHandler:getTeamID()
	local team = nil
	--如果双方队伍ID无效
	if pTeamID == InvalidTeamID and tTeamID == InvalidTeamID then
		--则创建一个新的队伍，玩家为队长
		team = self:createTeam(playerID)
	--如果玩家队伍无效，目标队伍有效
	elseif pTeamID == InvalidTeamID and tTeamID ~= InvalidTeamID then
		--玩家申请入队
		self:requestJoinTeam(playerID,targetID)
		return
	--如果双方队伍都有效
	elseif  pTeamID ~= InvalidTeamID and tTeamID ~= InvalidTeamID then
		--发送消息到客户端，表示已经有队伍
		local event = Event.getEvent(TeamEvents_SC_targetHasTeamNotify)
		g_eventMgr:fireRemoteEvent(event,player)
		return
	--玩家队伍有效，目标队伍无效，得到玩家队伍
	else
		team = self._teams[pTeamID]
	end
	--判断目标是否已经存在于玩家队伍邀请中
	if team:existInviteList(targetID) then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 8)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	--判断玩家队伍是否满员
	if team:isFull() then
		--发送消息到客户��?
		local event = Event.getEvent(TeamEvents_SC_TeamIsFullNotify)
		g_eventMgr:fireRemoteEvent(event,player)
		return
	end
	--判断玩家队伍是否收到过五条消息以��?
	if table.size(tTeamHandler:getTeaminviteList()) >= MaxInvalidCount then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 11)
		g_eventMgr:fireRemoteEvent(event, targetPlayer)
		return
	end
	--判断
	if self.lastTargetID == targetID then
		local event = Event.getEvent(TeamEvents_SC_InviteJoinTeamNotify,true)
		g_eventMgr:fireRemoteEvent(event,player)
		return
	else
		tTeamHandler:addTeaminviteList(playerID)
		team:addinviteList(targetID)
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local playerName = player:getName()
			local event = Event.getEvent(TeamEvents_SC_InviteJoinTeam,playerID,playerName)
			g_eventMgr:fireRemoteEvent(event,targetPlayer)
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 7)
			g_eventMgr:fireRemoteEvent(event, targetPlayer)
		end
	end
	--给队长提示，你已发出组队邀请，请等待对方接受
	local event = Event.getEvent(TeamEvents_SC_inviteJoinTeamNotify)
	g_eventMgr:fireRemoteEvent(event,player)
end

--邀请对方入队回答
function TeamManager:answerInvite(targetID,leaderID,isAccept)
	local player = g_entityMgr:getPlayerByID(leaderID)
	local teamID = player:getHandler(HandlerDef_Team):getTeamID()
	local team = self._teams[teamID]
	local targetPlayer = g_entityMgr:getPlayerByID(targetID)
	if team == nil then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 4)
		g_eventMgr:fireRemoteEvent(event, targetPlayer)
		return
	end
	local tTeamHandler = targetPlayer:getHandler(HandlerDef_Team)
	if tTeamHandler:isTeam() then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 1)
		g_eventMgr:fireRemoteEvent(event, targetPlayer)
		return
	end

	if isAccept then
		if team:isFull() then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 6)
			g_eventMgr:fireRemoteEvent(event, targetPlayer)
			return
		end
		local flag = nil
		if player:isInView(targetID) then --是否队长视野判断
			flag = MemberState.Follow
		else
			flag = MemberState.StepOut
		end
		team:addMember(targetID,flag)
		local memberList = {}
		--给队伍中所有的玩家发
		for _,memberInfo in pairs(team:getMemberList()) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			if memberInfo.memberID ~= targetID then
				local event = Event.getEvent(TeamEvents_SC_NewMemberJoinTeam,targetID,targetPlayer:getName(),targetPlayer:getLevel(),targetPlayer:getSchool(),targetPlayer:getModelID(),targetPlayer:getScene():getMapID(),flag,targetPlayer:getMaxHP(),targetPlayer:getMaxMP())
				g_eventMgr:fireRemoteEvent(event,member)
			end
			local info = {memberID = member:getID(),name = member:getName(),level = member:getLevel(),school = member:getSchool(),modelID = member:getModelID(),mapID = member:getScene():getMapID(),memberState = memberInfo.memberState,maxHp = targetPlayer:getMaxHP(),maxMp = targetPlayer:getMaxMP()}
			table.insert(memberList,info)
		end
		--给被邀请玩家发
		local event = Event.getEvent(TeamEvents_SC_MemberJoinTeam,leaderID,memberList)
		g_eventMgr:fireRemoteEvent(event,targetPlayer)

		tTeamHandler:removeTeaminviteList(leaderID)
		for k,playerID in pairs(tTeamHandler:getTeaminviteList()) do --同意了一个玩家，便拒绝了所有玩家的邀请
			--print("XXX已拒绝了您的组队邀请")
			tTeamHandler:removeTeaminviteList(playerID)
			local leader = g_entityMgr:getPlayerByID(playerID)
			local teamID = leader:getHandler(HandlerDef_Team):getTeamID()
			local leaderteam = self._teams[teamID]
			leaderteam:removeinviteList(targetID)
		end
		
		event = Event.getEvent(TeamEvents_SS_MemberJoinTeam,targetID)
		g_eventMgr:fireEvent(event)
	else
		tTeamHandler:removeTeaminviteList(leaderID)
		--print("XXX已拒绝了您的组队邀请")
		local event = Event.getEvent(TeamEvents_SC_refuseJoinTeamToLeader,targetPlayer:getName())
		g_eventMgr:fireRemoteEvent(event,player)
		local event = Event.getEvent(TeamEvents_SC_refuseJoinTeamToTarget,player:getName())
		g_eventMgr:fireRemoteEvent(event,targetPlayer)
		if self.lastTargetID ~= targetID then
			self.lastTargetID = targetID
			--30s计时器
			self.lastID = g_timerMgr:regTimer(self,30*1000,30*1000,"30s内不能重复邀请同一个玩家。")
		end
	
	end
	team:removeinviteList(targetID)
end
--定时器回调
function TeamManager:update(timerID)
	self.lastTargetID = 0
end

--玩家申请加入队伍
function TeamManager:requestJoinTeam(playerID,targetID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local targetPlayer = g_entityMgr:getPlayerByID(targetID)
	if not targetPlayer or not player then
		return
	end
	local pTeamID = player:getHandler(HandlerDef_Team):getTeamID()
	local tTeamID = targetPlayer:getHandler(HandlerDef_Team):getTeamID()
	if pTeamID == InvalidTeamID and tTeamID ~= InvalidTeamID then
		local team = self._teams[tTeamID]
		if team:isFull() then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 6)
			g_eventMgr:fireRemoteEvent(event, player)
			return
		else
			local leaderID = team:getLeaderID()
			local event = Event.getEvent(TeamEvents_SC_RequestJoinTeam,playerID)
			g_eventMgr:fireRemoteEvent(event,g_entityMgr:getPlayerByID(leaderID))
		end
	end
end

--回答申请
function TeamManager:answerRequest(leaderID,targetID,isAccept)
	local player = g_entityMgr:getPlayerByID(leaderID)
	local targetPlayer = g_entityMgr:getPlayerByID(targetID)
	if not targetPlayer then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 7)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	local pTeamID = player:getHandler(HandlerDef_Team):getTeamID()
	local tTeamID = targetPlayer:getHandler(HandlerDef_Team):getTeamID()
	if tTeamID ~= InvalidTeamID then
		--申请人有队伍了
		if isAccept then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 5)
			g_eventMgr:fireRemoteEvent(event, player)
		end
		local event = Event.getEvent(TeamEvents_SC_RefuseRequestTeam,targetID)
		g_eventMgr:fireRemoteEvent(event, player)
		return
	end
	local team = self._teams[pTeamID]
	if isAccept then
		if team:isFull() then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 6)
			g_eventMgr:fireRemoteEvent(event, player)
			return
		end
		local flag = nil
		if player:isInView(targetID) then --是否队长视野判断
			flag = MemberState.Follow
		else
			flag = MemberState.StepOut
		end
		team:addMember(targetID,flag)
		local memberList = {}
		--给队伍中所有的玩家发
		for _,memberInfo in pairs(team:getMemberList()) do
			local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
			if memberInfo.memberID ~= targetID then
				local event = Event.getEvent(TeamEvents_SC_NewMemberJoinTeam,targetID,targetPlayer:getName(),targetPlayer:getLevel(),targetPlayer:getSchool(),targetPlayer:getModelID(),targetPlayer:getScene():getMapID(),flag,targetPlayer:getMaxHP(),targetPlayer:getMaxMP())
				g_eventMgr:fireRemoteEvent(event,player)
			end
			local info = {memberID = player:getID(),name = player:getName(),level = player:getLevel(),school = player:getSchool(),modelID = player:getModelID(),mapID = player:getScene():getMapID(),memberState = memberInfo.memberState,maxHp = targetPlayer:getMaxHP(),maxMp = targetPlayer:getMaxMP()}
			table.insert(memberList,info)
		end
		--给申请玩家发
		local event = Event.getEvent(TeamEvents_SC_MemberJoinTeam,leaderID,memberList)
		g_eventMgr:fireRemoteEvent(event,targetPlayer)

		event = Event.getEvent(TeamEvents_SS_MemberJoinTeam,targetID)
		g_eventMgr:fireEvent(event)
	else
		local event = Event.getEvent(TeamEvents_SC_RefuseRequestTeam,targetID)
		g_eventMgr:fireRemoteEvent(event,player)
	end
end

--玩家暂离队伍
function TeamManager:stepOutTeam(playerID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local teamID = player:getHandler(HandlerDef_Team):getTeamID()
	local team = self._teams[teamID]
	if team then
		if team:getLeaderID() ~= playerID then
			-- 玩家在副本当中不能暂离
			local ectypeHandler = player:getHandler(HandlerDef_Ectype)
			local ectypeMapID = ectypeHandler:getEctypeMapID()
			if ectypeMapID >= EctypeMap_StartID then
				print("副本当中不能暂离")
				return
			end
			team:stepOut(playerID)
			for _,memberInfo in pairs(team:getMemberList()) do
				local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
				local event = Event.getEvent(TeamEvents_SC_StepOutTeam,playerID)
				g_eventMgr:fireRemoteEvent(event,player)
			end
			local localEvent = Event.getEvent(TeamEvents_SS_StepOutTeam, playerID)
			g_eventMgr:fireEvent(localEvent)
		else
			print("只有队员可以操作")
		end
	end
end

--玩家归队
function TeamManager:comeBackTeam(playerID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local teamID = player:getHandler(HandlerDef_Team):getTeamID()
	local team = self._teams[teamID]
	if team then
		local leaderID = team:getLeaderID()	
		if player:isInView(leaderID) then 
			local leader = g_entityMgr:getPlayerByID(leaderID)
			if not leader then
				return
			end
			if leader:isFighting() then
				print("队伍处于战斗状态，无法归队")
				-- 战斗中无法操作
				return
			end
			-- 直接传送到队长附近
			local mapID, xPos, yPos = leader:getCurPos()
			if mapID >= EctypeMap_StartID then
				g_ectypeMgr:enterEctypeScene(mapID, {player, xPos, yPos})
			else
				g_sceneMgr:enterPublicScene(mapID, player, xPos, yPos)
			end
			team:comeBack(playerID)
			for _,memberInfo in pairs(team:getMemberList()) do
				local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
				local event = Event.getEvent(TeamEvents_SC_ComeBackTeam,playerID)
				g_eventMgr:fireRemoteEvent(event,player)
			end
		else
			local event = Event.getEvent(TeamEvents_SC_ComeBackTeamNotify)
			g_eventMgr:fireRemoteEvent(event,player)
		end
	end
end

--退出队伍
function TeamManager:quitTeam(playerID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local teamID = player:getHandler(HandlerDef_Team):getTeamID()
	local team = self._teams[teamID]
	if team then
		--如果是队长退出队伍
		if team:getLeaderID() == playerID then--TODO 
			team:leaderQuit()
			local leaderID = team:getLeaderID()
			if leaderID then
				--给队伍其他人发队长退出队伍
				for _,memberInfo in pairs(team:getMemberList() or {}) do
					local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
					local event = Event.getEvent(TeamEvents_SC_LeaderQuitTeam,playerID,leaderID)
					g_eventMgr:fireRemoteEvent(event,member)
				end
				--给老队长本人发
				local event = Event.getEvent(TeamEvents_SC_QuitTeam,playerID)
				g_eventMgr:fireRemoteEvent(event,player)
								
				--如果新队长属于自动组队队列则退出
				for k,queueInfo in pairs(self.queueList) do
					if leaderID == queueInfo.ID then
						table.remove(self.queueList,k)
						break
					end
				end
				local leader = g_entityMgr:getPlayerByID(leaderID)
				leader:setMoveSpeed(leader:getSelfSpeed())
			else
				local event = Event.getEvent(TeamEvents_SC_DissolveTeam)
				g_eventMgr:fireRemoteEvent(event,player)
			end

			--队长退出队伍则退出自动组队队列
			for k,queueInfo in pairs(self.leaderQueueList) do
				if playerID == queueInfo.ID then
					table.remove(self.leaderQueueList,k)
					return true
				end
			end
		else
			--给队伍中所有的玩家发
			for _,memberInfo in pairs(team:getMemberList()) do
				local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
				local event = Event.getEvent(TeamEvents_SC_QuitTeam,playerID)
				g_eventMgr:fireRemoteEvent(event,player)
			end
			team:removeMember(playerID)

			--玩家主动手动取消自动排队、主动手动退出队伍（队伍解散除外）、创建自己的队伍或者下线，则会取消自动排队状态。
			for k,queueInfo in pairs(self.queueList) do
				if playerID == queueInfo.ID then
					table.remove(self.queueList,k)
					break
				end
			end
		end
		localEvent = Event.getEvent(TeamEvents_SS_QuitTeam, playerID)
		g_eventMgr:fireEvent(localEvent)
	end
end

--更换队长
function TeamManager:changeLeader(leaderID,playerID)
	local leader = g_entityMgr:getPlayerByID(leaderID)
	local teamID = leader:getHandler(HandlerDef_Team):getTeamID()
	local team = self._teams[teamID]
	if table.size(team:getMemberList()) <= 1 then
		return
	end
	if team:getLeaderID() == leaderID then
		if team then
			playerID = team:changeLeader(leaderID,playerID)
			if not playerID then return end 
			--给队伍中所有的玩家发
			for _,memberInfo in pairs(team:getMemberList()) do
				local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
				local event = Event.getEvent(TeamEvents_SC_ChangeLeader,playerID)
				g_eventMgr:fireRemoteEvent(event,player)
			end
			local event = Event.getEvent(TeamEvents_SS_ChangeLeader,playerID)
			g_eventMgr:fireEvent(event)
		end
		--老队长退出队长自动组队队列
		for k,queueInfo in pairs(self.leaderQueueList) do
			if leaderID == queueInfo.ID then
				table.remove(self.leaderQueueList,k)
				break
			end
		end

		--新队长退出玩家自动组队队列
		for k,queueInfo in pairs(self.queueList) do
			if playerID == queueInfo.ID then
				table.remove(self.queueList,k)
				break
			end
		end
	else
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 10)
		g_eventMgr:fireRemoteEvent(event, targetPlayer)
		print("只有队长可以操作")
		return
	end
end

--移除队伍
function TeamManager:moveOutMember(leaderID,playerID)
	local leader = g_entityMgr:getPlayerByID(leaderID)
	local teamID = leader:getHandler(HandlerDef_Team):getTeamID()
	local team = self._teams[teamID]
	if team then
		if team:getLeaderID() == leaderID then
			for _,memberInfo in pairs(team:getMemberList()) do
				local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
				local event = Event.getEvent(TeamEvents_SC_MoveOutMember,playerID)
				g_eventMgr:fireRemoteEvent(event,player)
			end
			team:removeMember(playerID)

			for k,queueInfo in pairs(self.leaderQueueList) do
				if queueInfo.ID == leaderID then
					queueInfo.autoTeam = true
					self:matchPlayerTeam(leader,queueInfo.minLevel,queueInfo.maxLevel,queueInfo.actionID)
					break
				end
			end

			--被队伍踢了之后，能够重新进入队列继续自动排队
			for k,queueInfo in pairs(self.queueList) do
				if queueInfo.ID == playerID then
					queueInfo.autoTeam = true
					local moveOutInfo = {ID = playerID,leaderID = leaderID,time = os.time()}
					table.insert(self.moveOutList,moveOutInfo)
					--3分钟以内，被踢的玩家不会再通过自动匹配进入该队伍
					local player = g_entityMgr:getPlayerByID(playerID)
					self:matchLeaderTeam(player,queueInfo.minLevel,queueInfo.maxLevel,queueInfo.actionTable)
					return
				end
			end

			-- 副本当中移除队员
			local ectypeEvent = Event.getEvent(TeamEvents_SS_MoveOutMember, playerID)
			g_eventMgr:fireEvent(ectypeEvent)
		else
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 10)
			g_eventMgr:fireRemoteEvent(event, targetPlayer)
		end
	end
end

--获取排队人数
function TeamManager:updateQueueCount(playerID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local leaderQueueCount = self:getLeaderQueueListCount()
	local queueCount = self:getQueueListCount()
	local event = Event.getEvent(TeamEvents_SC_UpdateQueueCount,leaderQueueCount,queueCount)
	g_eventMgr:fireRemoteEvent(event,player)
end

--非组队玩家去查找相应队伍
function TeamManager:searchTeamList(playerID,minLevel,maxLevel,actionTable)
	for k,queueInfo in pairs(self.queueList) do
		if playerID == queueInfo.ID then
			print("自动组队状态不能查询相应队伍")
			return
		end
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	local leaderTable = {}
	for _,leaderQueueInfo in pairs(self.leaderQueueList) do
		local leader = g_entityMgr:getPlayerByID(leaderQueueInfo.ID)
		local level = leader:getLevel()
		if level >= minLevel and level <= maxLevel and leaderQueueInfo.autoTeam then--等级符合要求
			for _,ID in pairs(actionTable) do
				if ID == leaderQueueInfo.actionID then--勾选的活动ID满足要求
					local teamID = leader:getHandler(HandlerDef_Team):getTeamID()
					local team = self._teams[teamID]
					local teamCount = team:getMemberCount()
					if ID == TeamActionID.DQCJ then --如果为当前场景还需要所在地图一致
						if player:getScene():getMapID() == leader:getScene():getMapID() then
							local tempLeaderInfo = {}
							tempLeaderInfo.ActionID = ID
							tempLeaderInfo.LeaderID = leaderQueueInfo.ID
							tempLeaderInfo.teamCount = teamCount
							table.insert(leaderTable,tempLeaderInfo)
						end
					else
						local tempLeaderInfo = {}
						tempLeaderInfo.ActionID = ID
						tempLeaderInfo.LeaderID = leaderQueueInfo.ID
						tempLeaderInfo.teamCount = teamCount
						table.insert(leaderTable,tempLeaderInfo)
					end
				end
			end
		end
	end
	local event = Event.getEvent(TeamEvents_SC_SearchTeamList,leaderTable)
	g_eventMgr:fireRemoteEvent(event,player)
end

--是否是仙府争夺战地图
local function isInXFZDZMap(mapID)
	for _,ID in pairs(XFZDZMapID) do
		if mapID == ID then
			return true
		end
	end
	return false
end

--被移除队伍是否超过3分钟
function TeamManager:isOverTime(leaderID,playerID)
	for k,moveOutInfo in pairs (self.moveOutList or {}) do
		if moveOutInfo.leaderID == leaderID and playerID == moveOutInfo.ID then
			if os.time() - moveOutInfo.time > 180 then
				table.remove(self.moveOutList,k)
				return true
			else
				return false
			end
		end
	end
	return true
end

--非队伍玩家自动组队
function TeamManager:autoTeam(playerID,minLevel,maxLevel,actionTable)
	local player = g_entityMgr:getPlayerByID(playerID)
	local teamID = player:getHandler(HandlerDef_Team):getTeamID()
	if teamID ~= InvalidTeamID then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 9)
		g_eventMgr:fireRemoteEvent(event, targetPlayer)
		return
	end

	--更改信息点击自动组队,先移除排队队列中再添加到最后
	for k,queueInfo in pairs(self.queueList) do
		if queueInfo.ID == playerID then
			table.remove(self.queueList,k)
			break
		end
	end
	local queueInfo = {ID = playerID,minLevel = minLevel,maxLevel = maxLevel,actionTable = actionTable,autoTeam = true}
	table.insert(self.queueList,queueInfo)
	self:matchLeaderTeam(player,minLevel,maxLevel,actionTable)
end

--匹配队长队伍
function TeamManager:matchLeaderTeam(player,minLevel,maxLevel,actionTable)
	for _,leaderQueueInfo in pairs(self.leaderQueueList) do
		local leader = g_entityMgr:getPlayerByID(leaderQueueInfo.ID)
		local level = leader:getLevel()
		if level >= minLevel and level <= maxLevel and leaderQueueInfo.autoTeam and self:isOverTime(leaderQueueInfo.ID,player:getID()) then--等级符合要求
			for _,ID in pairs(actionTable) do
				if ID == leaderQueueInfo.actionID then--勾选的活动ID满足要求
					if ID == TeamActionID.DQCJ then --如果为当前场景还需要所在地图一致
						local mapID = player:getScene():getMapID()
						if mapID == leader:getScene():getMapID() then
							if isInXFZDZMap(mapID) then
								if player:getSchool() == leader:getSchool() then
									self:autoTeamAddMember(leader,player)
									return
								end
							else
								self:autoTeamAddMember(leader,player)
								return
							end
						end
					else
						self:autoTeamAddMember(leader,player)
						return
					end
				end
			end
		end
	end
end

--非队伍玩家取消自动组队
function TeamManager:cancelAutoTeam(playerID)
	for k,queueInfo in pairs(self.queueList) do
		if playerID == queueInfo.ID then
			table.remove(self.queueList,k)
			local player = g_entityMgr:getPlayerByID(playerID)
			local event = Event.getEvent(TeamEvents_SC_CancelAutoTeam)
			g_eventMgr:fireRemoteEvent(event,player)
			return
		end
	end
end

--队长发布组队
function TeamManager:leaderAutoTeam(leaderID,minLevel,maxLevel,actionID)
	local leader = g_entityMgr:getPlayerByID(leaderID)
	local teamID = leader:getHandler(HandlerDef_Team):getTeamID()
	local team = self._teams[teamID]
	if team:isFull() then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 6)
		g_eventMgr:fireRemoteEvent(event, targetPlayer)
		return
	end
	--更改信息点击发布组队,先移除在队长队列中再添加到最后
	for k,queueInfo in pairs(self.leaderQueueList) do
		if queueInfo.ID == leaderID then
			table.remove(self.leaderQueueList,k)
		end
	end
	local leaderQueueInfo = {ID = leaderID,minLevel = minLevel,maxLevel = maxLevel,actionID = actionID,autoTeam = true}
	table.insert(self.leaderQueueList,leaderQueueInfo)
	self:matchPlayerTeam(leader,minLevel,maxLevel,actionID)
end

--队长发布组队匹配玩家
function TeamManager:matchPlayerTeam(leader,minLevel,maxLevel,actionID)
	for _,queueInfo in pairs(self.queueList) do
		local player = g_entityMgr:getPlayerByID(queueInfo.ID)
		local level = player:getLevel()
		if minLevel <= level and level <= maxLevel and queueInfo.autoTeam and self:isOverTime(leader:getID(),queueInfo.ID)then
			for _,ID in pairs(queueInfo.actionTable) do
				if ID == actionID then--勾选的活动ID满足要求
					if ID == TeamActionID.DQCJ then --如果为当前场景还需要所在地图一致
						local playerMapID = player:getScene():getMapID()
						if playerMapID == leader:getScene():getMapID() then
							if isInXFZDZMap(playerMapID) then
								if player:getSchool() == leader:getSchool() then
									if self:autoTeamAddMember(leader,player,queueInfo) then
										return
									end
								end
							else
								if self:autoTeamAddMember(leader,player,queueInfo) then
									return
								end
							end
						end
					else
						if self:autoTeamAddMember(leader,player,queueInfo) then
							return
						end
					end
					break
				end
			end
		end
	end
end

--队长自动组队匹配到玩家加入队伍
function TeamManager:autoTeamAddMember(leader,addPlayer)
	local teamID = leader:getHandler(HandlerDef_Team):getTeamID()
	local team = self._teams[teamID]
	local leaderID = leader:getID()
	local addID = addPlayer:getID()
	local flag = nil
	if addPlayer:isInView(leaderID) then --是否队长视野判断
		flag = MemberState.Follow
	else
		flag = MemberState.StepOut
	end
	team:addMember(addID,flag)
	if team:isFull() then
		--如果队伍满，只退出队长队列计数，但依然保持自动排队的状态
		for k,queueInfo in pairs(self.leaderQueueList) do
			if leaderID == queueInfo.ID then
				queueInfo.autoTeam = false
				break
			end
		end
	end

	--成功加入了队伍，只退出队列计数，但依然保持自动排队的状态
	for k,queueInfo in pairs(self.queueList) do
		if addID == queueInfo.ID then
			queueInfo.autoTeam = false
		end
	end
	local memberList = {}
	--给队伍中所有的玩家发
	for _,memberInfo in pairs(team:getMemberList()) do
		local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
		if memberInfo.memberID ~= addID then
			local event = Event.getEvent(TeamEvents_SC_NewMemberJoinTeam,addID,addPlayer:getName(),addPlayer:getLevel(),addPlayer:getSchool(),addPlayer:getModelID(),addPlayer:getScene():getMapID(),flag)
			g_eventMgr:fireRemoteEvent(event,player)
		end
		local info = {memberID = player:getID(),name = player:getName(),level = player:getLevel(),school = player:getSchool(),modelID = player:getModelID(),mapID = player:getScene():getMapID(),memberState = memberInfo.memberState}
		table.insert(memberList,info)
	end
	--给加入的玩家发
	local event = Event.getEvent(TeamEvents_SC_MemberJoinTeam,leaderID,memberList)
	g_eventMgr:fireRemoteEvent(event,addPlayer)
	return team:isFull()
end

--队长取消发布组队,取消自动排队、队长退出队伍或解散队伍、队长下线
function TeamManager:leaderCancelAutoTeam(leaderID)
	for k,leaderQueueInfo in pairs(self.leaderQueueList) do
		if leaderID == leaderQueueInfo.ID then
			table.remove(self.leaderQueueList,k)
			local player = g_entityMgr:getPlayerByID(leaderID)
			local event = Event.getEvent(TeamEvents_SC_CancelAutoTeam)
			g_eventMgr:fireRemoteEvent(event,player)
			return
		end
	end
end

--获得非队伍玩家处于组队状态的数量
function TeamManager:getQueueListCount()
	local size = 0
	for _,queueInfo in pairs(self.queueList or {}) do
		if queueInfo.autoTeam then
			size = size + 1
		end
	end
	return size
end

--获得队长处于组队状态的数量
function TeamManager:getLeaderQueueListCount()
	local size = 0
	for _,queueInfo in pairs(self.leaderQueueList or {}) do
		if queueInfo.autoTeam then
			size = size + 1
		end
	end
	return size
end

--获得队伍
function TeamManager:getTeam(teamID)
	return self._teams[teamID]
end

function TeamManager.getInstance()
	return TeamManager()
end
