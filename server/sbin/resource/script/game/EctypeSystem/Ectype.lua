--[[Ectype.lua
描述:
	副本类
]]

Ectype = class(nil, Timer)

function Ectype:__init()
	-- 副本ID，也就是配置ID
	self.ectypeID = -1
	-- 副本动态地图ID，副本唯一ID
	self.ectypeMapID = -1
	-- 当前进度
	self.curProgress = 1
	-- 副本结束时间
	self.endTime = 0
	-- 记录副本里的玩家
	self.allPlayers = {}
	-- 副本生命定时器
	self.lifeTimerID = -1
	-- 副本弥留定时器
	self.dyingTimerID = -1
	-- 副本动态NPC
	self.ectypeNpc = {}
	-- 执行前置步骤的标志，比如触发热区打开对话框后掉线，那么再上线就需要重新创建热区来打开对话框，也就是要执行前置步骤
	self.exePreProcedureFlag = false
	-- 副本完成标志
	self.finishFlag = false
end

function Ectype:__release()
end

-- 创建
function Ectype:create(ectypeID)
	self.ectypeID = ectypeID
	-- 找到副本配置
	self.ectypeConfig = tEctypeDB[self.ectypeID]
	if not self.ectypeConfig then
		return false
	end
	-- 创建新的副本地图
	self.ectypeMapID = g_sceneMgr:createEctypeScene(self.ectypeConfig.StaticMapID)
	if self.ectypeMapID > 0 then
		return true
	else
		return false
	end
end

-- 打开副本机关
function Ectype:openEctypeEffect()
	local effect = self.ectypeConfig.EctypeEffect 
	if effect then
		local funs = effect[1]
		funs(self, effect)
	end
end

-- 添加动态NPC
function Ectype:createNpc(params)
	local npcID = params.npcID
	local xPos = params.xPos
	local yPos = params.yPos
	local dir = params.dir
	local npc = g_entityFct:createEctypeNpc(npcID)
	if not npc then
		return nil
	end
	local peer = npc:getPeer()
	peer:setDirection(dir)
	if not self.ectypeNpc[npcID] then
		self.ectypeNpc[npcID] = npc
		local ectypeMapID = self:getEctypeMapID2()
		if not ectypeMapID then
			g_sceneMgr:enterEctypeScene(self.ectypeMapID, {npc, xPos, yPos})
		else
			g_sceneMgr:enterEctypeScene(ectypeMapID, {npc, xPos, yPos})
		end
	end
	return npc
end

-- 根据指定的ID删除动态NPC
function Ectype:removeNpc(npcID)
	local npc = self.ectypeNpc[npcID]
	if not npc then return end
	local scene = npc:getScene()
	scene:detachEntity(npc)
	g_entityMgr:removeNpc(npc:getID())
	self.ectypeNpc[npcID] = nil
	release(npc)
end

-- 获取所有的动态NPC
function Ectype:getEctypeNpc()
	return self.ectypeNpc
end

-- 删除所有的NPC
function Ectype:removeAllNpc()
	for npcID, _ in pairs(self.ectypeNpc) do
		 self:removeNpc(npcID)
	end

	if self.ectypePatrolNpc then
		for npcID, _ in pairs(self.ectypePatrolNpc) do
			self:removePatrolNpc(npcID)
		end
	else
		print("子类没有副本巡逻npc的实现")
	end
end

-- 删除所有的场景物件
function Ectype:removeAllObject()
	--print("self>>>>>>>>>>>>ectyoe ", toString(self.ectypeObject))
	if self.ectypeObject then
		for objectID, _ in pairs(self.ectypeObject) do
			self:removeObject(objectID)
		end
	else
		print("子类没有副本对象实现")
	end
end

-- 打开对话
function Ectype:openDialog(optionID)
	if self.exePreProcedureFlag then
		local ectypePlayers = self:getEctypePlayers()
		for playerID, _ in pairs(ectypePlayers) do
			local player = g_entityMgr:getPlayerByID(playerID)
			if player then
				-- 创建一个npc对话
				g_dialogDoer:createDialogByID(player, optionID)
			end
		end
	else
		self.curProgress = self.curProgress - 1
		self:exeLogicProcedure(true)
	end
end

-- 获得副本ID
function Ectype:getEctypeID()
	return self.ectypeID
end

-- 获得副本静态地图ID
function Ectype:getMapID()
	return self.ectypeConfig.StaticMapID
end

-- 获得副本动态地图ID
function Ectype:getEctypeMapID()
	return self.ectypeMapID
end

-- 获得副本动态地图ID2
function Ectype:getEctypeMapID2()
	return self.ectypeMapID2
end

-- 设置副本进度
function Ectype:setEctypeProcess(curProgress)
	self.curProgress = curProgress
	print("设置副本当前进度为", curProgress)
end

-- 获得副本进度
function Ectype:getEctypeProcess()
	return self.curProgress
end

-- 设置副本剩余分钟数
function Ectype:setEctypeLeftMin(leftMin)
	print("设置副本剩余分数为", leftMin)
	local lifeTime = 0
	if leftMin > 0 then
		-- 根据剩余分钟数重新计算副本结束时间
		lifeTime = leftMin * 60
		self.endTime = os.time() + lifeTime
	else
		-- 如果剩余时间为0，就默认用副本配置时间
		lifeTime = self.ectypeConfig.EctypeExistTime * 60
		self.endTime = os.time() + lifeTime
	end
	-- 开启副本生命定时器
	if lifeTime > 0 then
		lifeTime = lifeTime * 1000
		if lifeTime > 0 then
			self.lifeTimerID = g_timerMgr:regTimer(self, lifeTime, lifeTime, "副本生命定时器")
		else
			print("Ectype:setEctypeLeftMin 逻辑错误，ectypeID = ", self.ectypeID)
		end
	else
		-- 不限制副本时间
	end
end

-- 获得副本剩余分钟数
function Ectype:getEctypeLeftMin()
	local leftMin = math.ceil((self.endTime - os.time()) / 60)
	if leftMin > 0 then
		return leftMin
	end
	return 0
end

-- 获得副本玩家
function Ectype:getEctypePlayers()
	return self.allPlayers
end

-- 定时器回调
function Ectype:update(timerID)
	-- 副本生命定时器
	--print("timerID>>>>>>>>>>>>>>>>", timerID, self.lifeTimerID)
	if timerID == self.lifeTimerID then
		-- 副本时间到了，如果副本还未完成，则消耗一次进入次数
		print("self.finishFalga>>>>>>>>>>>>>>>>>>>>>>>>>", self.finishFlag)
		if not self.finishFlag then
			if self.ectypeConfig.EctypeType == EctypeType.Ring then
			else
				-- 处理相应的副本奖励，时间到，帮会副本要给予适当的奖励
				if self.ectypeConfig.EctypeType == EctypeType.Faction then
					-- 时间到结束帮会副本，同时也要给奖励
					--print("zhixing dao zhel.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
					self:finishFactionEctype()
				end
				local ectypePlayers = self:getEctypePlayers()
				for playerID, _ in pairs(ectypePlayers) do
					local player = g_entityMgr:getPlayerByID(playerID)
					if player then
						-- 增加完成次数
						local ectypeHandler = player:getHandler(HandlerDef_Ectype)
						ectypeHandler:addEctypeFinishTimes(self.ectypeID)
						print("普通副本存在时间超时，增加次数，ectypeID = ", self.ectypeID)
					end
				end
			end
		end
	-- 副本弥留定时器
	elseif timerID == self.dyingTimerID then
	end
	
	-- 销毁副本
	self:releaseEctype()
end

-- 执行前置步骤这个主要是针对没有销毁的副本
function Ectype:exePreProcedure()
	if self.exePreProcedureFlag then
		self.curProgress = self.curProgress - 1
		self:exeLogicProcedure(true)
	end
end

-- 移除NPC 要放在战斗胜利之前
function Ectype:exeLogicFightClean(progress)
	local logicProcedure = self.ectypeConfig.LogicProcedure[progress]
	if logicProcedure then
		-- 先执行上一步骤的退出动作
		for i = 1, table.getn(logicProcedure.End) do
			local funs = logicProcedure.End[i][1]
			funs(self, logicProcedure.End[i])
		end
	end
end
-- 执行指定步骤的结束动作进度奖励
function Ectype:exeLogicProcedureEnd(progress)
	local logicProcedure = self.ectypeConfig.LogicProcedure[progress]
	if logicProcedure then
		-- 先执行上一步骤的退出动作
		for i = 1, table.getn(logicProcedure.End) do
			local funs = logicProcedure.End[i][1]
			funs(self, logicProcedure.End[i])
		end

		-- 设置完成当前进度
		local ectypePlayers = self:getEctypePlayers()
		if self.ectypeConfig.EctypeType == EctypeType.Ring then
			for playerID, _ in pairs(ectypePlayers) do
				local player = g_entityMgr:getPlayerByID(playerID)
				if player then
					local ectypeHandler = player:getHandler(HandlerDef_Ectype)
					-- 设置连环副本进度
					ectypeHandler:setRingEctypeProcess(self.ectypeConfig.ringEctypeID, progress)
					print("完成连环副本进度", progress)
				end
			end
		elseif self.ectypeConfig.EctypeType == EctypeType.Faction then
			-- 完成帮会副本
			for playerID, _ in pairs(ectypePlayers) do
				local player = g_entityMgr:getPlayerByID(playerID)
				if player then
					local ectypeHandler = player:getHandler(HandlerDef_Ectype)
					-- 设置连环副本进度
					ectypeHandler:setFactionEctypeProcess(self.ectypeID, progress)
					print("完成帮会副本进度", progress)
				end
			end
		else
			-- 完成普通副本进度
			for playerID, _ in pairs(ectypePlayers) do
				local player = g_entityMgr:getPlayerByID(playerID)
				if player then
					local ectypeHandler = player:getHandler(HandlerDef_Ectype)
					ectypeHandler:setEctypeProcess(self.ectypeID, progress)
					print("完成普通副本进度")
				end
			end
		end
	end
end

-- 在加一个战斗胜利之前的清理工作
function Ectype:exeLogicProcedureBefor()
	self:exeLogicFightClean(self.curProgress)
end

-- 执行指定步骤
function Ectype:exeLogicProcedure(bNewEctype)
	-- 如果是新建的副本，就不执行上一步骤的结束动作了
	if not bNewEctype then
		local lastProgress = self.curProgress-1
		self:exeLogicProcedureEnd(lastProgress)
	end
	
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		return
	end
	print("执行步骤开始动作，progress = "..self.curProgress)
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

	-- 如果是最后一个步骤，则完成整个副本
	if self.curProgress >= table.getn(self.ectypeConfig.LogicProcedure) then
		-- 执行最后一个步骤的结束动作
		self:exeLogicProcedureEnd(self.curProgress)
		-- 副本结束
		self:onEctypeEnd()
	end
end

-- 发送副本消息事件
function Ectype:sendEctypeEvent(event)
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

-- 热区触发
function Ectype:hotAreaCB(player, hotAreaID)
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		return
	end
	if not curProcedure.Goto then
		return
	end
	local enterArea = curProcedure.Goto.EnterArea
	if not enterArea then
		return
	end
	local bValid = false
	for i = 1, table.getn(enterArea) do
		if hotAreaID == enterArea[i].hotAreaID then
			local hotArea = curProcedure.Start[enterArea[i].index]
			if hotArea and hotArea.hotAreaID and hotAreaID == hotArea.hotAreaID then
				-- 验证热区是否合法
				local mapID, xPos, yPos = player:getCurPos()
				--local distance = GridDistance(xPos, yPos, hotArea.xPos, hotArea.yPos)
				print("mapID, xPos, yPos, distance", mapID, xPos, yPos, distance)
				--if distance then
				if self.curProgress == enterArea[i].gotoNext then
					-- 已经触发过了
					return
				end
				self.curProgress = enterArea[i].gotoNext
				self:setPreProcedureFlag(true)
				bValid = true
				--end
			end
			break
		end
	end
	if not bValid then
		-- 不合法
		return
	end
	-- 执行跳转步骤的动作
	self:exeLogicProcedure(false)
end

-- 对话结束
function Ectype:onDialogueEnd(player, dialogueID)
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		return
	end
	if not curProcedure.Goto then
		return
	end
	local dialogueEnd = curProcedure.Goto.DialogueEnd
	if not dialogueEnd then
		return
	end

	local bValid = false
	for i = 1, table.getn(dialogueEnd) do
		if dialogueEnd[i].dialogueID == dialogueID then
			if self.curProgress == dialogueEnd[i].gotoNext then
				-- 已经触发过了
				return
			end
			self.curProgress = dialogueEnd[i].gotoNext
			bValid = true
			break
		end
	end
	if not bValid then
		-- 不合法
		return
	end

	-- 执行跳转步骤的动作
	self:exeLogicProcedure(false)
end

function Ectype:setPreProcedureFlag(flag)
	self.exePreProcedureFlag = flag
end

function Ectype:getPreProcedureFlag()
	return self.exePreProcedureFlag
end

-- 回到副本初始坐标，一般在战斗失败后调用
function Ectype:returnEctypeInitLocs()
	local ectypePlayers = self:getEctypePlayers()
	for _, player in pairs(ectypePlayers) do
		local ectypeMapID = self:getEctypeMapID2()
		if not ectypeMapID then
			g_sceneMgr:enterEctypeScene(self.ectypeMapID, {player, self.ectypeConfig.EnterInitLocs.locX, self.ectypeConfig.EnterInitLocs.locY})
		else
			g_sceneMgr:enterEctypeScene(ectypeMapID, {player, self.ectypeConfig.EnterInitLocs2.locX, self.ectypeConfig.EnterInitLocs2.locY})
		end
	end
end

-- 同步连环副本队员的当前环数
function Ectype:syncRingEctypeCurRing()
	local needSync = -1
	local curMaxRing = -1
	-- 找到队员当前最大环数
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local ectypeHandler = player:getHandler(HandlerDef_Ectype)
			-- 只判断未通关的
			local finishFlag = ectypeHandler:getRingEctypeFinishFlag(self.ectypeConfig.ringEctypeID)
			if finishFlag == 0 then
				-- 获取当前玩家连环副本的环数
				local ringEctypeCurRing = ectypeHandler:getRingEctypeCurRing(self.ectypeConfig.ringEctypeID)
				if curMaxRing ~= ringEctypeCurRing then
					if curMaxRing < ringEctypeCurRing then
						curMaxRing = ringEctypeCurRing
					end
					-- 如果大于0，代表有至少两个队员环数不一致，需要同步
					needSync = needSync + 1
				end
			end
		end
	end
	if curMaxRing > 0 and needSync > 0 then
		for playerID, _ in pairs(ectypePlayers) do
			local player = g_entityMgr:getPlayerByID(playerID)
			if player then
				local ectypeHandler = player:getHandler(HandlerDef_Ectype)
				ectypeHandler:setRingEctypeCurRing(self.ectypeConfig.ringEctypeID, curMaxRing)
			end
		end
		print("队员的副本环数已经同步")
	end
end

-- 战斗结束前
function Ectype:onFightEndBefor(player, fightID, fightResult)
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		return
	end

	if not curProcedure.Goto then
		return
	end
	local bValid = false
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
					bValid = true
					break
				end
			end
		end
	end

	if not bValid then
		return
	end
	self:exeLogicProcedureBefor()
end

-- 战斗结束后
function Ectype:onFightEnd(player, fightID, fightResult)
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		return
	end
	if not curProcedure.Goto then
		return
	end
	local bValid = false
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
					bValid = true
					if self.ectypeConfig.EctypeType == EctypeType.Ring then
						-- 连环副本在战斗胜利后同步队友完成环数
						self:syncRingEctypeCurRing()
					end
					break
				end
			end
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
					bValid = true
					break
				end
			end
		end
		-- 回到副本初始坐标
		self:returnEctypeInitLocs()
		if not bValid then
			-- 如果没有战斗失败动作，就返回上一步骤，以便能重新打开对话框进入战斗
			self.curProgress = self.curProgress - 1
		end
	end
	if not bValid then
		local fightEnd = curProcedure.Goto.FightEnd
		if fightEnd then
			-- 战斗结束
			for i = 1, table.getn(fightEnd) do
				if fightEnd[i].fightID == fightID then
					if self.curProgress == fightEnd[i].gotoNext then
						-- 已经触发过了
						return
					end
					self.curProgress = fightEnd[i].gotoNext
					print("执行到战斗结束")
					bValid = true
				end
			end
		end
	end
	if not bValid then
		-- 不合法
		return
	end

	-- 执行跳转步骤的动作
	self:exeLogicProcedure(false)
end

-- 连环副本传送门
function Ectype:onTransferDoor(player)
	if self.transferDoorEnterEctypeID and self.transferDoorEnterEctypeID > 0 then
		g_ectypeMgr:enterEctype(player, self.transferDoorEnterEctypeID)
		self.transferDoorEnterEctypeID = nil
		return
	end
	-- 如果是普通副本，说明副本已结束，就直接传送出去
	if self.ectypeConfig.EctypeType ~= EctypeType.Ring then
		g_ectypeMgr:exitEctype(player)
		return
	end
	
	-- 连环副本进传送门处理
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local ectypeHandler = player:getHandler(HandlerDef_Ectype)
			-- 点击传送门后重设当前进度
			ectypeHandler:setRingEctypeProcess(self.ectypeConfig.ringEctypeID, 0)
			-- 点击传送门后重设碰撞次数
			ectypeHandler:setRingEctypeAttackTime(self.ectypeConfig.ringEctypeID, 0)
		end
	end

	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ringEctypeCurRing = ectypeHandler:getRingEctypeCurRing(self.ectypeConfig.ringEctypeID)
	if ringEctypeCurRing + 1 >= RingEctype_MaxRingNum then
		-- 已经完成今日连环副本，直接传送出
		g_ectypeMgr:exitEctype(player)
	else
		-- 随机出是继续下一子副本还是结束连环副本
		local transferDoorNums = RingEctype_MaxRingNum - ringEctypeCurRing
		local randomResult = math.random(1, transferDoorNums)
		if randomResult > transferDoorNums then
			-- 运气不好，随机到离开副本了，这里直接设置完成今日连环副本
			local ectypePlayers = self:getEctypePlayers()
			for playerID, _ in pairs(ectypePlayers) do
				local player = g_entityMgr:getPlayerByID(playerID)
				if player then
					local ectypeHandler = player:getHandler(HandlerDef_Ectype)
					ectypeHandler:setRingEctypeFinishFlag(self.ectypeConfig.ringEctypeID)
				end
			end
			-- 离开副本
			g_ectypeMgr:exitEctype(player)
			print("运气不好，没能完成最后一个子副本就退出了")
		else
			local teamHandler = player:getHandler(HandlerDef_Team)
			local teamID = teamHandler:getTeamID()
			local team = g_teamMgr:getTeam(teamID)
			if not team then
				-- 找不到队伍
				return
			end
			local teamMember = g_entityMgr:getPlayerByID(team[self.ectypeConfig.ringEctypeID])
			if not teamMember then
				-- 找不到领队人，这里可能是队伍中进副本时进度较高的那个人
				return
			end
			local ectypeHandler = teamMember:getHandler(HandlerDef_Ectype)
			-- 随机出子副本
			local childEctypeID = g_ectypeMgr:randomRingEctypeChildEctypeID(ectypeHandler, self.ectypeConfig.ringEctypeID)
			print("2 随机出子副本ID = ", childEctypeID)

			self:syncRingEctypeCurRing()

			-- 先退出当前子副本
			local ectypePlayers = self:getEctypePlayers()
			for playerID, _ in pairs(ectypePlayers) do
				-- 从副本里删除
				local player = g_entityMgr:getPlayerByID(playerID)
				if player then
					-- 每个队员设置环数和完成当前的副本标志
					self:removePlayer(player)
					-- 记录当前随机出的子副本
					local ectypeHandler = player:getHandler(HandlerDef_Ectype)
					ectypeHandler:setCurChildEctypeID(self.ectypeConfig.ringEctypeID, childEctypeID)
					ectypeHandler:addRingEctypeCurRing(self.ectypeConfig.ringEctypeID)
					--self:syncRingEctypeCurRing()
				end
			end

			-- 进入子副本
			g_ectypeMgr:enterEctype(player, childEctypeID)
		end
	end
end

-- 副本增加玩家
function Ectype:addPlayer(player, isSecondScene)
	-- 副本不可乘坐飞剑

	local playerID = player:getID()
	print("玩家进入副本，playerID，ectypeID", playerID, self.ectypeID)
	self.allPlayers[playerID] = player

	-- 有玩家进入，如果副本处于弥留状态，就删除弥留定时器
	if self.dyingTimerID > 0 then
		g_timerMgr:unRegTimer(self.dyingTimerID)
	end

	-- 通知进入副本
	local ectypeInfo = {}
	if self.ectypeConfig.ringEctypeID then
		ectypeInfo.ringEctypeID = self.ectypeConfig.ringEctypeID
		-- 连环副本可能各成员的环数不一致，这里显示给客户端的一律用副本最高环数
		local teamHandler = player:getHandler(HandlerDef_Team)
		local teamID = teamHandler:getTeamID()
		local team = g_teamMgr:getTeam(teamID)
		if team then
			local teamMember = g_entityMgr:getPlayerByID(team[self.ectypeConfig.ringEctypeID])
			if teamMember then
				local ectypeHandler = teamMember:getHandler(HandlerDef_Ectype)
				ectypeInfo.ringEctypeCurRing = ectypeHandler:getRingEctypeCurRing(self.ectypeConfig.ringEctypeID)
				-- 数据库是从0开始的，显示给客户端的从1开始
				ectypeInfo.ringEctypeCurRing = ectypeInfo.ringEctypeCurRing + 1
			end
		end
	else
		ectypeInfo.ringEctypeID = 0
	end
	-- 连环本会出现一种创建传送门，玩家离开副本这时候执行的进度会超过副本配置的步骤
	local progress = table.getn(self.ectypeConfig.LogicProcedure)
	if self.curProgress > progress then
		self.curProgress = progress
	end

	ectypeInfo.ectypeID = self.ectypeID
	ectypeInfo.curProgress = self.curProgress
	ectypeInfo.ectypeLeftSec = self.endTime - os.time()
	if isSecondScene then
		ectypeInfo.isSecondScene = true
	end
	local event = Event.getEvent(EctypeEvents_SC_EnterEctype, ectypeInfo)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 从副本删除玩家
function Ectype:removePlayer(player)
	local playerID = player:getID()
	if not self.allPlayers[playerID] then
		-- 逻辑错误
		return
	end
	-- 清除跟随NPC
	self:clearFollowNPC(player)
	-- 清除玩家
	self.allPlayers[playerID] = nil
	print("玩家退出副本，playerID，ectypeID", playerID, self.ectypeID)

	-- 如果是单人副本，并且此副本已经完成所有步骤，就直接销毁副本，不再理会弥留时间了
	if self.ectypeConfig.EctypeEnterType == EctypeEnterType.Single then
		if self.curProgress >= table.getn(self.ectypeConfig.LogicProcedure) then
			print("已经完成，立即销毁单人副本。。")
			self:releaseEctype()
			return
		end
	end

	-- 如果副本没有玩家了，就开启弥留定时器
	if table.size(self.allPlayers) == 0 then
		-- 普通副本和连环副本退出后立即销毁副本
		if self.ectypeConfig.EctypeType == EctypeType.Common or self.ectypeConfig.EctypeType == EctypeType.Ring then
			self:releaseEctype()
		else
			
			-- 副本弥留时间已经取消，需要立即销毁副本
			self:releaseEctype()
		end
	end
end

-- 玩家进入副本场景
function Ectype:enterEctypeScene(player)
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	if ectypeHandler:getEctypeMapID() >= EctypeMap_StartID then
		-- 这种情况应该是连环副本，从一个子副本到另一个子副本，不用再次记录进入位置信息
	else
		-- 记录玩家进入副本前的地图信息
		local mapID, xPos, yPos = player:getCurPos()
		ectypeHandler:setEnterPos(mapID, xPos, yPos)
		print("进入副本前地图信息", mapID, xPos, yPos)
	end
	-- 拉玩家进入副本
	if not self.ectypeMapID2 then
		g_sceneMgr:enterEctypeScene(self.ectypeMapID, {player, self.ectypeConfig.EnterInitLocs.locX, self.ectypeConfig.EnterInitLocs.locY})
	else
		g_sceneMgr:enterEctypeScene(self.ectypeMapID2,{player, self.ectypeConfig.EnterInitLocs2.locX, self.ectypeConfig.EnterInitLocs2.locY})
	end

	-- 记录玩家当前进入的副本地图ID
	ectypeHandler:setEctypeMapID(self.ectypeMapID)

	-- 副本增加玩家
	self:addPlayer(player)
end

-- 玩家进入副本场景扩展函数
function Ectype:enterEctypeSceneEx(player, enterPosX, enterPosY)
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	if ectypeHandler:getEctypeMapID() >= EctypeMap_StartID then
		-- 这种情况应该是连环副本，从一个子副本到另一个子副本，不用再次记录进入位置信息
	else
		-- 记录玩家进入副本前的地图信息
		local mapID, xPos, yPos = player:getCurPos()
		ectypeHandler:setEnterPos(mapID, xPos, yPos)
		print("进入副本前地图信息", mapID, xPos, yPos)
	end

	-- 拉玩家进入副本
	g_sceneMgr:enterEctypeScene(self.ectypeMapID, {player, enterPosX, enterPosY})

	-- 记录玩家当前进入的副本地图ID
	ectypeHandler:setEctypeMapID(self.ectypeMapID)

	-- 副本增加玩家
	self:addPlayer(player)
end

-- 是否创建当前副本的第二张地图
function Ectype:createEctypeOhterScene()
	local staticMapID2 = self.ectypeConfig.StaticMapID2
	if not staticMapID2 then return end
		
	local mapID2Process = false
	local logicProcedure = self.ectypeConfig.LogicProcedure
	for index = 1, table.getn(logicProcedure) do 
		local start = logicProcedure[index].Start
		local finish = logicProcedure[index].End
		for _, startConfig in pairs(start or {}) do 
			-- 判断是否是进入第二张地图的函数
			if type(startConfig[1]) == 'function' and startConfig[1] == Ectype_TransferToSecondScene then
				mapID2Process = index
				break
			end
		end

		for _, finishConfig in pairs(finish or {}) do
			if type(finishConfig[1]) == 'function' and finishConfig[1] == Ectype_TransferToSecondScene then
				mapID2Process = index
				break
			end
		end
	end
	
	if mapID2Process and mapID2Process <= self.curProgress then
		local ectypeMapID = self:getEctypeMapID2()
		if not ectypeMapID then
			-- 场景还未创建
			ectypeMapID = g_sceneMgr:createEctypeScene(self.ectypeConfig.StaticMapID2)
			if ectypeMapID == -1 then
				return
			end
			self.ectypeMapID2 = ectypeMapID
		end
	end
end

-- 玩家进入副本其他场景
function Ectype:enterEctypeOtherScene(enterPosX, enterPosY, player)
	local ectypeMapID = self:getEctypeMapID2()
	if not ectypeMapID then
		-- 场景还未创建
		ectypeMapID = g_sceneMgr:createEctypeScene(self.ectypeConfig.StaticMapID2)
		if ectypeMapID == -1 then
			return
		end
		self.ectypeMapID2 = ectypeMapID
	end
	if not player then
		local ectypePlayers = self:getEctypePlayers()
		for playerID, _ in pairs(ectypePlayers) do
			local player = g_entityMgr:getPlayerByID(playerID)
			if player then
				if player:getScene():getMapID() == self.ectypeConfig.StaticMapID2 then 
					break
				end
				-- 拉玩家进入副本
				g_sceneMgr:enterEctypeScene(ectypeMapID, {player, enterPosX, enterPosY})
				-- 副本增加玩家，广播进入信息给客户端
				self:addPlayer(player, true)
			end
		end
	else
		-- 拉玩家进入副本
		g_sceneMgr:enterEctypeScene(ectypeMapID, {player, enterPosX, enterPosY})
		-- 副本增加玩家，广播进入信息给客户端
		self:addPlayer(player, true)
	end
	-- 触发机关
	self:openEctypeEffect()
	-- 触发副本下一步骤
	local curProcedure = self.ectypeConfig.LogicProcedure[self.curProgress]
	if not curProcedure then
		return
	end
	if not curProcedure.Goto.EnterSecondScene then
		return
	end
	self.curProgress = curProcedure.Goto.EnterSecondScene.gotoNext
	-- 执行跳转步骤的动作
	self:exeLogicProcedure(false)
end

-- 获取连环副本中领队人的传送门信息, 这个我想改下, 连环副本必定要组队
function Ectype:getTransferDoorsInfo()
	local ectypePlayers = self:getEctypePlayers()
	local teamID
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local teamHandler = player:getHandler(HandlerDef_Team)
			teamID = teamHandler:getTeamID()
			break
		end
	end
	if not teamID then return end
	if teamID > 0 then
		local team = g_teamMgr:getTeam(teamID)
		if team then
			local teamMember = g_entityMgr:getPlayerByID(team[self.ectypeConfig.ringEctypeID])
			if teamMember then
				local ectypeHandler = teamMember:getHandler(HandlerDef_Ectype)
				local ringEctypeCurRing = ectypeHandler:getRingEctypeCurRing(self.ectypeConfig.ringEctypeID)
				local transferDoorsInfo = {}
				-- 其中有一个是离开副本的传送门
				transferDoorsInfo.transferDoorNums = RingEctype_MaxRingNum - ringEctypeCurRing
				for i = 1, transferDoorsInfo.transferDoorNums do
					transferDoorsInfo[i] = {}
					transferDoorsInfo[i].locX = self.ectypeConfig.TransferDoorLocs[i].locX
					transferDoorsInfo[i].locY = self.ectypeConfig.TransferDoorLocs[i].locY
				end
				return transferDoorsInfo
			end
		end
	end
	return nil
end

-- 驱动副本进度
function Ectype:driveEctypeProcess()
	-- 在驱动副本进度前要先打开副本机关
	self:openEctypeEffect()
	-- 驱动副本进度
	print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>", self.curProgress)
	if self.curProgress >= table.getn(self.ectypeConfig.LogicProcedure) then
		-- 执行到这里应该是子副本掉线，没有点击传送门进行下一步，所以这里重走一下流程
		local transferDoorsInfo = self:getTransferDoorsInfo()
		print("tasstransferDoorsInfoFer捏皮囊", transferDoorsInfo)
		if transferDoorsInfo then
			local ectypePlayers = self:getEctypePlayers()
			for playerID, _ in pairs(ectypePlayers) do
				local player = g_entityMgr:getPlayerByID(playerID)
				if player then
					-- 通知客户端创建传送门
					local event = Event.getEvent(EctypeEvents_SC_TransferDoor, transferDoorsInfo)
					g_eventMgr:fireRemoteEvent(event, player)
					print("2 通知客户端创建传送门，Num = ", transferDoorsInfo.transferDoorNums)
				end
			end
		end
	else
		-- 执行副本步骤
		self:exeLogicProcedure(true)
	end
end

-- 副本玩家返回公共场景
function Ectype:returnPublicScene(player)
	local playerID = player:getID()
	if not self.allPlayers[playerID] then
		-- 逻辑错误
		return
	end

	-- 清除玩家当前进入的副本地图ID
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	ectypeHandler:setEctypeMapID(-1)
	ectypeHandler:setIntegral(0)
	-- 记录副本剩余时间，如果副本已经完成，就设置成0，下次从头开始
	if self.finishFlag then
		if self.ectypeConfig.ringEctypeID then
			ectypeHandler:setRingEctypeLeftMin(self.ectypeConfig.ringEctypeID, 0)
		else
			if self.ectypeConfig.EctypeType ~= EctypeType.Common then
				ectypeHandler:setEctypeLeftMin(self.ectypeID, 0)
			end
		end
	else
		local leftMin = self:getEctypeLeftMin()
		if self.ectypeConfig.ringEctypeID then
			ectypeHandler:setRingEctypeLeftMin(self.ectypeConfig.ringEctypeID, leftMin)
		else
			if self.ectypeConfig.EctypeType ~= EctypeType.Common then
				ectypeHandler:setEctypeLeftMin(self.ectypeID, leftMin)
			end
		end
	end

	-- 返回公共场景
	local enterPos = ectypeHandler:getEnterPos()
	g_sceneMgr:enterPublicScene(enterPos.mapID, player, enterPos.xPos, enterPos.yPos)

	-- 退出当前副本
	self:removePlayer(player)
	-- 玩家设置公共地图标识
	player:setEctypeMapID(false)
end

-- 副本里下线
function Ectype:onPlayerCheckOut(player)
	local playerID = player:getID()
	if not self.allPlayers[playerID] then
		-- 逻辑错误
		return
	end

	-- 清除玩家当前进入的副本地图ID
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	ectypeHandler:setEctypeMapID(-1)
	ectypeHandler:setIntegral(0)
	-- 记录副本剩余时间，如果副本已经完成，就设置成0，下次从头开始
	if self.finishFlag then
		if self.ectypeConfig.ringEctypeID then
			ectypeHandler:setRingEctypeLeftMin(self.ectypeConfig.ringEctypeID, 0)
		else
			if self.ectypeConfig.EctypeType ~= EctypeType.Common then
				ectypeHandler:setEctypeLeftMin(self.ectypeID, 0)
			end
		end
	else
		local leftMin = self:getEctypeLeftMin()
		if self.ectypeConfig.ringEctypeID then
			ectypeHandler:setRingEctypeLeftMin(self.ectypeConfig.ringEctypeID, leftMin)
		else
			if self.ectypeConfig.EctypeType ~= EctypeType.Common then
				ectypeHandler:setEctypeLeftMin(self.ectypeID, leftMin)
			end
		end
	end

	-- 退出当前副本
	self:removePlayer(player)
end

-- 副本玩家返回公共场景
function Ectype:returnPublicSceneEx(mapID, xPos, yPos)
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		-- 从副本里删除
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			-- 清除玩家当前进入的副本地图ID
			local ectypeHandler = player:getHandler(HandlerDef_Ectype)
			ectypeHandler:setEctypeMapID(-1)
			ectypeHandler:setIntegral(0)

			-- 返回公共场景
			g_sceneMgr:enterPublicScene(mapID, player, xPos, yPos)

			-- 退出当前副本
			self:removePlayer(player)

			-- 玩家设置公共地图标识
			player:setEctypeMapID(false)
		end
	end
end

-- 添加动态传送门进入指定副本
function Ectype:notifyDynamicTransferDoors(ectypeID, transferDoorLocX, transferDoorLocY)
	-- 记录点击传送门进入的副本ID
	self.transferDoorEnterEctypeID = ectypeID
	-- 通知客户端创建传送门
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local transferDoorsInfo = {}
			transferDoorsInfo.transferDoorNums = 1
			transferDoorsInfo[1] = {}
			transferDoorsInfo[1].locX = transferDoorLocX
			transferDoorsInfo[1].locY = transferDoorLocY
			local event = Event.getEvent(EctypeEvents_SC_TransferDoor, transferDoorsInfo)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

-- 清除副本里所有玩家
function Ectype:clearAllPlayer()
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		-- 从副本里删除
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			self:returnPublicScene(player)
		end
	end
end

-- 副本结束，这里是指副本进度到了最后，正常流程打完了副本
function Ectype:onEctypeEnd()
	-- 设置副本完成标志
	self.finishFlag = true
	local ectypePlayers = self:getEctypePlayers()
	if self.ectypeConfig.EctypeType == EctypeType.Ring then
		print("执行连环副本结束动作创建传送门")
		-- 完成连环副本
		for playerID, _ in pairs(ectypePlayers) do
			local player = g_entityMgr:getPlayerByID(playerID)
			if player then
				local ectypeHandler = player:getHandler(HandlerDef_Ectype)
				-- 增加连环副本当前环数
				--ectypeHandler:addRingEctypeCurRing(self.ectypeConfig.ringEctypeID)
				-- 设置完成当前子副本
				ectypeHandler:setRingEctypeChildEctypeFinish(self.ectypeConfig.ringEctypeID, self.ectypeID)
				--print("设置完成当前子副本，ringEctypeID，ectypeID", self.ectypeConfig.ringEctypeID, self.ectypeID)
				local ringEctypeCurRing = ectypeHandler:getRingEctypeCurRing(self.ectypeConfig.ringEctypeID)
				if ringEctypeCurRing + 1 >= RingEctype_MaxRingNum then
					-- 完成当前连环副本
					ectypeHandler:setRingEctypeFinishFlag(self.ectypeConfig.ringEctypeID)
					print("设置当前连环副本已经完成的标志, ringEctypeID", self.ectypeConfig.ringEctypeID)
				end

				-- 连环副本的子副本结束后，需要创建传送门
				local transferDoorsInfo = {}
				-- 其中有一个是离开副本的传送门
				transferDoorsInfo.transferDoorNums = RingEctype_MaxRingNum - ringEctypeCurRing
				for i = 1, transferDoorsInfo.transferDoorNums do
					transferDoorsInfo[i] = {}
					transferDoorsInfo[i].locX = self.ectypeConfig.TransferDoorLocs[i].locX
					transferDoorsInfo[i].locY = self.ectypeConfig.TransferDoorLocs[i].locY
				end
				-- 通知客户端创建传送门
				local event = Event.getEvent(EctypeEvents_SC_TransferDoor, transferDoorsInfo)
				g_eventMgr:fireRemoteEvent(event, player)
				print("通知客户端创建传送门，Num = ", transferDoorsInfo.transferDoorNums)
			end
		end
	else
		print("普通副本结束。。。")
		-- 完成普通副本
		for playerID, _ in pairs(ectypePlayers) do
			local player = g_entityMgr:getPlayerByID(playerID)
			if player then
				-- 增加完成次数
				local ectypeHandler = player:getHandler(HandlerDef_Ectype)
				ectypeHandler:addEctypeFinishTimes(self.ectypeID)
				print("完成普通副本，增加次数，ectypeID = ", self.ectypeID)

				-- 通知客户端创建传送门
				if self.ectypeConfig.TransferDoorLocs then
					local transferDoorsInfo = {}
					transferDoorsInfo.transferDoorNums = 1
					transferDoorsInfo[1] = {}
					transferDoorsInfo[1].locX = self.ectypeConfig.TransferDoorLocs[1].locX
					transferDoorsInfo[1].locY = self.ectypeConfig.TransferDoorLocs[1].locY
					local event = Event.getEvent(EctypeEvents_SC_TransferDoor, transferDoorsInfo)
					g_eventMgr:fireRemoteEvent(event, player)
				-- 副本结束传送到指定公共场景
				elseif self.ectypeConfig.GotoPublicScene then
					local mapID = self.ectypeConfig.GotoPublicScene.mapID
					local xPos = self.ectypeConfig.GotoPublicScene.xPos
					local yPos = self.ectypeConfig.GotoPublicScene.yPos
					self:returnPublicSceneEx(mapID, xPos, yPos)
				end
			end
		end
	end
end

-- 释放副本
function Ectype:releaseEctype()
	-- 关闭定时刷新定时器， 帮会任务定时刷新的定时器
	if self.checkTimerID and self.checkTimerID > 0 then
		g_timerMgr:unRegTimer(self.checkTimerID)
	end
	-- 清除副本里所有玩家
	self:clearAllPlayer()
	-- 清除副本里所有的NPC
	self:removeAllNpc()
	-- 关闭生命定时器
	if self.lifeTimerID > 0 then
		g_timerMgr:unRegTimer(self.lifeTimerID)
	end
	-- 关闭弥留定时器
	if self.dyingTimerID > 0 then
		g_timerMgr:unRegTimer(self.dyingTimerID)
	end
	-- 移除所有的场景物件 ，关闭场景定时刷新之后
	self:removeAllObject()
	-- 删除副本
	g_ectypeMgr:onReleaseEctype(self.ectypeID, self.ectypeMapID)
	if self.ectypeMapID2 then
		g_sceneMgr:releaseEctypeScene(self.ectypeMapID2)
	end
end

--加载副本机关
function Ectype:loadOrganEffect(player)
	if not player then
		local ectypePlayers = self:getEctypePlayers()
		for playerID, _ in pairs(ectypePlayers) do
			local player = g_entityMgr:getPlayerByID(playerID)
			local teamHandler = player:getHandler(HandlerDef_Team)
			local teamID = teamHandler:getTeamID()
			local team = g_teamMgr:getTeam(teamID)
			if team then
				local event = Event.getEvent(SceneEvent_SC_StartOrganEffect, team:getLeaderID())
				g_eventMgr:fireRemoteEvent(event, player)
			else
				local event = Event.getEvent(SceneEvent_SC_StartOrganEffect, playerID)
				g_eventMgr:fireRemoteEvent(event, player)
			end
		end
	else
		local event = Event.getEvent(SceneEvent_SC_StartOrganEffect, player:getID())
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

--开启副本机关
function Ectype:openOrganEffect(npcID)
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local event = Event.getEvent(SceneEvent_SC_AddOrganEntity, npcID)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

--移除副本机关
function Ectype:removeOrganEffect(npcID)
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local event = Event.getEvent(SceneEvent_SC_RemoveOrganEntity, npcID)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

--恢复副本机关
function Ectype:resumeOrganEffect(npcID)
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local event = Event.getEvent(SceneEvent_SC_ResumeOrganEntity, npcID)
			g_eventMgr:fireRemoteEvent(event, player)
		end
	end
end

-- 判断副本里可否交易
function Ectype:canTradeInEctype()
	if self.ectypeConfig.CanTradeInEctype == false then
		return false
	end
	return true
end

-- 判断副本里可否使用治疗类道具
function Ectype:canUseHealItems()
	if self.ectypeConfig.CanUseHealItems == false then
		return false
	end
	return true
end

-- 创建副本跟随NPC
function Ectype:createFollowNPC(followNpcID)
	if self.ectypeConfig.EctypeType ~= EctypeType.Common then
		return
	end
	local player = nil
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		player = g_entityMgr:getPlayerByID(playerID)
		break
	end
	if not player then
		return
	end
	local followEntity = g_entityFct:createFollowEntity(followNpcID)
	if followEntity then
		followEntity:setSpeed(player:getMoveSpeed())
		followEntity:setTaskType(TaskType2.Copy)
		player:getHandler(HandlerDef_Follow):addEctypeMember(followEntity)
		local event = Event.getEvent(EctypeEvents_SC_AddFollowEntity, {{followEntity:getID(), followNpcID}})
		g_eventMgr:fireRemoteEvent(event, player)
		local scene = player:getScene()
		local pos = player:getPos()
		scene:attachEntity(followEntity, pos[2] - 1 , pos[3] - 1)
	end
end

-- 删除副本跟随NPC
function Ectype:deleteFollowNPC(followNpcID)
	if self.ectypeConfig.EctypeType ~= EctypeType.Common then
		return
	end
	local player = nil
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		player = g_entityMgr:getPlayerByID(playerID)
		break
	end
	if not player then
		return
	end
	local npcsData = {}
	local followHandler = player:getHandler(HandlerDef_Follow)
	local followEntity = followHandler:getEctypeMember(followNpcID)
	if followEntity then
		followHandler:removeEctypeMember(followNpcID)
		table.insert(npcsData, {followEntity:getID(), followNpcID})
		local scene = player:getScene()
		scene:detachEntity(followEntity)
	end
	local event = Event.getEvent(EctypeEvents_SC_RemoveFollowEntity, npcsData)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 清除副本里跟随NPC
function Ectype:clearFollowNPC(player)
	if self.ectypeConfig.EctypeType ~= EctypeType.Common then
		return
	end
	if not player then
		return
	end
	local npcsData = {}
	local followHandler = player:getHandler(HandlerDef_Follow)
	local followList = followHandler:getEctypeMembers()
	for followNpcID, followEntity in pairs(followList) do
		if followEntity:getTaskType() == TaskType2.Copy then
			followHandler:removeEctypeMember(followNpcID)
			table.insert(npcsData, {followEntity:getID(), followNpcID})
			local scene = player:getScene()
			scene:detachEntity(followEntity)
		end
	end
	local event = Event.getEvent(EctypeEvents_SC_RemoveFollowEntity, npcsData)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 副本战斗玩家离线和再次上线的相关处理，只正对再次上线的玩家
-- 副本战斗当中玩家掉线再次上线的玩家
function Ectype:onPlayerPreRelogin(player)
	self:openReloginEctypeEffect(player)
	local curProgress = self.curProgress - 1
	self:addPlayer(player)
	self:exePreReloginLogicProcedure(curProgress)
end

-- 打开副本机关, 单人执行
function Ectype:openReloginEctypeEffect(player)
	local effect = self.ectypeConfig.EctypeEffect 
	if effect then
		local funs = effect[1]
		funs(self, effect, player)
	end
end

-- 掉线再次上线
function Ectype:exePreReloginLogicProcedure(curProgress)
	local curProcedure = self.ectypeConfig.LogicProcedure[curProgress]
	if not curProcedure then
		return
	end
	-- 执行本步骤的开始动作
	for i = 1, table.getn(curProcedure.Start) do
		local funs = curProcedure.Start[i][1]
		funs(self, curProcedure.Start[i])
	end

	if curProgress >= 1 then
		-- 通知当前步骤
		local event = Event.getEvent(EctypeEvents_SC_CurProcess, curProgress)
		self:sendEctypeEvent(event)
	end
end

-- 副本当中机关撞击效果, 分普通副本，和连环副本
function Ectype:onAttackEffect()
	-- 通过判断副本当前进度，只有这种情况才做机关伤害次数累计增加
	if self.curProgress < table.size(self.ectypeConfig.LogicProcedure) then
		-- 此时机关撞击才会有效果。累计次数加1
		if self.ectypeConfig.EctypeType == EctypeType.Ring then
			local ectypePlayers = self:getEctypePlayers()
			for playerID, _ in pairs(ectypePlayers) do
				local player = g_entityMgr:getPlayerByID(playerID)
				if player then
					local ectypeHandler = player:getHandler(HandlerDef_Ectype)
					ectypeHandler:addRingEctypeAttackTime(self.ectypeConfig.ringEctypeID)
				end
			end
		else
			-- 如果是普通副本
			local ectypePlayers = self:getEctypePlayers()
			for playerID, _ in pairs(ectypePlayers) do
				local player = g_entityMgr:getPlayerByID(playerID)
				if player then
					local ectypeHandler = player:getHandler(HandlerDef_Ectype)
					ectypeHandler:addEctypeAttackTime(self.ectypeID)
				end
			end
		end
	end
end

-- 对于那些不需要保存进度的副本
function Ectype:setEctypeAttackTime(attackTime)
	local ectypePlayers = self:getEctypePlayers()
	for playerID, _ in pairs(ectypePlayers) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local ectypeHandler = player:getHandler(HandlerDef_Ectype)
			ectypeHandler:setEctypeAttackTime(self.ectypeID, attackTime)
		end
	end
end