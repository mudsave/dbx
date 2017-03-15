--[[TNormalTrigger.lua
描述：
	主线支线任务特定触发器(任务系统)
--]]

function Triggers.createFollow(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local npcsData = {}
	local scene = player:getScene()
	local sceneType = scene:getSceneType()
	local pos = player:getPos()	
	local followEntityList = {}
	for index, npcID in pairs(param.npcs) do	
		local followEntity = g_entityFct:createFollowEntity(npcID)
		if followEntity then
			followEntity:setSpeed(player:getMoveSpeed())
			followEntity:setTaskType(task:getType())			
			player:getHandler(HandlerDef_Follow):addMember(followEntity)
			table.insert(npcsData, {followEntity:getID(), npcID})
			table.insert(followEntityList, followEntity)
		end	
	end
	g_taskSystem:addFollowEntity(player, npcsData)
	for _, followEntity in pairs(followEntityList) do	
		if sceneType == MapType.Task or sceneType == MapType.Wild or task:getType() == TaskType.loop or scene:getMapID() == 9 then
			scene:attachEntity(followEntity, pos[2] - 1 , pos[3] - 1)
		end
	end
end

function Triggers.deleteFollow(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local scene = player:getScene()
	local sceneType = scene:getSceneType()
	local followHandler = player:getHandler(HandlerDef_Follow)
	local npcsData = {}
	for _, npcID in pairs(param.npcs) do	
		local follow = followHandler:getMember(npcID)
		if follow then
			followHandler:removeMember(npcID)
			table.insert(npcsData,{follow:getID(), npcID})
			if sceneType == MapType.Task or sceneType == MapType.Wild then
				scene:detachEntity(follow)
			end
		end
	end
	g_taskSystem:removeFollowEntity(player, npcsData)
end

function Triggers.createPrivateNpc(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local npcsData = {}
	for index, npcData in pairs(param.npcs) do
		local t_npcData = 
		{
			mapID = npcData.mapID,
			npcID = npcData.npcID,
			dir = npcData.dir,
			x = npcData.x,
			y = npcData.y,
		}
		table.insert(npcsData, t_npcData)
		player:getHandler(HandlerDef_TaskPrData):addNormalNpcData(task:getID(),index, t_npcData)
	end
	--通知客户端
	g_taskSystem:onAddPrivateNpc(player, npcsData)
end

function Triggers.deletePrivateNpc(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local npcs = {}
	for _, npcData in pairs(param.npcs) do
		table.insert(npcs, npcData.npcID)
		for _, taskID in pairs(npcData.taskID) do
			player:getHandler(HandlerDef_TaskPrData):removeNormalNpcData(taskID, npcData.index)
		end
	end
	--通知客户端
	g_taskSystem:onRemovePrivateNpc(player, npcs)
end

--创建客户端传送阵
function Triggers.createPrivateTransfer(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)	
	for index, transferData in pairs(param.transfers) do
		player:getHandler(HandlerDef_TaskPrData):addTransferData(task:getID(), index, transferData)
	end
	g_taskSystem:onAddPrivateTransfer(player, param.transfers, task:getID())		
end

--移除客户端传送阵
function Triggers.deletePrivateTransfer(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	for _, transferData in pairs(param.transfers) do
		player:getHandler(HandlerDef_TaskPrData):removeTransferData(transferData.taskID, transferData.index)
		g_taskSystem:onRemovePrivateTransfer(player, transferData.taskID, transferData.index)
	end
end

--创建客户端传送阵
function Triggers.createCage(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)	
	player:getHandler(HandlerDef_TaskPrData):addCage(task:getID(), param.position)
	g_taskSystem:onCreateCage(player, task:getID(), param.position)
end

--创建客户端传送阵
function Triggers.deleteCage(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)	
	player:getHandler(HandlerDef_TaskPrData):removeCage(task:getID())
	g_taskSystem:onRemoveCage(player, task:getID())
end

--npc逃跑
function Triggers.npcEscape(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	g_taskSystem:npcEscape(player, param.npcs)
end

function Triggers.createMine(roleID, param, task, fromDB)
	local player = g_entityMgr:getPlayerByID(roleID)
	for _, mineData in pairs(param) do
		player:getHandler(HandlerDef_TaskPrData):addTaskMine(task:getID(),mineData)
	end
end

function Triggers.removeMine(roleID, param, task, fromDB)
	--print("移除宠物>>>>>>>>>>>>>执行到到这列没有")
	local player = g_entityMgr:getPlayerByID(roleID)
	player:getHandler(HandlerDef_TaskPrData):removeTaskMine(task:getID())
end

function Triggers.CreateIntemDirect(roleID, param, task, fromDB)
	local player = g_entityMgr:getPlayerByID(roleID)
	g_taskSystem:notifyClient(player, TaskNotifyClientType.item, param)
end

function Triggers.enterScriptFight(roleID, param, task, fromDB)
	if fromDB then
		return
	end
	local player = g_entityMgr:getPlayerByID(roleID)
	local playerList = {}
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
	--加宠物
	local finalList = {}
	for k,player in ipairs(playerList) do
		table.insert(finalList,player)
		local petID = player:getFightPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			table.insert(finalList,pet)
		end
	end
	g_fightMgr:startScriptFight(finalList, param.scriptID, param.mapID)
end
