--[[TbabelScript
	通天塔任务目标
--]]

TbabelScript = class(TaskTarget)

function TbabelScript:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onScriptDone")
	end
end

function TbabelScript:onScriptDone(scriptID, isWin)
	if scriptID == self._param.scriptID then 
		local taskHandler = self._entity:getHandler(HandlerDef_Task)
		if isWin then
			self:setState(self._state + 1)
			if self:completed() then
				self:removeWatchers()
				self._task:refresh()
				-- 这个地方还要找失败的次数，>0时，直接完成当天
				local faildTimes = taskHandler:getBabelFaildTimes(self._task:getID())
				if faildTimes > 0 then
					-- 此时，
					taskHandler:endFinishBabelTask(self._task:getID())
				else
					local layer = self._task:getLayer()
					if layer == BabelTaskDB[self._task:getID()].maxLayer then
						-- 此时任务完成，退出场景
						taskHandler:endFinishBabelTask(self._task:getID())
					end
				end
			end
		else
			-- 战斗失败, 
			local level = self._entity:getLevel()
			local layer = self._task:getLayer()
			-- 这个证明是在突破阶段，失败次数+ 1
			if level < layer then
				taskHandler:addBabelFaildTimes(self._task:getID())
				-- 如果失败次数为3的话，，记录完成标记，回到公共场景， 最后删除任务
				if taskHandler:getBabelFaildTimes(self._task:getID()) >= 3 then
					-- 设置任务外完成标记
					local msgID = 33
					local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, msgID)
					g_eventMgr:fireRemoteEvent(event, self._entity)
					taskHandler:endFinishBabelTask(self._task:getID())
				end
			end
		end
	end
end

function TbabelScript:completed()
	return self._state >= self._param.count
end

function TbabelScript:getState()
	return self._state
end

function TbabelScript:removeWatchers()
	self:removeWatcher("onScriptDone")
end
