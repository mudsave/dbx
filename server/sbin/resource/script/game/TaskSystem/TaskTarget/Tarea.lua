--[[Tarea.lua
描述：
	任务目标：经过某区域，本目标不可逆
--]]

Tarea = class(TaskTarget)

function Tarea:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onPosChanged")
	end
end

function Tarea:onPosChanged(mapID, x, y)
	if mapID == self._param.mapID then
		if (x >= self._param.x - 5) and (y >= self._param.y - 5) and (x <= self._param.x + 5) and (y <= self._param.y + 5) then
			self:setState(self._state + 1)
			if self:completed() then
				self:removeWatcher("onPosChanged")
				self._task:refresh()
			end
		end
	end
end

function Tarea:completed()
	return self._state >= 1
end

function Tarea:removeWatchers()
	self:removeWatcher("onPosChanged")
end
