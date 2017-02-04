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
		return
	else
		return false,param.errorID and param.errorID or 2
	end
end

function RoleVerify:notHasFactionTask(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	if not taskHandler:getTask(param.taskID) then
		return
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

function RoleVerify:checkBeastBless(player, param)
	local minLvl		= param.minLvl		-- 等级限制
	local playerCount	= param.playerCount -- 队伍人数限制
	local lvlDiffer		= player.lvlDiffer	-- 等级差
	--local 
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

function RoleVerify.getInstance()
	return RoleVerify()
end
