--[[RescueHulaoPassEctype.lua
	驰援虎牢关
--]]
RescueHulaoPassEctype = class( Ectype, Timer )

function RescueHulaoPassEctype:__init()
	self.checkTimerID = -1
	--  记录副本场景物件
	self.ectypeObject = {}
	--  记录副本巡逻怪
	self.ectypePatrolNpc = {}
	--  记录战斗NPC
	self.fightNpc = {}
	-- 副本开始时间
	self.startTime = os.time()
end

function RescueHulaoPassEctype:__release()
	self.checkTimerID = nil
	--  记录副本场景物件
	self.ectypeObject = nil
	--  记录副本巡逻怪
	self.ectypePatrolNpc = nil
	--  记录战斗NPC
	self.fightNpc = nil
end

-- 创建场景物件的时候， 要监测副本场景当中有多少个物件
function RescueHulaoPassEctype:createObject(params)
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
function RescueHulaoPassEctype:removeObject(objectID)
	local object = self.ectypeObject[objectID]
	if object then
		local scene = object:getScene()
		scene:detachEntity(object)
		self.ectypeObject[objectID] = nil
		g_entityMgr:removeGoodsNpc(objectID)
	end
end

-- 驱动副本进度
function RescueHulaoPassEctype:driveEctypeProcess()
	-- 在驱动副本进度前要先打开副本机关
	self:openEctypeEffect()
	-- 触发副本动作
	self:exeLogicProcedure()
end

-- 只有一个动作序列,不需要一步一步的执行
function RescueHulaoPassEctype:exeLogicProcedure()
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
function RescueHulaoPassEctype:createPatrolNpc(params)
	local nowTime = os.time()
	local patrolNpcID = params.npcID
	-- 判断场景物件的个数
	local objectsNum = table.size(self.ectypePatrolNpc)
	if objectsNum < params.npcNum then
		local needCreateNum = params.npcNum - objectsNum
		for i = 1, needCreateNum do 
			-- 随机坐标：
			local xPos, yPos = self:getEctypeValidEmptyPos()
			local patrolNpc = g_entityFct:createEctypePatrolNpc(patrolNpcID)
			if not patrolNpc then
				return
			end
			if not self.ectypePatrolNpc[patrolNpc:getID()] then
				self.ectypePatrolNpc[patrolNpc:getID()] = patrolNpc
				g_sceneMgr:enterEctypeScene(self.ectypeMapID, {patrolNpc, xPos, yPos})
				-- 把对应配置的东西设置进去
				patrolNpc:setScriptID(params.scriptID)
				patrolNpc:setRadius(params.radius)
				patrolNpc:setStartMoveTime(nowTime)
			end
		end
		--[[
		local patrolNpc = g_entityFct:createEctypePatrolNpc(patrolNpcID)
		if not patrolNpc then
			return
		end
		if not self.ectypePatrolNpc[patrolNpc:getID()] then
			self.ectypePatrolNpc[patrolNpc:getID()] = patrolNpc
			g_sceneMgr:enterEctypeScene(self.ectypeMapID, {patrolNpc, 126, 44})
			-- 把对应配置的东西设置进去
			patrolNpc:setScriptID(params.scriptID)
			patrolNpc:setRadius(params.radius)
			patrolNpc:setStartMoveTime(nowTime)
		end
		--]]
	end
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
	-- 给玩家减积分
	local msgID = 18
	self:redIntegral(msgID, EctypeIntegral.Patrol)
end

-- 战斗结束后
function RescueHulaoPassEctype:onFightEnd(player, fightID, fightResult)
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
				if fightWin[i].fightID == fightID then
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
		self:exeLogicFightClean(self.curProgress)
		if self.ectypeConfig.FightWinID == fightID then
			self:exeLogicProcedureEnd(self.curProgress)
			self:onEctypeEnd()
			self:setEctypeLeftMin( self.ectypeConfig.EctypeExistTime/60 )
			return
		else
			self.curProgress = 1
			-- 执行跳转步骤的动作
			self:exeLogicProcedure()
		end
	else
		-- 战斗失败
		local fightLose = curProcedure.Goto.FightLose
		if fightLose then
			for i = 1, table.getn(fightLose) do
				if fightLose[i].fightID == fightID then
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


-- 收到机关撞击
function RescueHulaoPassEctype:onAttackEffect()
	if not self.finishFlag then
		local msgID = 17
		self:redIntegral(msgID, EctypeIntegral.Effect)
	end
end

-- 在这个副本当中没有记录撞击次数
function RescueHulaoPassEctype:redIntegral(msgID, ectypeIntegral)
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