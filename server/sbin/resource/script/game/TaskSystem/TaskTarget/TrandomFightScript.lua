--[[TrandomFighTrandomFightScript.lua
描述：
	随机脚本战斗任务目标
--]]

TrandomFightScript = class(TaskTarget)
--随机战斗
function TrandomFightScript:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onScriptDone")
	end
end

function TrandomFightScript:onScriptDone(scriptID, isWin)
    if self:completed() then
        self:removeWatchers()
        self._task:refresh()
    end
end

function TrandomFightScript:completed()
	return true
end

function TrandomFightScript:getState()
	return self._state
end

function TrandomFightScript:removeWatchers()
	self:removeWatcher("onScriptDone")
end


function TrandomFightScript:addScriptID(scriptID)
	if not self._param.scriptID then
		self._param.scriptID = scriptID
	end
end
