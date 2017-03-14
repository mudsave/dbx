--[[TlearnSkill.lua
描述：
	学习技能任务目标(任务系统)
--]]

TlearnSkill = class(TaskTarget)

function TlearnSkill:__init(entity, task, param, state)
	if not state then
		local handler = self._entity:getHandler(HandlerDef_Mind)
		self._state = handler:getSkillLevel(self._param.skillID)
	else
		self._state = state
	end
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
	-- 检查当前任务是否已经完成 再接任务时
	return self._state >= self._param.tarLevel
end

function TlearnSkill:getState()
	return self._state
end


