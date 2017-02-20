--[[CatchPetManager.lua
	捕宠管理类
--]]
CatchPetManager = class(nil, Singleton)

function CatchPetManager:__init()
	self.catchPetList = {}
	self.fightPlayers = {}
end

function CatchPetManager:__release()

end

-- 活动时间到，创建4个场景巡逻NPC
function CatchPetManager:openActivity()
	-- 根据活动配置表，来创建
	for _, monsterDB in pairs(CatchPetDB) do
		local mapID = monsterDB.mapID
		local catchPet = CatchPet(mapID, monsterDB)
		-- 先创建NPC
		catchPet:createMonster()
		-- 每个当中创建一个定时器
		catchPet:createTimer()
		if not self.catchPetList[mapID] then
			self.catchPetList[mapID] = catchPet
		end
	end
end

function CatchPetManager:onFightEndBefor(fightID, result, fightEndResults)
	for mapID, catchPet in pairs(self.catchPetList) do
		if catchPet then
			catchPet:onFightEndBefor(fightID, result, fightEndResults)
		end
	end
end

function CatchPetManager:onFightEndAfter(fightID, result, fightEndResults)
	for playerID, fightResult in pairs(fightEndResults) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player then
			local activityHandler = player:getHandler(HandlerDef_Activity)
			for index, playerID in pairs(self.fightPlayers) do
				if player:getID() == playerID then
					local enterPos = activityHandler:getEnterPos()
					g_sceneMgr:enterPublicScene(enterPos.mapID, player,  enterPos.xPos, enterPos.yPos)
					table.remove(self.fightPlayers, index)
				end
			end
		end
	end
end

function CatchPetManager:enterCatchPet(player, param)
	-- 存储当前进入场景的玩家
	local activityID = catchPetActivityID
	print("当前捕宠活动ID>>>>", activityID)
	local activity = g_activityMgr:getActivity(activityID)
	if not activity then
		print("当前活动没有开启，不能进入")
		self:sendCatchPetMessageTip(player, 1)
		return
	end
	local curMembers = {}
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	if teamID > 0 then
		local team = g_teamMgr:getTeam(teamID)
		local memberList = team:getMemberList()
		for _, memberInfo in pairs(memberList) do
			table.insert(curMembers, memberInfo.memberID)
		end
	else
		local playerID = player:getID()
		table.insert(curMembers, playerID)
	end

	for _, playerID in pairs(curMembers) do 
		-- 判断等级
		local error = self:checkPlayer(playerID, param.level)
		if error > 0 then
			-- 条件不满足提示信息
			self:sendCatchPetMessageTip(player, error)
			return
		end
	end
	local catchPet = self.catchPetList[param.mapID]
	if not catchPet then
		print("配置地图ID错误")
		return
	end
	local catchPetPlayers = catchPet:getPlayers()
	local count = table.size(curMembers) + table.size(catchPetPlayers)
	if count > 100 then
		self:sendCatchPetMessageTip(player, 3)
	end
	catchPet:enterCatchPet(curMembers)
	for _, playerID in pairs(curMembers) do
		SceneManager.getInstance():doSwitchScence(playerID, param.mapID, param.x, param.y)
	end
end

-- 检测所有玩家的条件
function CatchPetManager:checkPlayer(playerID, levelCondition)
	local player = g_entityMgr:getPlayerByID(playerID)
	local level = player:getLevel()
	if level < levelCondition then
		return 2
	end
	return 0
end

function CatchPetManager:closeActivity()
	local activityID = catchPetActivityID
	local activity = g_activityMgr:getActivity(activityID)
	if activity then
		-- 处理活动关闭相关数据
		for mapID, catchPet in pairs(self.catchPetList) do
			if catchPet then
				catchPet:clear()
				self.catchPetList[mapID] = nil
				release(catchPet)
			end
		end
	end
end

-- 玩家下线清理工作
function CatchPetManager:onPlayerCheckOut(player)
	local mapID = player:getScene():getMapID()
	if mapID then
		local catchPet = self.catchPetList[mapID]
		if catchPet then
			catchPet:onPlayerCheckOut(player)
		end
	end
end

function CatchPetManager:saveFightPlayer(roleID)
	table.insert(self.fightPlayers, roleID)
end

function CatchPetManager:onOffline(player, activityID)
	if activityID ~= catchPetActivityID then
		return
	end
	local activity = g_activityMgr:getActivity(activityID)
	if activity then
		-- 清除相应的数据
		for mapID, catchPet in pairs(self.catchPetList) do
			if catchPet then
				catchPet:onOffline(player)
			end
		end
	end
end

-- 玩家X客户端，捕宠活动开启，玩家在捕宠活动场景当中
function CatchPetManager:isInActivityScene(player)
	local activity = g_activityMgr:getActivity(catchPetActivityID)
	-- 如果捕宠活动开启
	if activity then
		for mapID, catchPet in pairs(self.catchPetList) do 
			if catchPet then
				if catchPet:isInActivityScene(player) then
					return true
				end
			end
		end
	end
end

-- 发送副本消息提示
function CatchPetManager:sendCatchPetMessageTip(player, msgID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, msgID)
	g_eventMgr:fireRemoteEvent(event, player)
end


function CatchPetManager.getInstance()
	return CatchPetManager()
end
