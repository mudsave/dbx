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
	-- 
	self._index = nil
	self._period = nil
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
	print("shezhi jinagli leing>>>>>>>>>>",rewardType)
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
	-- 设置任务出发器参数，状态为Done
	--[[
	local talkNpcTrace = configParam.talkNpcTrace[1]
	local doneTriggerParam = self._triggers[TaskStatus.Done][1].param
	doneTriggerParam.npcID = talkNpcTrace.npcID
	doneTriggerParam.mapID = talkNpcTrace.mapID
	doneTriggerParam.x = talkNpcTrace.x
	doneTriggerParam.y = talkNpcTrace.y
	--]]
end

function BabelTask:setTaskIndex(index)
	print("随机只》》》》》》", index)
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