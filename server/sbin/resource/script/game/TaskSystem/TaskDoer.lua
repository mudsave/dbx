--[[TaskDoer.lua
描述：
	任务执行(任务系统)
--]]

TaskDoer = class(nil, Singleton)

function TaskDoer:__init()

end

function TaskDoer:__release()

end

-- 创建通天塔，，根据任务创建成功和失败，来决定是否进入场景
function TaskDoer:doReceiveBabelTask(player, taskID, rewardType, layer, flyLayer)
	if not BabelTaskDB[taskID] then
		print("通天塔任务ID配置错误", taskID)
		return 24
	end
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID > 0 then
		print("此任务不能组队")
		return 25
	end
	local level = player:getLevel()
	if level < 50 then
		print("玩家等级不够50级")
		return 26
	end
	local taskHandler = player:getHandler(HandlerDef_Task)
	babelTask = g_taskFty:createBabelTask(player, taskID, rewardType, layer, flyLayer)
	taskHandler:addTask(babelTask)
	return 0
end

-- 接任务
function TaskDoer:doRecetiveTask(player, taskID, GM)

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
			print("你已经有这个任务了")
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
		taskHandler:setReceiveTaskTime(taskID)
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

		if not TaskCondition.dailyTask(player, taskID, true, GM) then
			print("任务条件不满足")
			return false, 2
		end
		local dailyTask = g_taskFty:createDailyTask(player, taskID)
		taskHandler:addTask(dailyTask)
		dailyTask:updateNpcHeader()
		taskHandler:changeDailyTaskConfigurationByID(taskID,false)

		LuaDBAccess.updateDailyTask(player:getDBID(), dailyTask)
		LuaDBAccess.updateDailyTaskConfiguration(player:getDBID(),taskHandler:getDailyTaskConfiguration())
		
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
	taskHandler:setUpdateDB()
	taskHandler:setLoopTaskSaveDB(taskID)
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
		taskHandler:addCountRing(taskID)
		taskHandler:resetCurrentRing(taskID)
	end
	taskHandler:removeTaskByID(taskID)
end


-- 客户端点击删除通天塔任务接口
function TaskDoer:doDeleteBabelTask(player, taskID)
	local taskHandler = player:getHandler(HandlerDef_Task)	
	local task = taskHandler:getTask(taskID)
	if task then
		taskHandler:setUpdateDB()
		taskHandler:endFinishBabelTask(taskID)
	end
end

--加载任务相关
function TaskDoer:loadNormalTask(player, recordList)
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
		--g_taskSystem:onLoadPlayerTasksData(player, recordList)
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

function TaskDoer:loadDailyTask( player, recordList )

	local taskHandler = player:getHandler(HandlerDef_Task)
	for _, taskData in pairs(recordList) do
		if type(taskData.targetState) then
			local c,cc = pcall(loadstring("return "..taskData.targetState))
			taskData.targetState = cc
		end
		local dailyTask = g_taskFty:createDailyTaskFromDB(player,taskData)
		if not dailyTask then
			return
		end
		taskHandler:addTask(dailyTask)
	end
	
end

function TaskDoer:loadDailyTaskConfiguration( player,recordList )
	local taskHandler = player:getHandler(HandlerDef_Task)
	local dailyTaskConfiguration = unserialize(recordList[1].config)
	for taskID,state in pairs(dailyTaskConfiguration) do 
		if not taskHandler:getTask(taskID) then
			if not state then
				local onlineDay = time.day(time.tostring(os.time()))
				local offlineDay = time.day(time.tostring(player:getOfflineDate()))
				local onlineMonth = time.month(time.tostring(os.time()))
				local offlineMonth = time.month(time.tostring(player:getOfflineDate()))
				local onlineYear = time.month(time.tostring(os.time()))
				local offlineYear = time.month(time.tostring(player:getOfflineDate()))
				if (onlineYear == offlineYear) and (onlineMonth == offlineMonth) and (onlineDay == offlineDay) then
					state = state
				else
					state = true
				end
			end 
		end
	end
	taskHandler:setDailyTaskConfiguration(dailyTaskConfiguration)
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
		if task:getType() == TaskType.normal and task:getUpdateDB() then
			LuaDBAccess.updateNormalTask(player:getDBID(), task)
		elseif task:getType() == TaskType.loop and task:getUpdateDB() then
			LuaDBAccess.updateLoopTask(player:getDBID(), task)			
		elseif task:getType() == TaskType.daily and task:getUpdateDB() then
			LuaDBAccess.updateDailyTask(player:getDBID(), task)
			LuaDBAccess.updateDailyTaskConfiguration(player:getDBID(),taskHandler:getDailyTaskConfiguration())
		end
	end
	self:updateLoopAndBabel(player)
	self:updateRolePrivateTask(player)
end

-- 保存循环任务和天道任务
function TaskDoer:updateLoopAndBabel(player)
	local taskHandler = player:getHandler(HandlerDef_Task)
	if taskHandler:getUpdateDB() then
		taskHandler:updateLoopTaskRingToDB(taskID)
		taskHandler:saveBabelTask()
	end
end

function TaskDoer:updateRolePrivateTask(player)
	local taskPriHandler = player:getHandler(HandlerDef_TaskPrData)
	local privateTaskData = {}
	if table.size(player:getHandler(HandlerDef_Follow):getMembersID()) > 0 or taskPriHandler:getPriUpdateDB() then
		privateTaskData.followData = player:getHandler(HandlerDef_Follow):getMembersID()
		privateTaskData.transferData = taskPriHandler:getTransferData()
		privateTaskData.npcData = taskPriHandler:getNormalNpcData()
		privateTaskData.cageData = taskPriHandler:getCage()
		LuaDBAccess.updateRoleTaskPrivate(player:getDBID(), privateTaskData)
	end
end

--等级任务主要是指引任务
function TaskDoer:updatePlayerLevelTasks(player)
	for taskID,taskData in pairs(NormalTaskDB) do
		if taskData.taskType2 == TaskType2.NewBie then
			if taskData.level[1] <= player:getLevel() then	-- 指引任务不能重复接
				if not player:getHandler(HandlerDef_Task):isHisTask(taskID) then
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
				elseif NormalTaskDB[taskID].taskType2 == TaskType2.NewBie then
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
			if TaskCondition.dailyTask(player,taskID) then
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
				if task:getSubType() == TaskType2.NewBie then
					npcStatue = DialogIcon.Task1
				end
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

function TaskDoer:loadBabelTask(player, recordList)
	if recordList then
		local taskHandler = player:getHandler(HandlerDef_Task)
		for _, babelTaskData in pairs(recordList) do
			if babelTaskData.targetState then
				 local c,cc = pcall(loadstring("return "..babelTaskData.targetState))
				 babelTaskData.targetState = cc
			end
			taskHandler:loadBabelTask(babelTaskData)
		end
	end
end

-- 通天塔飞升
--param = {taskID = 20001, costType = 1, addLayer = 2, money = 1000},
function TaskDoer:doFlyUp(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(param.taskID)
	local result = self:checkFlyUpCondition(player, param)
	if result > 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, result)
		g_eventMgr:fireRemoteEvent(event, player)
	else
		-- 删除当前任务
		if task then
			local layer = task:getLayer() + param.addLayer
			local reWardType = task:getRewardType()
			taskHandler:finishBabelTask(param.taskID)
			-- 在这可能还要判断一下层数， 之后再添加
			g_taskDoer:doReceiveBabelTask(player, param.taskID, reWardType, layer, param.addLayer)
			local curTask = taskHandler:getTask(param.taskID)
			if curTask then
				local layer = curTask:getLayer()
				local mapID = BabelEachLayerDB[param.taskID][layer].mapID
				if mapID then
					-- 切换玩家到场景
					g_sceneMgr:doSwitchScence(player:getID(), mapID, 34, 25)
				end
			end
		end
	end

end

-- 监测飞升条件
function TaskDoer:checkFlyUpCondition(player, param)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local task = taskHandler:getTask(param.taskID)
	if task then
		local level = player:getLevel()
		local curTaskLayer = task:getLayer()
		if curTaskLayer <= level then
			if curTaskLayer + param.addLayer > level then
				return 18
			end
		end
		if (curTaskLayer + param.addLayer) > BabelTaskDB[param.taskID].maxLayer then
			return 19
		end
		local costType = param.costType
		if costType == CostType.money then
			local money = player:getMoney()
			if money < param.money then
				return 20
			else
				player:setMoney(money - param.money)
			end
		elseif costType == CostType.gold then
			local goldCoin = player:getGoldCoin()
			if goldCoin < param.money then
				return 21
			else
				player:setGoldCoin(goldCoin - param.money)
			end
		end
		return 0
	end
end

-- 特殊任务，既能对组，又能单人
function TaskDoer:doReceiveSpecialTask(player, taskID)
	-- 分单人， 组队，还有单人和组队都可以
	if not LoopTaskDB[taskID] then
		print("没有配置相应的任务ID")
		return
	end
	local playerList 
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID > 0 then
		playerList = teamHandler:getTeamPlayerList()
	else
		playerList = {}
		table.insert(playerList, player)
	end
	local taskHandler = player:getHandler(HandlerDef_Task)
	if taskHandler:getTask(taskID) then
		return 25
	end

	local result = TaskCondition.SpecialTask(playerList, taskID, teamID)
	if result > 0 then
		return result 
	end
	-- 先以队长来创建任务
	taskHandler:updateLoopCount(taskID)
	local loopTask = g_taskFty:createLoopTask(player, taskID)
	loopTask:setReceiveTaskLvl(player:getLevel())
	taskHandler:addTask(loopTask)
	taskHandler:setReceiveTaskTime(taskID)
	if table.size(playerList) > 1 then
		for _, entity in pairs(playerList) do
			local roleID = entity:getID()
			local curTaskHandler = entity:getHandler(HandlerDef_Task)
			if roleID ~= player:getID() then
				-- 队员接任务是如果有任务在的话，要把当前任务给删除
				local task = curTaskHandler:getTask(taskID)
				if task then
					-- 如果有任务，先删除当前任务, 没有加
					self:doDeleteTask(entity, taskID)
				end
				loopTask1 = g_taskFty:createLoopByTask(loopTask, roleID)
				loopTask1:setReceiveTaskLvl(entity:getLevel())
				curTaskHandler:addTask(loopTask1)
				curTaskHandler:setReceiveTaskTime(taskID)
				loopTask1:updateNpcHeader()
			end
			curTaskHandler:updateTaskList(taskID, false)
		end
	end
end

function TaskDoer.getInstance()
	return TaskDoer()
end

g_taskDoer = TaskDoer.getInstance()

g_periodChecker:addPeriodListener("day", g_taskDoer)
g_periodChecker:addPeriodListener("week", g_taskDoer)
g_periodChecker:addUpdateListener(g_taskDoer)
