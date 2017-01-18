--[[PatrolNpc.lua
描述：
	PatrolNpc类
--]]

require "base.base"
require "entity.Entity"

PatrolNpc = class(Entity, Timer)

function PatrolNpc:__init()
	self._dbID = nil
	self.scriptID = 0
	self.radius = nil
	self.ownerID = nil
end

function PatrolNpc:__release()
	self._dbID = nil
	self.scriptID = nil
	self.radius = nil
	self.ownerID = nil
	if self.timerID  then 
		g_timerMgr:unRegTimer(self.timerID)
		self.timerID = nil
	end
	
end

function PatrolNpc:setCatchPet(catchPet)
	self.catchPet = catchPet
end

function PatrolNpc:getCatchPet()
	return self.catchPet
end

function PatrolNpc:beginScopeMove()
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

-- 移动停止注册一个5秒定时器
function PatrolNpc:moveNext()
	if not self.ownerID then
		self.timerID = g_timerMgr:regTimer(self, 5*1000, 5*1000, "moveNext")
	end
end

-- 停止5秒之后
function PatrolNpc:update()
	if self.timerID  then
		g_timerMgr:unRegTimer(self.timerID)
		self.timerID = nil
		self:beginScopeMove()
	end
end

function PatrolNpc:setOwnerID(playerID)
	self.ownerID = playerID
end

function PatrolNpc:getOwnerID()
	return self.ownerID
end