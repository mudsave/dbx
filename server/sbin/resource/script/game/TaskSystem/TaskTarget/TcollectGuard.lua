--[[TcollectGuard.lua
描述：
	采集守卫目标
--]]

TcollectGuard = class(TaskTarget)

function TcollectGuard:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onScriptDone")
		g_taskSystem:addCollectGuard(entity, param.mpwID, param.npcsData, param.dialogID)
	end
end

function TcollectGuard:onScriptDone(scriptID, isWin)
	if scriptID == self._param.scriptID then 
		if isWin then
			self:setState(self._state + 1)
			g_taskSystem:removeCollectGuard(self._entity, self._param.mpwID)
			if self:completed() then
				self:removeWatchers()
				self._task:refresh()
				local targetsState = self._task:getTargetState()
				if table.size(targetsState) > 1 then
					-- 让客户端改变任务目标状态
					g_taskSystem:setTargetsState(self._entity, self._task:getID(), targetsState)
				end
			end		
		end
		return true
	end
end

function TcollectGuard:completed()
	return self._state >= 1
end

function TcollectGuard:getState()
	return self._state
end

function TcollectGuard:removeWatchers()
	self:removeWatcher("onScriptDone")
end
