--[[Task.lua
描述：
	任务基类
--]]

Task = class()

function Task:__init()
	self._targets = {}
	self._taskID	= nil
	self._roleID	= nil
	self._status	= nil
	self._type		= nil
	self._subType	= nil
	self._startTime = nil
	self._endTime = nil
	self._rewards	= nil
	self._triggers	= {}
	self._multipleReward = nil
	self.updateDB = false
end

function Task:__release()	
	self:releaseTarget()
	self._targets = nil
	self._triggers = nil
	self._taskID = nil
	self._roleID = nil
	self._rewards = nil
	self._status = nil
	self._type = nil
	self._subType = nil
	self._startTime = nil
	self._endTime = nil
	self._multipleReward = nil
	self.updateDB = false
end

function Task:setUpdateDB()
	self.updateDB = true
end

function Task:getUpdateDB()
	return self.updateDB
end

function Task:releaseTarget()
	for _, target in pairs(self._targets) do
		release(target)
	end
end

--任务目标
function Task:addTarget(idx, target)
	if self._targets[idx] then	
		print("配置任务目标索引出错")
	else
		self._targets[idx] = target
	end
end

function Task:getTargets()
	return self._targets
end

--任务类型
function Task:setType(taskType)
	self._type = taskType
end

--任务子类型
function Task:setSubType(subType)
	self._subType = subType
end

function Task:getSubType()
	return self._subType
end

function Task:getType()
	return self._type
end

function Task:getTriggers()
	return self._triggers
end

--任务ID
function Task:setID(taskID)
	self._taskID = taskID
end

function Task:getID()
	return self._taskID
end

--任务环
function Task:setStartTime(startTime)
	self._startTime = startTime
end

function Task:getStartTime()
	return self._startTime
end

function Task:setEndTime(time, direct)
	if direct then
		self._endTime = time
	else
		if time then
			self._endTime = time + self._startTime
		end
	end
end

function Task:getEndTime()
	return self._endTime
end

--状态跳转
function Task:stateChange(taskStatus, fromDB)
	local oldStatus = self:getStatus()
	--不允许同一状态改变两次
	if oldStatus == taskStatus then
		return 
	end	
	local player = g_entityMgr:getPlayerByID(self._roleID)
	self._status = taskStatus
	local taskData = self:createDataForClient(taskStatus)
	if taskStatus == TaskStatus.Active then
		--通知客户端	
		g_taskSystem:onRecetiveTask(player, taskData, fromDB)
	elseif taskStatus == TaskStatus.Failed then			--任务失败
		self:removeTarget()	
		g_taskSystem:onTaskFaild(player, taskData)
	elseif taskStatus == TaskStatus.Done then			--任务完成
		self:removeTarget()	
		self:addBabelReward()
		g_taskSystem:onDoneTask(player, taskData)
	elseif taskStatus == TaskStatus.Finished then
		--给奖励	
		self:removeTarget()	
		self:removeAllWatchers()
		self:addReward()
		g_taskSystem:onFinishTask(player, self._taskID)
	elseif taskStatus == TaskStatus.Deleted then			--任务删除
		self:removeTarget()	
		self:removeAllWatchers()
		g_taskSystem:onDeleteTask(player, self._taskID)
	end
	self:updateNpcHeader()
	self:fireTriggers(taskStatus, fromDB)
end

function Task:getStatus()
	return self._status
end

function Task:updateNpcHeader()
	local player = g_entityMgr:getPlayerByID(self._roleID)
	if self._type == TaskType.normal then
		local startNpcID = NormalTaskDB[self._taskID].startNpcID
		local startNpc = g_entityMgr:getNpc(startNpcID)
		if startNpc then
			g_taskDoer:updateNpcHeader(player, startNpc)
		end
		local endNpcID = NormalTaskDB[self._taskID].endNpcID
		local endNpc = g_entityMgr:getNpc(endNpcID)
		if endNpc then
			g_taskDoer:updateNpcHeader(player, endNpc)
		end
	elseif self._type == TaskType.daily then
		local startNpcID = DailyTaskDB[self._taskID].startNpcID
		local startNpc = g_entityMgr:getNpc(startNpcID)
		if startNpc then
			g_taskDoer:updateNpcHeader(player,startNpc)
		end
		local endNpcID = DailyTaskDB[self._taskID].endNpcID
		local endNpc = g_entityMgr:getNpc(endNpcID)
		if endNpc then
			g_taskDoer:updateNpcHeader(player, endNpc)
		end
	elseif self._type == TaskType.loop then
		local startNpcID = LoopTaskDB[self._taskID].startNpcID
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

-- 移除任务目标监听
function Task:removeTarget()
	for idx, target in pairs(self._targets) do
		if target then
			 target:removeWatchers() 
		end
	end
end

function Task:removeAllWatchers()
	for idx, target in pairs(self._targets) do
		if target then
			 target:removeAllWatchers() 
		end
	end
end

--任务持有人
function Task:setRoleID(roleID)
	self._roleID = roleID
end

function Task:getRoleID()
	return self._roleID
end

function Task:fireTriggers(taskState, fromDB)
	if self._triggers[taskState] then
		for _, trigger in ipairs(self._triggers[taskState]) do
			FireTrigger(trigger.type or trigger[1], self._roleID, self, trigger.param, fromDB)
		end
	end
end

function Task:refresh()
	-- 此时可能会出现任务回退
	if self:canEnd() then
		self:stateChange(TaskStatus.Done)
	elseif self:isFaild() then
		self:stateChange(TaskStatus.Failed)
	else
		-- 如果循环任务出现回退,
		if self._status == TaskStatus.Done then
			self:resetState()
		end
		self:stateChange(TaskStatus.Active)	
	end
end

-- 重新设置状态
function Task:resetState()
	for idx, target in pairs(self._targets) do
		if target then
			 target:resetState() 
		end
	end
end

-- 动态添加脚本战斗ID
function Task:addScriptID(scriptID)
	for idx, target in pairs(self._targets) do
		if target then
			 target:addScriptID(scriptID) 
		end
	end
end

function Task:createDataForClient(taskStatus)
	local taskData = {}
	local player = g_entityMgr:getPlayerByID(self._roleID)

	taskData.taskID = self._taskID
	taskData.taskStatus = taskStatus

	if taskStatus == TaskStatus.Deleted or taskStatus == TaskStatus.Finished then
		return taskData
	end
	if self._type == TaskType.normal then 

		if table.size(self._targets) > 0 then
			taskData.targets = self:getTargetState()
		end

	elseif self._type == TaskType.loop then

		-- 接循环任务时，把当前任务的环数 ,没有的话顺便把值给设置进去 
		local taskHandler = player:getHandler(HandlerDef_Task)
		-- 对于天道任务只能取队长的
		taskData.ring = taskHandler:getCurrentRing(self._taskID)
		taskData.countRing = taskHandler:getCountRing(self._taskID)
		taskData.finishTimes =  taskHandler:getFinishTimes(self._taskID)
		taskData.targetType = self:getTargetType()
		--taskData.targetIdx	= self:getTargetIdx()
		--taskData.gradeIdx = self:getGradeIdx()
		-- 任务状态
		taskData.targets = self:getTargetState()
	elseif self._type == TaskType.babel then

	elseif self._type == TaskType.daily then
		taskData.targetType = self:getTargetType()
		taskData.targetParam = self:getTargetParam()
		taskData.targets = self:getTargetState()	
	end

	return taskData
end

-- 获取任务目标的状态
function Task:getTargetState()
	local targetState = {}
	for idx, target in pairs(self._targets) do
		targetState[idx] = target:getState()
	end
	return targetState
end

function Task:addReward()

end

function Task:addMultiple(multiple)
	self._multipleReward = multiple
end

function Task:canEnd()

	local bEnd = true
	for idx, target in pairs(self._targets) do
		if target then
			if target:getBor() then	--只要有一个成功就算成功
				if target:completed() then
					return true
				else
					bEnd = false
				end
			else
				if not target:completed() then
					bEnd = false
				else
				end
			end
		end
	end
	if bEnd then
		return true
	end
	
end

function Task:isFaild()
	for idx, target in pairs(self._targets) do
		if target then
			if target:isFaild() then	--比如运镖 护送
				return true
			end
		end
	end
	return false
end

function Task:addBabelReward()

end