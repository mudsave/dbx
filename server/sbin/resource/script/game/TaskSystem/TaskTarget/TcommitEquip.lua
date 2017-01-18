--[[TcommitEquip.lua
描述：
	提交装备
--]]

TcommitEquip = class(TaskTarget)

function TcommitEquip:__init(entity, task, param, state)
	self._state = state or 0
	if not self:completed() then 
		self:addWatcher("onCommitEquip")
	end
end

-- 监提交物品
function TcommitEquip:onCommitEquip(equipGuid, count)
	local equip = g_itemMgr:getItem(equipGuid)
	if equip then
		local equipQuality = equip:getEquipQuality()
		local equipNeedLevel = equip:getEquipLevel()			--装备的使用等级
		if self._param.equipClass == equip:getSubClass() then 
			if self._param.subClass == equip:getEquipClass() then
				if self._param.level == equipNeedLevel then
					if equipQuality == 1 or equipQuality == 5 or equipQuality == 0 then
						local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, 7)
						g_eventMgr:fireRemoteEvent(event, self._entity)

						local event = Event.getEvent(TaskEvent_SC_CommitEquipResult, self._param.taskID,false)
						g_eventMgr:fireRemoteEvent(event, self._entity)

						return 
					else
						local packetHandler = self._entity:getHandler(HandlerDef_Packet)
						packetHandler:removeItem(equipGuid,1)
						-- 扣除装备成功
						local event = Event.getEvent(TaskEvent_SC_CommitEquipResult, self._param.taskID,true)
						g_eventMgr:fireRemoteEvent(event, self._entity)
						-- 记录装备的等级和品质
						local taskPrivateHandler = self._entity:getHandler(HandlerDef_TaskPrData)
						taskPrivateHandler:addEquipData(self._param.taskID, equipNeedLevel, equipQuality)
						self._state = self._state + 1
						if self:completed() then
							self:removeWatchers()
							self._task:refresh()
							self._entity:getHandler(HandlerDef_Task):finishLoopTask(self._param.taskID)
						end
						return true
					end
				else
					--装备等级不对
					local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, 3)
					g_eventMgr:fireRemoteEvent(event, self._entity)

					local event = Event.getEvent(TaskEvent_SC_CommitEquipResult, self._param.taskID,false)
					g_eventMgr:fireRemoteEvent(event, self._entity)
					return
				end
			else
				--装备类型不对
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, 6)
				g_eventMgr:fireRemoteEvent(event, self._entity)

				local event = Event.getEvent(TaskEvent_SC_CommitEquipResult, self._param.taskID,false)
				g_eventMgr:fireRemoteEvent(event, self._entity)
				return
			end
		else
			--装备类别不对
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, 5)
			g_eventMgr:fireRemoteEvent(event, self._entity)

			local event = Event.getEvent(TaskEvent_SC_CommitEquipResult, self._param.taskID,false)
			g_eventMgr:fireRemoteEvent(event, self._entity)
			return
		end
	end
end

function TcommitEquip:completed()
	return self._state >= self._param.count
end

function TcommitEquip:getState()
	return self._state
end

-- 当中卖物品的监听不有删除，还要持续监听
function TcommitEquip:removeWatchers()
	self:removeWatcher("onCommitEquip")
end
