--[[TwearEquip.lua
描述：
	穿上装备道具
--]]

local function checkEquip(player, equipID)
	local equipHandler = player:getHandler(HandlerDef_Equip)
	local equip = equipHandler:getEquip()
	local equipPack = equip:getPack()

	local equipConfig = tEquipmentDB[equipID]
	local itemGrid = EquipType_ItemGrid[equipConfig.SubClass][equipConfig.EquipClass]

	if type(itemGrid) == "table" then
		for _,grid in pairs(itemGrid) do
			local equipMent = equipPack:getGridItem(grid)
			if equipMent and equipMent:getItemID() == equipID then
				return true
			end
		end
	else
		local equipMent = equipPack:getGridItem(itemGrid)
		if equipMent and equipMent:getItemID() == equipID then
			return true
		end
	end
	return false
end

TwearEquip = class(TaskTarget)

function TwearEquip:__init(entity, task, param, state)	
	--获得已经上装的装备里有没有param.equipID
	self._state = checkEquip(entity, param.equipID) and 1 or 0
	if self:completed() then
		-- 如果完成，那么此时购买物品经停已经删除	
		self:addWatcher("onDownEquip")
	else
		self:addWatcher("onWearEquip")
	end
end

-- 监听上装
function TwearEquip:onWearEquip(equipID)
	if equipID == self._param.equipID then 
		self:setState(self._state + 1)
		if self:completed() then
			-- 如果完成，那么此时购买物品经停已经删除
			
			if self._task:canEnd() then
				self._task:refresh()
			else
				local event = Event.getEvent(TaskTargetEvent_SC_UpdateEquipTrace, self._task:getID(), self._task:getTargetState())
				g_eventMgr:fireRemoteEvent(event, self._entity)
			end
			self:addWatcher("onDownEquip")
			self:removeWatcher("onWearEquip")
		end
	end
end

-- 监听下装
function TwearEquip:onDownEquip(equipID)
	if equipID == self._param.equipID then 
		self:setState(self._state - 1)
		if not self:completed() then
			if self._task:getStatus() == TaskStatus.Done then
				self._task._status = TaskStatus.Active
				local event = Event.getEvent(TaskTargetEvent_SC_UpdateEquipTrace, self._task:getID(), self._task:getTargetState(), TaskStatus.Active)
				g_eventMgr:fireRemoteEvent(event, self._entity)
			else
				local event = Event.getEvent(TaskTargetEvent_SC_UpdateEquipTrace, self._task:getID(), self._task:getTargetState())
				g_eventMgr:fireRemoteEvent(event, self._entity)
			end
			self:addWatcher("onWearEquip")
			self:removeWatcher("onDownEquip")
		end
	end
end

function TwearEquip:completed()
	return self._state >= 1
end

function TwearEquip:getState()
	return self._state
end

-- 当中卖物品的监听不有删除，还要持续监听
function TwearEquip:removeWatchers()
	
end

function TwearEquip:removeAllWatchers()
	self:removeWatcher("onWearEquip")
	self:removeWatcher("onDownEquip")
end