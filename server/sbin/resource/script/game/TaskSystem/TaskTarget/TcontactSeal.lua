--[[TcontactSeal.lua
描述：
	解除封印
--]]

TcontactSeal = class(TaskTarget)

function TcontactSeal:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onContactSeal")
	end
end

function TcontactSeal:onContactSeal(sealID)
	if sealID == self._param.sealID then 
		self:setState(self._state + 1)
		if self:completed() then
			self:removeWatchers()
			self._task:refresh()
		end
		return true
	end
end

function TcontactSeal:completed()
	return self._state >= 1
end

function TcontactSeal:getState()
	return self._state
end

function TcontactSeal:removeWatchers()
	self:removeWatcher("onContactSeal")
end
