--[[OldTowerEliminateSystem.lua
	古塔驱妖任务系统
--]]

--地图配置
oldTowerMapID = 100000

-- 三种Npc出现的权重
oldTowerNpcClass = {
	{ID = 1, Name = 'NpcA', npcID = 1001, weight = 30},
	{ID = 2, Name = 'NpcB', npcID = 1002, weight = 30},
	{ID = 3, Name = 'NpcC', npcID = 1003, weight = 30},
}

ranksTable = {
	[1] = {1,2,3},
	[2] = {4,5,6},
	[3] = {7,8,9},
	[4] = {1,4,7},
	[5] = {2,5,8},
	[6] = {3,6,9},
}

OldTowerEliminateSystem = class(EventSetDoer, Singleton)

function OldTowerEliminateSystem:__init()
	self._doer = 
	{
		--[TaskEvent_CS_OldTowerNpcChange]		= OldTowerEliminateSystem.onNpcClassChange,					--在古塔驱妖场景中点击了某个npc
		--[TaskEvent_CS_OldTowerNpcClear]			= OldTowerEliminateSystem.onClearOldTowerNpc,				--某行某列重复，清除
	}
	self.npcMSGTable = {}
	self.playerPosition = {}
	self.playClearTimes = {}
end

function OldTowerEliminateSystem:__release()
	self.npcMSGTable = nil
	self.playerPosition = nil
	self.playClearTimes = nil
end

function OldTowerEliminateSystem:getNpcDatasFromPlayerID(playerID)
	return self.npcMSGTable[playerID]
end

function OldTowerEliminateSystem:setEnterPos(playerID,mapID, xPos, yPos)
	self.playerPosition[playerID] = {mapID,xPos,yPos}
end

--初始化数据
function OldTowerEliminateSystem:initOldTowerData(playerID)
	--创建场景
	local newMap = g_sceneMgr:createEctypeScene(oldTowerMapID)
	if newMap then
		g_sceneMgr:doSwitchScence(playerID, oldTowerMapID, 34, 25)

	local i = 1
	local npcTableDatas = {}
	while i <= 9 do
		local getRandomData = getRandNpc(oldTowerNpcClass)
		if i <7 and i ~=3 and i~=6 then
			npcTableDatas[i] = getRandomData.npcID
		elseif i ==3 or i ==6 then
			getNpcData = getRandDifferenceNpc(npcTableDatas[i-1])
			npcTableDatas[i] = getNpcData.npcID
		else
			getNpcData = getRandDifferenceNpc(npcTableDatas[i-3])
			npcTableDatas[i] = getNpcData.npcID
		end

		i = i+1
	end
	self.playClearTimes[playerID] = 0
	self.npcMSGTable[playerID] = npcTableDatas
	--通知客户端
	local event = Event.getEvent(TaskEvent_SC_EnterOldTower, self.npcMSGTable[playerID])
	g_eventMgr:fireRemoteEvent(event, player)
end

--随机跟指定npcID不同的NPC类型
local function getRandDifferenceNpc(uselessNpcID)
	local newTable = {}
	table.deepCopy(oldTowerNpcClass,newTable)	--配置复制

	for k,v in pairs(newTable) do
		if v.npcID == uselessNpcID then
			table.remove(newTable,k)
		end
	end

	local npcData = getRandNpc(newTable)
	return npcData
end

--根据权重随机出Npc类型
local function getRandNpc(config)
	local getConfig = {}
	table.deepCopy(config,getConfig)	--配置复制
	local maxWeight = 0
	-- 计算总权重
	for _, datas in pairs(config) do
		maxWeight = maxWeight + datas.weight
	end
	-- 得到随机物
	local rand = math.random(maxWeight)
	local curWeight  = 0
	for _,datas in pairs(config) do
		if rand >= curWeight and rand < curWeight +  datas.weight then
			return datas
		end
		curWeight = curWeight +  datas.weight
	end	
end

-- 当玩家下线或者通关时，清掉玩家相关数据
function OldTowerEliminateSystem:onClearOldTowerEliminate(playerID)
	for i,datas in ipairs(self.npcMSGTable) do
		if i == playerID then
			self.npcMSGTable[i] = nil
		end
	end
	self.playerPosition[playerID] = nil
	self.playClearTimes[playerID] = nil
end

--由客户端通知Npc出现行重复或列重复
function OldTowerEliminateSystem:onClearOldTowerNpc(event)
	local params = event:getParams()
	local dataTable = params[1]
	local playerID = event.playerID
	local clearTimes = #dataTable
	if self.npcMSGTable[playerID] then
		for k, v in ipairs(dataTable) do
			local getranks = ranksTable[v]
			for _,value in ipairs(getranks) do
				local newData = getRandNpc(oldTowerNpcClass)
				self.npcMSGTable[playerID][value] = newData.npcID
			end
		end
		self.playClearTimes[playerID] = self.playClearTimes[playerID] + clearTimes
		TaskCallBack.onOldTowerClear(playerID, self.playClearTimes[playerID])

		--通知客户端
		local event = Event.getEvent(TaskEvent_SC_ClearOldTowerNpc, self.npcMSGTable[playerID], self.playClearTimes[playerID])
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

-- 由客户端通知点击了某个npc
function OldTowerEliminateSystem:onNpcClassChange(event)
	local params = event:getParams()
	local aimNpcID = params[1]
	local aimNpcPoint = params[2]
	local playerID = event.playerID

	local newNpcData = getRandDifferenceNpc(aimNpcID)
	if self.npcMSGTable[playerID] then
		self.npcMSGTable[playerID][aimNpcPoint] = newNpcData.npcID
		--通知客户端
		local event = Event.getEvent(TaskEvent_SC_ChangeOldTowerNpc, aimNpcPoint, newNpcData.npcID)
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

function OldTowerEliminateSystem.getInstance()
	return OldTowerEliminateSystem()
end

EventManager.getInstance():addEventListener(OldTowerEliminateSystem.getInstance())
