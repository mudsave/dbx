--[[TaskPrivateHandler.lua
描述：
	任务私有数据handler
--]]

TaskPrivateHandler = class()

function TaskPrivateHandler:__init(entity)
	self._entity = entity
	self.transferData = {}

	self.normalNpcData = {}
	self.loopNpcData = {}
	self.traceInfo = {}

	self.taskMineList = {}			--任务雷列表
	self.mineState = {}				--任务雷状态

	self.cageData = {}
	self.donateRandom = nil	
	self.specialArea = {}
	self.followNpc = {}
	self.equipData = {}				-- 记录装备信息
	self.taskItem = {}				-- 神秘商人道具，和送信道具记录
	self.updateDB = false
	
end

function TaskPrivateHandler:__release()
	self._entity = nil
	self.transferData = nil
	self.normalNpcData = nil
	self.loopNpcData = nil
	self.traceInfo = nil

	self.taskMineList = nil
	self.mineState = nil

	self.cageData = nil
	self.donateRandom = nil
	
	self.specialArea = nil
	self.followNpc = nil

	self.updateDB = false
end

function TaskPrivateHandler:getPriUpdateDB()
	return self.updateDB
end

--传送阵
function TaskPrivateHandler:loadTransferData(transferData)
	self.transferData = transferData
	for taskID, _transferData in pairs(transferData) do
		g_taskSystem:onAddPrivateTransfer(self._entity, _transferData, taskID)	
	end
end

function TaskPrivateHandler:addTransferData(taskID, index, transferData)
	if not self.transferData[taskID] then
		self.transferData[taskID] = {}	
	end
	self.transferData[taskID][index] = transferData
	self.updateDB = true
end

function TaskPrivateHandler:removeTransferData(taskID, index)
	if not self.transferData[taskID] then
		print("你当前没有存此任务的私有传送阵",taskID)
		return 
	end
	self.transferData[taskID][index] = nil
	self.updateDB = true
end

function TaskPrivateHandler:getTransferData()
	return self.transferData
end

-- 从数据库加载私有NPC
function TaskPrivateHandler:loadNpcData(npcData)
	self.normalNpcData = npcData
	for taskID, data in pairs(npcData) do
		if table.size(data) > 0 then
			--通知客户端创建私有NPC
			g_taskSystem:onAddPrivateNpc(self._entity, data)
		end	
	end
end

function TaskPrivateHandler:addNormalNpcData(taskID, index, npcData)
	if not self.normalNpcData[taskID] then
		self.normalNpcData[taskID] = {}	
	end
	if self.normalNpcData[taskID][index] then
		return false
	end
	self.normalNpcData[taskID][index] = npcData
	self.updateDB = true
	return true
end

function TaskPrivateHandler:removeNormalNpcData(taskID, index)
	if not self.normalNpcData[taskID] then
		--print("你当前没有存此任务的私有npc",taskID)
		return 
	end
	self.normalNpcData[taskID][index] = nil
	self.updateDB = true
end

function TaskPrivateHandler:getNormalNpcData()
	return self.normalNpcData
end

--追踪数据
function TaskPrivateHandler:addTraceInfo(taskID, npcID)
	if not self.traceInfo[taskID] then
		self.traceInfo[taskID] = npcID
	else
		self.traceInfo[taskID] = npcID
	end
end

function TaskPrivateHandler:removeTraceInfo(taskID)
	self.traceInfo[taskID] = nil
end

function TaskPrivateHandler:getTraceInfo(taskID)
	return self.traceInfo[taskID]
end

--笼子
function TaskPrivateHandler:loadCage(cageData)
	self.cageData = cageData
	for taskID, data in pairs(cageData) do
		g_taskSystem:onCreateCage(self._entity, taskID, data)
	end
end

function TaskPrivateHandler:addCage(taskID, position)
	self.cageData[taskID] = position
	self.updateDB = true
end

function TaskPrivateHandler:removeCage(taskID)
	self.cageData[taskID] = nil
	self.updateDB = true
end

function TaskPrivateHandler:getCage()
	return self.cageData
end

-- 添加尾随NPC
function TaskPrivateHandler:loadFollowNpc(followData)
	local scene = self._entity:getScene()
	local sceneType = scene:getSceneType()
	local pos = self._entity:getPos()	
	for _, followData in pairs(followData) do
		local followEntity = g_entityFct:createFollowEntity(followData[1])
		if followEntity then
			followEntity:setSpeed(self._entity:getMoveSpeed())
			followEntity:setTaskType(followData[2])		
			self._entity:getHandler(HandlerDef_Follow):addMember(followEntity)
			g_taskSystem:addFollowEntity(self._entity, {{followEntity:getID(),followData[1]}})
			if sceneType == MapType.Task or sceneType == MapType.Wild or followData[2] == TaskType.loop then
				scene:attachEntity(followEntity, pos[2] - 1 , pos[3] - 1)	
			end
		end	
	end
end

--任务雷相关
function TaskPrivateHandler:setStartMine(taskID)
	self.mineState[taskID] = true
end

function TaskPrivateHandler:getStartMineByID(taskID)
	return self.mineState[taskID]
end

function TaskPrivateHandler:addTaskMine(taskID, taskMineInfo)
	if not self.taskMineList[taskID] then
		self.taskMineList[taskID] = {}
	end
	table.insert(self.taskMineList[taskID], taskMineInfo)
end

function TaskPrivateHandler:removeTaskMine(taskID)
	self.taskMineList[taskID] = nil
	if self.mineState[taskID] then
		self.mineState[taskID] = nil
	end
end

function TaskPrivateHandler:getTaskMines()
	return self.taskMineList
end

-----------------------------------------------循环任务

-- 添加尾随NPC
function TaskPrivateHandler:addTaskFollowNpc(taskID, npcID)
	if not self.followNpc[taskID] then
		self.followNpc[taskID] = npcID
	end
end

function TaskPrivateHandler:getTaskFollowNpc(taskID)
	return self.followNpc[taskID]
end

function TaskPrivateHandler:removeTaskFollowNpc(taskID)
	self.followNpc[taskID] = nil
end

--私有npc
function TaskPrivateHandler:addLoopNpcData(taskID, index, npcID)
	if not self.loopNpcData[taskID] then
		self.loopNpcData[taskID] = {}	
	end
	if self.loopNpcData[taskID][index] then
		return false
	end
	self.loopNpcData[taskID][index] = npcID
	return true
end

function TaskPrivateHandler:removeLoopNpcData(taskID, index)
	if not self.loopNpcData[taskID] then
		--print("你当前没有存此任务的私有npc",taskID)
		return 
	end
	self.loopNpcData[taskID][index] = nil
end

function TaskPrivateHandler:getLoopNpcData(taskID, index)
	if self.loopNpcData[taskID] then
		return self.loopNpcData[taskID][index]
	end
end

--设置循环任务捐献的随机数
function TaskPrivateHandler:setTaskDonateRandom(moneyNumber)
	self.donateRandom = moneyNumber
end

function TaskPrivateHandler:getTaskDonateRandom()
	return self.donateRandom
end

-- 动态热区
function TaskPrivateHandler:addSpecialArea(taskID, mapID)
	if not self.specialArea[taskID] then
		self.specialArea[taskID] = mapID
	end
end

function TaskPrivateHandler:getSpecialArea(taskID)
	return self.specialArea[taskID]
end

function TaskPrivateHandler:removeSpecialArea(taskID)
	self.specialArea[taskID] = nil
end

-- 添加神秘商人物品道具记录
function TaskPrivateHandler:addTaskItem(taskID, itemID)
	if not self.taskItem[taskID] then
		self.taskItem[taskID] = itemID
	end
end

function TaskPrivateHandler:getTaskItem(taskID)
	return self.taskItem[taskID]
end

function TaskPrivateHandler:removeTaskItem(taskID)
	self.taskItem[taskID] = nil
end

-- 记录装备信息
function TaskPrivateHandler:addEquipData(taskID, equipNeedLevel, equipQuality)
	local taskEquipData = self.equipData[taskID]
	if not curTaskEquipData then
		taskEquipData = {}
		self.equipData[taskID] = taskEquipData
	end
	taskEquipData.equipNeedLevel = equipNeedLevel
	taskEquipData.equipQuality = equipQuality
end

-- 获取装备记录信息
function TaskPrivateHandler:getEquipData(taskID)
	return self.equipData[taskID]
end

-- 移除装备记录信息
function TaskPrivateHandler:removeEquipData(taskID)
	self.equipData[taskID] = nil
end
