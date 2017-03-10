--[[RescueHulaoPassEctype.lua
	驰援虎牢关
--]]
RescueHulaoPassEctype = class( Ectype, Timer )

function RescueHulaoPassEctype:__init()
	self.checkTimerID = -1
	--  记录副本巡逻怪
	self.ectypePatrolNpc = {}
	--  记录战斗NPC
	self.fightNpc = {}
	-- 副本开始时间
	self.startTime = os.time()
	-- 定时器id
	self.moveTimerID = nil
end

function RescueHulaoPassEctype:__release()
	self.checkTimerID = nil
	--  记录副本巡逻怪
	self.ectypePatrolNpc = nil
	--  记录战斗NPC
	self.fightNpc = nil

	if self.moveTimerID ~= nil then
		g_timerMgr:unRegTimer( self.moveTimerID )
	end
end

function RescueHulaoPassEctype:createMoveTimer()
	self.moveTimerID = g_timerMgr:regTimer(self, 2000, 2000, "定时扫描NPC定时")
end

-- 定时器回调
function RescueHulaoPassEctype:update( timerID )
	-- 副本生命定时器
	if timerID == self.moveTimerID then
		self:checkPatroNpc()
	end
end

-- 驱动副本进度
function RescueHulaoPassEctype:driveEctypeProcess()
	-- 在驱动副本进度前要先打开副本机关
	self:openEctypeEffect()
	-- 触发副本动作
	self:exeLogicProcedure()
	self:createMoveTimer()
end

-- 只有一个动作序列,不需要一步一步的执行
function RescueHulaoPassEctype:exeLogicProcedure()
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		print("副本当前环节配置错误,",self.curProgress)
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

function RescueHulaoPassEctype:checkPatroNpc()
	local nowTime = os.time()
	for patrolNpcID, patrolNpc in pairs(self.ectypePatrolNpc) do
		if patrolNpc then
			if not patrolNpc:getMoveState() and nowTime >= patrolNpc:getStartMoveTime() and not patrolNpc:getOwnerID() then
				patrolNpc:beginScopeMove()
			end
		end
	end
end

function RescueHulaoPassEctype:incIntegral()
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
function RescueHulaoPassEctype:createPatrolNpc( params )
	local nowTime = os.time()
	local patrolNpcID = params.npcID
	local xPos = params.xPos
	local yPos = params.yPos
	local patrolNpc = g_entityFct:createEctypePatrolNpc(patrolNpcID)
	if not patrolNpc then
		return
	end
	self.ectypePatrolNpc[patrolNpc:getID()] = patrolNpc
	g_sceneMgr:enterEctypeScene(self.ectypeMapID, {patrolNpc, xPos, yPos})
	-- 把对应配置的东西设置进去
	patrolNpc:setScriptID(params.scriptID)
	patrolNpc:setRadius(params.radius)
	patrolNpc:setStartMoveTime(nowTime)
end

-- 移除巡逻NPC
function RescueHulaoPassEctype:removePatrolNpc(npcID)
	local patrolNpc = self.ectypePatrolNpc[npcID]
	if patrolNpc then
		local scene = patrolNpc:getScene()
		scene:detachEntity(patrolNpc)
		self.ectypePatrolNpc[npcID] = nil
		g_entityMgr:removePatrolNpc(patrolNpc:getID())
	end
end

-- 绑定NPCID 和 fightID
function RescueHulaoPassEctype:attachPatrolNpc(fightID, patrolNpcID)
	if not self.fightNpc[fightID] then
		self.fightNpc[fightID] = patrolNpcID
	end
end

-- 战斗结束。这个地方还要做下处理，战斗完看标志，
function RescueHulaoPassEctype:onFightEndBefor(fightID, isWin)
	local patrolNpcID = self.fightNpc[fightID]
	if patrolNpcID then
		local patrolNpc = g_entityMgr:getPatrolNpc(patrolNpcID)
		if patrolNpc then
			self.fightNpc[fightID] = nil
			if isWin then
				-- 战斗胜利移除NPC
				self:removePatrolNpc(patrolNpcID)
			else
				patrolNpc:setOwnerID()
				patrolNpc:moveNext()
			end
		end
	end
end

-- 战斗结束后
function RescueHulaoPassEctype:onFightEnd( player, scriptID, fightResult )
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		return
	end
	if not curProcedure.Goto then
		return
	end
	if fightResult then
		-- 战斗胜利
		local fightWin = curProcedure.Goto.FightWin
		if fightWin then
			for i = 1, table.getn(fightWin) do
				if fightWin[i].fightID == scriptID then
					if self.curProgress == fightWin[i].gotoNext then
						-- 已经触发过了
						return
					end
					self.curProgress = fightWin[i].gotoNext
					print("执行到战斗胜利")
					break
				end
			end
		end
		-- 战斗胜利后清理场景
		if self.ectypeConfig.FightWinID == scriptID then
			print("abc")
			self:exeLogicProcedureEnd(self.curProgress)
			self:onEctypeEnd()
			self:setEctypeLeftMin( self.ectypeConfig.EctypeExistTime/60 )
		else
			if self.curProgress ~= 1 then
				self:exeLogicFightClean( self.curProgress )
				self.curProgress = 1
				-- 执行跳转步骤的动作
				self:exeLogicProcedure()
			end
		end
	else
		-- 战斗失败
		local fightLose = curProcedure.Goto.FightLose
		if fightLose then
			for i = 1, table.getn(fightLose) do
				if fightLose[i].fightID == scriptID then
					if self.curProgress == fightLose[i].gotoNext then
						-- 已经触发过了
						return
					end
					self.curProgress = fightLose[i].gotoNext
					print("执行到战斗失败")
					break
				end
			end
		end
		-- 回到副本初始坐标
		self:returnEctypeInitLocs()
		-- 返回上一步骤，以便能重新打开对话框进入战斗
		self.curProgress = self.curProgress - 1
		-- 执行跳转步骤的动作
		self:exeLogicProcedure()
	end
end

function RescueHulaoPassEctype:getEctypeValidEmptyPos()
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
			if entity:getEntityType() == eLogicEctypeObject or entity:getEntityType() == eLogicEctypePatrolNpc then
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
function RescueHulaoPassEctype:finishFactionEctype()
	-- 副本结束, 来设置完成标志和奖励
	self:onEctypeEnd()
end

-- 根据通关时间获得得分
function RescueHulaoPassEctype:getFactionEctypeStage()
	local msgID = 26
	local allTime = (os.time() - self.startTime) / 60
	for index, integralSection in pairs( RescueHulaoPassTime ) do
		if allTime >= integralSection[1] and allTime <= integralSection[2] then
			local ectypePlayers = self:getEctypePlayers()
			for playerID, _ in pairs( ectypePlayers ) do
				local player = g_entityMgr:getPlayerByID( playerID )
				if player then
					local ectypeHandler = player:getHandler( HandlerDef_Ectype )
					-- 点击传送门后重设当前进度
					ectypeHandler:incIntegral( EctypeIntegral.Object )
					self:sendEctypeMessageTip( player, msgID, EctypeIntegral.Object )
				end
			end
			return 
		end
	end
end

-- 发送副本消息提示
function RescueHulaoPassEctype:sendEctypeMessageTip(player, msgID, ectypeIntegral)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Ectype, msgID, ectypeIntegral)
	g_eventMgr:fireRemoteEvent(event, player)
end