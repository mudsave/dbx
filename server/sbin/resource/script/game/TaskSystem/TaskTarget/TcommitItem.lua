--[[TcommitItem.lua
描述：
	上交物品目标
]]

TcommitItem = class(TaskTarget)


function TcommitItem:__init(entity, task, param, state)
	self._state = 0
	self:addWatcher("onCommitItem")
end

function TcommitItem:onCommitItem(itemsInfo)
	local count = table.size(self._param.itemsInfo)
	local curCount = 0
	for _, itemInfo in pairs(itemsInfo) do
		local item = g_itemMgr:getItem(itemInfo.guid)
		local itemID = item:getItemID()
		for _, configItemInfo in pairs(self._param.itemsInfo) do
			if configItemInfo.itemID == itemID and configItemInfo.count <= itemInfo.count then
				curCount = curCount + 1
				break
			end
		end
	end
	if count == curCount then
		local privateHandler = self._entity:getHandler(HandlerDef_TaskPrData)
		local packetHandler = self._entity:getHandler(HandlerDef_Packet)
		self:setState(self._state + 1)
		if self:completed() then
			-- 先移除买物品监听：
			self._task:removeAllWatchers()
			for _, itemInfo in pairs(itemsInfo) do
				local item = g_itemMgr:getItem(itemInfo.guid)
				local itemID = item:getItemID()
				for _, pItemInfo in pairs(self._param.itemsInfo) do
					if itemID == pItemInfo.itemID then
						packetHandler:removeItem(itemInfo.guid, pItemInfo.count)
						privateHandler:removeTaskItem(self._task:getID())
						break
					end
				end
			end
			-- 移除客户端的
			local event = Event.getEvent(TaskEvent_SC_CommitItemResult, self._task:getID(),true)
			g_eventMgr:fireRemoteEvent(event, self._entity)
			if LoopTaskDB[self._task:getID()] then 
				self._entity:getHandler(HandlerDef_Task):finishLoopTask(self._task:getID())
			elseif NormalTaskDB[self._task:getID()] then
				if NormalTaskDB[self._task:getID()].taskType2 == TaskType2.Main then 
					self._task:refresh()
				end
			end
		end
	else
		local event = Event.getEvent(TaskEvent_SC_CommitItemResult, self._task:getID(), false)
		g_eventMgr:fireRemoteEvent(event, self._entity)
	end
end

function TcommitItem:completed()
	return self._state >= 1
end

function TcommitItem:getState()
	return self._state
end

function TcommitItem:removeWatchers()
end

-- 当中卖物品的监听不有删除，还要持续监听
function TcommitItem:removeAllWatchers()
	self:removeWatcher("onCommitItem")
end
