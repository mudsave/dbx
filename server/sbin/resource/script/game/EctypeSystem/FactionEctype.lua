--[[FactionEctype.lua
	帮会副本，继承副本基本规则，重新进行扩展
--]]
FactionEctype = class(Ectype, Timer)

function FactionEctype:__init()
	self.checkTimerID = -1
	--  记录副本场景物件
	self.ectypeObject = {}
	--  记录副本巡逻怪
	self.ectypePatrolNpc = {}
	--  记录战斗NPC
	self.fightNpc = {}
	--  记录副本物件采集个数
	self.collectObjectNum = 0
end

function FactionEctype:__release()
	self.checkTimerID = nil
	--  记录副本场景物件
	self.ectypeObject = nil
	--  记录副本巡逻怪
	self.ectypePatrolNpc = nil
	--  记录战斗NPC
	self.fightNpc = nil
	--  记录副本物件采集个数
	self.collectObjectNum = nil
end

function FactionEctype:driveEctypeProcess()
	-- 在驱动副本进度前要先打开副本机关
	self:openEctypeEffect()
	-- 自己写的接口
	self:exeLogicProcedure()
	-- 启动一分钟监测定时器
	self:createCheckTimer()
end

-- 只有一个动作序列,不需要一步一步的执行
function FactionEctype:exeLogicProcedure()
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		return
	end
	-- 执行本步骤的开始动作
	for i = 1, table.getn(curProcedure.Start) do
		local funs = curProcedure.Start[i][1]
		funs(self, curProcedure.Start[i])
	end

	if self.curProgress >= 1 then
		-- 通知当前步骤
		local event = Event.getEvent(EctypeEvents_SC_CurProcess, self.curProgress)
		self:sendEctypeEvent(event)
	end
end

function FactionEctype:createCheckTimer()
	local checkTime = self.ectypeConfig.EctypeCheckTime
	if checkTime > 0 then
		checkTime = checkTime * 60 * 1000
		if checkTime > 0 then
			self.checkTimerID = g_timerMgr:regTimer(self, checkTime, checkTime, "副本定时刷怪定时器")
		else
			print("FactionEctype:createCheckTimer() 逻辑错误，ectypeID = ", self.ectypeID)
		end
	else
		-- 没有定时刷怪的定时器
	end
end

-- 定时器回调
function FactionEctype:update(timerID)
	-- 副本生命定时器
	if timerID == self.checkTimerID then
		-- 做该做的事, 重新执行第一步相关动作序列
		self:exeLogicProcedure()
	elseif timerID == self.lifeTimerID then
		Ectype.update(self, timerID)
	end
end

-- 创建场景物件的时候， 要监测副本场景当中有多少个物件
function FactionEctype:createObject(params)
	local objectID = params.objectID
	-- 判断场景物件的个数
	local objectsNum = table.size(self.ectypeObject)
	if objectsNum < params.objectNum then
		local needCreateNum = params.objectNum - objectsNum
		for i = 1, needCreateNum do 
			-- 随机坐标：
			local object = g_entityFct:createEctypeObject(objectID)
			if not object then
				return
			end
			local xPos, yPos = self:getEctypeValidEmptyPos()
			if not self.ectypeObject[object:getID()] then
				self.ectypeObject[object:getID()] = object
				g_sceneMgr:enterEctypeScene(self.ectypeMapID, {object, xPos, yPos})
			end
		end
	end
end

-- 移除副本场景物件, 左键点击移除物品
function FactionEctype:removeObject(objectID)
	local object = self.ectypeObject[objectID]
	if object then
		local scene = object:getScene()
		scene:detachEntity(object)
		self.ectypeObject[objectID] = nil
		g_entityMgr:removeGoodsNpc(objectID)
	end
end

-- 处理采集物品的个数，来判断副本是否完成, 副本时间到也会执行到这里
function FactionEctype:dealObjectNum()	
	self.collectObjectNum = self.collectObjectNum + 1
	if self.collectObjectNum == self.ectypeConfig.CollectObjectNum then
		-- 此时当前副本完成，
		if self.checkTimerID > 0 then
			-- 注销定时器
			g_timerMgr:unRegTimer(self.checkTimerID)
		end
		-- 执行当前进度的结束动作,奖励
		self:exeLogicProcedureEnd(self.curProgress)
		-- 副本结束, 来设置完成标志和奖励
		self:onEctypeEnd()
		self:removeAllObject()
		self:removeAllNpc()
	end
end

function FactionEctype:incIntegral()
	local msgID = 16
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local ectypeHandler = player:getHandler(HandlerDef_Ectype)
			-- 点击传送门后重设当前进度
			ectypeHandler:incIntegral(EctypeIntegral.Object)
			self:sendEctypeMessageTip(player, msgID, EctypeIntegral.Object)
		end
	end
end

-- 创建副本巡逻怪
function FactionEctype:createPatrolNpc(params)
	local patrolNpcID = params.npcID
	-- 判断场景物件的个数
	local objectsNum = table.size(self.ectypePatrolNpc)
	if objectsNum < params.npcNum then
		local needCreateNum = params.npcNum - objectsNum
		
		for i = 1, needCreateNum do 
			-- 随机坐标：
			local xPos, yPos = self:getEctypeValidEmptyPos()
			local patrolNpc = g_entityFct:createPatrolNpc(patrolNpcID)
			if not patrolNpc then
				return
			end
			if not self.ectypePatrolNpc[patrolNpc:getID()] then
				self.ectypePatrolNpc[patrolNpc:getID()] = patrolNpc
				g_sceneMgr:enterEctypeScene(self.ectypeMapID, {patrolNpc, xPos, yPos})
				-- 把对应配置的东西设置进去
				patrolNpc:setScriptID(params.scriptID)
				patrolNpc:setRadius(params.radius)
				-- 在挡墙场景当中移动
				patrolNpc:beginScopeMove()
			end
		end
		--[[
		local patrolNpc = g_entityFct:createPatrolNpc(patrolNpcID)
		if not patrolNpc then
			return
		end
		if not self.ectypePatrolNpc[patrolNpc:getID()] then
			self.ectypePatrolNpc[patrolNpc:getID()] = patrolNpc
			g_sceneMgr:enterEctypeScene(self.ectypeMapID, {patrolNpc, 126, 44})
			-- 把对应配置的东西设置进去
			patrolNpc:setScriptID(params.scriptID)
			patrolNpc:setRadius(params.radius)
			--patrolNpc:setCenterTile({129, 39})
			-- 在挡墙场景当中移动
			patrolNpc:beginScopeMove()
		end
		--]]
	end
end

-- 移除巡逻NPC
function FactionEctype:removePatrolNpc(npcID)
	local patrolNpc = self.ectypePatrolNpc[npcID]
	if patrolNpc then
		local scene = patrolNpc:getScene()
		scene:detachEntity(patrolNpc)
		self.ectypePatrolNpc[npcID] = nil
		g_entityMgr:removePatrolNpc(patrolNpc:getID())
	end
end

-- 绑定NPCID 和 fightID
function FactionEctype:attachPatrolNpc(fightID, patrolNpcID)
	if not self.fightNpc[fightID] then
		self.fightNpc[fightID] = patrolNpcID
	end
	-- 给玩家减积分
	local msgID = 18
	self:redIntegral(msgID, EctypeIntegral.Patrol)
end

-- 战斗结束。这个地方还要做下处理，战斗完看标志，
function FactionEctype:onFightEndBefor(fightID, isWin)
	local patrolNpcID = self.fightNpc[fightID]
	if patrolNpcID then
		local patrolNpc = g_entityMgr:getPatrolNpc(patrolNpcID)
		if patrolNpc then
			if isWin then
				-- 战斗胜利移除NPC
				self.fightNpc[fightID] = nil
				self:removePatrolNpc(patrolNpcID)
			else
				patrolNpc:setOwnerID()
				patrolNpc:moveNext()
			end
		end
	end
end

function FactionEctype:onFightEnd(fightID, isWin)
	-- 战斗失败
	if not isWin then
		self:returnEctypeInitLocs()
	end
end

-- 收到机关撞击
function FactionEctype:onAttackEffect()
	if not self.finishFlag then
		local msgID = 17
		self:redIntegral(msgID, EctypeIntegral.Effect)
	end
end

-- 在这个副本当中没有记录撞击次数
function FactionEctype:redIntegral(msgID, ectypeIntegral)
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local ectypeHandler = player:getHandler(HandlerDef_Ectype)
			-- 点击传送门后重设当前进度
			local curRedIntegral = ectypeHandler:redIntegral(ectypeIntegral)
			if curRedIntegral then	
				self:sendEctypeMessageTip(player, msgID, curRedIntegral)
			end
		end
	end
end

function FactionEctype:getEctypeValidEmptyPos()
	local scene = g_sceneMgr:getEctypeScene(self.ectypeMapID)
	local x, y
	local times = 0
	local checkSuccess
	while (1) do
		if times > 50 then
			print("检测50次依然没有发现可用坐标")
			break
		end
		times = times + 1
		checkSuccess = true 
		x, y = g_sceneMgr:getEctypeRandomPosition(self.ectypeMapID, self.ectypeConfig.StaticMapID)
		for entityId, entity in pairs(scene:getEntityList()) do
			if entity:getEntityType() == eLogicEctypeObject or entity:getEntityType() == eLogicPatrolNpc then
				if entity:getPos()[2] == x and entity:getPos()[3] == y then
					checkSuccess = false
					break
				end
			end
		end
		if checkSuccess then
			break
		end
	end

	--随机失败,直接放到安全坐标
	if checkSuccess == false then
		return mapDB[self.ectypeConfig.StaticMapID].safeX, mapDB[self.ectypeConfig.StaticMapID].safeY
	end
	--print("随机坐标成功mapID, x, y", mapId, vect.x, vect.y)
	return x, y
end

-- 时间到完成帮会副本
function FactionEctype:finishFactionEctype()
	-- 执行当前进度的结束动作,奖励
	self:exeLogicProcedureEnd(self.curProgress)
	-- 副本结束, 来设置完成标志和奖励
	self:onEctypeEnd()
end

-- 发送副本消息提示
function FactionEctype:sendEctypeMessageTip(player, msgID, ectypeIntegral)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Ectype, msgID, ectypeIntegral)
	g_eventMgr:fireRemoteEvent(event, player)
end