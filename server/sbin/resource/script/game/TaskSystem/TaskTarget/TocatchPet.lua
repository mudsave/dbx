--[[TocatchPet.lua
描述：
	循环任务当中捕捉宠物
--]]

TocatchPet = class(TaskTarget)

function TocatchPet:__init(entity, task, param, state)
	self._state = state or 0
	local petList = entity:getPetList()
	self:addWatcher("onCatchPet")
	self:addWatcher("onRemovePet")
	self:addWatcher("onPaidPet")
	local needPetCount = 0
	for petID, pet in pairs(petList) do
		if pet and pet:getConfigID() == param.petID then
			-- 证明有这个宠物，你不需要捕捉
			needPetCount = needPetCount + 1
		end
	end
	if self._state == 0 then
		self._state = needPetCount
	end
	if self:completed() then
		self._task:refresh()
	end
	-- 上缴宠物界面, 不同颜色显示
	g_taskSystem:addTaskPet(entity, task:getID(), param.petID)
end

-- 捕捉宠物
function TocatchPet:onCatchPet(petID)
	if petID == self._param.petID then
		self:setState(self._state + 1)
		if self:completed() then
			-- 此时捕捉宠物监听已经移除
			self._task:refresh()
		end
	end
end

-- 销毁和遣散宠物
function TocatchPet:onRemovePet(petID)
	if petID == self._param.petID then 
		local petList = self._entity:getPetList()
		local needPetCount = 0
		for petID, pet in pairs(petList) do
			if pet and pet:getConfigID() == self._param.petID then
				-- 证明有这个宠物，你不需要捕捉
				needPetCount = needPetCount + 1
			end
		end
		self:setState(needPetCount)
		if not self:completed() then
			self._task:refresh()
			self:addWatcher("onCatchPet")

		end
	end
end

-- 上缴宠物
function TocatchPet:onPaidPet(taskID, petID)
	if taskID ~= self._task:getID() then
		return
	end
	local pet = g_entityMgr:getPet(petID)
	if not pet then
		print("你当中没有上所需要上缴的宠物")
		return
	end
	if pet:getConfigID() ~= self._param.petID then
		print("提交宠物不匹配")
		return
	end
	local errCode = DeletePetCheck(self._entity, pet)
	if errCode == 0 then
		self:removeWatcher("onRemovePet")
		LuaDBAccess.DeletePet(pet)
		self._entity:removePet(petID)
		g_entityMgr:removePet(petID)
		local event = Event.getEvent(PetEvent_SC_PetLeaved, petID)
		g_eventMgr:fireRemoteEvent(event, self._entity)
		-- 通知客户端移除
		g_taskSystem:removeTaskPet(self._entity, taskID)
		self._entity:getHandler(HandlerDef_Task):finishLoopTask(self._task:getID())
	else
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet, errCode)
		g_eventMgr:fireRemoteEvent(event, self._entity)
		print("宠物当前状态不能够上缴")
	end
end

function TocatchPet:completed()
	return self._state >= self._param.count
end

function TocatchPet:getState()
	return self._state
end


-- 当中卖物品的监听不有删除，还要持续监听
function TocatchPet:removeWatchers()
	self:removeWatcher("onCatchPet")
end

function TocatchPet:removeAllWatchers()
	self:removeWatcher("onCatchPet")
	self:removeWatcher("onRemovePet")
	self:removeWatcher("onPaidPet")
end