--[[LoopTask.lua
描述：
	循环任务类
--]]

LoopTask = class(Task)

function LoopTask:__init(taskData)
	self._loop = nil
	self._period = nil
	self._startTime = nil
	self._canDelete = false
	self._trigger = nil
	self._endNpcID = nil
	self._endDialogID = nil
	self._endTime = nil
	self._targetType = nil
	self._gradeIdx = nil
	self._targetIdx = nil
	-- 任务目标配置
	self._targetsConfig = {}
	self._formulaRewards = nil
	self._normalRewards = nil
	-- 物品奖励
	self._itemRewards = nil
	-- 接任务时的等级
	self._receiveTaskLvl = nil
end

function LoopTask:__release()
	self._loop = nil
	self._period = nil
	self._canDelete = nil
	self._trigger = nil
	self._endNpcID = nil
	self._endDialogID = nil
	self._formulaRewards = nil
	self._normalRewards = nil
	self._targetType = nil
	self._gradeIdx = nil
	self._targetIdx = nil
	self._targetContext = nil
	-- 物品奖励
	self._itemRewards = nil
	-- 接任务时的等级
	self._receiveTaskLvl = nil
end

--公式奖励
function LoopTask:setFormulaRewards(formulaRewards)
	self._formulaRewards = formulaRewards
end

function LoopTask:getFormulaRewards()
	return self._formulaRewards
end

--一般奖励
function LoopTask:setNormalRewards(normalRewards)
	self._normalRewards = normalRewards
end

function LoopTask:getNormalRewards()
	return self._normalRewards
end

--任务环
function LoopTask:setLoop(loop)
	self._loop = loop
end

function LoopTask:getLoop()
	return self._loop
end

--任务周期
function LoopTask:setPeriod(period)
	self._period = period
end

function LoopTask:getPeriod()
	return self._period
end

--是否可以删除
function LoopTask:setDelete(delete)
	self._canDelete = delete
end

function LoopTask:getDelete()
	return self._canDelete
end

-- 前面的拷贝到后面
function LoopTask:setTriggers(trigger)
	table.deepCopy(trigger, self._triggers)
end

function LoopTask:getTriggers()
	return self._triggers
end

function LoopTask:setEndNpcID(endNpcID)
	self._endNpcID = endNpcID
end

function LoopTask:getEndNpcID()
	return self._endNpcID
end

--
function LoopTask:setEndDialogID(dialogID)
	self._endDialogID = dialogID
end

function LoopTask:getEndDialogID()
	return self._endDialogID
end

function LoopTask:getFormulaRewards()
	return self._formulaRewards
end

function LoopTask:setTargetType(targetType)
	self._targetType = targetType
end

function LoopTask:getTargetType()
	return self._targetType
end

function LoopTask:setTargetIdx(targetIdx)
	self._targetIdx = targetIdx
end

function LoopTask:setGradeIdx(gradeIdx)
	self._gradeIdx = gradeIdx
end

function LoopTask:getGradeIdx()
	return self._gradeIdx
end

function LoopTask:setRingIdx(ringIdx)
	self._ringIdx = ringIdx
end

function LoopTask:getRingIdx()
	return self._ringIdx
end

function LoopTask:getTargetIdx()
	return self._targetIdx
end

function LoopTask:setStartUiId(startUiId)
	self._startUiId = startUiId
end

function LoopTask:getStartUiId()
	return self._startUiId
end

function LoopTask:setFaildUiId(faildUiId)
	self._faildUiId = faildUiId
end

function LoopTask:getFaildUiId()
	return self._faildUiId
end

function LoopTask:setEndUiId(endUiId)
	self._endUiId = endUiId
end

function LoopTask:getEndUiId()
	return self._endUiId
end


-- 固定奖励，固定值，不是公式奖励
function LoopTask:addReward()
	-- 固定奖励
	local reward = {}
	local player = g_entityMgr:getPlayerByID(self._roleID)
	local factionID = player:getFactionDBID()
	for rewardType, value in pairs(self._normalRewards or {}) do
		local curValue = value * (self._multipleReward or 1)
		if rewardType == TaskRewardList.player_xp then			
			player:addXp(curValue)
			if reward[rewardType] then
				reward[rewardType] = reward[rewardType] + curValue
			else
				reward[rewardType] = curValue
			end
		elseif rewardType == TaskRewardList.player_pot then
			local playerPot = player:getAttrValue(player_pot)
			player:setAttrValue(player_pot, playerPot + curValue)			
			if reward[rewardType] then
				reward[rewardType] = reward[rewardType] + curValue
			else
				reward[rewardType] = curValue
			end
		elseif rewardType == TaskRewardList.player_tao then
			-- 道行奖励
			local playerTao = player:getAttrValue(player_tao)
			player:setAttrValue(player_tao, playerTao + curValue)			
			if reward[rewardType] then
				reward[rewardType] = reward[rewardType] + curValue
			else
				reward[rewardType] = curValue
			end
		elseif rewardType == TaskRewardList.pet_tao then
			local followPetID	= player:getFollowPetID()
			local followPet		= followPetID and g_entityMgr:getPet(followPetID)
			if followPet then
				local petTao = followPet:getAttrValue(pet_tao)
				followPet:setAttrValue(pet_tao, petTao + curValue)
				if reward[rewardType] then
					reward[rewardType] = reward[rewardType] + curValue
				else
					reward[rewardType] = curValue
				end
			end
		-- 帮贡
		elseif rewardType == TaskRewardList.faction_cont then
			local factionMoney = player:getFactionMoney()
			player:setFactionMoney(factionMoney + curValue)
			if reward[rewardType] then
				reward[rewardType] = reward[rewardType] + curValue
			else
				reward[rewardType] = curValue
			end
			local memberInfoList = {{name = "memberMoney",value = player:getFactionMoney()}}
            local event_UpdateFactionInfo = Event.getEvent(FactionEvent_BC_UpdateFactionMemberInfo,player:getDBID(),memberInfoList)
            g_eventMgr:fireRemoteEvent(event_UpdateFactionInfo,player)
		-- 帮会任务当中的固定奖励， 声望
		elseif rewardType == TaskRewardList.faction_Fame then
			if factionID ~= 0 then
				local playerDBID = player:getDBID()
				local event = Event.getEvent(FactionEvent_BB_UpdateFactionInfo, "addFactionFame", playerDBID, curValue)
				g_eventMgr:fireWorldsEvent(event, SocialWorldID)
				if reward[rewardType] then
					reward[rewardType] = reward[rewardType] + curValue
				else
					reward[rewardType] = curValue
				end
			end
		-- 帮会资金
		elseif rewardType == TaskRewardList.faction_money then
			if factionID ~= 0 then
				local playerDBID = player:getDBID()
				local event = Event.getEvent(FactionEvent_BB_UpdateFactionInfo, "addFactionMoney", playerDBID, curValue)
				g_eventMgr:fireWorldsEvent(event, SocialWorldID)
				if reward[rewardType] then
					reward[rewardType] = reward[rewardType] + curValue
				else
					reward[rewardType] = curValue
				end
			end
		end
	end
	g_taskSystem:addMessageShow(player, reward)
	-- 处理循环任务公式奖励
	local taskType2 = self:getSubType()
	if taskType2 == TaskType2.Faction then
		self:dealFactionFormulaReward()
	else
		self:dealFormulaReward()
	end
	player:flushPropBatch()
	-- 处理物品奖励
	self:dealItemReward()
end

-- 处理循环任务不是帮会任务公式奖励
function LoopTask:dealFormulaReward()
	-- 根据不同的任务分不同的奖励
	local player = g_entityMgr:getPlayerByID(self._roleID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local curRing = taskHandler:getCurrentRing(self._taskID)
	local level = self._receiveTaskLvl
	local followPetID	= player:getFollowPetID()
	local followPet		= followPetID and g_entityMgr:getPet(followPetID)
	local petLevel
	if followPet then
		petLevel = followPet:getLevel()
	end
	local reward = {}
	for rewardType, rewardFunc in pairs(self._formulaRewards or {}) do
		local value = rewardFunc(curRing, level, petLevel)
		if not value then
			break
		end
		local curValue = value * (self._multipleReward or 1)
		if rewardType == TaskRewardList.player_xp then
			player:addXp(curValue)
			reward[rewardType] = curValue
		elseif rewardType == TaskRewardList.player_pot then
			local playerPot = player:getAttrValue(player_pot)
			player:setAttrValue(player_pot, playerPot + curValue)		
			reward[rewardType] = curValue
		elseif rewardType == TaskRewardList.player_tao then
			-- 道行奖励
			local playerTao = player:getAttrValue(player_tao)
			player:setAttrValue(player_tao, playerTao + curValue)			
			reward[rewardType] = curValue
		elseif rewardType == TaskRewardList.subMoney then
			-- 绑银
			local playerSubMoney = player:getSubMoney()
			player:setSubMoney(playerSubMoney + curValue)
			reward[rewardType] = curValue
		elseif rewardType == TaskRewardList.pet_tao then
			if followPet then
				local petTao = followPet:getAttrValue(pet_tao)
				followPet:setAttrValue(pet_tao, petTao + curValue)
				reward[rewardType] = curValue
				followPet:flushPropBatch()
			end
		elseif rewardType == TaskRewardList.pet_xp then
			if followPet then
				local petXp = followPet:getAttrValue(pet_xp)
				followPet:setAttrValue(pet_xp, petXp + curValue)
				reward[rewardType] = curValue
				followPet:flushPropBatch()
			end
		end
	end
	g_taskSystem:addMessageShow(player, reward)
end

-- 处理帮会公式奖励
function LoopTask:dealFactionFormulaReward()
	-- 所带的参数不一样
	local player = g_entityMgr:getPlayerByID(self._roleID)
	local taskPrivateHandler = player:getHandler(HandlerDef_TaskPrData)
	local equipData = taskPrivateHandler:getEquipData(self._taskID)
	if equipData then
		local reward = {}
		equipNeedLevel = equipData.equipNeedLevel
		equipQuality = equipData.equipQuality
		for rewardType, rewardFunc in pairs(self._formulaRewards or {}) do
			local value = rewardFunc(equipNeedLevel, equipQuality)
			local curValue = value * (self._multipleReward or 1)
			if rewardType == TaskRewardList.player_xp then
				player:addXp(curValue)
				reward[rewardType] = curValue
			elseif rewardType == TaskRewardList.player_pot then
				local playerPot = player:getAttrValue(player_pot)
				player:setAttrValue(player_pot, playerPot + curValue)	
				reward[rewardType] = curValue
			elseif rewardType == TaskRewardList.player_tao then
				local playerTao = player:getAttrValue(player_tao)
				player:setAttrValue(player_tao, playerTao + curValue)	
				reward[rewardType] = curValue
			elseif rewardType == TaskRewardList.pet_tao then
				local followPetID	= player:getFollowPetID()
				local followPet		= followPetID and g_entityMgr:getPet(followPetID)
				if followPet then
					local petTao = followPet:getAttrValue(pet_tao)
					followPet:setAttrValue(pet_tao, petTao + curValue)
					reward[rewardType] = curValue
					followPet:flushPropBatch()
				end
			end
		end
		g_taskSystem:addMessageShow(player, reward)
		taskPrivateHandler:removeEquipData(self._taskID)
	end
end


-- 获取当前任务目标配置
function LoopTask:getTargetsConfig()
	return self._targetsConfig
end

function LoopTask:setTargetsConfig(targets)
	table.deepCopy(targets, self._targetsConfig)
end

--刷新周期
function LoopTask:update()
	
end

--捐献任务的服务器随机数
function g_getRandomMoney()
	local moneyTable = {1500,1600,1700,1800,1900,2000}
	local tempData = math.random(6)
	return 1700--moneyTable[tempData]
end

-- 配置的物品
function LoopTask:setItemRewards(itemRewards)
	self._itemRewards = itemRewards
end

function LoopTask:getItemRewards()
	return self._itemRewards
end

-- 循环任务物品奖励
function LoopTask:dealItemReward()
	local player = g_entityMgr:getPlayerByID(self._roleID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local curRing = taskHandler:getCurrentRing(self._taskID)
	local level = player:getLevel()
	-- 获取等级索引
	local itemRewards = {}
	local msgID = 4
	if self._itemRewards then
		local gradeIndex = GetLevelIndex(player, ItemLevelSectionDB[self._taskID])
		-- 当前等级索引配置
		local curGradeConfig = self._itemRewards[gradeIndex]
		if curGradeConfig then
			local packetHandler = player:getHandler(HandlerDef_Packet)
			local curRingConfig = curGradeConfig[curRing]
			if curRingConfig then
				for _, itemInfo in pairs(curRingConfig) do
					if packetHandler:addItemsToPacket(itemInfo.itemID, itemInfo.itemNum) then
						if not itemRewards[itemInfo.itemID] then
							itemRewards[itemInfo.itemID] = itemInfo.itemNum
						end
					end
				end
			end
		end
	end

	if self._itemRewards then
		local params = false
		for itemID, itemNum in pairs(itemRewards) do
			params = string.format("%s%sx%s.", params or "", tItemDB[itemID].Name, itemNum)
		end
		if params then
			self:sendTaskItemMessageTip(player, msgID, params)
		end
	end
end

function LoopTask:sendTaskItemMessageTip(player, msgID, msgParams)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 设置接任务等级
function LoopTask:setReceiveTaskLvl(level)
	self._receiveTaskLvl = level
end

function LoopTask:getReceiveTaskLvl()
	return self._receiveTaskLvl
end