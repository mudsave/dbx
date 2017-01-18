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
	if table.size(self._param.itemsInfo) == table.size(itemsInfo)then
		local t_count = 0
		for _, pItemInfo in pairs(self._param.itemsInfo) do			
			for _, itemInfo in pairs(itemsInfo) do
				local item = g_itemMgr:getItem(itemInfo.guid)
				local itemID = item:getItemID()
				if pItemInfo.itemID == itemID and pItemInfo.count == itemInfo.count then
					t_count = t_count + 1
				end
			end
		end
		if t_count == table.size(self._param.itemsInfo) then
			self._state = self._state + 1
			if self:completed() then
				local packetHandler = self._entity:getHandler(HandlerDef_Packet)
				for _,itemInfo in pairs(itemsInfo) do
					-- 这个地方做移除的时候，不触发监听
					packetHandler:removeItem(itemInfo.guid, itemInfo.count)
				end
				
				--上交物品成功发送客户端
				local event = Event.getEvent(TaskEvent_SC_CommitItemResult, self._task:getID(),true)
				g_eventMgr:fireRemoteEvent(event, self._entity)
				
				local privateHandler = self._entity:getHandler(HandlerDef_TaskPrData)
				if privateHandler:getTaskItem(self._task:getID()) then
					privateHandler:removeTaskItem(self._task:getID())
				end
				if LoopTaskDB[self._task:getID()] then 
					self._entity:getHandler(HandlerDef_Task):finishLoopTask(self._task:getID())
				elseif NormalTaskDB[self._task:getID()] then
					if NormalTaskDB[self._task:getID()].taskType2 == TaskType2.Main then 
						self._task:refresh()
					end
				end
			end
		else
			--print("上交物品不正确，任务不能完成")
			local event = Event.getEvent(TaskEvent_SC_CommitItemResult, self._task:getID(),false)
			g_eventMgr:fireRemoteEvent(event, self._entity)
			return
		end
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
