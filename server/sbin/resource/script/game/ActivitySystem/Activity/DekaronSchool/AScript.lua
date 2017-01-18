--[[AScript.lua
描述：
	活动目标战斗(活动系统)
--]]

AScript = class(ActivityTarget)

function AScript:__init(param)
	self.historySchool = {}
	self.DB = table.copy(self._param.DB)
	self._param = param
	self:addWatcher("onScriptDone")
end

function AScript:onScriptDone(scriptID, isWin)
	if scriptID == self._param.scriptID then 
		if isWin then
			if table.size(self._param.DB) <= 1 then
				self._param.DB = nil
				self._param.DB = table.copy(self.DB)
				self.historySchool = {}
			else
				self._param.DB[self._param.school] = nil
				self.historySchool[self._param.school] = true
			end
			--队伍加进度
			self._param.team:setProcess(self._param.team:getProcess() + 1)
			--为每个队员添加积分

			--刷新排行
			self._param.activity:updateRank(self._param.team)
		end
	end
end

function AScript:removeWatchers()
	self:removeWatcher("onScriptDone")
end
