--[[Tmine.lua
描述：
	主线任务雷任务目标(任务系统)
--]]

Tmine = class(TaskTarget)
function Tmine:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onScriptDone")
		g_taskSystem:addTaskMine(entity, param.mineIndex, param.posData, param.npcsData, param.dialogID)
	else
		g_taskSystem:addTaskMine(entity, param.mineIndex, param.posData, 0, 0)
	end
end

function Tmine:onScriptDone(scriptID, isWin)
	if scriptID == self._param.scriptID then
		if isWin then
			self:setState(self._state + 1)
			if self:completed() then
				self:removeWatchers()
				--print("要移除任务雷了移除数据是",self._task:getID(),self._param.mineIndex,toString(self._param.posData), toString(self._param.npcsData))
				g_taskSystem:removeTaskMine(self._entity, self._task:getID(), self._param.mineIndex, self._param.posData, self._param.npcsData)
				if self._param.lastMine then
					if self._task:canEnd() then
						self._task:stateChange(TaskStatus.Done)
						
					else
						self._task:stateChange(TaskStatus.HalfDone)
					end
				else
					-- 单独把当前任务目标的状态发给客户端
					local targetsState = self._task:getTargetState()
					if table.size(targetsState) > 1 then
						-- 让客户端改变任务目标状态
						g_taskSystem:setTargetsState(self._entity, self._task:getID(), targetsState)
					end
				end
			end
		else
			if self._param.lostTransfer then
				g_sceneMgr:doSwitchScence(self._entity:getID(), self._param.lostTransfer.mapID ,self._param.lostTransfer.x ,self._param.lostTransfer.y)
			end
			g_taskSystem:revertState(self._entity)
		end
		return true
	end
end

function Tmine:completed()
	return self._state >= 1
end

function Tmine:getState()
	return self._state
end

function Tmine:removeWatchers()
	self:removeWatcher("onScriptDone")
end
