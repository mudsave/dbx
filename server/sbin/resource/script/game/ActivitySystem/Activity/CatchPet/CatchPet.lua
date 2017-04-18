--[[CatchPet.lua
--]]

CatchPet = class(nil, Timer)
-- 这个当中还需要及时
function CatchPet:__init(mapID, monsterDB)
	-- 存储巡逻NPC实体
	self.patrolMonster1 = {}
	self.patrolMonster2 = {}
	self.patrolMonster3 = {}
	-- 地图ID
	self.mapID = mapID
	-- 把当前配置传递进来
	self.monsterDB = monsterDB
	-- 根据配置的的怪物来创建怪物
	self.patrolMonster1Num = 0
	self.patrolMonster2Num = 0
	-- 存放当前fightID
	self.fightMonster = {}
	-- 记录当前场景所有的玩家
	self.playerList = {}
	self.times = 0
end

function CatchPet:__release()
	-- 存储静态NPC实体
	self.patrolMonster1 = nil
	self.patrolMonster2 = nil
	self.mapID = nil
	-- 把当前配置传递进来
	self.monsterDB = nil
	self.patrolMonster1Num = nil
	self.patrolMonster2Num = nil
	self.playerList = nil
	self.times = nil
end

function CatchPet:createAllMonster()
	self:createMonster()
	self:createSpecialMonster()
end

-- 这个创建monster在场景场景之后再
function CatchPet:createMonster()
	-- 配置静态NPC的数量
	local scene = g_sceneMgr:getSceneByID(self.mapID)
	local monsterDB = self.monsterDB
	local patrolMonster1Num = monsterDB.patrolMonster1Num
	-- 所需要创建的静态NPC的数量
	local needCreatePatrolMonster1Num = patrolMonster1Num - self.patrolMonster1Num
	local patrolMonster1 = monsterDB.patrolMonster1
	local number = 0
	local tempTime = os.time()
	for monsterNum1 = 1, needCreatePatrolMonster1Num do
		-- 根据权重函数来创建静态NPC
		number = number + 1
		local index = self:FunTaskWeight(patrolMonster1)
		local monsterConfig = patrolMonster1[index]
		local monsterID = monsterConfig.monsterID
		-- 在当前场景随机位置
		local x, y = self:getEctypeValidEmptyPos()
		local monster = g_entityFct:createActivityPatrolNpc(monsterID)
		monster:setScriptID(monsterConfig.scriptID)
		monster:setRadius(monsterConfig.radius)
		monster:setCatchPet(self)
		-- 关联到场景中
		scene:attachEntity(monster, x , y)
		self.patrolMonster1[monster:getID()] = monster
		self.patrolMonster1Num = self.patrolMonster1Num + 1
		if number <= 20 then
			monster:setStartMoveTime(tempTime + 2)
		elseif number > 20 and number <= 40 then
			monster:setStartMoveTime(tempTime + 4)
		elseif number > 40 and number <= 60 then
			monster:setStartMoveTime(tempTime + 6)
		else
			monster:setStartMoveTime(tempTime + 8)
		end
	end
	print("第一类怪物的个数", self.patrolMonster1Num)
end


-- 半小时之后刷新特殊NPC， 不需要记录个数，每隔半小时刷新一个
function CatchPet:createSpecialMonster()
	local scene = g_sceneMgr:getSceneByID(self.mapID)
	local monsterDB = self.monsterDB
	local patrolMonster2Num = monsterDB.patrolMonster2Num
	local needCreatePatrolMonster2Num = patrolMonster2Num - self.patrolMonster2Num
	local patrolMonster2 = monsterDB.patrolMonster2
	local number = 0
	local tempTime = os.time()
	for monsterNum2 = 1, needCreatePatrolMonster2Num do
		-- 根据权重函数来创建静态NPC
		number = number + 1
		local index = self:FunTaskWeight(patrolMonster2)
		local monsterConfig = patrolMonster2[index]
		local monsterID = monsterConfig.monsterID
		-- 在当前场景随机位置
		local x, y = self:getEctypeValidEmptyPos()
		--local x = 99
		--local y = 94
		-- 创建一个实体
		local monster = g_entityFct:createActivityPatrolNpc(monsterID)
		monster:setScriptID(monsterConfig.scriptID)
		monster:setRadius(monsterConfig.radius)
		monster:setCatchPet(self)
		-- 设置绑定的宠物ID
		monster:setBindPetID(monsterConfig.petID)
		scene:attachEntity(monster, x , y)
		self.patrolMonster2[monster:getID()] = monster
		self.patrolMonster2Num = self.patrolMonster2Num + 1
		monster:setStartMoveTime(tempTime + 10)
	end
	print("第二类怪物的个数", self.patrolMonster2Num)
end

-- 里面的小的再进行权重随机
function CatchPet:FunTaskWeight(config)
	local totalWeight = 0
	for _,info in ipairs(config) do
		totalWeight = totalWeight + (info.weight or 0)
	end
	local rand = math.random(totalWeight)
	local curWeight = 0
	for index,info in ipairs(config) do
		if rand >= curWeight and rand <= curWeight +  info.weight then
			return index
		end
		curWeight = curWeight + info.weight
	end
end

function CatchPet:createTimer()
	self.patrolTimerID = g_timerMgr:regTimer(self, 2*1000, 2*1000, "巡逻NPC定时移动")
end

-- 这个主要是定时让巡逻NPC行走
function CatchPet:update(timerID)
	
	self.times = self.times + 2
	-- 此时重新刷新场景NPC
	if self.times % (self.monsterDB.refreshTime1 * 60) == 0 then
		self:createMonster()
	end
	
	if self.times % (self.monsterDB.refreshTime2 * 60) == 0 then
		self:createSpecialMonster()
	end
	local nowTime = os.time()
	if timerID == self.patrolTimerID then
		for _, patrolNpc1 in pairs(self.patrolMonster1) do
			if not patrolNpc1:getMoveState() and nowTime >= patrolNpc1:getStartMoveTime() and not patrolNpc1:getOwnerID() then
				-- 不是战斗状态的才能够开始移动
				patrolNpc1:startMove()
			end
		end

		for _, patrolNpc2 in pairs(self.patrolMonster2) do
			if not patrolNpc2:getMoveState() and nowTime >= patrolNpc2:getStartMoveTime() and not patrolNpc2:getOwnerID() then
				patrolNpc2:startMove()
			end
		end
	end
	
end

-- 把战斗怪物存起来
function CatchPet:attachPatrolNpc(fightID, patrolNpcID)
	if not self.fightMonster[fightID] then
		self.fightMonster[fightID] = patrolNpcID
	end
end

-- 战斗结束。这个地方还要做下处理，战斗完看标志，
function CatchPet:onFightEndBefor(fightID, isWin, fightEndResults)
	local patrolNpcID = self.fightMonster[fightID]
	if patrolNpcID then
		local patrolNpc = g_entityMgr:getPatrolNpc(patrolNpcID)
		if patrolNpc then
			self.fightMonster[fightID] = nil
			if isWin then
				-- 战斗胜利移除NPC
				local scene = patrolNpc:getScene()
				scene:detachEntity(patrolNpc)
				if self.patrolMonster1[patrolNpcID] then
					self.patrolMonster1[patrolNpcID] = nil
					self.patrolMonster1Num = self.patrolMonster1Num - 1
				elseif self.patrolMonster2[patrolNpcID] then
					self.patrolMonster2[patrolNpcID] = nil
					self.patrolMonster2Num = self.patrolMonster2Num - 1
					self:dealPet(fightEndResults, patrolNpc)
				end
				-- 这个当中已经释放掉呢
				g_entityMgr:removePatrolNpc(patrolNpcID)
			else
				patrolNpc:setOwnerID()
				patrolNpc:moveNext()
			end
		end
	end
	-- 最后再做传送
	--[[
	for playerID, fightResult in pairs(fightEndResults) do
		local player = g_entityMgr:getPlayer(playerID)
		if player then
			local flag = player:getLeaveFlag()
			if flag then
				if self.playerList[palyerID] then
					self.playerList[roleID] = nil
				end
				local catchPetHandler = player:getHandler(HandlerDef_CatchPet)
				catchPetHandler:resetCatchPetInfo(self.mapID)
				local teamHandler = player:getHandler(HandlerDef_Team)
				local teamID = teamHandler:getTeamID()
				if teamID > 0 then
					-- 让他退出队伍
					g_teamMgr:quitTeam(roleID)
				end
				g_sceneMgr:enterPublicScene(10, {player, 200, 200})
			end
		end
	end
	--]]
end

-- 玩家点击对话进入捕宠场景
function CatchPet:enterCatchPet(members)
	for _, playerID in pairs(members) do
		local player = g_entityMgr:getPlayerByID(playerID)
		local mapID, xPos, yPos = player:getCurPos()
		local activityHandler = player:getHandler(HandlerDef_Activity)
		activityHandler:setEnterPos(mapID, xPos, yPos)
		if not self.playerList[playerID] then
			self.playerList[playerID] = player
		end
	end
end

-- 玩家下线时
function CatchPet:onPlayerCheckOut(player)
	local playerID = player:getID()
	if self.playerList[playerID] then
		self.playerList[playerID] = nil
	end
end

function CatchPet:getEctypeValidEmptyPos()
	local scene = g_sceneMgr:getSceneByID(self.mapID)
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
		x, y = g_sceneMgr:getRandomPosition(self.mapID)
		for entityId, entity in pairs(scene:getEntityList()) do
			if entity:getEntityType() == eLogicActivityPatrolNpc then
				if self:checkTile(entity:getPos()[2], entity:getPos()[3], x, y) <= 5 then
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

function CatchPet:getPlayers()
	return self.playerList
end

-- 清理工作
function CatchPet:clear()
	-- 关闭定时器
	if self.patrolTimerID > 0 then
		g_timerMgr:unRegTimer(self.patrolTimerID)
	end
	-- 删除所有的NPC
	for _, patrolNpc1 in pairs(self.patrolMonster1) do
		local scene = patrolNpc1:getScene()
		scene:detachEntity(patrolNpc1)
		self.patrolMonster1[patrolNpc1:getID()] = nil
		g_entityMgr:removePatrolNpc(patrolNpc1:getID())
	end
	for _, patrolNpc2 in pairs(self.patrolMonster2) do
		local scene = patrolNpc2:getScene()
		scene:detachEntity(patrolNpc2)
		self.patrolMonster2[patrolNpc2:getID()] = nil
		g_entityMgr:removePatrolNpc(patrolNpc2:getID())
	end
	-- 传送所有的玩家
	for playerID, player in pairs(self.playerList) do
		if player then
			self:removePlayer(player)
		end
	end
end

-- 清除所有玩家，传送非战斗场景玩家
function CatchPet:removePlayer(player)
	local playerID = player:getID()
	if not self.playerList[playerID] then
		-- 逻辑错误
		return
	end
	self.playerList[playerID] = nil
	local activityHandler = player:getHandler(HandlerDef_Activity)
	local enterPos = activityHandler:getEnterPos()
	if player:getStatus() ~= ePlayerFight then
		g_sceneMgr:enterPublicScene(enterPos.mapID, player,  enterPos.xPos, enterPos.yPos)
	else
		g_catchPetMgr:saveFightPlayer(player:getID())
	end
end

-- 玩家非战斗状态，在活动场景当中。
function CatchPet:onOffline(player)
	local playerID = player:getID()
	if not self.playerList[playerID] then
		return
	end
	if player:getStatus() ~= ePlayerFight then
		self.playerList[playerID] = nil
	end
end

function CatchPet:isInActivityScene(player)
	local playerID = player:getID()
	if self.playerList[playerID] then
		return true
	end
end

function CatchPet:dealPet(fightEndResults, patrolNpc)
	local petID = patrolNpc:getBindPetID()
	if petID then
		for playerID, fightResult in pairs(fightEndResults) do
			local player = g_entityMgr:getPlayerByID(playerID)
			if player then
				local teamHandler = player:getHandler(HandlerDef_Team)
				local teamID = teamHandler:getTeamID()
				if teamID > 0 then
					local team = g_teamMgr:getTeam(teamID)
					if team:getLeaderID() == player:getID() then
						-- 玩家添加宠物
						self:addPet(player, petID)
					end
				else
					-- 给玩家添加宠物
					self:addPet(player, petID)
				end
			end
		end
	end
end

function CatchPet:addPet(player, petID)
	if player:canAddPet() then
		local pet = g_entityFct:createPet(petID)
		if not pet then
			print(("宠物%s是没有配置的"):format(configID))
			return
		end
		pet:setOwner(player)
		player:addPet(pet)
	else
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(
				ClientEvents_SC_PromptMsg, eventGroup_Pet, PetError.MaxPetNumber
			),player
		)
	end
end

function CatchPet:checkTile(x1, y1, x2, y2)
	local disX = math.abs(x1 - x2)
	local disY = math.abs(y1 - y2)
	local dis = disX * disX + disY * disY
	return dis^(1/2)
end