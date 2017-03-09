--[[TaskCondition.lua
	任务条件(任务系统)
]]

TaskCondition = {}

function TaskCondition.hasPreTask(player, taskID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local hisTask = taskHandler:isHisTask(taskID)
	if hisTask then
		return true
	end
	return false
end

function TaskCondition.normalTask(player, taskID, needDebug, GM)
	local taskData = NormalTaskDB[taskID]
	if not taskData then
		return false
	end
	if GM then
		return true
	end
	local levelLimit = taskData.level
	local consume = taskData.consume
	local school = taskData.school
	local level = player:getLevel()
	if level < levelLimit[1] or  level > levelLimit[2] then
		if needDebug then
			print("等级条件不满足")
		end
		return false
	end
	--以后写个门派判断
	if school and school~= player:getSchool() then
		if needDebug then
			print("门派不满足条件")
		end
		return false
	end
	--
	local preTaskData = taskData.preTaskData
	if preTaskData then
		if preTaskData.condition == "and" then
			for _, taskID in pairs(preTaskData[1]) do
				if taskID and not TaskCondition.hasPreTask(player, taskID) then
					if needDebug then
						print("前置任务没满足")
					end
					return false
				end
			end
		elseif preTaskData.condition == "or" then
			local preCondition = false
			for _, taskID in pairs(preTaskData[1]) do
				if taskID and TaskCondition.hasPreTask(player, taskID) then
					preCondition = true
					break
				end
			end
			if not preCondition then
				if needDebug then
					print("前置任务没满足")
				end
				return false
			end
		else
			if preTaskData[1] and not TaskCondition.hasPreTask(player, preTaskData[1]) then
				if needDebug then
					print("前置任务没满足")
				end
				return false
			end
		end
	end

	local taskHandler = player:getHandler(HandlerDef_Task)
	local hisTask = taskHandler:isHisTask(taskID)
	if hisTask then
		if needDebug then
			print("你已经做过这个任务了")
		end
		return false
	end
	
	if not TaskCondition.nomarlConsume(player, consume) then
		if needDebug then
			print("任务消耗的东西你们没有")
		end
		return false
	end

	return true
end

--接任务消耗
function TaskCondition.nomarlConsume(player, taskID)
	return true
end


--循环任务条件
------------------------------------------------
--是否有足够的环
function TaskCondition.hasEnoughLoop(player, taskID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local loop = taskHandler:getCurrentTaskLoopByID(taskID)
	if LoopTaskDB[taskID].loop < loop then
		return false
	end
	return true
end

function TaskCondition.schoolCheck(player, taskID)
	local taskData = LoopTaskDB[taskID]
	if not taskData then
		return false
	end
	local npcSchool = taskData.school
	-- 判断玩家和NPC的门派是否对应
	if not npcSchool then
		return true
	else
		if npcSchool~= player:getSchool() then
			return false
		end
	end
	return true
end

--循环任务条件没有门派限定，有等级，有
function TaskCondition.loopTask(player, taskID, needDebug, GM)
	local taskData = LoopTaskDB[taskID]
	if not taskData then
		return false
	end
	local levelLimit = taskData.level
	local level = player:getLevel()
	if level < levelLimit[1] or  level > levelLimit[2] then
		if needDebug then
			print("等级条件不满足")
		end
		return false
	end
	-- 还有当前的次数
	if not TaskCondition.factionCheck(player, taskID) then
		if needDebug then
			print("帮派条件不满足")
		end
		return false
	end

	if not TaskCondition.teamCheck(player, taskID) then
		if needDebug then
			print("组队条件不满足")
			return false
		end
	end

	if not TaskCondition.schoolCheck(player, taskID) then
		if needDebug then
			print("门派条件不满足")
		end
		return false
	end
	
	if not TaskCondition.isCountRing(player, taskID) then
		if needDebug then
			print("环数已经做完呢")
		end
		return false
	end

	return true
end

function TaskCondition.isCountRing(player, taskID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local taskData = LoopTaskDB[taskID]
	if taskHandler:getCountRing(taskID) < taskData.loop then
		return true
	end
	return false
end
-- 循环任务是否最大环
function TaskCondition.isMaxRing(player, taskID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local taskData = LoopTaskDB[taskID]
	--print("队长当前的环数》》》》", taskHandler:getCurrentRing(taskID), "配置环数", taskData.loop )
	if taskHandler:getCurrentRing(taskID) >= taskData.loop then
		return true
	end
	return false
end

--帮派检测
function TaskCondition.factionCheck(player, taskID)
	local taskData = LoopTaskDB[taskID]
	if taskData.taskType2 == TaskType2.Faction then

	else
		return true
	end
	return true
end

--组队检测
function TaskCondition.teamCheck(player, taskID)
	local taskData = LoopTaskDB[taskID]
	local isTeam = player:getHandler(HandlerDef_Team):isTeam()
	if taskData.team == true then
		if isTeam then
			return true
		else
			return false
		end
	elseif taskData.team == false then
		if isTeam then
			return false
		else
			return true
		end
	else
		return true
	end
end

--日常任务条件检测
function TaskCondition.dailyTask( player, taskID, GM )
	if DailyTaskDB[taskID] then
		local DailyTaskData = DailyTaskDB[taskID]
		local levelLimit = DailyTaskData.level
		local consume = DailyTaskData.consume
		local school = DailyTaskData.school
		local level = player:getLevel()
		local taskHandler = player:getHandler(HandlerDef_Task)
		if level < levelLimit[1] or level > levelLimit[2] then
			return false
		elseif taskHandler:getDailyTaskConfigurationByID(taskID) == nil then
				return true
		elseif not taskHandler:getDailyTaskConfigurationByID(taskID) then
			return false
		else
			return true
		end
	else
		return false
	end
end

-- 特殊任务，主要分三种，组队，单人， 组队和单人都可以
function TaskCondition.SpecialTask(playerList, taskID, teamID)
	local taskData = LoopTaskDB[taskID]
	local teamType = taskData.teamType
	local result 
	for _, entity in pairs(playerList) do
		local level = entity:getLevel()
		if level < taskData.level[1] or level > taskData.level[2] then
			return 42
		end
	end

	if teamType == TeamType.single then
		if teamID > 0 then
			return 5
		end
	elseif teamType == TeamType.team then
		if teamID <= 0 then
			return 4
		end
		if taskData.condition.teamerCount then
			if table.size(playerList) < taskData.condition.teamerCount then
				return 44
			end
		end
		-- 要判断队员之间的等级差
		if table.size(playerList) > 1 then
			result = TaskCondition.checkPlayerLevelDiff(playerList, taskID)
		end
	
	elseif teamType == TeamType.special then
		if table.size(playerList) > 1 then
			-- 要判断队员之间的等级差
			result = TaskCondition.checkPlayerLevelDiff(playerList, taskID)
		end
	end
	if result then
		if result > 0 then
			return result 
		end
	end
	return 0
end

-- 这个方法监测队员之间的等级差
function TaskCondition.checkPlayerLevelDiff(playerList, taskID)
	local taskData = LoopTaskDB[taskID]
	local maxLevel
	local minLevel
	for _, entity in pairs(playerList) do
		local level = entity:getLevel()
		if not maxLevel and not minLevel then
			maxLevel = level
			minLevel = level
		else
			if maxLevel < level then
				maxLevel = level
			end
			if minLevel > level then
				minLevel = level
			end
		end
	end
	if maxLevel - minLevel > taskData.condition.levelDiff then
		return 43
	end
	return 0
end