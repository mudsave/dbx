--[[TpaidPet.lua
	循环任务当中上缴宠物
--]]
TpaidPet = class(TaskTarget)

function TpaidPet:__init(entity, task, param, state)
	self._state = state or 0
	local petList = entity:getPetList()
	self:addWatcher("onCatchPet")
	self:addWatcher("onRemovePet")
	self:addWatcher("onPaidPet")
	if not state then
		local needPetCount = 0
		for petID, pet in pairs(petList) do
			if pet and pet:getConfigID() == param.petID then
				-- 证明有这个宠物，你不需要捕捉
				needPetCount = needPetCount + 1
			end
		end
		self._state = needPetCount
	end
	if not self:completed() then
		-- 添加货架高亮记录
		g_taskSystem:addShelfPet(entity, task:getID(), param.petID)
	end
	-- 上缴宠物界面, 不同颜色显示
	g_taskSystem:addTaskPet(entity, task:getID(), param.petID)
end

-- 捕捉宠物, 或者购买成功都会执行到这里
function TpaidPet:onCatchPet(petID)
	if petID == self._param.petID then
		self:setState(self._state + 1)
		if self:completed() then
			-- 此时捕捉宠物监听已经移除
			self._task:refresh()
			g_taskSystem:removeShelfPet(self._entity, self._task:getID())
		end
	end
end

-- 销毁和遣散宠物
function TpaidPet:onRemovePet(petID)
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
			g_taskSystem:addShelfPet(self._entity, self._task:getID(), self._param.petID)
			self:addWatcher("onCatchPet")
		end
	end
end

-- 上缴宠物
function TpaidPet:onPaidPet(taskID, petID)
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
	end
end

function TpaidPet:completed()
	return self._state >= self._param.count
end

function TpaidPet:getState()
	return self._state
end


-- 当中卖物品的监听不有删除，还要持续监听
function TpaidPet:removeWatchers()
	self:removeWatcher("onCatchPet")
end

function TpaidPet:removeAllWatchers()
	-- 不管是买，还是不做，都能算任务目标完成
	self:removeWatcher("onCatchPet")
	self:removeWatcher("onRemovePet")
	self:removeWatcher("onPaidPet")
end