--[[TileUtils.lua

description: tile relation function
]]

TileUtils = {}

local curScene = nil
local maxSearchCount = 3
local curSearchCount = 0
local newPos = {x = 0, y = 0}
--pos + offset around 8 tile 
local function getTile(pos, offset)
	curSearchCount = curSearchCount + 1
	local x = pos.x
	local y = pos.y
	local peer = curScene:getPeer()

	--EastNorth
	y = pos.y - offset
	bValue = peer:posValidate(x, y, 0)
	if bValue then
		newPos.x = x
		newPos.y = y
		return newPos
	end
	--EastSouth
	x = x + offset
	local bValue = peer:posValidate(x, y, 0)
	if bValue then
		newPos.x = x
		newPos.y = y
		return newPos
	end
	--WestNorth
	x = pos.x - offset
	bValue = peer:posValidate(x, y, 0)
	if bValue then
		newPos.x = x
		newPos.y = y
		return newPos
	end
	--WestSouth
	x = pos.x
	y = y + offset
	bValue = peer:posValidate(x, y, 0)
	if bValue then
		newPos.x = x
		newPos.y = y
		return newPos
	end
	--East
	x = pos.x + offset
	y = pos.y + offset
	bValue = peer:posValidate(x, y, 0)
	if bValue then
		newPos.x = x
		newPos.y = y
		return newPos
	end
	--West
	x = pos.x - offset
	y = pos.y - offset
	bValue = peer:posValidate(x, y, 0)
	if bValue then
		newPos.x = x
		newPos.y = y
		return newPos
	end
	--North
	x = pos.x - offset
	y = pos.y + offset
	bValue = peer:posValidate(x, y, 0)
	if bValue then
		newPos.x = x
		newPos.y = y
		return newPos
	end
	--South
	x = pos.x + offset
	y = pos.y - offset
	bValue = peer:posValidate(x, y, 0)
	if bValue then
		newPos.x = x
		newPos.y = y
		return newPos
	end
	
	--超过最大的搜寻次数了 
	if curSearchCount < maxSearchCount then
		return getTile(pos, offset + 1)
	else
		return
	end
end

--circle ring
--bFollow是否需要考虑到跟随实体
--maxCount 最大的搜寻次数  次数增加 那么offset也会跟着变大
function TileUtils.getVaildTile(player, offset, bFollow, maxCount)
	if player then
		local info = player:getPos()
		local pos = {x = info[2], y = info[3]}
		if not offset or offset <= 0 then
			return pos
		else
			newPos.x = 0
			newPos.y = 0
			curScene = player:getScene()
			if not maxCount then
				maxSearchCount = 3
			end
			curSearchCount = 0
			if curScene then
				if bFollow then
					local nCount = 0
					local teamHandler = player:getHandler(HandlerDef_Team)
					local teamID = teamHandler:getTeamID()
					local team = g_teamMgr:getTeam(teamID)
					if team and team:getLeaderID() == player:getID() then
						local teamList = team:getMemberList()
						local index = 0
						if teamList and table.size(teamList) > 1 then --加个是队长判断	
							for _, memberInfo in pairs(teamList) do
								if memberInfo.memberState == MemberState.Follow then
									nCount = nCount + 1
								end
							end
							--队长也在这个成员当中 
							nCount = nCount - 1
						end
					end
					local mapID = player:getScene():getMapID()
					local followHandler = player:getHandler(HandlerDef_Follow)
					local followList = followHandler:getMembers()
					for memberID, member in pairs(followList) do	
						if mapDB[mapID].mapType == MapType.Task or mapDB[mapID].mapType == MapType.Wild or member:getTaskType() == TaskType.loop then
							nCount = nCount + 1
						end
					end
					local ectypeFollowList = followHandler:getEctypeMembers()
					for memberID, member in pairs(ectypeFollowList) do	
						if member:getTaskType() == TaskType2.Copy then
							nCount = nCount + 1
						end
					end
					--宠物
					local petID = player:getFollowPetID()
					if petID then
						local pet = g_entityMgr:getPet(petID)
						if pet and pet:isVisible() then
							nCount = nCount + 2
						end
					end
					offset = offset + nCount
				end
				return getTile(pos, offset)
			end
		end
	end
end
