--[[TaskHandler.lua
描述：
	任务handler(任务系统)
--]]

TaskHandler = class()

function TaskHandler:__init(entity)
	self._entity = entity
	self.currentTask = {}			--当前任务
	self.nextTaskID = 0				--主线下一个任务
	self.hisTasks = {}				--历史任务
	self.taskTraceList = nil		--任务追踪列表
	self.canRecetiveLoopTask = {}	--可接循环任务列表
	self.count = 0					--任务数量
	self.loopTaskInfo = {}			--循环任务信息
	self.canRecetiveTaskID = {}
	self.updateDB = false

	self.dailyTaskConfiguration = {}   --日常任务配置表
	-- 通天塔任务初
	self.babelTaskInfo = {}


end

function TaskHandler:__release()
	self._entity = nil
	self:releaseCurTask()
	self.nextTaskID = nil
	self.hisTasks = nil
	self.taskTraceList = nil
	self.canRecetiveLoopTask = nil
	self.taskMineList = nil
	self.count = nil
	self.loopTaskInfo = nil
	self.babelTaskInfo = nil
	self.dailyTaskConfiguration = nil   --日常任务配置表
	self.updateDB = false
end

function TaskHandler:releaseCurTask()
	for taskID, task in pairs(self.currentTask) do
		if task then
			release(task)
			self.currentTask[taskID] = nil
		end
	end
	self.currentTask = nil
end

function TaskHandler:setUpdateDB()
	self.updateDB = true
end

function TaskHandler:getUpdateDB()
	return self.updateDB
end

function TaskHandler:addTask(task)
	local taskID = task:getID()
	if self.currentTask[taskID] then
		--提示重复接任务
	else
		self.currentTask[taskID] = task
		self:updateNextTask(taskID)
		self.count = self.count + 1
	end

	if DailyTaskDB[taskID] then
		self.dailyTaskConfiguration[taskID] = false
	end

end

function TaskHandler:loadHistoryTask(hisTasks)
	self.hisTasks = hisTasks
	self:loadNextTaskID(hisTasks)
end

function TaskHandler:setTaskTraceList(taskTraceList)
	self.taskTraceList = taskTraceList
end

function TaskHandler:getTaskTraceList()
	return self.taskTraceList
end

function TaskHandler:loadNextTaskID(hisTasks)
	if 0 == self.nextTaskID then
		assert (type(hisTasks) == "table")
		for _, taskID in pairs(hisTasks) do
			local nextTaskID = NormalTaskDB[taskID] and NormalTaskDB[taskID].nextTaskID
			if nextTaskID  then
				if type(nextTaskID) == "number" then
					local taskType = NormalTaskDB[taskID] and NormalTaskDB[taskID].taskType2
					if taskType == TaskType2.Main and self.nextTaskID < nextTaskID then
						self.nextTaskID = nextTaskID
					end
				elseif type(nextTaskID) == "table" then
					for _, nexttaskID in pairs(nextTaskID) do
						if TaskCondition.normalTask(self._entity, nexttaskID) then
							local taskType = NormalTaskDB[nexttaskID] and NormalTaskDB[nexttaskID].taskType2
							if taskType == TaskType2.Main and self.nextTaskID < nexttaskID then
								self.nextTaskID = nexttaskID
								break
							end
						end
					end
				end
			end
		end
	end
	if self.nextTaskID == 0 then
		self.nextTaskID = 2002
		g_taskSystem:updateNormalTaskList(self._entity, self.nextTaskID)
	end
end

function TaskHandler:updateNextTask(taskID)
	if NormalTaskDB[taskID] then
		if self.nextTaskID == taskID then
			self.nextTaskID = nil
		end
	end
end

-- 玩家上线加载完任务之后，调用一下这个接口， 设置这些可接任务
function TaskHandler:loadCanRecetiveLoopTask()
	for loopTaskID, taskData in pairs(LoopTaskDB) do
		if self._entity:getLevel() >= taskData.level[1] and self._entity:getLevel() <= taskData.level[2] then
			if taskData.school then
				-- 如果有门牌限定
				if taskData.school == self._entity:getSchool() then
					if not self.currentTask[loopTaskID] and self:getCountRing(loopTaskID) < taskData.loop then
						if not self.canRecetiveLoopTask[loopTaskID] then
							self.canRecetiveLoopTask[loopTaskID] = true
						end
					end
				end
			else
				-- 如果没有门牌限制, 还有帮会任务，上缴装备
				if taskData.taskType2 == TaskType2.Faction then
					local factionID = self._entity:getFactionDBID()
					if factionID > 0 then
						if not self.currentTask[loopTaskID] and self:getCountRing(loopTaskID) < taskData.loop then
							if not self.canRecetiveLoopTask[loopTaskID] then
								self.canRecetiveLoopTask[loopTaskID] = true
							end
						end
					end
				else
					if not self.currentTask[loopTaskID] and self:getCountRing(loopTaskID) < taskData.loop then
						if not self.canRecetiveLoopTask[loopTaskID] then
							self.canRecetiveLoopTask[loopTaskID] = true
						end
					end
				end
			end
		end
	end
end

-- 完成任务之后再添加，因为在完成任务之前，一些判断都满足，才能执行到
function TaskHandler:addLoopTaskList(taskID)
	if not self.currentTask[taskID] and self:getCountRing(taskID) < LoopTaskDB[taskID].loop then
		if not self.canRecetiveLoopTask[taskID] then
			self.canRecetiveLoopTask[taskID] = true
			return true
		end
	end
end

-- 接任务之后， 删除可接循环任务列表
function TaskHandler:removeLoopTaskList(taskID)
	if self.canRecetiveLoopTask[taskID] then
		self.canRecetiveLoopTask[taskID] = nil
	end
end

-- 完成任务之后跟新任务列表，先添加在设置之后,再发送到客户端
function TaskHandler:updateTaskList(taskID, flag)
	if NormalTaskDB[taskID] then
		g_taskSystem:updateNormalTaskList(self._entity, self.nextTaskID)
	elseif LoopTaskDB[taskID] then
		-- 完成循环任务之后， 先添加,和删除
		if flag then
			if not self:addLoopTaskList(taskID) then
				return
			end
		else
			-- 必须移除
			self:removeLoopTaskList(taskID)
		end
		g_taskSystem:updateLoopTaskList(self._entity, taskID, flag)
	end
end

function TaskHandler:getRecetiveLoopTask()
	return self.canRecetiveLoopTask
end

function TaskHandler:getNextID()
	return self.nextTaskID
end

-- 接任务的时候，当前函数+ 1 
function TaskHandler:updateLoopCount(taskID)
	self:checkTaskData(taskID)
	self.loopTaskInfo[taskID].currentRing = self.loopTaskInfo[taskID].currentRing + 1
end

-- 服务器定时扫描定时器， 结束时间到，循环任务结束
function TaskHandler:updateMinTask(currentTime)
	for taskID, task in pairs(self.currentTask) do
		if LoopTaskDB[taskID] then
			if task:getEndTime() then
				if task:getEndTime() > 0 and task:getEndTime() < currentTime then
					-- 删除任务,设置任务状态为失败。
					--g_taskDoer:doDeleteTask(self._entity, taskID)
					task:stateChange(TaskStatus.Failed)
					task:setUpdateDB()
				end
			end
		else
			if task:getStatus() == TaskStatus.Active then 
				if task:getEndTime() then
					if task:getEndTime() > 0 and task:getEndTime() < currentTime then
						task:stateChange(TaskStatus.Failed)
						task:setUpdateDB()
					end
				end
			end
		end
	end
end

-- 跨天重置
function TaskHandler:updateDayTask()
	for taskID, loopTaskInfo in pairs(self.loopTaskInfo) do
		if LoopTaskDB[taskID].period == TaskPeriod.day then
			loopTaskInfo.countRing = 0
			loopTaskInfo.finishTimes = 0
			--loopTaskInfo.receiveTaskTime = os.time()
		end
	end
	-- 跟新通天塔任务, 有任务和没有任务的情况
	local babelTaskID = 20001
	if self.currentTask[babelTaskID] then
		--完成任务
		self:finishBabelTask(babelTaskID)
		local mapID = self.entity:getScene():getMapID()
		if mapID >= 1001 and mapID <= 1200 then
			g_sceneMgr:doSwitchScence(self._entity:getID(), 10, 123, 265)
		end
	end
	local babelTaskInfo = self.babelTaskInfo[babelTaskID]
	if babelTaskInfo then
		babelTaskInfo.faildTimes = 0
		babelTaskInfo.finishFlag = 0
	end
end

-- 跨周
function TaskHandler:updateWeekTask()
	for taskID, loopTaskInfo in pairs(self.loopTaskInfo) do
		if LoopTaskDB[taskID].period == TaskPeriod.week then
			loopTaskInfo.countRing = 0
			loopTaskInfo.finishTimes = 0
		end
	end
end

-- 刚开始没有环数为配置的次数
function TaskHandler:getCountRing(taskID)
	-- 天道任务总的环数不需要考虑
	self:checkTaskData(taskID)
	return self.loopTaskInfo[taskID].countRing
end

-- 得到完成次数
function TaskHandler:getFinishTimes(taskID)
	self:checkTaskData(taskID)
	return self.loopTaskInfo[taskID].finishTimes
end

-- 天道任务获取当前的环数
function TaskHandler:checkTaskData(taskID)
	local taskData = self.loopTaskInfo[taskID]
	if not taskData then
		taskData = {}
		taskData.countRing = 0
		taskData.currentRing = 0
		taskData.finishTimes = 0
		taskData.receiveTaskTime = 0
		-- print("taskData.finishTimes",taskData.finishTimes)
		self.loopTaskInfo[taskID] = taskData
	end
end

-- 设置当前的环数
function TaskHandler:setCurrentRing(taskID, ring)
	self:checkTaskData(taskID)
	self.loopTaskInfo[taskID].currentRing = ring
end

function TaskHandler:setCountRing(taskID, countRing)
	self:checkTaskData(taskID)
	self.loopTaskInfo[taskID].countRing = countRing
end

-- 更新完成次数
function TaskHandler:updateFinishTimes(taskID)
	self:checkTaskData(taskID)
	self.loopTaskInfo[taskID].finishTimes = self.loopTaskInfo[taskID].finishTimes + 1
	self.loopTaskInfo[taskID].countRing = self.loopTaskInfo[taskID].countRing + 1
end

-- 设置一下接任务的时间
function TaskHandler:setReceiveTaskTime(taskID)
	self:checkTaskData(taskID)
	self.loopTaskInfo[taskID].receiveTaskTime = os.time()
end

-- 刚开始没有环数为1设置呢 这个需要做下判断， 同步队员之间的环数
function TaskHandler:getCurrentRing(taskID)
	local taskConfig = LoopTaskDB[taskID]
	local taskType2 = taskConfig.taskType2
	-- 天道任务总的环数不需要考虑
	if taskType2 == TaskType2.Heaven then
		-- 判断有没有组队
		local teamHandler = self._entity:getHandler(HandlerDef_Team)
		local teamID = teamHandler:getTeamID()
		-- 如果组队
		if teamID > 0  then
			local team = g_teamMgr:getTeam(teamID)
			if teamHandler:isLeader() then
				self:checkTaskData(taskID)
				return self.loopTaskInfo[taskID].currentRing
			else
				-- 如果不是队长 , 取队长当前的环数 
				local leaderPlayer = g_entityMgr:getPlayerByID(team:getLeaderID())
				local leaderTaskHandler = leaderPlayer:getHandler(HandlerDef_Task)
				local curRing = leaderTaskHandler:getCurrentRing(taskID)
				local countRing = leaderTaskHandler:getCountRing(taskID)
				self:setCurrentRing(taskID, curRing)
				self:setCountRing(taskID, countRing)
				return curRing
			end
		else
			self:checkTaskData(taskID)
			return self.loopTaskInfo[taskID].currentRing
		end
	else
		self:checkTaskData(taskID)
		return self.loopTaskInfo[taskID].currentRing
	end
end

function TaskHandler:getLoopTaskInfo()
	return self.loopTaskInfo
end

function TaskHandler:getTask(taskID)
	return self.currentTask[taskID]
end

function TaskHandler:getTasks()
	return self.currentTask
end

function TaskHandler:getHisTasks()
	return self.hisTasks
end

function TaskHandler:updateHisTask(taskID)
	if self.currentTask[taskID]:getSubType() == TaskType2.Sub then
		return
	end
	local state = false
	for _, histaskID in pairs(self.hisTasks) do
		if histaskID == taskID then
			state = true
		end

	end
	if not state then
		table.insert(self.hisTasks, taskID)
	end
end

function TaskHandler:isHisTask(taskID)
	for _, histaskID in pairs(self.hisTasks) do
		if histaskID == taskID then
			return true
		end
	end
	return false
end

-- 删除任务
function TaskHandler:removeTaskByID(taskID)
	if self.currentTask[taskID] then
		release(self.currentTask[taskID])
		self.currentTask[taskID] = nil	
		self:deleteTaskToDB(taskID) 
		self.count = self.count - 1
		-- 此时也要跟新一下npc头顶状态
		self:updateNpcHeader(taskID)
		self:updateTaskList(taskID, true)
		self.updateDB = true
		if self.loopTaskInfo[taskID] then
			self.loopTaskInfo[taskID].isSaveDB = true
		end
	end
end

function TaskHandler:updateNpcHeader(taskID)
	local player = self._entity
	if NormalTaskDB[taskID] then
		local startNpcID = NormalTaskDB[taskID].startNpcID
		local startNpc = g_entityMgr:getNpc(startNpcID)
		if startNpc then
			g_taskDoer:updateNpcHeader(player, startNpc)
		end
		local endNpcID = NormalTaskDB[taskID].endNpcID
		local endNpc = g_entityMgr:getNpc(endNpcID)
		if endNpc then
			g_taskDoer:updateNpcHeader(player, endNpc)
		end
	elseif LoopTaskDB[taskID] then
		local startNpcID = LoopTaskDB[taskID].startNpcID
		local startNpc = g_entityMgr:getNpc(startNpcID)
		if startNpc then
			g_taskDoer:updateNpcHeader(player, startNpc)
		end
		local endNpc = g_entityMgr:getNpc(self._endNpcID)
		if endNpc then
			g_taskDoer:updateNpcHeader(player, endNpc)
		end
	elseif DailyTaskDB[taskID] then
		local startNpcID = DailyTaskDB[taskID].startNpcID
		local startNpc = g_entityMgr:getNpc(startNpcID)
		if startNpc then
			g_taskDoer:updateNpcHeader(player, startNpc)
		end
		local endNpc = g_entityMgr:getNpc(self._endNpcID)
		if endNpc then
			g_taskDoer:updateNpcHeader(player, endNpc)
		end
	end
end

function TaskHandler:doneTaskByID(taskID)
	if self.currentTask[taskID] then
		self.currentTask[taskID]:stateChange(TaskStatus.Done)
	end
end

function TaskHandler:setLoopTaskSaveDB(taskID)
	local loopTaskInfo = self.loopTaskInfo[taskID]
	if loopTaskInfo then
		loopTaskInfo.isSaveDB = true 
	end
end

-- 完成循环任务的接口,如果是天道任务。都完成之后才能接任务, 帮会任务不用这个接口
function TaskHandler:finishLoopTask(taskID)
	-- 完成当前任务，
	self:finishTaskByID(taskID)
	self.loopTaskInfo[taskID].isSaveDB = true
	local player = self._entity
	-- 完成循环任务的时候向活动界面发一个接口
	self:updateFinishTimes(taskID)
	local activityEvent = Event.getEvent(TaskEvent_SS_AddActivityPractise, player:getID(), taskID)
	g_eventMgr:fireEvent(activityEvent)
	-- 自动交接, 天道任务和其他任务处理方式不一样， 天道任务处理
	if LoopTaskDB[taskID].taskType2 == TaskType2.Heaven then
		local teamHandler = player:getHandler(HandlerDef_Team)
		local teamID = teamHandler:getTeamID()
		if teamID > 0  then
			-- 所有队员都完成任务才能接
			local team = g_teamMgr:getTeam(teamID)
			-- 如果任务玩家是队长才能接
			if team:getLeaderID() == player:getID() then
				if not TaskCondition.isMaxRing(player, taskID) then
					g_taskDoer:doReceiveSpecialTask(player, taskID)
				else
					-- 次数到，重置
					for _, entity in pairs(teamHandler:getTeamPlayerList()) do
						local taskHandler = entity:getHandler(HandlerDef_Task)
						taskHandler:resetCurrentRing(taskID)
					end
				end
			end	
		else
			if not TaskCondition.isMaxRing(player, taskID) then
				g_taskDoer:doReceiveSpecialTask(player, taskID)
			else
				-- 重置当前环数，不需要转盘奖励
				self:resetCurrentRing(taskID)
			end
		end
	-- 如果是帮会任务
	elseif LoopTaskDB[taskID].taskType2 == TaskType2.Faction then
		-- 不自动接不奖励
		if TaskCondition.isMaxRing(player, taskID) then
			self:resetCurrentRing(taskID)
		end
	else 
		-- 其他循环任务不涉及到组队的问题
		if not TaskCondition.isMaxRing(player, taskID) then
			-- 不涉及到组队的自动接任务
			g_taskDoer:doRecetiveTask(player, taskID)
		else
			self:resetCurrentRing(taskID)
			-- 完成所有环打开奖励界面
			local event = Event.getEvent(TaskEvent_SC_OpenRewardUI)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

function TaskHandler:addCountRing(taskID)
	self:checkTaskData(taskID)
	self.loopTaskInfo[taskID].countRing = self.loopTaskInfo[taskID].countRing + 1
end

function TaskHandler:finishTaskByID(taskID)
	if self.currentTask[taskID] then
		self.updateDB = true
		-- 清除taskPrivateHandler当中的绑定的npcID
		local taskPrivateHandler = self._entity:getHandler(HandlerDef_TaskPrData)
		taskPrivateHandler:removeTraceInfo(taskID)
		self:updateHisTask(taskID)
		self:updateHisTaskToDB()
		--最好不要在这个地方重新设置
		self.currentTask[taskID]:stateChange(TaskStatus.Finished)
		-- 完成之后环数+1
		self:deleteTaskToDB(taskID) 
		release(self.currentTask[taskID])
		self.currentTask[taskID] = nil
		self:createNextTaskID(taskID)
		-- 完成任务时，重新设置这个任务列表
		self:updateTaskList(taskID, true)
		self.count = self.count - 1

		-- 判断任务目标
		TaskCallBack.onGuideTask(self._entity,taskID)
		return true
	else
		print("任务不存在",taskID)
		print("当前只有",toString(self.currentTask))
		return false
	end
end

function TaskHandler:createNextTaskID(taskID)
	if NormalTaskDB[taskID] then
		local nextTaskID = NormalTaskDB[taskID].nextTaskID
		if nextTaskID  then
			if type(nextTaskID) == "number" then
				local taskType = NormalTaskDB[nextTaskID].taskType2
				if taskType == TaskType2.Main then
					self.nextTaskID = nextTaskID
				end
			elseif type(nextTaskID) == "table" then
				for _, nexttaskID in pairs(nextTaskID) do
					if TaskCondition.normalTask(self._entity, nexttaskID) then
						local taskType = NormalTaskDB[nexttaskID].taskType2
						if taskType == TaskType2.Main then
							self.nextTaskID = nexttaskID
							break
						end
					end
				end
			end
		end
	end
end

function TaskHandler:deleteTaskToDB(taskID)
	-- 如果是循环任则从数据库删除
	if LoopTaskDB[taskID] then
		LuaDBAccess.deleteLoopTask(self._entity:getDBID(), taskID)
		return true
		-- 环数完成时不要清理数据库
	elseif DailyTaskDB[taskID] then
		LuaDBAccess.deleteDailyTask(self._entity:getDBID(), taskID)
		return true
	else
		LuaDBAccess.deleteNormalTask(self._entity:getDBID(), taskID)
		return true
	end
end

function TaskHandler:updateHisTaskToDB()
	if type(self.hisTasks) ~= "table" then
		print("历史任务存储出错",self.hisTasks)
	end
	LuaDBAccess.updateHisTask(self._entity:getDBID(), self.hisTasks)
end

--检测玩家是否满足任务条件，如果是的话，则显示任务对话
function TaskHandler:checkTaskProvider(npcID)
	local taskList = g_taskProvideNpcs[npcID]
	if taskList then
		--先显示主线任务
		for _, taskID in pairs(taskList) do
			if TaskCondition.normalTask(self._entity, taskID) then
				return taskID, TaskType.normal
			end

		end
		--其他任务继续监测
		for _, taskID in pairs(taskList) do
			if TaskCondition.loopTask(self._entity, taskID, true) then
				return taskID, TaskType.loop
			end
		end

		for _,taskID in pairs(taskList) do
			if TaskCondition.dailyTask(self._entity, taskID, true) then
				return taskID, TaskType.daily
			end
		end

	end
end

function TaskHandler:checkTaskRecetiver(npcID)
	local taskList = g_taskRecetiveNpcs[npcID]
	if taskList then
		--先显示主线任务
		for _, taskID in pairs(taskList) do
			if NormalTaskDB[taskID] then
				if self.currentTask[taskID] and self.currentTask[taskID]:getStatus() == TaskStatus.Done then
					return taskID, TaskType.normal
				end
			end
		end

		--其他任务继续监测
		for _, taskID in pairs(taskList) do
			if LoopTaskDB[taskID] then
				if self.currentTask[taskID] and self.currentTask[taskID]:getStatus() == TaskStatus.Done then
					return taskID, TaskType.Loop
				end
			end
		end

		for _, taskID in pairs(taskList) do
			if DailyTaskDB[taskID] then
				if self.currentTask[taskID] and self.currentTask[taskID]:getStatus() == TaskStatus.Done then
					return taskID, TaskType.daily
				end
			end
		end

	end
end

-- 设置循环任务的环数
function TaskHandler:loadLoopTaskInfo(loopTaskRecord)
	for _, loopTask in pairs(loopTaskRecord or {}) do
		local receiveTaskTime = loopTask.receiveTaskTime
		-- 如果副本数据是上一个CD周期的，则要重置完成次数
		local loopTaskConfig = LoopTaskDB[loopTask.taskID]
		if loopTaskConfig then
			-- 如果是每日的循环任务
			if loopTaskConfig.period == TaskPeriod.day then
				-- 判断记录日期跟现在是不是同一天 判断这次登陆和上次离线的时间做比较
				if not time.isSameDay(receiveTaskTime) then
					-- 不是同一天，重新设置当前可做的次数，
					loopTask.countRing = 0
					loopTask.finishTimes = 0
				end
			else
				-- 判断记录日期跟现在是不是同一周
				if not time.isSameWeek(receiveTaskTime) then
					-- 不是同一周，算是新CD了，重置完成次数和副本进度
					loopTask.countRing = 0
					loopTask.finishTimes = 0
				end
			end
			if not self.loopTaskInfo[loopTask.taskID] then
				self.loopTaskInfo[loopTask.taskID] = {}
				self.loopTaskInfo[loopTask.taskID].countRing = loopTask.countRing
				self.loopTaskInfo[loopTask.taskID].finishTimes = loopTask.finishTimes
				self.loopTaskInfo[loopTask.taskID].currentRing = loopTask.currentRing
				self.loopTaskInfo[loopTask.taskID].receiveTaskTime = loopTask.receiveTaskTime
				self.loopTaskInfo[loopTask.taskID].isSaveDB = false
				-- 把循环任务的消息给客户端
				self:loadLoopTaskInfoToClient()
			else

			end
		else
			print("数据初始化出错，任务id是",loopTask.taskID)
		end
	end
end

function TaskHandler:loadLoopTaskInfoToClient()
	g_taskSystem:loadLoopTaskToClient(self._entity, self.loopTaskInfo)
end

-- 保存循环任务环数
function TaskHandler:updateLoopTaskRingToDB()
	local playerDBID = self._entity:getDBID()
	for taskID ,taskInfo in pairs(self.loopTaskInfo) do
		if taskInfo.isSaveDB then
			LuaDBAccess.updateLoopTaskRing(playerDBID, taskID, taskInfo)
		end
	end
end

function TaskHandler:resetCurrentRing(taskID)
	if LoopTaskDB[taskID] then
		self.loopTaskInfo[taskID].currentRing = 0
	end
end

function TaskHandler:setDailyTaskConfiguration( taskConfiguration )	
	self.dailyTaskConfiguration = taskConfiguration
end

function TaskHandler:getDailyTaskConfiguration( )
	return self.dailyTaskConfiguration
end

function TaskHandler:getDailyTaskConfigurationByID( taskID )
	return self.dailyTaskConfiguration[taskID]
end

function TaskHandler:addDailyTaskConfiguration( taskID )
	self.dailyTaskConfiguration[taskID] = true
end

-- 通天塔任务初始化
function TaskHandler:checkBabelTask(taskID)
	local taskData = self.babelTaskInfo[taskID]
	if not taskData then
		taskData = {}
		taskData.receiveTime = 0
		taskData.faildTimes = 0
		taskData.finishFlag = 0	
		self.babelTaskInfo[taskID] = taskData
	end
end

-- 完成通天塔任务接口, 通天塔任务相关记录, 把时间重置一下
function TaskHandler:finishBabelTask(taskID)
	if self.currentTask[taskID] then
		self.updateDB = true
		-- 清除taskPrivateHandler当中的绑定的npcID
		local taskPrivateHandler = self._entity:getHandler(HandlerDef_TaskPrData)
		taskPrivateHandler:removeTraceInfo(taskID)
		self.currentTask[taskID]:stateChange(TaskStatus.Finished)
		release(self.currentTask[taskID])
		self.currentTask[taskID] = nil
		-- 完成任务时，重新设置这个任务列表
		self.babelTaskInfo[taskID].receiveTime = os.time()
		return true
	else
		print("任务不存在",taskID)
		return false
	end
end

-- 失败次数
function TaskHandler:addBabelFaildTimes(taskID)
	self.babelTaskInfo[taskID].faildTimes = self.babelTaskInfo[taskID].faildTimes + 1
	self.babelTaskInfo[taskID].receiveTime = os.time()
	self.updateDB = true
end

function TaskHandler:getBabelFaildTimes(taskID)
	return self.babelTaskInfo[taskID].faildTimes
end

function TaskHandler:setBabelFinishFlag(taskID)
	self.babelTaskInfo[taskID].finishFlag = 1
end

function TaskHandler:getBabelFinishFlag(taskID)
	if self.babelTaskInfo[taskID] then
		return self.babelTaskInfo[taskID].finishFlag
	end
end

function TaskHandler:setReceiveBabelTaskTime(taskID)
	self:checkBabelTask(taskID)
	self.babelTaskInfo[taskID].receiveTime = os.time()
end

function TaskHandler:getReceiveBabelTaskTime(taskID)
	return self.babelTaskInfo[taskID].receiveTime
end

-- 保存通天塔任务
function TaskHandler:saveBabelTask()
	local playerID = self._entity:getID()
	for taskID, taskInfo in pairs(self.babelTaskInfo) do
		if taskID then
			LuaDBAccess.saveBabelTask(playerID, taskID, taskInfo)
		end
	end
end

function TaskHandler:loadBabelTask(taskData)
	-- 接任务的时间
	local receiveTime = taskData.receiveTime
	-- 如果副本数据是上一个CD周期的，则要重置完成次数
	local babelTaskConfig = BabelTaskDB[taskData.taskID]
	if babelTaskConfig then
		-- 如果是每日的循环任务
		if babelTaskConfig.period == TaskPeriod.day then
			-- 判断记录日期跟现在是不是同一天 判断这次登陆和上次离线的时间做比较
			if not time.isSameDay(receiveTime) then
				-- 不是同一天，重新设置当前可做的次数，
				taskData.faildTimes = 0
				taskData.finishFlag = 0
			else
				-- 如果是同一天， 判断不是完成标志
				if taskData.finishFlag ~= 1 then
					-- 此时要根据数据库的内容来创建任务，
					local babelTask = g_taskFty:createBabelTaskFromDB(self._entity, taskData)
					self:addTask(babelTask)
				end
			end
		end
		self:checkBabelTask(taskData.taskID)
		local babelTaskInfo = self.babelTaskInfo[taskData.taskID]
		babelTaskInfo.receiveTime = taskData.receiveTime
		babelTaskInfo.faildTimes = taskData.faildTimes
		babelTaskInfo.finishFlag = taskData.finishFlag
	else
		print("数据初始化出错，任务id是",taskData.taskID)
	end
end

-- 挑战完成
function TaskHandler:endFinishBabelTask(taskID)
	self:setBabelFinishFlag(taskID)
	local mapID = self._entity:getScene():getMapID()
	if mapID >= 1001 and mapID <= 1200 then
		g_sceneMgr:doSwitchScence(self._entity:getID(), 10, 123, 265)
	end
	self:finishBabelTask(taskID)
end