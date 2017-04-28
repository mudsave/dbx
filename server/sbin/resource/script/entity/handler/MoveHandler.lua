--[[MoveHanler

description:
	
	entity move implement
	other system can get this handle from entity and call the function
]]
MoveHandler = class()

function MoveHandler:__init(entity)
	self.m_entity = entity
	self.m_isMoving = false
end

function MoveHandler:__release()
	self.m_entity = nil
end

function MoveHandler:GetIsInMove()
	return self.m_isMoving
end

function MoveHandler:SetIsInMove(value)
	self.m_isMoving = value
end

--服务器移动的话 路径可以长一点
function MoveHandler:ServerMoveEntity(pPosData, paths)
	local player = self.m_entity
	local peer = player:getPeer()
    peer:moveByPath(pPosData, paths)
end

function MoveHandler:MoveEntity(pPosData, paths)
	local player = self.m_entity
	local peer = player:getPeer()
	--先移动自己
    peer:moveByPath(pPosData, paths)
	
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler and teamHandler:isTeam() then
		if teamHandler:isLeader() then
			local teamList = teamHandler:getTeamPlayerList()
			local follows = nil
			local followEntitys = nil
			if table.size(teamList) > 1 then
				follows = {}
				followEntitys = {}
				for _, entity in pairs(teamList) do
					if entity:getID() ~= player:getID() then
						table.insert(follows, entity:getID())
						table.insert(followEntitys, entity)
					end
				end
			end
			--移动跟随实体
			self:moveFollowEntity(0, pPosData, paths, true, follows)
			if followEntitys then
				local size = table.size(followEntitys)
				for _, member in pairs(followEntitys) do
					local handler = member:getHandler(HandlerDef_Move)
					handler:moveFollowEntity(size, pPosData, paths, false, nil)
				end
			end
		else
			if teamHandler:isStepOutState() then
				self:moveFollowEntity(0, pPosData, paths, true, nil)
			end
		end
	else
		self:moveFollowEntity(0, pPosData, paths, true, nil)
	end
end

function MoveHandler:Move(tarTile)
	self.m_entity:getPeer():move(tarTile[1], tarTile[2], 0x01)
end

--这里注意 如果传targetPos的话 那么所有的实体都会在同一个位置
--不传的话 那么停在当前的位置
function MoveHandler:DoStopMove(bCheckTeam, targetTile)
	local player = self.m_entity
	
	if not bCheckTeam then
		local teamHandler = player:getHandler(HandlerDef_Team)
		if teamHandler and teamHandler:isTeam() then
			if teamHandler:isLeader() then
				local teamList = teamHandler:getTeamPlayerList()
				if teamList and table.size(teamList) > 1 then
					for _, member in pairs(teamList) do
						member:getHandler(HandlerDef_Move):DoStopMove(true, targetTile)
					end
					return
				end
			end
		end
	end
	
	local x = 0
	local y = 0
	if targetTile then
		x = targetTile.x
		y = targetTile.y
	end
	--player:getPeer():stopMove(x, y)

	local follows = {} 
	local followHandler = player:getHandler(HandlerDef_Follow)
	if followHandler then
		local followList = followHandler:getMembers()
		for _, member in pairs(followList) do
			if member:isVisible() then
				--member:getPeer():stopMove(x, y)										
				table.insert(follows, member:getID())
			end
		end
	
		local ectypeFollowList = followHandler:getEctypeMembers()
		for _, member in pairs(ectypeFollowList) do
			if member:isVisible() then
				--member:getPeer():stopMove(x, y)
				table.insert(follows, member:getID())
			end
		end
	end
	local petId = nil
	if player:getEntityType() == eClsTypePlayer then
		local petID = player:getFollowPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			if pet then
				if pet:isVisible() then
					table.insert(follows, petID)
					petId = petID
					--pet:getPeer():stopMove(x, y)
				end
			end
		end
	end
	
	player:getPeer():stopMoveAndFollow(x, y, follows, petId);
end

function MoveHandler:moveFollowEntity(offset, pPosData, paths, bTeamLeader, followList)
	local player = self.m_entity
	local follows = nil
	if followList then
		follows = followList
	else
		follows = {}
	end
	
	local mapID = player:getScene():getMapID()
	local followHandler = player:getHandler(HandlerDef_Follow)

	if followHandler then
		local followList = followHandler:getMembers()
		for memberID, member in pairs(followList) do
			if member:isVisible() then
				if mapDB[mapID].mapType == MapType.Task or mapDB[mapID].mapType == MapType.Wild or member:getTaskType() == TaskType.loop or mapID == 9 then
					table.insert(follows, member:getID())
				end
			end
		end

		local ectypeFollowList = followHandler:getEctypeMembers()
		for memberID, member in pairs(ectypeFollowList) do
			if member:isVisible() then
				if member:getTaskType() == TaskType2.Copy then
					table.insert(follows, member:getID())
				end
			end
		end
	end
	-- 宠物
	local petID = nil
	if bTeamLeader then
		petID = player:getFollowPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			if pet and pet:isVisible() then
				table.insert(follows, petID)
			end
		end
	end
	-- 
	if #follows > 0 and #paths >= 2 then
		local value = player:getHandler(HandlerDef_Ride):getRidingMount() and 3 or 1
		offset = offset + value
		player:getPeer():moveFollowEntity(offset, pPosData, follows, paths, petID)
	end
end
