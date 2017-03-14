--[[RoleVerify.lua
	角色检测条件
]]

RoleVerify = class(nil, Singleton)

function RoleVerify:__init()
	
end

function RoleVerify:checkLevel(player, param)
	local curLevel = player:getLevel()
	if curLevel < param.level then
		return false, param.errorID and param.errorID or 1
	end
	-- 上限设置
	if param.maxLevel then
		if curLevel > param.maxLevel then
			return false, param.errorID and param.errorID or 1
		end
	end
	return true
end

function RoleVerify:hasTask(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	if taskHandler:getTask(param.taskID) then
		if param.statue then
			return true
		else
			return false, param.errorID and param.errorID or 2
		end
	end
	if param.statue then
		return false, param.errorID and param.errorID or 2
	else
		return true
	end
end

function RoleVerify:hasTasks(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	for _, taskID in pairs(param.taskIDs) do
		if taskHandler:getTask(taskID) then
			if param.statue then
				return true
			else
				return false, param.errorID and param.errorID or 2
			end
		end
	end
	if param.statue then
		return false, param.errorID and param.errorID or 2
	else
		return true
	end
end

function RoleVerify:hasTask_1(player, param)
	local flag = true
	local taskHandler = player:getHandler(HandlerDef_Task)
	for _,taskID in pairs(param.taskIDs) do
		if taskID then
			if taskHandler:getTask(taskID) then
				flag = false
				return flag,1
			end
		end
	end
	return flag
end

function RoleVerify:checkSchool(player, param)
	if player:getSchool() == param.school then
		return true
	end
	return false, param.errorID and param.errorID or 3
end

function RoleVerify:hasTeam(player, param)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		if param.statue then
			return true
		else
			return false, param.errorID and param.errorID or 4
		end
	else
		if param.statue then
			return false, param.errorID and param.errorID or 5
		else
			return true
		end
	end
end

function RoleVerify:hasCurrency(player, param)
	if param.type == "money" then
		if player:getMoney() < param.value then
			return false, param.errorID and param.errorID or 6
		end
	end
	return true
end

function RoleVerify:hasAttr(player, param)
	if player:getAttrValue(param.type) < param.value then
		return false, param.errorID and param.errorID or 18
	end
	return true
end

function RoleVerify:checkFaction( player,param )

	if player:getFactionDBID() > 0 then
		if param.factionDBID > 0 then
			return true
		else
			return false, param.errorID and param.errorID or 20
		end
	else
		if param.factionDBID == 0 then
			return true
		else
			return false, param.errorID and param.errorID or 22
		end
	end
	
end

-- 循环任务交谈对话NPC
function RoleVerify:loopTaskTalk(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local taskID = param.taskID
	local taskType = param.taskType
	local configNpcID = param.npcID
	local statue = param.statue -- 是否需要判断存在任务才可以判断
	local task = taskHandler:getTask(taskID)
	if not task and not statue then
		--print("没有此任务，不能接")
		return false,param.errorID and param.errorID or 6
	end	
	if configNpcID then
		local privateHandler = player:getHandler(HandlerDef_TaskPrData)
		local taskNpcID = privateHandler:getTraceInfo(taskID)
		if taskNpcID then
			if taskNpcID ~= configNpcID then
				--print("任务交接NPC不是这个")
				return false,param.errorID and param.errorID or 6
			end
		else
			return false, 6
		end
	end
	if taskType then
		if task:getTargetType() ~= taskType then
			--print("任务类型不匹配")
			return false,param.errorID and param.errorID or 6
		end
	end
	return true 
end

function RoleVerify:checkLoopTask(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local taskID = param.taskID
	local loopTaskDB = LoopTaskDB[taskID]
	if taskHandler:getCountRing(taskID) >= loopTaskDB.loop then
		return false, param.errorID and param.errorID or 31
	end
	return true
end

function RoleVerify:checkLoopTasks(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	for _,value in pairs(param.taskIDs) do
		local loopTaskDB = LoopTaskDB[value]
		if taskHandler:getCountRing(value) >= loopTaskDB.loop  + 1 then
			return false, param.errorID and param.errorID or 31
		else
			return true
		end
	end
end
function RoleVerify:hasFactionTask(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	if taskHandler:getTask(param.taskID) then
		return true
	else
		return false,param.errorID and param.errorID or 2
	end
end

function RoleVerify:notHasFactionTask(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	if not taskHandler:getTask(param.taskID) then
		return true
	else
		return false,param.errorID and param.errorID or 2
	end
end

function RoleVerify:checkTaskTeam(player, param)
	local teamHandler = player:getHandler(HandlerDef_Team)
	-- 是否组队
	if teamHandler and teamHandler:isTeam() then 
		-- 队伍中人数的判断
		if  param.playerNum then
			if teamHandler:getCurMemberNum() < param.playerNum then
				--print("队伍中人数的判断")
				return false, param.errorID and param.errorID or 18
			end
		end
		-- 判断暂离的状态
		if teamHandler:isStepOutState() then
			return false, param.errorID and param.errorID or 18
		end
		local maxLvl,minLvl = teamHandler:getCurMaxAndMinLvl()
		-- 队员之间的等级差
		if param.playerLvlRange then
			--print("maxLvl - minLvl",(maxLvl - minLvl))
			if param.playerLvlRange < (maxLvl - minLvl) then
				return false ,param.errorID and param.errorID or 18
			end
		end
		-- 接任务的等级区间
		if param.taskLvlRange then
			--print("接任务的等级区间")
			if param.taskLvlRange.minLvl > minLvl and param.taskLvlRange.maxLvl < maxLvl then
				return false,param.errorID and param.errorID or 18
			end
		end
		-- 判断活力值
		if param.tiredness then
			local playerList = teamHandler:getTeamPlayerList()
			for _,player in pairs(playerList) do
				if param.tiredness > player:getTiredness() then
					return false,param.errorID and param.errorID or 18
				end
			end
		end
		return true
	end
	return false, param.errorID and param.errorID or 4
end

function RoleVerify:checkBeastBless(player, param, npcID)
	print("checkBeastBless$$$$$$")
	local minLvl		= BeastBlessMinLvl			-- 等级限制
	local playerNum		= BeastBlessPlayerNum		-- 队伍人数限制
	local fightCount	= BeastBlessFightCount		-- 战斗次数
	local playerLvlRange= BeastBlessPlayerLvlRange	-- 等级差
	-- 判断NPC是否处于战斗状态
	local teamHandler = player:getHandler(HandlerDef_Team)
	local npc = g_entityMgr:getNpc(npcID)
	if npc then
		if npc:isFighting() then
			return false, param.errorID and param.errorID or 37
		end
	end
	local activityHandler = player:getHandler(HandlerDef_Activity)
	local activityId = g_beastBless:getID()
	local teamFightCount = activityHandler:getPriData(activityId)
	print("teamFightCount:",teamFightCount)
	if teamHandler and teamHandler:isTeam() then 
		-- 队伍中人数的判断
		if playerNum then
			if teamHandler:getCurMemberNum() < playerNum then
				--print("队伍中人数的判断")
				return false, param.errorID and param.errorID or 33
			end
		end
		local teamMaxLvl,teamMinLvl = teamHandler:getCurMaxAndMinLvl()
		if minLvl then
			if teamMinLvl < minLvl then
				return false ,param.errorID and param.errorID or 34
			end
		end
		-- 队员之间的等级差
		if playerLvlRange then
			if playerLvlRange < (teamMaxLvl - teamMinLvl) then
				return false ,param.errorID and param.errorID or 35
			end
		end 
		if fightCount then
			local playerList = teamHandler:getTeamPlayerList()
			local activityHandler = player:getHandler(HandlerDef_Activity)
			local activityId = g_beastBless:getID()
			for _,player in pairs(playerList) do
				local activityHandler = player:getHandler(HandlerDef_Activity)
				if activityHandler then
					local teamFightCount = activityHandler:getPriData(activityId)
					print("teamFightCount>>>",teamFightCount,fightCount)
					if teamFightCount > fightCount then
						return false ,param.errorID and param.errorID or 36
					end
				end
			end
		end
		-- 排除所有的条件
		return true
	end
	return false, param.errorID and param.errorID or 4
end
function RoleVerify:checkTime(player, param)
	local hour = param.hour
	local min = param.min
	local tInfo = os.date("*t")
	if (tInfo.hour> hour) or (tInfo.hour == hour and tInfo.min > min) then
		return true
	else
		return false
	end
end


-- 通天塔任务NPC三个条件， 匹配NPC, 任务状态为Active
function RoleVerify:matchTaskNpc(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local taskID = param.taskID
	local taskState = param.taskState
	local npcID = param.npcID
	local task = taskHandler:getTask(taskID)
	if task then
		if task:getStatus() == taskState then
			local privateHandler = player:getHandler(HandlerDef_TaskPrData)
			local taskNpcID = privateHandler:getTraceInfo(taskID)
			if taskNpcID then
				if taskNpcID == npcID then
					--print("任务交接NPC不是这个")
					return true
				end
			end
		end
	end
end

-- 状态为Activie ，不是匹配NPC
function RoleVerify:noMatchTaskNpc(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local taskID = param.taskID
	local taskState = param.taskState
	local npcID = param.npcID
	local task = taskHandler:getTask(taskID)
	if task then
		if task:getStatus() == taskState then
			local privateHandler = player:getHandler(HandlerDef_TaskPrData)
			local taskNpcID = privateHandler:getTraceInfo(taskID)
			if taskNpcID then
				if taskNpcID ~= npcID then
					--print("任务交接NPC不是这个")
					return true
				end
			end
		end
	end
end

-- 任务状态为Done
function RoleVerify:matchTaskState(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local taskID = param.taskID
	local taskState = param.taskState
	local npcID = param.npcID
	local task = taskHandler:getTask(taskID)
	if task then
		if task:getStatus() == taskState then
			return true
		end
	end
end


function RoleVerify:checkActivityOpening(player, param)
	local teamHandler = player:getHandler(HandlerDef_Team)
	if not (teamHandler and teamHandler:isLeader()) then
		return false,4
	end
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	local activityTarget = team:getDekaronActivityTarget()
	if activityTarget then
		return false,34
	end
	local activityID = param.activityID
	local activity = g_activityMgr:getActivity(activityID)
	if activity and activity:isOpening() then
		return true
	else
		return false,34
	end
end

--检查是否领取了门派闯关活动
function RoleVerify:haveActivityTarget(player)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if teamHandler and team then
		local activityTarget = team:getDekaronActivityTarget()
		if activityTarget then
			return true
		else
			return false,34
		end
	end
	return false,34
end

--检查现在的活动目标是否跟此NPC的活动目标一样。
function RoleVerify:checkActivityTarget(player, param)
	local teamHandler = player:getHandler(HandlerDef_Team)
	if not (teamHandler and teamHandler:isLeader()) then
		print("不是队长")
		return false,33
	end

	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	local activityTarget = team:getDekaronActivityTarget()
	print(param.activityTargetID,activityTarget:getActivityTargetId())
	if activityTarget and activityTarget:getActivityTargetId() == param.activityTargetID then
		return true
	else
		return false,34
	end
end

function RoleVerify:checkKillMonster( player,param )
	
	local taskID = param.taskID
	local statue = param.statue
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(taskID)

	if task:canEnd() then
		if statue then
			return true
		else
			return false,1
		end
	else
		if not statue then
			return true
		else
			return false,1
		end
	end

end

function RoleVerify:checkDailyTaskTimes(  player,param  )	
	local taskID = param.taskID
	local taskHandler = player:getHandler(HandlerDef_Task)
	local exist = false
	for taskID,config in pairs(taskHandler:getDailyTaskConfiguration()) do  
		if taskID == param.taskID then
			if not taskHandler:getDailyTaskConfigurationByID(param.taskID) then
				return true
			else
				return false,1
			end
		end
	end
	if not exist then
		taskHandler:addDailyTaskConfiguration(taskID)
		return false,1
	end

end

function RoleVerify.getInstance()
	return RoleVerify()
end
