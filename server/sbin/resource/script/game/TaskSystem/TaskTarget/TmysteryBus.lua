--[[TmysteryBus.lua
	神秘商人
--]]
TmysteryBus = class(TaskTarget)
-- 附加参数当中还有热区的发送
function TmysteryBus:__init(entity, task, param, state)
	self._state = state or 0
	local privateHandler = entity:getHandler(HandlerDef_TaskPrData)
	if not self:completed() then
		-- 通知客户端创建一个热区
		self:addWatcher("onAddItem")
		local posData = param.posData
		local dialogID = param.dialogID
		privateHandler:addSpecialArea(task:getID(), posData.mapID)
		g_taskSystem:addSpecialArea(entity, task:getID(), posData, dialogID)
	end
	-- 记录添加的任务道具, 方便任务删除是任务道具也一并删除
	privateHandler:addTaskItem(task:getID(), param.itemID)
end

-- 监听买物品
function TmysteryBus:onAddItem(itemID)
	if itemID == self._param.itemID then 
		self:setState(self._state + 1)
		if self:completed() then
			-- 如果完成，那么此时购买物品经停已经删除
			self:removeWatchers()
			self._task:refresh()
		end
	end
end

function TmysteryBus:completed()
	return self._state >= self._param.count
end

function TmysteryBus:getState()
	return self._state
end

-- 当中卖物品的监听不有删除，还要持续监听
function TmysteryBus:removeWatchers()
	self:removeWatcher("onAddItem")
end
