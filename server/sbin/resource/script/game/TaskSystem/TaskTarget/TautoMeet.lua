--[[TautoMeet.lua
描述：
	任务目标：经过某区域，本目标不可逆
--]]

TautoMeet = class(TaskTarget)

function TautoMeet:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onPosChanged")
	end
end

function TautoMeet:onPosChanged(mapID, x, y)
	if self._task:getStatus() == TaskStatus.Done then
		return
	end
	--print("self._state>>>>>>>>>>>>>任务状态", self._state)
	if self._state == 1 then
		return
	end
	if mapID == self._param.mapID then
		if (x >= self._param.x - 5) and (y >= self._param.y - 5) and (x <= self._param.x + 5) and (y <= self._param.y + 5) then
			print("任务当前状态加 >>>>>>>>>>>>>>>>1")
			self._entity:getHandler(HandlerDef_TaskPrData):setStartMine(self._task:getID())
			CactionSystem.getInstance():doAutoMeet(self._entity)
			self:setState(self._state + 1)
		end
	end
end

function TautoMeet:completed()
	return self._state >= 1
end

function TautoMeet:removeWatchers()
	self:removeWatcher("onPosChanged")
end

function TautoMeet:resetState()
	self._state = 0
	self:addWatcher("onPosChanged")
end