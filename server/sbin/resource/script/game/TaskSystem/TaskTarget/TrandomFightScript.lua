--[[TrandomFighTrandomFightScript.lua
描述：
	随机脚本战斗任务目标
--]]

TrandomFightScript = class(TaskTarget)

function TrandomFightScript:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onScriptDone")
	end
end

function TrandomFightScript:onScriptDone(scriptID, isWin)
	print("准备判断胜利条件",scriptID,isWin)
	if scriptID == self._param.scriptID then
		if isWin then
			self:setState(self._state + 1)
			if self:completed() then
				self:removeWatchers()
				self._task:refresh()
			end
		end
	end
end

function TrandomFightScript:completed()
	return self._state > self._param.count
end

function TrandomFightScript:getState()
	return self._state
end

function TrandomFightScript:removeWatchers()
	self:removeWatcher("onScriptDone")
end

--因为随机所以需要动态添加
function TrandomFightScript:addScriptID(scriptID)
	if not self._param.scriptID then
		self._param.scriptID = scriptID
	end
end
