--[[Tescort.lua
描述：
	循环任务当中护送任务目标
--]]

Tescort = class(TaskTarget)

function Tescort:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then
		self:addWatcher("onAddFollowNpc")
	end
	-- 当中先把任务匹配的followNpcID记录下来, 做个前置先记录，后添加
	local privateHandler = entity:getHandler(HandlerDef_TaskPrData)
	privateHandler:addTaskFollowNpc(task:getID(), param.followNpcID)
end

-- 对话获取尾随NPC
function Tescort:onAddFollowNpc(npcID)
	if npcID == self._param.followNpcID then
		self:setState(self._state + 1)
		if self:completed() then
			self:removeWatchers()
			self._task:refresh()
		end
	end
end


function Tescort:completed()
	return self._state >= self._param.count
end

function Tescort:getState()
	return self._state
end

-- 当中卖物品的监听不有删除，还要持续监听
function Tescort:removeWatchers()
	self:removeWatcher("onAddFollowNpc")
end

function Tescort:removeAllWatchers()
	self:removeWatcher("onAddFollowNpc")
end