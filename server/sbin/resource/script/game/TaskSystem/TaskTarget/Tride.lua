--[[Tride.lua
描述：
	上坐骑目标
]]

Tride = class(TaskTarget)

function Tride:__init(entity, task, param, state)
	self._state = state or 0
	self:addWatcher("onUpRide")
end

function Tride:onUpRide(rideID)
	if self._param.rideID <= rideID then
		self:setState(self._state + 1)
		if self:completed() then
			self:removeWatchers()
			self._task:refresh()
		end
	end
end

function Tride:completed()
	return self._state >= 1
end

function Tride:getState()
	return self._state
end

function Tride:removeWatchers()

end

function Tride:removeAllWatchers()
	self:removeWatcher("onUpRide")
end
