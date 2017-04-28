--[[TjoinFaction.lua
	描述:指引加入帮派目标
]]

TjoinFaction = class(TaskTarget)

function TjoinFaction:__init(entity, task, param, state)
	self._task	= task
	self._state = state or 0
	self._entity = entity
	self._param = param	-- 只有一个数字用来表示做了
	if not self:completed() then
		self:addWatcher("onjoinFaction")	-- 没有完成继续指引
	end
end  

function TjoinFaction:onjoinFaction(flag)
	local taskHandler = self._entity:getHandler(HandlerDef_Task)
	local taskID = self._task:getID()	
	self:setState(self._state + 1)
	if self._param.taskID == guideTaskID and self:completed() then
		taskHandler:finishTaskByID(taskID)	--  加入帮派之后就结束任务
	end
end

function TjoinFaction:completed()
	return self._state >= self._param.count
end

function TjoinFaction:removeWatchers()
	self:removeWatcher("onjoinFaction")
end
