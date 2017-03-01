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

--特殊任务天道任务专用条件, 传进来的肯定是队长
function TaskCondition.SpecialTeamTask(team, taskID)
	local taskData = LoopTaskDB[taskID]
	local condition = taskData.condition
	local leader = g_entityMgr:getPlayerByID(team:getLeaderID())
	local teamHandler = leader:getHandler(HandlerDef_Team)
	if not condition then
		print("你配了天道任务条件了吗？",taskID)
		return false
	end

	if table.size(teamHandler:getTeamPlayerList()) < condition.teamerCount then
		print("队伍人数不足")
		return false
	end
	local maxLevel
	local minLevel
	for _, entity in pairs(teamHandler:getTeamPlayerList()) do
		local levelLimit = taskData.level
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
		
		if level < levelLimit[1] or  level > levelLimit[2] then
			print("有队员等级条件不满足")
			return false
		end
		
		--if < condition.vitalityConsume then

		--end

	end

	if maxLevel > minLevel + taskData.condition.levelDiff then
		print("队伍中等级差距太大")
		return false
	end
	-- 判断队长有无次任务
	local leaderTaskHandler = leader:getHandler(HandlerDef_Task)
	if leaderTaskHandler:getTask(taskID) then
		print("队长有此任务，不能再次接取")
		return false
	end
	
	return true
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


