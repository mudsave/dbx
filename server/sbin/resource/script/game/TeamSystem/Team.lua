--[[Team.lua
描述:
	队伍信息
]]

Team = class()

function Team:__init(teamID,leaderID)
	self.teamID = teamID
	self.leaderID = leaderID
	self.allMemberList = {}
	self.inviteList = {}
	self:setLeader(leaderID)
end

function Team:__release()
	self.teamID = nil
	self.leaderID = nil
	self.allMemberList = nil
	self.inviteList = nil
end

--获得队长ID
function Team:getLeaderID()
	return self.leaderID
end

--获得队伍ID
function Team:getTeamID()
	return self.teamID
end

function Team:getMemberCount()
	return table.size(self.allMemberList)
end

--获得成员列表
function Team:getMemberList()
	return self.allMemberList
end

--将玩家存到自己的邀请列表中
function Team:addinviteList(targetID)
	table.insert(self.inviteList,targetID)
end

--将玩家移除自己的邀请列表中
function Team:removeinviteList(targetID)
	for k,ID in pairs(self.inviteList) do
		if ID == targetID then
			table.remove(self.inviteList,k)
		end
	end
end

--判断被邀请玩家是否已经存在自己的要求列表中
function Team:existInviteList(targetID)
	for k,ID in pairs(self.inviteList) do
		if ID == targetID then
			return true
		end
	end
	return false
end

--是否队伍已经满了
function Team:isFull()
	return table.size(self.allMemberList)>= MaxTeamMember
end

--设置队长
function Team:setLeader(playerID)
	local memberInfo = {memberID = playerID,memberState = MemberState.Leader}
	table.insert(self.allMemberList,memberInfo)
	local player = g_entityMgr:getPlayerByID(playerID)
	player:setActionState(PlayerStates.Team)
end

--更换队长
function Team:changeLeader(leaderID,targetID)
	local player = g_entityMgr:getPlayerByID(leaderID)
	local targetPlayer = g_entityMgr:getPlayerByID(targetID)
	if not targetPlayer then
		local haveFollowMem = false
		for k,memberInfo in pairs(self.allMemberList) do
			if memberInfo.memberState == MemberState.Follow then
				haveFollowMem = true
				targetID = memberInfo.memberID
				break
			end
		end
		if haveFollowMem then
			targetPlayer = g_entityMgr:getPlayerByID(targetID)
		end
	end
	if targetPlayer then
		--如果转移目标处于暂离状态责返回提示信息
		for _,memberInfo in pairs(self.allMemberList) do
			if memberInfo.memberID == targetID then
				if memberInfo.memberState == MemberState.StepOut then
					local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Team, 2)
					g_eventMgr:fireRemoteEvent(event, player)
					return
				end
			end
		end

		--更换成队长，重新设置速度
		self.leaderID = targetID
		targetPlayer:setMoveSpeed(targetPlayer:getSelfSpeed())

		for _,memberInfo in pairs(self.allMemberList) do
			local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
			if memberInfo.memberID == self.leaderID then
				memberInfo.memberState = MemberState.Leader
				player:setActionState(PlayerStates.Team)
			end
			if memberInfo.memberID == leaderID then
				memberInfo.memberState = MemberState.Follow
				player:setActionState(PlayerStates.Follow)
			end
		end
		--如果此人在副本中，切换机关
		local ectypeHandler = targetPlayer:getHandler(HandlerDef_Ectype)
		local ectypeMapID = ectypeHandler:getEctypeMapID()
		local ectype = g_ectypeMgr:getEctype(ectypeMapID)
		if ectype then
			SceneSystem.getInstance():changeLeader(self.leaderID)
		end
		return self.leaderID
	end
end

--队长退出队伍
function Team:leaderQuit()
	local leader = g_entityMgr:getPlayerByID(self.leaderID)
	if leader:getActionState() == PlayerStates.FightAndTeam or leader:getActionState() == Fight then
		leader:setOldActionState(PlayerStates.Normal)
	end
	self:removeMember(self.leaderID)
	local haveFollowMem = false
	if table.size(self.allMemberList) > 0 then
		for k,memberInfo in pairs(self.allMemberList) do
			if memberInfo.memberState == MemberState.Follow then
				haveFollowMem = true
				memberInfo.memberState = MemberState.Leader
				self.leaderID = memberInfo.memberID
				local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
				if player:getActionState() == PlayerStates.Fight then
					player:setOldActionState(PlayerStates.Team)
					player:setActionState(PlayerStates.FightAndTeam)
				else
					player:setActionState(PlayerStates.Team)
				end
				break
			end
		end
		if not haveFollowMem then
			for k,memberInfo in pairs(self.allMemberList) do
				if memberInfo.memberState == MemberState.StepOut then
					memberInfo.memberState = MemberState.Leader
					self.leaderID = memberInfo.memberID
					local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
					if player:getActionState() == PlayerStates.Fight then
						player:setOldActionState(PlayerStates.Team)
						player:setActionState(PlayerStates.FightAndTeam)
					else
						player:setActionState(PlayerStates.Team)
					end
					--暂离变为变为队长不用设速度
					break
				end
			end
		end
	else
		self:release()
	end
end

--添加跟随队员
function Team:addMember(playerID,memberState)
	local memberInfo = {memberID = playerID,memberState = memberState}
	table.insert(self.allMemberList,memberInfo)
	local player = g_entityMgr:getPlayerByID(playerID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	teamHandler:setTeamID(self.teamID)
	if memberState == MemberState.StepOut then
		player:setActionState(PlayerStates.Normal)
	else
		player:setActionState(PlayerStates.Follow)
		--入队伍，设置为队长速度
		local leader = g_entityMgr:getPlayerByID(self:getLeaderID())
		player:setTeamSpeed(leader:getMoveSpeed())
	end

	
end

--移除队员
function Team:removeMember(playerID)
	for k,memberInfo in pairs(self.allMemberList) do
		if memberInfo.memberID == playerID then
			table.remove(self.allMemberList,k)
			break
		end
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	player:setActionState(PlayerStates.Normal)
	
	local teamHandler = player:getHandler(HandlerDef_Team)
	teamHandler:setTeamID(InvalidTeamID)
	--被移除队伍设置速度
	print("-----退出队伍-----------d----",player:getName(),player:getSelfSpeed())
	player:setMoveSpeed(player:getSelfSpeed())

end

--暂时离开
function Team:stepOut(playerID)
	for _,memberInfo in pairs(self.allMemberList) do
		if memberInfo.memberID == playerID then
			memberInfo.memberState = MemberState.StepOut
			local player = g_entityMgr:getPlayerByID(playerID)
			player:setActionState(PlayerStates.Normal)
			--暂离，恢复原来速度
			player:setMoveSpeed(player:getSelfSpeed())
			local id = player:getFollowPetID()
			local pet = id and player:getPet(id)
			if pet then
				pet:setVisible(true)
			end
		end
	end
end

--归队
function Team:comeBack(playerID)
	for _,memberInfo in pairs(self.allMemberList) do
		if memberInfo.memberID == playerID then
			memberInfo.memberState = MemberState.Follow
			--归队伍，设置为队长速度
			local leader = g_entityMgr:getPlayerByID(self:getLeaderID())
			local player = g_entityMgr:getPlayerByID(playerID)
			player:setTeamSpeed(leader:getMoveSpeed())
			local id = player:getFollowPetID()
			local pet = id and player:getPet(id)
			if pet then
				pet:setVisible(false)
			end
		end
	end
end

function Team:getMaxAndMinLvl()
	local player = g_entityMgr:getPlayerByID(self.leaderID)
	local maxLvl = player:getLevel()
	local minLvl = maxLvl
	local curLvl = 0
	-- 求最大最小值
	for _,memberInfo in pairs(self.allMemberList) do
		player = g_entityMgr:getPlayerByID(memberInfo.memberID)
		curLvl = player:getLevel()
		if curLvl > maxLvl then
			maxLvl = curLvl
		end
		if curLvl < minLvl then
			minLvl = curLvl
		end
	end
	return maxLvl,minLvl
end
