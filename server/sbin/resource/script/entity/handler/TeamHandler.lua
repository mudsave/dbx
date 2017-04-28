--[[TeamHandler.lua
描述��?
	实体的组队handler
--]]

TeamHandler = class()

function TeamHandler:__init(entity)
	self._entity = entity
	self.teamID = InvalidTeamID
	self.teaminviteList = {}
end

function TeamHandler:__release()
	self.teaminviteList = nil
	self.teamID = nil
	self._entity = nil
end

function TeamHandler:isTeam()
	return self.teamID ~= InvalidTeamID
end

function TeamHandler:isLeader()
	local team = g_teamMgr:getTeam(self.teamID)
	if not team then
		return
	end
	return team:getLeaderID() == self._entity:getID()
end

function TeamHandler:setTeamID(teamID)
	self.teamID = teamID
end

function TeamHandler:getTeamID()
	return self.teamID
end

function TeamHandler:getTeaminviteList()
	return self.teaminviteList
end

function TeamHandler:addTeaminviteList(playerID)
	table.insert(self.teaminviteList,playerID)
end

function TeamHandler:removeTeaminviteList(playerID)
	for k,ID in pairs(self.teaminviteList) do
		if ID == playerID then
			table.remove(self.teaminviteList,k)
		end
	end
end

--判断自己是否在暂离状��?
function TeamHandler:isStepOutState()
	local team = g_teamMgr:getTeam(self.teamID)
	if not team then
		return
	end
	local memberList = team:getMemberList()
	for _,memberInfo in pairs(memberList) do
		if memberInfo.memberID == self._entity:getID() then
			return MemberState.StepOut == memberInfo.memberState
		end
	end
	return false
end

--不带暂离��?
function TeamHandler:getTeamPlayerList(isAll)
	local team = g_teamMgr:getTeam(self.teamID)
	if not team then
		return
	end
	local memberList = team:getMemberList()
	local playerList = {}
	for _,memberInfo in pairs(memberList) do
		if isAll then
			local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
			table.insert(playerList,player)
		elseif memberInfo.memberState ~= MemberState.StepOut then
			local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
			table.insert(playerList,player)
		end
	end
	return playerList
end

--带暂离的
function TeamHandler:getTeamAllPlayerList()
	local team = g_teamMgr:getTeam(self.teamID)
	if not team then
		return
	end
	local memberList = team:getMemberList()
	local playerList = {}
	for _,memberInfo in pairs(memberList) do
		local player = g_entityMgr:getPlayerByID(memberInfo.memberID)
		table.insert(playerList,player)
	end
	return playerList
end


-- 非暂离人员的最��? 最小等级比
function TeamHandler:getCurMaxAndMinLvl()
	local playerList = self:getTeamPlayerList()
	local maxLvl = self._entity:getLevel()
	local minLvl = maxLvl
	local curLvl = 0
	-- 求最大最小��?
	for _,player in pairs(playerList) do
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

-- 非暂离人员的人数
function TeamHandler:getCurMemberNum()
	local playerList = self:getTeamPlayerList()
	return table.size(playerList)
end

function TeamHandler:isExistStepOut()
	local team = g_teamMgr:getTeam(self.teamID)
	if not team then
		return
	end
	local memberList = team:getMemberList()
	for _,memberInfo in pairs(memberList) do
		if MemberState.StepOut == memberInfo.memberState then
			return true
		end
	end
	return false
end

--跟随宠改变调用
function TeamHandler:setLeaderFollowPetID(playerID)
	local team = g_teamMgr:getTeam(self.teamID)
	if not team then return end 
	local leaderID = team:getLeaderID()
	if leaderID ~= playerID then return end
	local leader = g_entityMgr:getPlayerByID(leaderID)
	local memberList = team:getMemberList()
	local followPetID = leader:getFollowPetID()
	for _,memberInfo in pairs(memberList) do
		local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
		local event = Event.getEvent(TeamEvents_CS_SendLeaderFollowID,followPetID)
		g_eventMgr:fireRemoteEvent(event,member)
	end
end

--队长变更调用
function TeamHandler:sendLeaderFollowPetID()
	local team = g_teamMgr:getTeam(self.teamID)
	if not team then return end 
	local leaderID = team:getLeaderID()
	local leader = g_entityMgr:getPlayerByID(leaderID)
	local memberList = team:getMemberList()
	local followPetID = leader:getFollowPetID()
	for _,memberInfo in pairs(memberList) do
		local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
		local event = Event.getEvent(TeamEvents_CS_SendLeaderFollowID,followPetID)
		g_eventMgr:fireRemoteEvent(event,member)
	end
end
