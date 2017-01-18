--[[FollowHandler.lua
描述：
	针对任务的跟随handler
--]]

FollowHandler = class()

function FollowHandler:__init(entity)
	self.entity = entity
	self._memberList = {}
	self._ectypeMemberList = {}
end

function FollowHandler:__release()
	self:clearFollows()
	self._entity = nil
	self._memberList = nil
	self._ectypeMemberList = nil
end

function FollowHandler:loadFollowEntity(mapID, x ,y)
	for npcID, npc in pairs(self._memberList) do
		--x = x - 1
		--y = y - 1
		if mapDB[mapID].mapType == MapType.Task or mapDB[mapID].mapType == MapType.Wild or npc:getTaskType() == TaskType.loop then
			--print("跟随进入场景",mapID,toString({npc, x, y}))
			g_sceneMgr:enterPublicScene(mapID, npc, x, y)
		end
	end
end

function FollowHandler:loadFollowEntityEx(ectypeMapID, enterPosX, enterPosY)
	for npcID, npc in pairs(self._ectypeMemberList) do
		--x = x - 1
		--y = y - 1
		if npc:getTaskType() == TaskType2.Copy then
			g_sceneMgr:enterEctypeScene(ectypeMapID, {npc, enterPosX, enterPosY})
		end
	end
end

function FollowHandler:addMember(member)
	self._memberList[member:getDBID()] = member
end

function FollowHandler:addEctypeMember(member)
	self._ectypeMemberList[member:getDBID()] = member
end

function FollowHandler:getMember(memberDBID)
	return self._memberList[memberDBID]
end

function FollowHandler:getEctypeMember(memberDBID)
	return self._ectypeMemberList[memberDBID]
end

function FollowHandler:getMembersID()
	local idList = {}
	for id, member in pairs(self._memberList) do
		table.insert(idList, {id, member:getTaskType()})
	end
	return idList
end

function FollowHandler:getMembers()
	return self._memberList
end

function FollowHandler:getEctypeMembers()
	return self._ectypeMemberList
end

function FollowHandler:removeMember(memberID)
	if self._memberList[memberID] then
		-- 实体销毁在Scene:detachEntity(entity) 
		--release(self._memberList[memberID])
		self._memberList[memberID] = nil
	end
end

function FollowHandler:removeEctypeMember(memberID)
	if self._ectypeMemberList[memberID] then
		release(self._ectypeMemberList[memberID])
		self._ectypeMemberList[memberID] = nil
	end
end

function FollowHandler:clearFollows()
	for memberID, member in pairs(self._memberList) do
		self:removeMember(memberID)
	end
	for memberID, member in pairs(self._ectypeMemberList) do
		self:removeEctypeMember(memberID)
	end
end
