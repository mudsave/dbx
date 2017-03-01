--[[PatrolNpc.lua
描述：
	PatrolNpc类
--]]

require "base.base"
require "entity.Entity"

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

function PatrolNpc:beginScopeMove()
	self.isMove = true
	local x, y
	local mapID = self._scene:getMapID()
	local pos = self:getPos()
	while((not x and not y) or not CoScene:PosValidate(mapID, x or 0, y or 0, 0)) or (x == pos[2] and y == pos[3]) do
		x = math.random(pos[2] - self.radius, pos[2] + self.radius)
		y = math.random(pos[3] - self.radius, pos[3] + self.radius)
	end
	self._handlers[HandlerDef_Move]:Move({x, y})
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
	self.startTime = nowTime + 4
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
