--[[MoveSystem.lua

description:
	
	move system is use to communication with the client for the entity move
]]

local function dirToPos(dir, x, y)
	if dir == Direction.EastSouth then
		x = x + 1
	elseif dir == Direction.East then
		x = x + 1
		y = y + 1
	elseif dir == Direction.EastNorth then
		y = y + 1
	elseif dir == Direction.North then
		x = x - 1
		y = y + 1
	elseif dir == Direction.WestNorth then
		x = x - 1
	elseif dir == Direction.West then
		x = x - 1
		y = y - 1
	elseif dir == Direction.WestSouth then
		y = y - 1
	elseif dir == Direction.South then
		x = x + 1
		y = y - 1
	end
	return x, y
end

local function dirToPath(dirPath, x, y)
	local paths = {}
	table.insert(paths, x)
	table.insert(paths, y)
	for _, dir in ipairs(dirPath) do
		x, y = dirToPos(dir, x, y)
		table.insert(paths, x)
		table.insert(paths, y)
	end
	return paths
end

function correctMovePath(roleID,x,y)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return	
	end
	local peer =  player:getPeer()
	local curIdx = peer:correctMovePath(x,y)

	if curIdx == -1 then
		return
	end
	
	local followedEntity = peer
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team and team:getLeaderID() == player:getID() then
		local teamList = team:getMemberList()
		if teamList and table.size(teamList) > 1 then --加个是队长判断	
			for _,memberInfo in pairs(teamList) do
				if memberInfo.memberState == MemberState.Follow then
					local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
					curIdx = member:getPeer():correctFollowMovePath(curIdx, followedEntity:getPathLen())
					followedEntity = member:getPeer()
				end
			end
		end
	end

	local mapID = player:getScene():getMapID()
	local followHandler = player:getHandler(HandlerDef_Follow)
	local followList = followHandler:getMembers()
	for memberID, member in pairs(followList) do	
		if member:isVisible() then
			if mapDB[mapID].mapType == MapType.Task or mapDB[mapID].mapType == MapType.Wild or member:getTaskType() == TaskType.loop then
				curIdx = member:getPeer():correctFollowMovePath(curIdx, followedEntity:getPathLen())
				followedEntity = member:getPeer()
			end
		end
	end

	local ectypeFollowList = followHandler:getEctypeMembers()
	for memberID, member in pairs(ectypeFollowList) do	
		if member:isVisible() then
			if member:getTaskType() == TaskType2.Copy then
				curIdx = member:getPeer():correctFollowMovePath(curIdx, followedEntity:getPathLen())
				followedEntity = member:getPeer()
			end
		end
	end
	
	local petID = player:getFollowPetID()
	if petID then
		local pet = g_entityMgr:getPet(petID)
		if pet and pet:isVisible() then
			pet:getPeer():correctFollowMovePath(curIdx, followedEntity:getPathLen())
		end
	end
end

MoveSystem = class(EventSetDoer, Singleton)

function MoveSystem:__init()
		self._doer =
		{
			[MoveEvent_CS_MoveTo]				= MoveSystem.doMoveTo,			--client notice server start move
			[MoveEvent_CS_StopMove]				= MoveSystem.doStopMove,		--client notice server stop move
			[MoveEvent_SS_StartMove]			= MoveSystem.doServerMoveTo,     -- server call server start move
			[MoveEvent_SS_StopMove]				= MoveSystem.doServeStopMove,	--server call server stop move
			[MoveEvent_SS_OnStopMove]			= MoveSystem.onServerStopMove,	--server entity stop call back
		}
end

function MoveSystem:__release()

end

function MoveSystem:doMoveTo(event)
	local params = event:getParams()
	local roleID = params[1]
	local mapID = params[2]
	local bEndPath = params[3]
	local step = params[4]
	local len = params[5]
	local player = g_entityMgr:getPlayerByID(roleID)

	if not player then
		return
	end
	
	local moveHandler = player:getHandler(HandlerDef_Move)
	if not moveHandler then
		return 
	end

	local scene = player:getScene()
	local curMapID = scene:getMapID()
	if mapID ~= curMapID then
		moveHandler:DoStopMove()
		return 
	end

	if not player:isCanMove() then
		moveHandler:DoStopMove()
		return
	end

	local x = params[6]
	local y = params[7]
	
	local dirPath = params[8]
	local realPath = dirToPath(dirPath, x, y)
	if realPath and table.size(realPath) >= 2 then
		correctMovePath(roleID, realPath[1], realPath[2])
		g_PosData.bMove = true
		g_PosData.len = len + 1
		g_PosData.idx = 0
		g_PosData.delay = 0
		g_PosData.step = step
		g_PosData.endPath = bEndPath
		moveHandler:MoveEntity(g_PosData, realPath)
	else
		moveHandler:DoStopMove()
	end
end

function MoveSystem:doStopMove(event)
	local params = event:getParams()
	local roleID = params[1]
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	local moveHandler = player:getHandler(HandlerDef_Move)
	if moveHandler and moveHandler:GetIsInMove() then
		moveHandler:DoStopMove()
	end
end

--if move by path, now just support MAX_PATH_LEN(16)*8 path
--because temporay the path don't know how to place
function MoveSystem:doServerMoveTo(evnet)
	local params = evnet:getParams()
	local roleID = params[1]
	local entityType = params[2]
	local bPath = params[3]
	local realPath = params[4]
	local entity = g_entityMgr:getEntity(entityType, roleID)
	if entity then
		if entity:getEntityType() == eClsTypePlayer then
			if not entity:isCanMove() then
				return 
			end
		end
		local handler = entity:getHandler(HandlerDef_Move)
		if handler then
			if bPath then
				local len = table.size(realPath)
				if len >= 2 then
					correctMovePath(roleID, realPath[1], realPath[2])
					g_PosData.bMove = true
					g_PosData.len = len 
					g_PosData.idx = 0
					g_PosData.delay = 0
					g_PosData.step = 0
					g_PosData.endPath = true
					moveHandler:MoveEntity(g_PosData, realPath)
				end
			else
				moveHandler:Move({realPath[1], realPath[2]})
			end
		end
	end
end				

function MoveSystem:doServerStopMove(evnet)
	local params = event:getParams()
	local roleID = params[1]
	local entityType = params[2]
	local targetTile = params[3]
	local entity = g_entityMgr:getEntity(entityType, roleID)
	if entity then
		local handler = entity:getHandler(HandlerDef_Move)
		if handler and handler:GetIsInMove() then
			handler:DoStopMove(nil, targetTile)
		end
	end
end

function MoveSystem:onServerStopMove(event)
	local params = event:getParams()
	local entityID = params[1]
	local mineNpc = g_entityMgr:getMineNpc(entityID)
	if mineNpc then
		mineNpc:moveNext()
	end
	local patrolNpc = g_entityMgr:getPatrolNpc(entityID)
	if patrolNpc then
		patrolNpc:moveNext()
	end
end

function MoveSystem.getInstance()
	return MoveSystem()
end

EventManager.getInstance():addEventListener(MoveSystem.getInstance())
