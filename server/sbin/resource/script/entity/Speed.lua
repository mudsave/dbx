--[[
description:
	entity speed script

	if entity is not player
	the self speed is useful.
	the team speed is not useful
	
	temporary, i think is not necessary to separate.
]]

DefaultSpeed = 40

Speed = class()

function Speed:__init(entity)
	self.m_entity = entity
	self.m_team = DefaultSpeed
	self.m_self = DefaultSpeed
	self.m_cur = DefaultSpeed
end

function Speed:__release()
	self.m_entity = nil
	self.m_team = nil
	self.m_self = nil
	self.m_cur = nil
end

function Speed:SetSpeed(value)
	local player = self.m_entity
	if player:getEntityType() == eClsTypePlayer then
		local handle = player:getHandler(HandlerDef_Team)
		if handle and handle:isTeam() then
			if handle:isLeader() then
				self.m_self = value
				local teamList = handle:getTeamPlayerList()
				for _, entity in pairs(teamList) do
					entity:setTeamSpeed(value)
				end
			else
				if handle:isStepOutState() then
					self:setSelfSpeed(value)
				else
					self.m_self = value
				end
			end
		else
			self:setSelfSpeed(value)
		end
	else
		self:setSelfSpeed(value)
	end
end

function Speed:SetTeamSpeed(value)
	self.m_team = value
	self:setCurSpeed(value)
end

function Speed:setSelfSpeed(value)
	self.m_self = value
	self:setCurSpeed(value)
end

function Speed:setCurSpeed(value)
	local player = self.m_entity
	self.m_cur = value
	local peer = player:getPeer()
	peer:setMoveSpeed(value)
	
	--follow entity speed
	if player:getEntityType() == eClsTypePlayer then
		local followHadler = player:getHandler(HandlerDef_Follow)
		if followHandler then
			local followList = followHandler:getMembers()
			for _, member in pairs (followList) do
				member:setMoveSpeed(value)
			end
			--[[local ectypeList = followHandler:getEctypeMembers()
			for _, memeber in pairs(ectypeList) do
				memeber:setMoveSpeed(value)
			end]]
		end
	
		--[[local petID = player:getdFollowPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			if pet and pet:isVisible() then
				pet:setMoveSpeed(value)
			end
		end]]
	end
end

function Speed:GetSpeed()
	return self.m_cur
end

function Speed:GetSelfSpeed()
	return self.m_self
end

function Speed:ChangeMoveSpeed(value)
	local speed = self:GetSelfSpeed() * value/100
	speed = speed + self.m_self
	self:setSelfSpeed(value)
	if self.m_entity:getEntityType() == eClsTypePlayer then
		local handle = self.m_entity:getHandler(HandleDef_Team)
		if handle and handle:isTeam() then
			if handle:isLeader() then
				self.m_self = speed
				local teamList = handle:getTeamPlayerList()
				for _, entity in pairs(teamList) do
					entity:setTeamSpeed(speed)
				end
			else
				if handle:isStepOutState() then
					self:setSelfSpeed(speed)
				else
					self.m_self = speed
				end
			end
		else
			self:setSelfSpeed(speed)
		end
	end
end
