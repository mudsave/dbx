--[[TguideTask.lua
    描述:指引任务目标
]]

TguideTask = class(TaskTarget)

function TguideTask:__init(entity, task, param, state)
	self._task	= task
	self._state = state or 0
	self._entity = entity
	self._param = param
	if not self:completed() then
		self:addWatcher("onGuideTask")	-- 没有完成继续指引
	end
end     

-- 指引任务目标（guideTaskID为该指引任务指向的任务的ID）
function TguideTask:onGuideTask(guideTaskID)
	-- 说明已经创建的改类型的任务目标
	local taskHandler = self._entity:getHandler(HandlerDef_Task)
	local taskID = self._task:getID()	
	self._state = self._state + 1
	if self._param.taskID == guideTaskID and self:completed() then
		taskHandler:finishTaskByID(taskID)
		self:removeWatchers()
		return
	end
	local targetsState = self._task:getTargetState()
	g_taskSystem:setTargetsState(self._entity,taskID,targetsState)
end

function TguideTask:completed()
	return self._state >= self._param.count
end

function TguideTask:removeWatchers()
	self:removeWatcher("onGuideTask")
end