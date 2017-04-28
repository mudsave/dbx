--[[OldTowerEliminateSystem.lua
	古塔驱妖任务系统
--]]

require "game.OldTowerEliminateSystem.OldTowerUtils"
require "game.OldTowerEliminateSystem.OldTowerEventMgr"

OldTowerEliminateSystem = class(nil, Singleton)

function OldTowerEliminateSystem:__init()
	self.npcMSGTable = {}
	self.playerPosition = {}
	self.playClearTimes = {}
	self.playerEndTimes ={}
end

function OldTowerEliminateSystem:__release()
	self.npcMSGTable = nil
	self.playerPosition = nil
	self.playClearTimes = nil
	self.playerEndTimes = nil
end

-- 当玩家下线或者通关时，清掉玩家相关数据
function OldTowerEliminateSystem:CleanOldTowerEliminate(playerID)
	for i,datas in ipairs(self.npcMSGTable) do
		if i == playerID then
			self.npcMSGTable[i] = nil
		end
	end
	self.playerPosition[playerID] = nil
	self.playClearTimes[playerID] = nil
	self.playerEndTimes[playerID] = nil
end

function OldTowerEliminateSystem:onFinishOldTower(player, config)
	--时间到或者是任务结束，离开场景
	local event = Event.getEvent(OldTowerEvent_SC_OldTowerTimeOut, player:getID())
	g_eventMgr:fireRemoteEvent(event, player)

	g_sceneMgr:releaseOldTowerScene(player:getID(), config.mapID, config.x, config.y)
	self:CleanOldTowerEliminate(player:getID())
end

function OldTowerEliminateSystem:setEnterPos(playerID,mapID, xPos, yPos)
	self.playerPosition[playerID] = {mapID,xPos,yPos}
end

function OldTowerEliminateSystem:getEnterPos(playerID)
	return self.playerPosition[playerID]
end

--初始化数据
function OldTowerEliminateSystem:initOldTowerData(playerID)
	--进入场景
	local player = g_entityMgr:getPlayerByID(playerID)
	local getMSG = g_sceneMgr:enterOldTowerScene(player, 34, 25)
	if not getMSG then
		print("ERROR OF ENTEROLDTOWER")
	end

	local endTime = os.time() + oldTowerTaskTime
	self.playerEndTimes[playerID] = endTime
	local i = 1
	local npcTableDatas = {}
	while i <= 9 do	
		if i <7 and i ~=3 and i~=6 then
			local getRandomData = OldTowerUtils.dogetRandNpc()
			npcTableDatas[i] = getRandomData.npcID
		elseif i ==3 or i ==6 then
			local getNpcData = OldTowerUtils.dogetRandDifferenceNpc(npcTableDatas[i-1])
			npcTableDatas[i] = getNpcData.npcID
		elseif i == 9 then
			local getNpcData = OldTowerUtils.dogetRandDifferenceNpc(npcTableDatas[i-1],npcTableDatas[i-3])
			npcTableDatas[i] = getNpcData.npcID
		else
			local getNpcData = OldTowerUtils.dogetRandDifferenceNpc(npcTableDatas[i-3])
			npcTableDatas[i] = getNpcData.npcID
		end

		i = i+1
	end
	self.playClearTimes[playerID] = 0
	self.npcMSGTable[playerID] = npcTableDatas
	--通知客户端
	local event = Event.getEvent(OldTowerEvent_SC_EnterOldTower, self.npcMSGTable[playerID])
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 服务器检测是否出现重复(行或列)
function OldTowerEliminateSystem:checkNpcDatas(playerID ,dataTable)
	local newFlag = true
	for k,v in ipairs(dataTable) do
		local getRanks = ranksTable[v]
		if self.npcMSGTable[playerID][getRanks[1]] == self.npcMSGTable[playerID][getRanks[2]] and self.npcMSGTable[playerID][getRanks[2]] == self.npcMSGTable[playerID][getRanks[3]] and newFlag then
			newFlag = true
		else
			newFlag = false
		end
	end
	return newFlag
end

--通知Npc出现行重复或列重复
function OldTowerEliminateSystem:onClearOldTowerNpc(dataTable,playerID,clearTimes)
	local player = g_entityMgr:getPlayerByID(playerID)
	local newNpcTable = {}
	if self.npcMSGTable[playerID] then
		local getFlag = self:checkNpcDatas(playerID,dataTable)
		if not getFlag then
			local event = Event.getEvent(OldTowerEvent_SC_ClearOldTowerNpc, 0, self.npcMSGTable[playerID], self.playClearTimes[playerID])
			g_eventMgr:fireRemoteEvent(event, player)
			return
		end
		for k, v in ipairs(dataTable) do
			local getranks = ranksTable[v]
			for _,value in ipairs(getranks) do
				local newData = OldTowerUtils.dogetRandNpc()
				self.npcMSGTable[playerID][value] = newData.npcID
				newNpcTable[value] = newData.npcID
			end
		end
		self.playClearTimes[playerID] = self.playClearTimes[playerID] + clearTimes
		TaskCallBack.onOldTowerClear(playerID, self.playClearTimes[playerID])

		--通知客户端
		local event = Event.getEvent(OldTowerEvent_SC_ClearOldTowerNpc, 1, newNpcTable, self.playClearTimes[playerID])
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

-- 通知点击了某个npc
function OldTowerEliminateSystem:onNpcClassChange(aimNpcPoint,playerID)
	local player = g_entityMgr:getPlayerByID(playerID)
	if self.npcMSGTable[playerID] then
		local getoldNpcID = self.npcMSGTable[playerID][aimNpcPoint]
		local newNpcData = OldTowerUtils.dogetRandDifferenceNpc(getoldNpcID)
		self.npcMSGTable[playerID][aimNpcPoint] = newNpcData.npcID
		--通知客户端
		local event = Event.getEvent(OldTowerEvent_SC_ChangeOldTowerNpc, aimNpcPoint, newNpcData.npcID)
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

-- 通知超时
function OldTowerEliminateSystem:onOldTowerTimeOut(playerID)
	if self.playerEndTimes[playerID] then
		if self.playerEndTimes[playerID] >= os.time() then
			--通知客户端
			local player = g_entityMgr:getPlayerByID(playerID)
			local newTime = self.playerEndTimes[playerID] - os.time()
			local event = Event.getEvent(OldTowerEvent_SC_OldTowerTimeSet, newTime)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

-- 通知退出
function OldTowerEliminateSystem:onOldTowerRequestQuit(playerID)
	if self.playerEndTimes[playerID] then
		self.playerEndTimes[playerID] = nil
		local player = g_entityMgr:getPlayerByID(playerID)
		local config = {mapID =14,x=154,y=74}
		self:onFinishOldTower(player,config)
	end
end

function OldTowerEliminateSystem:minUpdate(currentTime)
	-- 每分钟更新
	for playerID,v in pairs(self.playerEndTimes) do
		if self.playerEndTimes[playerID] then
			if self.playerEndTimes[playerID] <= currentTime then
				local player = g_entityMgr:getPlayerByID(playerID)
				TaskCallBack.onOldTowerTimeOut(playerID, true)
				local config = {mapID =14,x=154,y=74}
				self:onFinishOldTower(player,config)
			end
		end
	end
end

function OldTowerEliminateSystem.getInstance()
	return OldTowerEliminateSystem()
end

g_periodChecker:addUpdateListener(OldTowerEliminateSystem:getInstance())
