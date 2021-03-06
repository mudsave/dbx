--[[TLoopTrigger.lua
描述：
	循环任务特定触发器(任务系统)
--]]

-- 完成循环任务，接下一个循环任务
function Triggers.finishLoopTask(roleID, param, task, isRandom)
	if isRandom then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local taskHandler = player:getHandler(HandlerDef_Task)
	local curTaskID = task:getID()
	taskHandler:finishLoopTask(task:getID())
end

--创建循环任务捐赠随机数
function Triggers.createDonateRandom(roleID, param, task, isRandom)
	local moneyTable = {1500,1600,1700,1800,1900,2000}
	local randomNum = math.random(6)
	local tempData = moneyTable[randomNum]
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:setTaskDonateRandom(tempData)
end

--创建boss
function Triggers.createBoss(roleID, param, task, isRandom)
	local tarPosConfig = {}
	local player = g_entityMgr:getPlayerByID(roleID)
	local playerLevel = player:getLevel()
	local conditions =
	{
		{type = "level" , param = {level = playerLevel, state = false}},
		{type = "type" , param = {type = MapType.Wild}}
	}
	if isRandom then
		local bossNpc = g_entityMgr:getBossTaskEntityByID(player:getDBID(), task:getID())
		if not bossNpc then
			-- 重新随机位置，还是要创建， 不能把任务设置成失败
			bossNpc = g_entityFct:createBoss(param.npcID, task:getEndTime())
			local name = ("%s %s %s"):format( player:getName(), string.utf8ToGbk("召唤的"), NpcDB[param.npcID].name ) 
			bossNpc:setName(name)
			local mapId, x, y = g_sceneMgr:getValidEmptyPos(conditions)
			print("创建boss",mapId, x, y)
			local scene = g_sceneMgr:getSceneByID(mapId)
			scene:attachEntity(bossNpc, x, y)
			g_entityMgr:addUpdateEntity(bossNpc)
			g_entityMgr:addBossTaskEntity(player:getDBID(), task:getID(), bossNpc)
		end
		tarPosConfig.taskID = task:getID()
		tarPosConfig.index = 1
		tarPosConfig.npcID = bossNpc:getDBID()
		tarPosConfig.mapID = bossNpc:getScene():getMapID()
		tarPosConfig.x = bossNpc:getPos()[2]
		tarPosConfig.y = bossNpc:getPos()[3]
	else
		local bossNpc = g_entityFct:createBoss(param.npcID, task:getEndTime())
		-- wrong use -_-:string.utf8ToGbk(player:getName().."召唤的"..NpcDB[param.npcID].name)
		local name = ("%s %s %s"):format( player:getName(), string.utf8ToGbk("召唤的"), NpcDB[param.npcID].name ) 
		bossNpc:setName(name)
		local mapId, x, y = g_sceneMgr:getValidEmptyPos(conditions)
		print("创建boss",mapId, x, y)
		local scene = g_sceneMgr:getSceneByID(mapId)
		scene:attachEntity(bossNpc, x, y)
		g_entityMgr:addUpdateEntity(bossNpc)
		g_entityMgr:addBossTaskEntity(player:getDBID(), task:getID(), bossNpc)
		tarPosConfig.taskID = task:getID()
		tarPosConfig.index = 1
		tarPosConfig.npcID = param.npcID
		tarPosConfig.mapID = mapId
		tarPosConfig.x = x
		tarPosConfig.y = y
	end
	g_taskSystem:onSetDirect(player, tarPosConfig)
end

--移除boss
function Triggers.removeBoss(roleID, param, task, isRandom)	
	if isRandom then
		return
	end
	
	local player = g_entityMgr:getPlayerByID(roleID)
	local bossNpc = g_entityMgr:getBossTaskEntityByID(player:getDBID(), task:getID())
	local scene = bossNpc:getScene()
	g_entityMgr:removeUpdateEntity(bossNpc)
	g_entityMgr:removeBossTaskEntityByID(player:getDBID(), task:getID())
	scene:detachEntity(bossNpc)
	release(bossNpc)
end
--------------------------------------
-- 对话交谈发送一个具体位置到客户端
function Triggers.createPosition(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	if not isRandom then
		-- 第一次读配置
		local npcConfig = GetRandData(task, "createPosition")
		-- 传递参数给配置
		curParam.npcID = npcConfig.npcID
		curParam.mapID = npcConfig.mapID
		curParam.x = npcConfig.x
		curParam.y = npcConfig.y
	end
	-- 绑定NPCID
	privateHandler:addTraceInfo(task:getID(), curParam.npcID)
	-- 发送指引给客户端
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 买物品指引
function Triggers.createBuyItemData(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		if table.size(curParam) == 0 then
			local config = GetRandData(task, "createBuyItemData")
			--local config_NPC = GetRandData(task, "createPaidItemTrace")
			-- 传递参数
			curParam.itemID = config.itemID
			curParam.count = config.count
			curParam.mapID = config.buyPosition.mapID
			curParam.x = config.buyPosition.x
			curParam.y = config.buyPosition.y
			curParam.npcID = config.buyPosition.npcID

			-- 如果有配置任务目标字段，则动态创建任务目标, 不去执行
			local targetParam1 =
			{
				itemID = curParam.itemID,
				count = curParam.count,
				bor = true,
			}

			local targetParam2 =  {}
			local itemsInfo = {}
			itemsInfo.itemID = curParam.itemID
			itemsInfo.count = curParam.count
			targetParam2.itemsInfo = {}
			table.insert(targetParam2.itemsInfo, itemsInfo)

			local target = createDynamicTarget(player, task, "TgetItem", targetParam1)
			local target1 = createDynamicTarget(player, task, "TcommitItem", targetParam2)
			-- 添加任务目标
			task:addTarget(1, target)
			task:addTarget(2, target1)
			local targets = {}
			targets[1] = {}
			targets[1].type = "TgetItem"
			targets[1].param = targetParam1
	
			targets[2] = {}
			targets[2].type = "TcommitItem"
			targets[2].param = targetParam2
		
			-- 配置拷贝
			task:setTargetsConfig(targets)
		end
	end
	-- 发送指引给客户端
	local config =
	{	
		taskID = task:getID(),
		itemID = curParam.itemID,
		mapID = curParam.mapID,
		npcID = curParam.npcID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
	task:refresh()
end

-- 上缴物品指引
function Triggers.createPaidItemTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local config = GetRandData(task, "createPaidItemTrace")
		-- 传递参数
		curParam.npcID = config.npcID
		curParam.mapID = config.mapID
		curParam.x = config.x
		curParam.y = config.y
	end
	-- 这个主要是作为对话公共场景NPC对话的条件
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:addTraceInfo(task:getID(), curParam.npcID)
	-- 发送指引给客户端
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 捕捉宠物
function Triggers.createCatchPetData(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		if table.size(curParam) == 0 then
			local config = GetRandData(task, "createCatchPetData")
			local mapID, x, y = GetRandTitle(task)
			-- 传递参数
			local targetParam = 
			{
				mapID = mapID,
				scriptID = {config.scriptID},
				fightMapID = nil,
				stepFactor = 0.1,
				mustCatch = true,
			}
			table.insert(curParam, targetParam)
			curParam.petID = config.petID
			curParam.mapID = mapID
			curParam.x = x
			curParam.y = y
			-- 创建这个任务目标
			local targetParam1 =
			{
				mapID = mapID,
				x = x,
				y = y,
				bor = false,
			}
			local targetParam2 =
			{
				petID = config.petID,
				scriptID = config.scriptID,
				count  =1,
				bor = true
			}
			local target1 = createDynamicTarget(player, task, "TautoMeet", targetParam1)
			local target2 = createDynamicTarget(player, task, "TocatchPet", targetParam2)
			-- 添加任务目标
			task:addTarget(1, target1)		
			task:addTarget(2, target2)
			local targets = {}
			targets[1] = {}
			targets[1].type = "TautoMeet"
			targets[1].param = targetParam1
			targets[2] = {}
			targets[2].type = "TocatchPet"
			targets[2].param = targetParam2
			-- 配置拷贝
			task:setTargetsConfig(targets)
			local config = GetRandData(task, "createPaidPetTrace")
			curParam.npcID = config.npcID
		end
	end
	player:getHandler(HandlerDef_TaskPrData):addTaskMine(task:getID(), curParam[1])
	-- 发送指引给客户端
	local config =
	{	
		taskID = task:getID(),
		petID = curParam.petID,
		mapID = curParam.mapID,
		npcID = curParam.npcID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
	task:refresh()
end

-- 强行停止自动遇敌
function Triggers.forceStopAutoMeet(roleID, curParam, task, isRandom)
	if isRandom then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	--player:setAutoMeetOrWay(nil)
	--g_taskSystem:onForceStopAutoMeet(player)
end

-- 上缴宠物
function Triggers.createPaidPetTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local config = GetRandData(task, "createPaidPetTrace")
		-- 传递参数
		curParam.npcID = config.npcID
		curParam.mapID = config.mapID
		curParam.x = config.x
		curParam.y = config.y
	end
	-- 这个主要是作为对话公共场景NPC对话的条件
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:addTraceInfo(task:getID(), curParam.npcID)
	-- 发送指引给客户端
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 主要是发送客户端指引，再就是动态添加任务目标
function Triggers.addSpecialArea(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local config = GetRandData(task, "addSpecialArea")
		-- 有一个对话ID和脚本ID
		local mapID, x, y = GetRandTitle(task ,roleID)
		-- 传递参数
		curParam.dialogID = config.dialogID
		curParam.mapID = mapID
		curParam.npcID = config.npcID
		curParam.x = x
		curParam.y = y

		-- 动态任务目标 一个战斗脚本监听的添加
		local targetParam =
		{
			scriptID = config.scriptID,
			count = 1,
			ignoreResult = false,
			bor = true,
		}
		local target = createDynamicTarget(player, task, "Tscript", targetParam)
		-- 添加任务目标
		task:addTarget(1, target)
		local targets = {}
		targets[1] = {}
		targets[1].type = "Tscript"
		targets[1].param = targetParam
		-- 配置拷贝
		task:setTargetsConfig(targets)
	end
	-- 客户端动态添加热区
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:addSpecialArea(task:getID(), curParam.mapID)

	local posData = {}
	posData.mapID = curParam.mapID
	posData.x = curParam.x
	posData.y = curParam.y
	g_taskSystem:addSpecialArea(player, task:getID(), posData, curParam.dialogID)

	-- 不管是读数据库，还是配置，都要发坐标
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 移除热区对话
function Triggers.removeSpecialArea(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	local mapID = privateHandler:getSpecialArea(task:getID())
	privateHandler:removeSpecialArea(task:getID())
	g_taskSystem:removeSpecialArea(player, task:getID(), mapID)
end

-- 创建随机NPC 1：坐标都是随机的 2：从指定坐标中随机
function Triggers.createRandomNpc(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	-- 根据配置的字段来创建NPC
	
	-- 如果没有配置NPCID
	if not isRandom then
		-- 这是代表读的是配置
		local npcConfig = GetRandData(task, "createRandomNpc")
		if npcConfig.mapID then
			curParam.npcID = npcConfig.npcID
			curParam.mapID = npcConfig.mapID
			curParam.x = npcConfig.x
			curParam.y = npcConfig.y
		else
			local mapID, x, y = GetRandTitle(task)
			-- 把随机到的参数传递到自己的配置当中
			curParam.npcID = npcConfig.npcID
			curParam.mapID = mapID
			curParam.x = x
			curParam.y = y
		end
		-- 如果有配置任务目标字段，则动态创建任务目标, 不去执行
		local targetParam =
		{
			scriptID = npcConfig.scriptID,
			count = 1,
			ignoreResult = false,
			bor = true,
		}
		local target = createDynamicTarget(player, task, "Tscript", targetParam)
		-- 添加任务目标
		task:addTarget(1, target)
		local targets = {}
		targets[1] = {}
		targets[1].type = "Tscript"
		targets[1].param = targetParam
		-- 配置拷贝
		task:setTargetsConfig(targets)
	end

	player:getHandler(HandlerDef_TaskPrData):addLoopNpcData(task:getID(), curParam.index, curParam.npcID)
	local npcsData = 
	{
		{
			npcID = curParam.npcID,
			mapID = curParam.mapID,
			x = curParam.x,
			y = curParam.y,
		}
	}	
	g_taskSystem:onAddPrivateNpc(player, npcsData)
	-- 之后全都通过这来发送客户端动态指引参数(如果坐标随机才发)
	local config =
	{
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

function Triggers.removeRandomNpc(roleID, curParam, task, isRandom)
	if isRandom then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	local npcs = {}
	local index = curParam.index
	local npcID = privateHandler:getLoopNpcData(task:getID(), index)
	table.insert(npcs, npcID)
	privateHandler:removeLoopNpcData(task:getID(), index)
	g_taskSystem:onRemovePrivateNpc(player, npcs)
end

-- 送信
function Triggers.deliverTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		--添加任务物品到包裹
		local config = GetRandData(task, "deliverTrace")
		--拷贝数据
		curParam.itemID = config.itemID
		curParam.count = 1
		curParam.npcID = config.npcID
		curParam.mapID = config.mapID
		curParam.x = config.x
		curParam.y = config.y
		
		local targetParam =  {}
		local itemsInfo = {}
		itemsInfo.itemID = curParam.itemID
		itemsInfo.count = curParam.count
		targetParam.itemsInfo = {}
		table.insert(targetParam.itemsInfo,itemsInfo)
		local target = createDynamicTarget(player, task, "TcommitItem", targetParam)
		task:addTarget(1, target)
		local targets = {}
		targets[1] = {}
		targets[1].type = "TcommitItem"
		targets[1].param = targetParam
		-- 配置拷贝
		task:setTargetsConfig(targets)

		local packetHandler = player:getHandler(HandlerDef_Packet)
		if packetHandler then
			packetHandler:addItemsToPacket(curParam.itemID,curParam.count)
		end
	end

	-- 对话条件
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:addTraceInfo(task:getID(), curParam.npcID)
	local itemInfo = 
	{
		itemID = curParam.itemID,
		count = curParam.count,
		taskID = task:getID(),
	}
	g_taskSystem:notifyClient(player, TaskNotifyClientType.item, itemInfo)
	-- 添加一个送信物品ID的记录
	privateHandler:addTaskItem(task:getID(), curParam.itemID)
	-- 发送指引给客户端
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}

	g_taskSystem:onSetDirect(player, config)
end

-- 添加尾随NPC
function Triggers.addFollowNpc(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	if not isRandom then
		local config = GetRandData(task, "addFollowNpc")
		-- 有一个对话ID和脚本ID
		curParam.npcID = config.npcID
		curParam.followNpcID = config.followNpcID
		curParam.mapID = config.mapID
		curParam.x = config.x
		curParam.y = config.y
		
		local npcsData = {}
		local scene = player:getScene()
		local sceneType = scene:getSceneType()
		local pos = player:getPos()	
		local followEntityList = {}
		local followEntity = g_entityFct:createFollowEntity(curParam.followNpcID)
		if followEntity then
			followEntity:setSpeed(player:getMoveSpeed())
			followEntity:setTaskType(task:getType())			
			player:getHandler(HandlerDef_Follow):addMember(followEntity)
			table.insert(npcsData, {followEntity:getID(), curParam.followNpcID})
			table.insert(followEntityList, followEntity)
		end	
		
		g_taskSystem:addFollowEntity(player, npcsData)
		for _, followEntity in pairs(followEntityList) do	
			if sceneType == MapType.Task or sceneType == MapType.Wild or task:getType() == TaskType.loop then
				scene:attachEntity(followEntity, pos[2] - 1 , pos[3] - 1)
			end
		end
	end
	local followNpcID = curParam.followNpcID
	privateHandler:addTaskFollowNpc(task:getID(), followNpcID)
	-- 对话条件NPC的添加
	privateHandler:addTraceInfo(task:getID(), curParam.npcID)
	-- 不管是读数据库，还是配置，都要发坐标
	local config =
	{	
		taskID = task:getID(),
		followNpcID = curParam.followNpcID,
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

function Triggers.removeFollowNpc(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	local followNpcID = privateHandler:getTaskFollowNpc(task:getID())
	local npcsData = {}
	local scene = player:getScene()
	local sceneType = scene:getSceneType()
	local followHandler = player:getHandler(HandlerDef_Follow)
	local follow = followHandler:getMember(followNpcID)
	if follow then
		table.insert(npcsData,{follow:getID(), followNpcID})
		--if sceneType == MapType.Task or sceneType == MapType.Wild then
		scene:detachEntity(follow)
		--release(follow)
		followHandler:removeMember(followNpcID)
		--end
	end
	g_taskSystem:removeFollowEntity(player, npcsData)
end

-- 巡逻出对话。
function Triggers.partrolTalkTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local config = GetRandData(task, "partrolTalkTrace")
		-- 有一个对话ID和脚本ID
		local mapID, x, y = GetRandTitle(task)
		-- 传递参数
		curParam.dialogID = config.dialogID
		curParam.mapID = mapID
		curParam.x = x
		curParam.y = y
	end
	-- 客户端动态添加热区
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:addSpecialArea(task:getID(), curParam.mapID)
	local posData = {}
	posData.mapID = curParam.mapID
	posData.x = curParam.x
	posData.y = curParam.y
	g_taskSystem:addSpecialArea(player, task:getID(), posData, curParam.dialogID)
	-- 不管是读数据库，还是配置，都要发坐标
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

function Triggers.removePartrolTalkTace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	local mapID = privateHandler:getSpecialArea(task:getID())
	privateHandler:removeSpecialArea(task:getID())
	g_taskSystem:removeSpecialArea(player, task:getID(), mapID)
end

--护送，巡逻出对话，对话添加尾随Npc，监听尾随Npc的添加, 任务状态为finished的时候删除尾随npc
function Triggers.escortTalkTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local config = GetRandData(task, "escortTalkTrace")
		-- 有一个对话ID和脚本ID
		local mapID, x, y = GetRandTitle(task)
		-- 传递参数
		curParam.dialogID = config.dialogID
		curParam.mapID = mapID
		curParam.x = x
		curParam.y = y
		-- 添加一个护送
		local followNpcID = config.followNpcID
		local targetParam =
		{
			followNpcID = followNpcID,
			count = 1
		}
		-- 添加一个护送动态目标
		local target = createDynamicTarget(player, task, "Tescort", targetParam)
		task:addTarget(1, target)		
		local targets = {}
		targets[1] = {}
		targets[1].type = "Tescort"
		targets[1].param = targetParam
		-- 配置拷贝
		task:setTargetsConfig(targets)
	end
	-- 客户端动态添加热区
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:addSpecialArea(task:getID(), curParam.mapID)
	local posData = {}
	posData.mapID = curParam.mapID
	posData.x = curParam.x
	posData.y = curParam.y
	g_taskSystem:addSpecialArea(player, task:getID(), posData, curParam.dialogID)
	-- 不管是读数据库，还是配置，都要发坐标
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 护送NPC指引
function Triggers.escortNpcTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local config = GetRandData(task, "escortNpcTrace")
		-- 有一个对话ID和脚本ID
		-- 有一个对话ID和脚本ID
		curParam.npcID = config.npcID
		curParam.mapID = config.mapID
		curParam.x = config.x
		curParam.y = config.y
	end
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	local followNpcID = privateHandler:getTaskFollowNpc(task:getID())
	-- 对话条件NPC的添加
	privateHandler:addTraceInfo(task:getID(), curParam.npcID)
	-- 不管是读数据库，还是配置，都要发坐标
	local config =
	{	
		taskID = task:getID(),
		followNpcID = followNpcID,
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 神秘商人
function Triggers.mysteryTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	if not isRandom then
		if table.size(curParam) == 0 then
			-- 读配置， 这个无任务目标 随机坐标
			local config = GetRandData(task, "mysteryTrace")
			-- 有一个对话ID和脚本ID
			local mapID, x, y = GetRandTitle(task)
			-- 传递参数
			curParam.dialogID = config.dialogID
			curParam.npcID = config.npcID
			curParam.mapID = mapID
			curParam.x = x
			curParam.y = y
	
			-- 如果有配置任务目标字段，则动态创建任务目标, 不去执行
			local targetParam =  {}
			local posData = 
			{
				mapID = curParam.mapID,
				x = curParam.x,
				y = curParam.y,
			}
			targetParam.posData = posData
			targetParam.dialogID = curParam.dialogID
			targetParam.itemID = config.itemID
			targetParam.count = 1
			local target1 = createDynamicTarget(player, task, "TmysteryBus", targetParam)
			-- 添加任务目标
			task:addTarget(1, target1)
			local targets = {}
			targets[1] = {}
			targets[1].type = "TmysteryBus"
			targets[1].param = targetParam
			task:setTargetsConfig(targets)
		end
	end
	-- 不管是读数据库，还是配置，都要发坐标
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

function Triggers.removeMysteryTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	local mapID = privateHandler:getSpecialArea(task:getID())
	privateHandler:removeSpecialArea(task:getID())
	g_taskSystem:removeSpecialArea(player, task:getID(), mapID)
	local itemID = privateHandler:getTaskItem(task:getID())
	-- 不管是读数据库，还是配置，都要发坐标 物品ID还是要发过去
	local config =
	{	
		taskID = task:getID(),
		itemID = itemID,
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 捐赠指引
function Triggers.donateTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local moneyTable = {1500,1600,1700,1800,1900,2000}
		local randomNum = math.random(6)
		local tempData = moneyTable[randomNum]

		local config = GetRandData(task, "donateTrace")
		-- 传递参数
		curParam.npcID = config.npcID
		curParam.mapID = config.mapID
		curParam.x = config.x
		curParam.y = config.y
		curParam.money = tempData
	end
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:setTaskDonateRandom(curParam.money)
	privateHandler:addTraceInfo(task:getID(), curParam.npcID)
	-- 不管是读数据库，还是配置，都要发坐标
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

--随机装备
function Triggers.randomEquip(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local level = player:getLevel()
		local equipLevel = math.floor(level/10)*10

		local equipInfo = GetRandEquipData(task, "randomEquip")

		--拷贝数据
		curParam.equipClass = equipInfo.type
		curParam.equipSubClass = equipInfo.index
		curParam.count = 1
		curParam.equipLevel = equipLevel
		curParam.npcID = equipInfo.npcID
		curParam.mapID = equipInfo.mapID
		curParam.x = equipInfo.x
		curParam.y = equipInfo.y

		local targetParam = 
		{
			equipClass = curParam.equipClass,
			subClass = curParam.equipSubClass,
			level = curParam.equipLevel,
			count = curParam.count,
			taskID = task:getID(),
		}
		local target = createDynamicTarget(player, task, "TcommitEquip", targetParam)
		task:addTarget(1, target)
		local targets = {}
		targets[1] = {}
		targets[1].type = "TcommitEquip"
		targets[1].param = targetParam
		-- 配置拷贝
		task:setTargetsConfig(targets)
	end

	local equipInfo = 
	{
		equipClass = curParam.equipClass,
		equipSubClass = curParam.equipSubClass,
		count = curParam.count,
		taskID = task:getID(),
		equipLevel = curParam.equipLevel,
	}
	g_taskSystem:notifyClient(player, TaskNotifyClientType.randomEquip, equipInfo)

	local config =
	{
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,	
		equipClass = curParam.equipClass,
		equipSubClass = curParam.equipSubClass,
		count = curParam.count,
		equipLevel = curParam.equipLevel,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 挑战明雷
function Triggers.brightMine(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local config = GetRandData(task, "brightMine")
		-- 传递参数
		curParam.npcID = config.npcID
		curParam.mapID = config.mapID
		curParam.x = config.x
		curParam.y = config.y
		-- 添加动态任务目标
		-- 如果有配置任务目标字段，则动态创建任务目标, 不去执行
		local targetParam =
		{
			scriptID = config.scriptID,
			count = 1,
			ignoreResult = false,
			bor = true,
		}
		local target = createDynamicTarget(player, task, "Tscript", targetParam)
		-- 添加任务目标
		task:addTarget(1, target)
		local targets = {}
		targets[1] = {}
		targets[1].type = "Tscript"
		targets[1].param = targetParam
		-- 配置拷贝
		task:setTargetsConfig(targets)
	end
	-- 对话条件
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:addTraceInfo(task:getID(), curParam.npcID)
	-- 发送指引给客户端
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

function Triggers.collectTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local config = GetRandData(task, "collectTrace")
		-- 传递参数
		curParam.npcID = config.npcID
		curParam.mapID = config.mapID
		curParam.x = config.x
		curParam.y = config.y
		curParam.itemsInfo = config.itemsInfo
		local targetParam =  {}
		targetParam.itemsInfo = curParam.itemsInfo--{}
		local target = createDynamicTarget(player, task, "TcollectItem", targetParam)
		task:addTarget(1, target)
		local targets = {}
		targets[1] = {}
		targets[1].type = "TcollectItem"
		targets[1].param = targetParam
		-- 配置拷贝
		task:setTargetsConfig(targets)
	end
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
		
		itemsInfo = curParam.itemsInfo,
	}
	local itemInfo = 
	{
		itemsInfo = curParam.itemsInfo,
		taskID = task:getID(),
	}
	g_taskSystem:notifyClient(player, TaskNotifyClientType.item, itemInfo)
	g_taskSystem:onSetDirect(player, config)	
end

function Triggers.createRandomPuzzle(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		local puzzleCount = 1
		local tPuzzleID = math.random(1, puzzleCount)
		curParam.puzzleID = tPuzzleID
		local target = createDynamicTarget(player, task, "Tpuzzle", curParam)
		task:addTarget(1, target)
		local targets = {}
		targets[1] = {}
		targets[1].type = "Tpuzzle"
		targets[1].param = curParam
		task:setTargetsConfig(targets)
	end
	print("createRandomPuzzle",toString(curParam),task:getID())
	--通知客户端
	local event = Event.getEvent(TaskEvent_SC_BeginPuzzle, task:getID(), curParam.puzzleID)
	g_eventMgr:fireRemoteEvent(event, player)
	local config =
	{	
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

function Triggers.finishPuzzle(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	-- 发送指引给客户端
	local config =
	{		
		taskID = task:getID(),
		npcID = curParam.npcID,
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
end

-- 上缴宠物，这个宠物是要去固定地方去买的
function Triggers.createBuyPetTrace(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		if table.size(curParam) == 0 then
			local config = GetRandData(task, "createBuyPetTrace")
			--local config_NPC = GetRandData(task, "createPaidItemTrace")
			-- 传递参数
			curParam.petID = config.petID
			curParam.count = config.count
			curParam.mapID = config.buyPosition.mapID
			curParam.x = config.buyPosition.x
			curParam.y = config.buyPosition.y
			curParam.npcID = config.buyPosition.npcID
			-- 如果有配置任务目标字段，则动态创建任务目标, 不去执行
			local targetParam1 =
			{
				petID = curParam.petID,
				count = curParam.count,
				bor = true,
			}
			local target = createDynamicTarget(player, task, "TpaidPet", targetParam1)
			-- 添加任务目标
			task:addTarget(1, target)
			local targets = {}
			targets[1] = {}
			targets[1].type = "TpaidPet"
			targets[1].param = targetParam1
			-- 配置拷贝
			task:setTargetsConfig(targets)
		end
	end
	-- 发送指引给客户端
	local config =
	{	
		taskID = task:getID(),
		petID = curParam.petID,
		mapID = curParam.mapID,
		npcID = curParam.npcID,
		x = curParam.x,
		y = curParam.y,
	}
	g_taskSystem:onSetDirect(player, config)
	task:refresh()
end

function Triggers.createOldTowerEliminate(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not isRandom then
		curParam.clearTimes = 20
		local target = createDynamicTarget(player, task, "ToldTower", curParam)
		task:addTarget(1, target)
		local targets = {}
		targets[1] = {}
		targets[1].type = "ToldTower"
		targets[1].param = curParam
		task:setTargetsConfig(targets)
	end
	print("createOldTowerEliminate:mapID",oldTowerMapID)
	--任务开始的时候创建场景
	g_sceneMgr:createOldTowerScene(oldTowerMapID,roleID)
end

function Triggers.finishOldTowerEliminate(roleID, curParam, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	--完成古塔驱妖任务
	local config =
	{		
		taskID = task:getID(),
		mapID = curParam.mapID,
		x = curParam.x,
		y = curParam.y,
	}
	g_oldTowerSym:onFinishOldTower(player, config)
	print("finishOldTowerEliminate")

end