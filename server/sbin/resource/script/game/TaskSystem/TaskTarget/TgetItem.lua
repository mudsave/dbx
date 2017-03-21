--[[TgetItem.lua
描述：
	获得任务物品道具
--]]

TgetItem = class(TaskTarget)

function TgetItem:__init(entity, task, param, state)
	self._state = state or 0
	self:addWatcher("onBuyItem")--添加监听器
	self:addWatcher("onRemoveItem")--添加监听器，以便后面的时候调用相关方法
	local packetHandler = entity:getHandler(HandlerDef_Packet)
	self._state = packetHandler:getNumByItemID(param.itemID)
	local itemInfo = 
	{
		itemID = param.itemID,
		count = param.count,
		taskID = task:getID(),
	}
	if self:completed() then
		-- 移除货架高亮记录
		g_taskSystem:removeTaskItem(entity, task:getID())
	else
		-- 添加货架高亮记录
		g_taskSystem:addTaskItem(entity, task:getID(), param.itemID)
	end
	-- 物品栏高亮记录
	g_taskSystem:notifyClient(entity, TaskNotifyClientType.item, itemInfo)
end

-- 监听买物品
function TgetItem:onBuyItem(itemID)
	if itemID == self._param.itemID then 
		local packetHandler = self._entity:getHandler(HandlerDef_Packet)
		local itemCount = packetHandler:getNumByItemID(itemID)
		self:setState(itemCount)
		if self:completed() then
			-- 如果完成，那么此时购买物品经停已经删除
			self._task:refresh()
			g_taskSystem:removeTaskItem(self._entity, self._task:getID())
		end
	end
end

-- 监听卖物品
function TgetItem:onRemoveItem(itemID)
	if itemID == self._param.itemID then 
		local packetHandler = self._entity:getHandler(HandlerDef_Packet)
		local itemCount = packetHandler:getNumByItemID(itemID)
		self:setState(itemCount)
		if not self:completed() then
			self._task:refresh()
			-- 添加货架高亮记录
			g_taskSystem:addTaskItem(self._entity, self._task:getID(), self._param.itemID)
		end
	end
end

function TgetItem:completed()
	return self._state >= self._param.count
end

function TgetItem:getState()
	return self._state
end


-- 当中卖物品的监听不有删除，还要持续监听
function TgetItem:removeWatchers()
	
end

function TgetItem:removeAllWatchers()
	self:removeWatcher("onBuyItem")
	self:removeWatcher("onRemoveItem")
end