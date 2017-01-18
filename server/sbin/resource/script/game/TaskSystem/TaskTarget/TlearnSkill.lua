--[[TlearnSkill.lua
描述：
	学习技能任务目标(任务系统)
--]]

TlearnSkill = class(TaskTarget)

function TlearnSkill:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onLearnDone")
	end
end

function TlearnSkill:onLearnDone(skillID, skillLevel)
	if self._param.skillID == skillID then
		self:setState(skillLevel)
		local event = Event.getEvent(TaskTargetEvent_SC_LearnSkill, self._task:getID(), skillLevel)
		g_eventMgr:fireRemoteEvent(event, self._entity)
		if skillLevel >= self._param.tarLevel then
			self:removeWatchers()
			self._task:refresh()
		end
	end
end

function TlearnSkill:removeWatchers()
	self:removeWatcher("onLearnDone")
end

function TlearnSkill:completed()
	return self._state >= self._param.tarLevel
end

function TlearnSkill:getState()
	return self._state
end


