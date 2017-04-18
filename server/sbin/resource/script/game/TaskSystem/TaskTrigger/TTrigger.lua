--[[TTriggers.lua
描述：
	一般性任务触发器(任务系统)
--]]

Triggers = {}

function FireTrigger(triggerName, roleID, task, param, fromDB)
	if type(Triggers[triggerName]) == "function" then
		return Triggers[triggerName](roleID, param, task, fromDB)
	end
end

function Triggers.RecetiveTask(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local RecetiveTaskID = nil
	if param.taskID then
		if type(param.taskIDs) == "table" then
			for _,taskID in pairs(param.taskIDs) do
				if TaskCondition.normalTask(player, taskID) then
					RecetiveTaskID = taskID
					break
				end
			end
		else
			print("配置错误，格式为{type = 'RecetiveTask', param = {taskIDs = {1}}}")
		end
		
	end
	if RecetiveTaskID then
		g_taskDoer:doRecetiveTask(player, RecetiveTaskID)
	end
end

function Triggers.finishTask(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	player:getHandler(HandlerDef_Task):finishTaskByID(task:getID())
	local recetiveTaskID = nil
	if param.recetiveTaskID then
		if type(param.recetiveTaskID) == "number" then
			recetiveTaskID = param.recetiveTaskID
		elseif type(param.recetiveTaskID) == "table" then
			for _,taskID in pairs(param.recetiveTaskID) do
				if TaskCondition.normalTask(player, taskID) then
					recetiveTaskID = taskID
					break
				end
			end
		end
		
	end
	if recetiveTaskID then
		g_taskDoer:doRecetiveTask(player, recetiveTaskID)
	end
end

function Triggers.openDialog(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	g_dialogDoer:createDialogByID(player, param.dialogID)
end

function Triggers.openUI(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)

	--发到客户端
	CactionSystem.getInstance():openUI(player, param)
end

function Triggers.doSwithScene(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	SceneManager.getInstance():doSwitchScence(roleID, param.tarMapID, param.x, param.y)
end

function Triggers.getRide(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	for index = 1, param.count do
		g_rideMgr:addRide(player, param.rideID)
	end
end

function Triggers.getPet(roleID, param, task, fromDB)
	if fromDB then
		return
	end
end

function Triggers.enterScriptFight(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local playerList = {}
	local player = g_entityMgr:getPlayerByID(roleID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		if teamHandler:isLeader() then
			playerList = teamHandler:getTeamPlayerList()
		elseif teamHandler:isStepOutState() then
			table.insert(playerList,player)
		end
	else
		table.insert(playerList,player)
	end
	print("进入脚本战斗战斗")
	local bPass = g_fightMgr:checkStartScriptFight(playerList, param.scriptID,  param.mapID)
	if bPass then
		g_fightMgr:startScriptFight(playerList, param.scriptID,  param.mapID)
	end
end

function Triggers.enterEctype(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	print("进入副本")
	local player = g_entityMgr:getPlayerByID(roleID)
	g_ectypeMgr:enterEctype(player, param.ectypeID)
end

function Triggers.autoTrace(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	CactionSystem.getInstance():doAutoTrace(player, param)
end

function Triggers.flyEffect(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		for _,memberInfo in pairs(team:getMemberList()) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			CactionSystem.getInstance():doFlyEffect(member, param.flyEffectID)	
		end
	else
		CactionSystem.getInstance():doFlyEffect(player, param.flyEffectID)
	end
end

function Triggers.playAnimation(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	CactionSystem.getInstance():doPlayAnimation(player, param)
end

function Triggers.getItem(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if packetHandler then
		packetHandler:addItemsToPacket(param.itemID, param.count)
	end
end

function Triggers.AutoMeet(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	CactionSystem.getInstance():doAutoMeet(player, param.nRad)
end

function Triggers.stopAutoMeet(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	print("停止自动遇敌动作")
	local player = g_entityMgr:getPlayerByID(roleID)
	CactionSystem.getInstance():doStopAutoMeet(player)
end

-- 打开UI指引
function Triggers.openUITip(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	CactionSystem.getInstance():doOpenUITip(player, param)
end