--[[TaskFactory.lua
描述：
	任务工厂(任务系统)
--]]

TaskFactory = class(nil, Singleton)

function TaskFactory:__init()

end

function TaskFactory:createNormalTask(player, taskID)
	local normalTaskData = NormalTaskDB[taskID]
	local normalTask = NormalTask()
	normalTask:setID(taskID)
	normalTask:setType(TaskType.normal)
	normalTask:setRewards(normalTaskData.rewards)
	normalTask:setTriggers(normalTaskData.triggers)
	normalTask:setSubType(normalTaskData.taskType2)
	normalTask:setRoleID(player:getID())
	normalTask:setUpdateDB()
	if normalTaskData.limitTime then
		normalTask:setStartTime(os.time())
		normalTask:setEndTime(normalTaskData.limitTime)
	end
	local hasTarget = self:buildTaskTarget(player, normalTask, normalTaskData.targets)
	-- 如果有任务目标状态设置为Active，没有任务目标的任务为Done
	if hasTarget then
		if not normalTask:canEnd() then
			normalTask:stateChange(TaskStatus.Active)
		else 
			normalTask:stateChange(TaskStatus.Done)
		end
	else
		normalTask:stateChange(TaskStatus.Done)
	end	
	local taskHandler = player:getHandler(HandlerDef_Task)
	taskHandler:setUpdateDB()
	return normalTask
end

-- 自行创建，这个循环任务没走数据库
function TaskFactory:createLoopTask(player, taskID, tarType)
	local loopTaskData = LoopTaskDB[taskID]
	local loopTask = LoopTask()
	local datas, targetType , levelIdx , ringIdx = self:createLoopTaskData(player, taskID, tarType)
	
	loopTask:setID(taskID)
	loopTask:setType(TaskType.loop)	
	loopTask:setSubType(loopTaskData.taskType2)
	loopTask:setPeriod(loopTaskData.period)
	loopTask:setRoleID(player:getID())
	loopTask:setFormulaRewards(loopTaskData.formulaRewards)
	loopTask:setNormalRewards(loopTaskData.normalRewards)
	loopTask:setItemRewards(loopTaskData.itemRewards)
	
	-- 设置开始时间
	--loopTask:setStartTime(os.time())
	-- 这个也是拷贝进去的
	loopTask:setTargetsConfig(datas.targets)
	-- 动态拷贝进去
	loopTask:setTriggers(datas.triggers)
	loopTask:setTargetType(targetType)
	loopTask:setGradeIdx(levelIdx)
	loopTask:setRingIdx(ringIdx)
	loopTask:setUpdateDB()
	-- 如果有时间限制
	--print("da>>>>>>>>>>>>>>", datas.limitTime)
	if datas.limitTime then
		loopTask:setStartTime(os.time())
		loopTask:setEndTime(datas.limitTime)
		g_taskSystem:onStartTimer(player, taskID, datas.limitTime)
	end
	if datas.triggers[TaskStatus.Active] then
		loopTask:stateChange(TaskStatus.Active)
	elseif datas.triggers[TaskStatus.Done] then
		loopTask:stateChange(TaskStatus.Done)
	else
		print("配置出错，动态任务目标没有配正确的触发器",toString(datas.triggers))
	end
	local taskHandler = player:getHandler(HandlerDef_Task)
	taskHandler:setUpdateDB()
	return loopTask
end

function TaskFactory:createLoopByTask(task, roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local loopTask = LoopTask()
	loopTask:setID(task:getID())
	loopTask:setType(task:getType())	
	loopTask:setSubType(task:getSubType())
	loopTask:setPeriod(task:getPeriod())
	loopTask:setRoleID(roleID)
	loopTask:setFormulaRewards(task:getFormulaRewards())
	loopTask:setNormalRewards(task:getNormalRewards())
	loopTask:setItemRewards(task:getItemRewards())
	
	-- 设置开始时间
	loopTask:setStartTime(task:getStartTime())
	-- 这个也是拷贝进去的
	loopTask:setTargetsConfig(task:getTargetsConfig())
	-- 动态拷贝进去
	loopTask:setTriggers(task:getTriggers())
	loopTask:setEndTime(task:getEndTime())
	loopTask:setTargetType(task:getTargetType())
	loopTask:setGradeIdx(task:getGradeIdx())
	loopTask:setRingIdx(task:getRingIdx())
	loopTask:setUpdateDB()
	local hasTarget = self:buildTaskTarget(player, loopTask, loopTask:getTargetsConfig())
	if hasTarget then
		if not loopTask:canEnd() then
			loopTask:stateChange(TaskStatus.Active, true)
		else
			loopTask:stateChange(TaskStatus.Done, true)			
		end
	else
		loopTask:stateChange(TaskStatus.Done, true)
	end
	local taskHandler = player:getHandler(HandlerDef_Task)
	taskHandler:setUpdateDB()
	return loopTask
end

function TaskFactory:createNormalTaskFromDB(player, taskData)
	local normalTaskData = NormalTaskDB[taskData.taskID]
	local normalTask = NormalTask()
	normalTask:setID(taskData.taskID)
	normalTask:setType(TaskType.normal)
	normalTask:setRoleID(player:getID())
	normalTask:setRewards(normalTaskData.rewards)
	normalTask:setTriggers(normalTaskData.triggers)
	normalTask:setSubType(normalTaskData.taskType2)
	if taskData.endTime and taskData.endTime > 0 and os.time() > taskData.endTime then
		normalTask:stateChange(TaskStatus.Failed, true)
		return normalTask
	end
	normalTask:setEndTime(taskData.endTime, true)
	local hasTarget = self:buildTaskTarget(player, normalTask, normalTaskData.targets, taskData.targetState)
	if hasTarget then
		if not normalTask:canEnd() then
			normalTask:stateChange(TaskStatus.Active, true)
		else
			normalTask:stateChange(TaskStatus.Done, true)
		end
	else
		normalTask:stateChange(TaskStatus.Done, true)
	end
	return normalTask
end

-- 从数据库读取, 超时不用创建，直接从数据库删除
function TaskFactory:createLoopTaskFromDB(player, taskData)
	local taskID = taskData.loopTaskID
	if taskData.endTime and taskData.endTime > 0 then
		if os.time() >= taskData.endTime then
			-- 如果是计时任务，时间到，直接从数据库删除
			local taskHandler = player:getHandler(HandlerDef_Task)
			taskHandler:deleteTaskToDB(taskID)
			return
		end
	end
	local loopTaskData = LoopTaskDB[taskID]
	-- 当前循环任务targets
	local datas = LoopTaskTargetsDB[taskID][taskData.targetType]
	local loopTask = LoopTask()
	loopTask:setID(taskID)
	loopTask:setType(TaskType.loop)	
	loopTask:setSubType(loopTaskData.taskType2)
	loopTask:setPeriod(loopTaskData.period)
	loopTask:setRoleID(player:getID())
	loopTask:setFormulaRewards(loopTaskData.formulaRewards)
	loopTask:setNormalRewards(loopTaskData.normalRewards)
	loopTask:setItemRewards(loopTaskData.itemRewards)
	-- 直接设置结束时间
	--loopTask:setEndTime(taskData.endTime, true)
	loopTask:setTargetType(taskData.targetType)
	loopTask:setGradeIdx(taskData.gradeIdx)
	loopTask:setRingIdx(taskData.ringIdx)
	loopTask:setReceiveTaskLvl(taskData.level)

	-- 如果结束时间大于0
	if taskData.endTime > 0 then
		loopTask:setEndTime(taskData.endTime, true)
		g_taskSystem:onStartTimer(player, taskID, taskData.endTime - os.time())
	end
	local c,targets = pcall(loadstring("return "..taskData.targets))
	loopTask:setTargetsConfig(targets)
	local c ,triggers = pcall(loadstring("return "..taskData.triggers))
	loopTask:setTriggers(triggers)
	local hasTarget = self:buildTaskTarget(player, loopTask, loopTask:getTargetsConfig(), taskData.targetState)
	if hasTarget then
		if not loopTask:canEnd() then
			loopTask:stateChange(TaskStatus.Active, true)
		else
			loopTask:stateChange(TaskStatus.Done, true)
		end
	else
		loopTask:stateChange(TaskStatus.Done, true)
	end
	-- 这个地方还有做一下处理
	return loopTask
end

-- 创建循环任务
function TaskFactory:createLoopTaskData(player, taskID, tarType)
	local loopTaskData = LoopTaskDB[taskID]
	local levelFlag = loopTaskData.levelFlag
	local targetsConfig = loopTaskData.targets
	--  根据等级去索引
	local firstGradeIdx
	if levelFlag then
		-- 等级区分
		firstGradeIdx = GetLevelIndex(player, LoopTaskDB[taskID].targetLevelSection)
	else 
		-- 环数区分
		firstGradeIdx = 1
	end
	-- 首先随机是那个类型
	local targets = targetsConfig[firstGradeIdx]
	local targetType = tarType or FunWeight(targets)

	-- 再加一个判断等级判断
	local targetConfigs = LoopTaskTargetsDB[taskID][targetType]

	-- 再根据等级随那个等级段
	local levelIdx = GetLevelIndex(player, RandDataSectionDB[taskID])
	local ringIdx =  GetRingIndex(player, TaskRingSectionDB[taskID], taskID)
	return LoopTaskTargetsDB[taskID][targetType], targetType, levelIdx, ringIdx

end

--创建任务目标
function TaskFactory:buildTaskTarget(player, task, targetsData, taskData)
	if table.size(targetsData) == 0 then
		return false
	end
	for idx ,targetData in pairs(targetsData) do -- 为任务添加任务目标
		local target = createTarget(player, task, targetData.type, targetData.param, taskData and taskData[idx])
		task:addTarget(idx, target)
	end
	return true
end

function TaskFactory:createDailyTask( player,taskID )	
	local dailyTaskData = DailyTaskDB[taskID]
	local dailyTask = DailyTask()
	dailyTask:setID(taskID)
	dailyTask:setType(TaskType.daily)
	dailyTask:setRewards(dailyTaskData.rewards)
	dailyTask:setTriggers(dailyTaskData.triggers)
	dailyTask:setSubType(dailyTaskData.taskType2)
	dailyTask:setTargetType(dailyTaskData.targets[1].type)
	dailyTask:setTargetParam(dailyTaskData.targets[1].param)
	dailyTask:setDailyTargets(dailyTaskData.targets)
	dailyTask:setRoleID(player:getID())
	if dailyTaskData.limitTime then
		dailyTask:setStartTime(os.time())
		dailyTask:setEndTime(dailyTaskData.limitTime)
	end
	dailyTask:setUpdateDB()
	local hasTarget = self:buildTaskTarget(player, dailyTask, dailyTaskData.targets)
	-- 如果有任务目标状态设置为Active，没有任务目标的任务为Done
	if hasTarget then
		if dailyTask:canEnd() then
			dailyTask:stateChange(TaskStatus.Done)
		else
			dailyTask:stateChange(TaskStatus.Active)
		end
	else
		dailyTask:stateChange(TaskStatus.Done)
	end
	
	local taskHandler = player:getHandler(HandlerDef_Task)
	taskHandler:setUpdateDB()
	return dailyTask
end

function TaskFactory:createDailyTaskFromDB(player, taskData)
	local dailyTaskData = DailyTaskDB[taskData.taskID]
	local taskTarget = unserialize(taskData.targets)
	local dailyTask = DailyTask()
	dailyTask:setID(taskData.taskID)
	dailyTask:setType(TaskType.daily)
	dailyTask:setRewards(dailyTaskData.rewards)
	dailyTask:setTriggers(dailyTaskData.triggers)
	dailyTask:setSubType(dailyTaskData.taskType2)
	dailyTask:setTargetType(taskTarget[1].type)
	dailyTask:setTargetParam(taskTarget[1].param)
	dailyTask:setDailyTargets(taskTarget)
	dailyTask:setRoleID(player:getID())
	if dailyTaskData.limitTime then
		dailyTask:setStartTime(os.time())
		dailyTask:setEndTime(dailyTaskData.limitTime)
	end
	local hasTarget = self:buildTaskTarget(player, dailyTask,taskTarget)
	-- 如果有任务目标状态设置为Active，没有任务目标的任务为Done
	if hasTarget then
		if dailyTask:canEnd() then
			dailyTask:stateChange(TaskStatus.Done,true)
		else
			dailyTask:stateChange(TaskStatus.Active,true)
		end
	else
		dailyTask:stateChange(TaskStatus.Done,true)
	end
	return dailyTask
end

-- 创建通天塔任务, rewardType 奖励类型， layer玩家任务对对应的层数, 数据库和普通的, 最后飞升层数
function TaskFactory:createBabelTask(player, taskID, rewardType, layer, flyLayer)
	local babelTaskData = BabelTaskDB[taskID]
	local babelTask = BabelTask()
	-- 设置奖励类型
	babelTask:setRewardType(rewardType)
	-- 设置奖励公式
	babelTask:setFormulaRewards(babelTaskData.formulaRewards)
	-- 通过多少才层，来随机
	babelTask:setLayer(layer)
	babelTask:setID(taskID)
	babelTask:setType(TaskType.babel)	
	babelTask:setSubType(babelTaskData.taskType2)
	-- 传递飞升层数
	babelTask:setFlyLayer(flyLayer)
	-- 跨天跟新
	babelTask:setPeriod(babelTaskData.period)
	babelTask:setRoleID(player:getID())
	-- 这个也是拷贝进去的， 刚开始配置为nil
	babelTask:setTargetsConfig(babelTaskData.targets)
	-- 动态拷贝进去, 这时候为NIl
	babelTask:setTriggers(babelTaskData.triggers)
	-- 此时创建任务目标和触发器的参数
	local configParam = BabelEachLayerDB[taskID][layer]
	babelTask:resetConfigParam(configParam)
	babelTask:setUpdateDB()
	-- 创建任务目标
	local hasTarget = self:buildTaskTarget(player, babelTask, babelTask:getTargetsConfig())
	if hasTarget then
		if not babelTask:canEnd() then
			babelTask:stateChange(TaskStatus.Active, true)
		else
			babelTask:stateChange(TaskStatus.Done, true)
		end
	else
		babelTask:stateChange(TaskStatus.Done, true)
	end
	local taskHandler = player:getHandler(HandlerDef_Task)
	taskHandler:setUpdateDB()
	return babelTask
end

-- 从数据库来创建
function TaskFactory:createBabelTaskFromDB(player, taskData) 
	local babelTaskData = BabelTaskDB[taskData.taskID]
	local babelTask = BabelTask()
	-- 设置奖励类型
	babelTask:setRewardType(taskData.rewardType)
	-- 设置配置奖励公式
	-- 设置奖励公式
	babelTask:setFormulaRewards(babelTaskData.formulaRewards)
	-- 通过多少才层，来随机
	babelTask:setLayer(taskData.layer)
	babelTask:setFlyLayer(taskData.flyLayer)
	babelTask:setID(taskData.taskID)
	babelTask:setType(TaskType.babel)	
	babelTask:setSubType(babelTaskData.taskType2)
	babelTask:setTaskIndex(taskData.taskIndex)
	-- 跨天跟新
	babelTask:setPeriod(babelTaskData.period)
	babelTask:setRoleID(player:getID())
	-- 这个也是拷贝进去的， 刚开始配置为nil
	babelTask:setTargetsConfig(babelTaskData.targets)
	-- 动态拷贝进去, 这时候为NIl
	babelTask:setTriggers(babelTaskData.triggers)
	-- 此时创建任务目标和触发器的参数
	local configParam = BabelEachLayerDB[taskData.taskID][taskData.layer]
	babelTask:resetConfigParam(configParam, true)
	-- 创建任务目标
	local hasTarget = self:buildTaskTarget(player, babelTask, babelTask:getTargetsConfig(), taskData.targetState)
	if hasTarget then
		if not babelTask:canEnd() then
			babelTask:stateChange(TaskStatus.Active, true)
		else
			babelTask:stateChange(TaskStatus.Done, true)
		end
	else
		babelTask:stateChange(TaskStatus.Done, true)
	end
	return babelTask
end

g_taskFty = TaskFactory()