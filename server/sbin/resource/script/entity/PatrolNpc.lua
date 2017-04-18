--[[PatrolNpc.lua
描述：
	PatrolNpc类
--]]

require "base.base"
require "entity.Entity"
local relative = 65536

PatrolNpc = class(Entity)

function PatrolNpc:__init()
	self._dbID = nil
	self.scriptID = 0
	self.radius = nil
	self.ownerID = nil
	self.isMove = false
	self.startTime = nil
	self.bindPetID = nil
end

function PatrolNpc:__release()
	self._dbID = nil
	self.scriptID = nil
	self.radius = nil
	self.ownerID = nil
	self.isMove = nil
	self.startTime = nil
	self.bindPetID = nil
end

function PatrolNpc:setCatchPet(catchPet)
	self.catchPet = catchPet
end

function PatrolNpc:getCatchPet()
	return self.catchPet
end

-- 第一次来找下一个位置
function PatrolNpc:beginScopeMove()
	self.isMove = true
	local x, y
	local mapID = self._scene:getMapID()
	local pos = self:getPos()
	local times = 0
	while(( not CoScene:PosValidate(mapID, x or 0, y or 0, 0)) or (x == pos[2] and y == pos[3])) do
		if times > 50 then
			x = pos[2]
			y = pos[3]
			break
		end
		times = times + 1
		x = math.random(pos[2] - self.radius, pos[2] + self.radius)
		y = math.random(pos[3] - self.radius, pos[3] + self.radius)
	end
	self._handlers[HandlerDef_Move]:Move({x, y})
end


-- 找着个里面有没有所在的位置
function PatrolNpc:startMove()
	self.isMove = true
	local mapID = self._scene:getMapID()
	local pos = self:getPos()
	local pointValue = pos[2]*relative + pos[3]
	local mapPoint = WayPoint[mapID].point
	-- 如果地图存在当前坐标
	curConfig = mapPoint[pointValue]
	--print("begin move postion", pos[2], pos[3])
	if curConfig then
		local paths =  WayPoint[mapID].paths
		local index = math.random(1, #curConfig)
		local id = curConfig[index].id
		local bReverse = curConfig[index].bReverse
		local oldPath = paths[id].path
		local path = {}
		local nLen = paths[id].nPathLen * 2
		if bReverse then
		
			for idx = 1, nLen, 2 do
				path[idx] = oldPath[nLen - idx]
				path[idx + 1] = oldPath[nLen - idx + 1]
			end
		else
			for idx = 1, nLen, 2 do
				path[idx] = oldPath[idx]
				path[idx + 1] = oldPath[idx + 1]
			end
		end
		--print("路径是。。。。。。。。。", toString(path))
		--print("起始点》》》》》》》》", path[1], path[2], path[#path - 1], path[#path])
		g_PosData.bMove = true
		g_PosData.len = paths[id].nPathLen
		g_PosData.idx = 0
		g_PosData.delay = 0
		g_PosData.step = 0
		g_PosData.endPath = true
		self._handlers[HandlerDef_Move]:ServerMoveEntity(g_PosData, path)
	else
		-- 取最小的绝对值, 没有的点
		local value = nil
		local destX = 0
		local destY = 0
		for pointValueConfig, _ in pairs(mapPoint) do
			local x = bit_rshift(pointValueConfig, 16)
			local y = pointValueConfig - x * relative
			local xDelta = math.abs(pos[2] - x)
			local yDelta = math.abs(pos[3] - y)
			local delta = xDelta + yDelta
			if not value then
				value = delta
				destX = x
				destY = y
			else
				if delta < value then
					value = delta
					destX = x
					destY = y
				end
			end
		end
		-- 根据getConfigPoint 获取坐标
		--print("not random position, destPosition",pos[2], pos[3], destX, destY)
		self._handlers[HandlerDef_Move]:Move({destX, destY})
	end
end

function PatrolNpc:setScriptID(scriptID)
	self.scriptID = scriptID
end

function PatrolNpc:getScriptID()
	return self.scriptID
end

function PatrolNpc:setDBID(dbID)
	self._dbID = dbID
end

function PatrolNpc:getDBID()
	return self._dbID
end

function PatrolNpc:setRadius(radius)
	self.radius = radius
end

-- 此时设置四秒时间让NPC移动
function PatrolNpc:moveNext()
	self.isMove = false
	local nowTime = os.time()
	self.startTime = nowTime + 2
	local pos = self:getPos()
end


function PatrolNpc:setOwnerID(playerID)
	self.ownerID = playerID
end

function PatrolNpc:getOwnerID()
	return self.ownerID
end

function PatrolNpc:setStartMoveTime(startTime)
	self.startTime = startTime
end

function PatrolNpc:getStartMoveTime()
	return self.startTime
end

function PatrolNpc:getMoveState()
	return self.isMove
end

function PatrolNpc:setBindPetID(petID)
	self.bindPetID = petID
end

function PatrolNpc:getBindPetID()
	return self.bindPetID
end
