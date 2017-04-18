--[[BabelTask.lua
	通天塔任务
--]]
BabelTask = class(Task)

function BabelTask:__init(taskData)
	-- 当前通天塔任务的层数
	self._layer = nil
	-- 奖励类型
	self._rewardType = nil
	-- 任务目标配置
	self._targetsConfig = {}
	self._index = nil
	self._period = nil
	-- 飞升层数
	self._flyLayer = 0
	self._formulaRewards = nil
end

function BabelTask:__release()
	-- 当前通天塔任务的层数
	self._layer = nil
	-- 奖励类型
	self._rewardType = nil
	-- 任务目标配置
	self._targetsConfig = nil
	self._index = nil
	self._period = nil
	-- 飞升层数
	self._flyLayer = nil
	self._formulaRewards = nil
end

-- 前面的拷贝到后面, 触发器拷贝
function BabelTask:setTriggers(trigger)
	table.deepCopy(trigger, self._triggers)
end

function BabelTask:getTriggers()
	return self._triggers
end

-- 任务目标
function BabelTask:setTargetsConfig(targets)
	table.deepCopy(targets, self._targetsConfig)
end

-- 获取当前任务目标配置
function BabelTask:getTargetsConfig()
	return self._targetsConfig
end

function BabelTask:setLayer(layer)
	self._layer = layer
end

function BabelTask:getLayer()
	return self._layer
end

function BabelTask:setRewardType(rewardType)
	self._rewardType = rewardType
end

function BabelTask:getRewardType()
	return self._rewardType
end

-- 重新设置任务配置参数
function BabelTask:resetConfigParam(configParam, fromDB)
	local challengeNpcTrace = configParam.challengeNpcTrace
	-- 随机索引值, 设置任务目标参数
	if not fromDB then
		self._index = math.random(#challengeNpcTrace)
	end
	local randomParam = challengeNpcTrace[self._index]
	local targetParam = self._targetsConfig[1].param
	targetParam.scriptID = randomParam.scriptID
	targetParam.count = 1
	--targetParam.ignoreResult = false
	targetParam.bor = true
	-- 设置任务触发器参数, 状态为Activit
	local activeTriggerParam = self._triggers[TaskStatus.Active][1].param
	activeTriggerParam.npcID = randomParam.npcID
	activeTriggerParam.mapID = randomParam.mapID
	activeTriggerParam.x = randomParam.x
	activeTriggerParam.y = randomParam.y
end

function BabelTask:setTaskIndex(index)
	self._index = index
end

function BabelTask:getTaskIndex()
	return self._index
end

--任务周期
function BabelTask:setPeriod(period)
	self._period = period
end

function BabelTask:getPeriod()
	return self._period
end

function BabelTask:setFlyLayer(flyLayer)
	self._flyLayer = flyLayer
end

function BabelTask:getFlyLayer()
	return self._flyLayer
end

--公式奖励
function BabelTask:setFormulaRewards(formulaRewards)
	self._formulaRewards = formulaRewards
end

function BabelTask:getFormulaRewards()
	return self._formulaRewards
end

--  通天塔任务奖励
function BabelTask:addBabelReward()
	local player = g_entityMgr:getPlayerByID(self._roleID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local level = player:getLevel()
	local followPetID = player:getFightPetID()
	local followPet	= followPetID and g_entityMgr:getPet(followPetID)
	local petLevel
	if followPet then
		petLevel = followPet:getLevel()
	end
	local reward = {}
	local curLayer = self._layer
	local curReward = self._formulaRewards[self._rewardType]
	for index = 1, self._flyLayer do
		for rewardType, rewardFunc in pairs(curReward or {}) do
			-- 玩家
			local value
			if rewardType == TaskRewardList.player_xp then
				value = rewardFunc(level, curLayer)
				local tem_xp_ratio = player:getAttrValue(player_xp_ratio)
				value = math.floor(value * tem_xp_ratio / 100)
			elseif rewardType == TaskRewardList.pet_xp then
				if followPet then
					value = rewardFunc(petLevel, curLayer)
				end
			elseif rewardType == TaskRewardList.player_tao then
				value = rewardFunc(level, curLayer)
			elseif rewardType == TaskRewardList.pet_tao then
				if followPet then
					value = rewardFunc(petLevel, curLayer)
				end
			end
			if value then
				reward[rewardType] = (reward[rewardType] or 0)+ value
			end
		end
		curLayer = curLayer - 1
	end
	
	for rewardType, valueInfo in pairs(reward) do
		if rewardType == TaskRewardList.player_xp then
			player:addXp(valueInfo)
		elseif rewardType == TaskRewardList.pet_xp then
			local petXp = followPet:getAttrValue(pet_xp)
			followPet:setAttrValue(pet_xp, petXp + valueInfo)
			followPet:flushPropBatch()	
		elseif rewardType == TaskRewardList.player_tao then
			local playerPot = player:getAttrValue(player_pot)
			player:setAttrValue(player_pot, playerPot + valueInfo)		
		elseif rewardType == TaskRewardList.pet_tao then
			local petTao = followPet:getAttrValue(pet_tao)
			followPet:setAttrValue(pet_tao, petTao + valueInfo)
			followPet:flushPropBatch()
		end
	end
	g_taskSystem:addMessageShow(player, reward)
end