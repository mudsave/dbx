--[[TobtainPet.lua
描述：
	任务目标：经过某区域，本目标不可逆
--]]

TobtainPet = class(TaskTarget)

function TobtainPet:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onObtainPet")
	end
end

function TobtainPet:onObtainPet(petID)
	if petID == self._param.petID then
		self:setState(self._state + 1)
		if self:completed() then
			self:removeWatchers()
			self._task:refresh()
		end
	end
end

function TobtainPet:completed()
	return self._state >= self._param.count
end

function TobtainPet:removeWatchers()
	self:removeWatcher("onObtainPet")
end
