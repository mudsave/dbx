--[[TcollectItem.lua
描述:
	收集材料
]]
TcollectItem = class(TaskTarget)


function TcollectItem:__init(entity, task, param, state)
	self._state = 0
	self:addWatcher("onCollectItem")
end

function TcollectItem:onCollectItem(itemsInfo)
	--[[if table.size(self._param.itemsInfo) == table.size(itemsInfo) then
		for _, pItemInfo in pairs(self._param.itemsInfo) do			
			for _, itemInfo in pairs(itemsInfo) do
				local item = g_itemMgr:getItem(itemInfo.guid)
				local itemID = item:getItemID()
				if pItemInfo.itemID == itemID and itemInfo.count >= pItemInfo.count then
					self:setState(self._state + 1)
					if self:completed() then
						local packetHandler = self._entity:getHandler(HandlerDef_Packet)
						for _,itemInfo in pairs(itemsInfo) do
							packetHandler:removeItem(itemInfo.guid, pItemInfo.count)
						end
				
						local event = Event.getEvent(TaskEvent_SC_CommitItemResult, self._task:getID(),true)
						g_eventMgr:fireRemoteEvent(event, self._entity)
						
						local privateHandler = self._entity:getHandler(HandlerDef_TaskPrData)
						if privateHandler:getTaskItem(self._task:getID()) then
							privateHandler:removeTaskItem(self._task:getID())
						end
						if LoopTaskDB[self._task:getID()] then 
							self._entity:getHandler(HandlerDef_Task):finishTaskByID(self._task:getID())
						end
					end
				end
			end
		end
	end
	]]

	for _, pItemInfo in pairs(self._param.itemsInfo) do			
		for _, itemInfo in pairs(itemsInfo) do
			local item = g_itemMgr:getItem(itemInfo.guid)
			local itemID = item:getItemID()
			if pItemInfo.itemID == itemID and itemInfo.count >= pItemInfo.itemNum then
				self:setState(self._state + 1)
				if self:completed() then
					local packetHandler = self._entity:getHandler(HandlerDef_Packet)
					--for _,itemInfo in pairs(itemsInfo) do
					packetHandler:removeItem(itemInfo.guid, pItemInfo.itemNum)
					--end

					local event = Event.getEvent(TaskEvent_SC_CommitItemResult, self._task:getID(),true)
					g_eventMgr:fireRemoteEvent(event, self._entity)
					
					local privateHandler = self._entity:getHandler(HandlerDef_TaskPrData)
					if privateHandler:getTaskItem(self._task:getID()) then
						privateHandler:removeTaskItem(self._task:getID())
					end
					if LoopTaskDB[self._task:getID()] then 
						self._entity:getHandler(HandlerDef_Task):finishTaskByID(self._task:getID())
					end
				end
			else
				--local event = Event.getEvent(TaskEvent_SC_CommitItemResult, self._task:getID(),false)	
				--g_eventMgr:fireRemoteEvent(event, self._entity)
				g_dialogDoer:createDialogByID(self._entity, 50112)
			end
		end
	end
end

function TcollectItem:completed()
	return self._state >= 1
end

function TcollectItem:getState()
	return self._state
end

function TcollectItem:removeWatchers()
end

function TcollectItem:removeAllWatchers()
	self:removeWatcher("onCollectItem")
end
