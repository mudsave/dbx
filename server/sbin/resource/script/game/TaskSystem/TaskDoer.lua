--[[TaskDoer.lua
描述：
	任务执行(任务系统)
--]]

TaskDoer = class(nil, Singleton)

function TaskDoer:__init()

end

function TaskDoer:__release()

end

--特殊类型组队任务--天道任务, 接任务之前要保证所有队员格子任务完成
function TaskDoer:doRecetiveTeamTask(player, taskID)
	if not LoopTaskDB[taskID] then
		print("配置错误taskID在循环任务里没有配",taskID)
		return
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if not team then
		print("没有组队接不了任务")
		return 
	end
	if not teamHandler:isLeader() then
		print("暂离队员不是对账》》》")
		return
	end

	if not TaskCondition.SpecialTeamTask(team, taskID) then
		print("您的队伍中有人不满足条件")
		return
	end
	-- 先以队长来创建任务
	local leaderTaskHandler = player:getHandler(HandlerDef_Task)
	leaderTaskHandler:updateLoopCount(taskID)
	local loopTask = g_taskFty:createLoopTask(player, taskID)
	leaderTaskHandler:addTask(loopTask)
	for _, entity in pairs(teamHandler:getTeamPlayerList()) do
		local roleID = entity:getID()
		local taskHandler = entity:getHandler(HandlerDef_Task)
		if roleID ~= player:getID() then
			-- 队员接任务是如果有任务在的话，要把当前任务给删除
			local task = taskHandler:getTask(taskID)
			if task then
				-- 如果有任务，先删除当前任务
				self:doDeleteTask(entity, taskID)
			end
			loopTask1 = g_taskFty:createLoopByTask(loopTask, roleID)
			taskHandler:addTask(loopTask1)
			loopTask1:updateNpcHeader()
		end
		--g_taskSystem:updateLoopTaskList(entity, taskHandler:getRecetiveTaskList())
		taskHandler:updateTaskList(taskID, false)
	end
end

-- 接任务
function TaskDoer:doRecetiveTask(player, taskID, GM)
	print("接受一个任务，任务的ID：",taskID)	
	local msgID = nil
	local taskHandler = player:getHandler(HandlerDef_Task)
	--先判断有没有接过该任务
	if NormalTaskDB[taskID] then
		if taskHandler:getTask(taskID) then
			return false, 2
		end
	elseif LoopTaskDB[taskID] then	
		local loopTaskDB = LoopTaskDB[taskID]
		if taskHandler:getCountRing(taskID) >= loopTaskDB.loop then
			if loopTaskDB.taskType2 == TaskType2.Master then
				return false, 31
			elseif loopTaskDB.taskType2 == TaskType2.Trial then
				return false, 31
			end
			return false, 31
		else
			-- 没有完成，当前不能再接
			if taskHandler:getTask(taskID) then
				print("你已经有这个任务了")
				return false, 30
			end
		end
	elseif DailyTaskDB[taskID] then
		if taskHandler:getTask(taskID) then
			return false, 2
		end
	end

	-- 再判断任务条件是否满足
	if NormalTaskDB[taskID] then
		if not TaskCondition.normalTask(player, taskID, true, GM) then
			print("任务条件不满足")
			return false, 2
		end	
		local normalTask = g_taskFty:createNormalTask(player, taskID)
		taskHandler:addTask(normalTask)
		normalTask:updateNpcHeader()
		-- g_taskSystem:updateNormalTaskList(player, taskHandler:getNextID())
		return true
	elseif LoopTaskDB[taskID] then	
		if not TaskCondition.loopTask(player, taskID, true, GM) then
			print("任务条件不满足")
			return false, 2
		end	
		-- 如果条件满足时当前环数和总的环数+1
		local level = player:getLevel()
		taskHandler:updateLoopCount(taskID)
		local loopTask = g_taskFty:createLoopTask(player, taskID)
		-- 设置玩家接任务时的等级
		loopTask:setReceiveTaskLvl(level)
		taskHandler:addTask(loopTask)
		loopTask:updateNpcHeader()
		-- 重新跟新一下循环任务列表
		-- g_taskSystem:updateLoopTaskList(player, taskHandler:getRecetiveTaskList())
		taskHandler:updateTaskList(taskID, false)
		return true
	elseif DailyTaskDB[taskID] then
		if not TaskCondition.DailyTask(player, taskID, true, GM) then
			print("任务条件不满足")
			return false, 2
		end	
		local dailyTask = g_taskFty:createDailyTask(player, taskID)
		taskHandler:addTask(dailyTask)
		dailyTask:updateNpcHeader()
		g_taskSystem:updateDailyTaskList(player, taskHandler:getNextID())
		return true
	else
		print("接受任务出错，任务找不到ID为",taskID)
		return false, 21
	end
end

-- 任务目标的切换移除当前循环任务，接其他任务的任务目标, 
-- 分为客户端的删除，和服务器的主动删除
function TaskDoer:doDeleteTask(player, taskID, flag)
	local taskHandler = player:getHandler(HandlerDef_Task)
	-- 在这之前还要移除私有NPC 和热区以及其他的任务物品
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	local npcs = {}
	-- 需要改动
	local allPrivateNpc = privateHandler:getNormalNpcData()
	local curTaskPrivateNpc = allPrivateNpc[taskID]
	if curTaskPrivateNpc and #(curTaskPrivateNpc) > 0 then
		for index, npcData in pairs(curTaskPrivateNpc) do
			table.insert(npcs, npcData.npcID)
			privateHandler:removeNormalNpcData(taskID, index)
		end
		g_taskSystem:onRemovePrivateNpc(player, npcs)
	end
	privateHandler:removeTraceInfo(taskID)
	-- 热区也要移除
	local mapID = privateHandler:getSpecialArea(taskID)
	if mapID then
		privateHandler:removeSpecialArea(taskID)
		g_taskSystem:removeSpecialArea(player, taskID, mapID)
	end

	-- 移除神秘商人道具记录
	local itemID = privateHandler:getTaskItem(taskID)
	if itemID then
		privateHandler:removeTaskItem(taskID)
	end
	-- 私有NPC移除
	local npcs = {}
	local defaultIndex = 1
	local loopNpcID = privateHandler:getLoopNpcData(taskID, defaultIndex)
	if loopNpcID then
		table.insert(npcs, loopNpcID)
		privateHandler:removeLoopNpcData(taskID, defaultIndex)
		g_taskSystem:onRemovePrivateNpc(player, npcs)
	end
	-- 移除任务雷
	privateHandler:removeTaskMine(taskID)
	-- 如果有尾随Npc也要移除
	local followNpcID = privateHandler:getTaskFollowNpc(taskID)
	local npcsData = {}
	local scene = player:getScene()
	local sceneType = scene:getSceneType()
	local followHandler = player:getHandler(HandlerDef_Follow)
	local follow = followHandler:getMember(followNpcID)
	if follow then
		followHandler:removeMember(followNpcID)
		table.insert(npcsData,{follow:getID(), followNpcID})
		scene:detachEntity(follow)
		release(follow)
	end
	g_taskSystem:removeFollowEntity(player, npcsData)
	-- 删除任务时候让客户端移除宠物记录
	g_taskSystem:removeTaskPet(player, taskID)
	-- 设置状态
	taskHandler:getTask(taskID):stateChange(TaskStatus.Deleted)
	-- 如果是客户端操作删除任务
	if flag then
		-- 改变当前环数, 重置为0
		if itemID then
			local packetHandler = player:getHandler(HandlerDef_Packet)
			packetHandler:removeByItemId(itemID, 1)
		end
		taskHandler:resetCurrentRing(taskID)
	end
	taskHandler:removeTaskByID(taskID)		
end

--加载任务相关
function TaskDoer:loadNormalTask(player, recordList)
	print("加载任务相关加载任务相关")
	if recordList then
		local taskHandler = player:getHandler(HandlerDef_Task)
		for _, taskData in pairs(recordList) do
			if type(taskData.targetState) then
				 local c,cc = pcall(loadstring("return "..taskData.targetState))
				 taskData.targetState = cc
			end
			
			local normalTask = g_taskFty:createNormalTaskFromDB(player, taskData)
			taskHandler:addTask(normalTask)
			g_taskSystem:updateNormalTaskList(player, taskHandler:getNextID())
		end
		if table.size(recordList) == 0 and table.size(taskHandler:getHisTasks()) == 0 then
			--开场对话
			if INIT_TASKID > 0 and INIT_DIALOGID > 0 then
				self:doRecetiveTask(player, INIT_TASKID)
				g_dialogDoer:createDialogByID(player, INIT_DIALOGID)
			end
			
		end
		g_taskSystem:onLoadPlayerTasksData(player, recordList)
	end
end

function TaskDoer:loadLoopTask(player, recordList)
	local taskHandler = player:getHandler(HandlerDef_Task)
	for _, taskData in pairs(recordList) do
		
		if type(taskData.targetState) then
			 local c,cc = pcall(loadstring("return "..taskData.targetState))
			 taskData.targetState = cc
		end
		local loopTask = g_taskFty:createLoopTaskFromDB(player, taskData)
		if not loopTask then
			return
		end
		taskHandler:addTask(loopTask)
	end
	-- 加载完循环任务之后，再加载可接任务
end

function TaskDoer:loadLoopTaskRing(player, recordList)
	local taskHandler = player:getHandler(HandlerDef_Task)
	taskHandler:loadLoopTaskInfo(recordList)
end

function TaskDoer:loadHistoryTask(player, recordList)
	if recordList then
		for _, taskData in pairs(recordList) do
			if taskData.historyTasks then
				 local c,cc = pcall(loadstring("return "..taskData.historyTasks))
				 taskData.historyTasks = cc
			end
			player:getHandler(HandlerDef_Task):loadHistoryTask(taskData.historyTasks)
		end
	end
end

function TaskDoer:loadTaskTrace(player, recordList)
	for _, taskData in pairs(recordList) do
		local c,taskTrace = pcall(loadstring("return "..taskData.taskTraceList))
		g_taskSystem:loadTaskTrace(player, taskTrace)
	end
end

function TaskDoer:loadTaskPrivateData(player, recordList)
	for _, taskData in pairs(recordList) do
		local c,taskPrivateData = pcall(loadstring("return "..taskData.taskPrivateData))
		local taskPriHandler = player:getHandler(HandlerDef_TaskPrData)
		taskPriHandler:loadTransferData(taskPrivateData.transferData)
		taskPriHandler:loadNpcData(taskPrivateData.npcData)
		taskPriHandler:loadCage(taskPrivateData.cageData)
		taskPriHandler:loadFollowNpc(taskPrivateData.followData)
	end
end

function TaskDoer:updateRoleTask(player)
	local taskHandler = player:getHandler(HandlerDef_Task)
	for taskID, task in pairs(taskHandler:getTasks()) do
		if task:getType() == TaskType.normal then
			LuaDBAccess.updateNormalTask(player:getDBID(), task)
		else
			-- 循环任务数据的跟新
			LuaDBAccess.updateLoopTask(player:getDBID(), task)
		end
	end
	taskHandler:updateLoopTaskRingToDB()
	self:updateRolePrivateTask(player)
end

function TaskDoer:updateRolePrivateTask(player)
	local taskPriHandler = player:getHandler(HandlerDef_TaskPrData)
	local privateTaskData = {}
	privateTaskData.followData = player:getHandler(HandlerDef_Follow):getMembersID()
	privateTaskData.transferData = taskPriHandler:getTransferData()
	privateTaskData.npcData = taskPriHandler:getNormalNpcData()
	privateTaskData.cageData = taskPriHandler:getCage()
	LuaDBAccess.updateRoleTaskPrivate(player:getDBID(), privateTaskData)
end

--等级任务主要是指引任务
function TaskDoer:updatePlayerLevelTasks(player)
	for taskID,taskData in pairs(NormalTaskDB) do
		if taskData.taskType2 == TaskType2.NewBie then
			if taskData.level[1] <= player:getLevel() then	-- 指引任务不能重复接
				if not player:getHandler(HandlerDef_Task):isHisTask(taskID) then
					print("--接受指引任务----")
					self:doRecetiveTask(player, taskID)	-- 升级自动接指引任务
				end
			end
		end
	end
end

--更新头顶显示
function TaskDoer:updateNpcHeader(player, npc)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local npcStatue = nil
	for _, taskID in ipairs(g_taskProvideNpcs[npc:getID()] or {}) do
		local task = taskHandler:getTask(taskID)
		if not task then
			if TaskCondition.normalTask(player, taskID) then	
				if NormalTaskDB[taskID].taskType2 == TaskType2.Main then
					npcStatue = DialogIcon.Task1
				else
					npcStatue = DialogIcon.Task2
				end
				break		
			end	
			-- 如果玩家和NPC 不属于同一个门派那么就为nil
			if TaskCondition.loopTask(player, taskID) then
				npcStatue = DialogIcon.Task2
				break		
			end
		end	
	end

	for _, taskID in pairs(g_taskRecetiveNpcs[npc:getID()] or {}) do
		local task = taskHandler:getTask(taskID)
		if task then
			if task:getStatus() == TaskStatus.Done then
				npcStatue = DialogIcon.Task4
				break
			elseif task:getStatus() == TaskStatus.Active then
				npcStatue = DialogIcon.Task3
				break
			end
		end
	end
	g_taskSystem:onUpdateNpcStatue(player, npc:getID(), npcStatue)
end

--天数刷新
function TaskDoer:update(period)
	if period == "day" then
		for playerID, player in pairs(g_entityMgr:getPlayers()) do
			print("进入跨天调用没有啊")
			player:getHandler(HandlerDef_Task):updateDayTask()
		end
	elseif period == "week" then
		for playerID, player in pairs(g_entityMgr:getPlayers()) do
			player:getHandler(HandlerDef_Task):updateWeekTask()
		end
	end
end

function TaskDoer:minUpdate(currentTime)
	-- 每分钟跟新一次， 遍历所有玩家主线任务
	for playerID, player in pairs(g_entityMgr:getPlayers()) do
		player:getHandler(HandlerDef_Task):updateMinTask(currentTime)
	end
end

-- 玩家等级变化的时候 
function TaskDoer:updateCurMapNpcHeader(player, curMapID)
	-- 跟新当前地图NPC
	local npcs = mapDB[curMapID].npcs
	if npcs then
		for _, npcID in pairs(npcs) do
			local npc = g_entityMgr:getNpc(npcID)
			if npc then
				self:updateNpcHeader(player, npc)
			end
		end
	end
end

-- 设置可接任务列表
function TaskDoer:loadCanRecetiveTask(player)
	local taskHandler = player:getHandler(HandlerDef_Task)
	if taskHandler then
		taskHandler:loadCanRecetiveLoopTask()
		-- 通知客户端
		g_taskSystem:loadLoopTaskList(player, taskHandler:getRecetiveLoopTask())
	end
end

-- 玩家设置等级的时候通知任务系统，fromDB读数据库
function TaskDoer:notifyTaskSystem(playerID, level, fromDB)
	-- 不是读数据库，从配置表当中去找，有没有匹配的等级，有的话就加载可接任务列表
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	
	for _, levelConfig in pairs(CanRecetiveLoopTaskLvl) do 
		if level == levelConfig then
			local taskHandler = player:getHandler(HandlerDef_Task)
			taskHandler:loadCanRecetiveLoopTask()
			g_taskSystem:loadLoopTaskList(player, taskHandler:getRecetiveLoopTask())
			break
		end
	end
	
	self:updatePlayerLevelTasks(player)
	-- 等级任务目标
	TaskCallBack.onAttainLevel(playerID, level)
	-- 跟新NPC头顶图标
	local scene = player:getScene()
	if scene then
		local curMapID = scene:getMapID()
		g_taskDoer:updateCurMapNpcHeader(player, curMapID)
	end
end

function TaskDoer.getInstance()
	return TaskDoer()
end

g_taskDoer = TaskDoer.getInstance()

g_periodChecker:addPeriodListener("day", g_taskDoer)
g_periodChecker:addPeriodListener("week", g_taskDoer)
g_periodChecker:addUpdateListener(g_taskDoer)
