--[[Tscript.lua
描述：
	脚本战斗任务目标
--]]

Tscript = class(TaskTarget)

function Tscript:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onScriptDone")
	end
end

function Tscript:onScriptDone(scriptID, isWin)
	if scriptID == self._param.scriptID then 
		if isWin or self._param.ignoreResult then
			self:setState(self._state + 1)
			if self:completed() then
				self:removeWatchers()
				self._task:refresh()
			end
		elseif self._param.lostTransfer then
			g_sceneMgr:doSwitchScence(self._entity:getID(), self._param.lostTransfer.mapID ,self._param.lostTransfer.x ,self._param.lostTransfer.y)
		end
		return true
	end
end

function Tscript:completed()
	return self._state >= self._param.count
end

function Tscript:getState()
	return self._state
end

function Tscript:removeWatchers()
	self:removeWatcher("onScriptDone")
end


function Tscript:addScriptID(scriptID)
	if not self._param.scriptID then
		self._param.scriptID = scriptID
	end
end
