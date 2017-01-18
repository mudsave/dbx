--[[TattainLevel.lua
描述：
	等级目标
]]

TattainLevel = class(TaskTarget)

function TattainLevel:__init(entity, task, param, state)
	self._state = 0
	self:addWatcher("onAttainLevel")
end

function TattainLevel:onAttainLevel(level)
	if self._param.level <= level then
		self:setState(self._state + 1)
		if self:completed() then
			self:removeWatchers()
			self._task:refresh()
		end
	end
end

function TattainLevel:completed()
	return self._state >= 1
end

function TattainLevel:getState()
	return self._state
end

function TattainLevel:removeWatchers()
	self:removeWatcher("onAttainLevel")
end

function TattainLevel:removeAllWatchers()
	self:removeWatcher("onAttainLevel")
end
