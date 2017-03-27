--[[TkillMonster.lua

    Function: The target of killMonster
    Author: Caesar

--]]

TkillMonster = class(TaskTarget)

function TkillMonster:__init(entity, task, param, state)

	self._entity = entity
	self._state = state or 0
	self._watchTasks = {}
	self._task = task
	self._monsterCounts = {}
	self._monsterCounts["currentCount"] = param.currentCount
	self._monsterCounts["targetCount"] = param.targetCount
	self:addWatcher("onKillMonster")--添加监听器，每次成功击杀怪物后执行相应的动作

end

-- 监听杀怪
function TkillMonster:onKillMonster()

	self._monsterCounts.currentCount = self._monsterCounts.currentCount + 1

	if self._monsterCounts.currentCount <= self._monsterCounts.targetCount then
		print("对执行次数进行统计",self._monsterCounts.currentCount)
		for _,target in ipairs(self._task:getDailyTargets()) do 
			if target.type == "TkillMonster" then
				target.param.currentCount = self._monsterCounts.currentCount
				g_taskSystem:setTargetsState(self._entity,self._task:getID(),self._task:getTargetState())
			end
		end
		if self:completed() then
			self:removeWatchers()
			self._task:refresh()
		end
	end
	
end

function TkillMonster:completed()

	return self._monsterCounts.currentCount >= self._monsterCounts.targetCount

end

function TkillMonster:getState()
	return self._monsterCounts
end

function TkillMonster:removeWatchers()
	
end

function TkillMonster:removeAllWatchers()
	self:removeWatcher("onKillMonster")
end