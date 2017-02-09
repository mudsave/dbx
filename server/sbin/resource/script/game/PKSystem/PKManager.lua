--[[PKManager.lua
描述：
	PK系统的管理
--]]



PKManager = class(EventSetDoer, Singleton)
local fightIDs = {}
function PKManager:__init()
	-- K值是被要请玩家ID，value是主动邀请PK的玩家ID
	self.requestList = {}
	self._doer = {
		[FightEvents_SS_FightEnd_afterClient]           = PKManager.onFightEnd,
		[FightEvents_SS_FightEnd_ResetState]			= PKManager.onFightEndReset,

	}
end

-- 让双方玩家进行pk -- 根据flag判断 true为强制PK，false为切磋PK
function PKManager:setPK(player, tgPlayer, flag)
	local playerList1 = {}
	local playerList2 = {}
	local teamHandler1 = player:getHandler(HandlerDef_Team)
	local playerList 
	local fightType
	if teamHandler1:isTeam() then
		playerList1 = teamHandler1:getTeamPlayerList()
	else
		table.insert(playerList1, player)
	end

	-- 目标玩家做下判断
	local teamHandler2 = tgPlayer:getHandler(HandlerDef_Team)
	if teamHandler2:isTeam() then
		playerList2 = teamHandler2:getTeamPlayerList()
	else
		table.insert(playerList2, tgPlayer)
	end
	
	-- 强制PK和切磋PK
	if flag == true then
		fightType = FightBussinessType.PK
		for _, activiPlayer in pairs(playerList1 or {}) do
			-- 判断玩家的生死状buff
			local pkInfo = activiPlayer:getPkInfo()
			local buffState = self:getPKBuffer(activiPlayer)
			pkInfo.hasBuff = buffState
			pkInfo.isAttacker = true
			pkInfo.isPK = true
		end

		for _, unactivePlayer in pairs(playerList2 or {}) do
			-- 判断玩家的生死状buff
			local pkInfo = unactivePlayer:getPkInfo()
			local buffState = self:getPKBuffer(unactivePlayer)
			pkInfo.hasBuff = buffState
			pkInfo.isAttacker = false
			pkInfo.isPK = true
		end
		-- 看所有目标玩家
		local reSult = self:getTgPlayerKillAir(playerList2)
		-- 移除主动pK玩家不死不休buff
		if not reSult then
			self:remveBuff(playerList1)
		end
	else
		fightType = FightBussinessType.Excise
		for _, activiPlayer in pairs(playerList1 or {}) do
			-- 判断玩家的生死状buff
			local pkInfo = activiPlayer:getPkInfo()
			local buffState = self:getPKBuffer(activiPlayer)
			pkInfo.hasBuff = buffState
			pkInfo.isAttacker = true
			pkInfo.isPK = false
			local hp = activiPlayer:getHP()
			local mp = activiPlayer:getMP()
			pkInfo.hp = hp
			pkInfo.mp = mp
		end
		
		for _, unactivePlayer in pairs(playerList2 or {}) do
			-- 判断玩家的生死状buff
			local pkInfo = unactivePlayer:getPkInfo()
			local buffState = self:getPKBuffer(unactivePlayer)
			pkInfo.hasBuff = buffState
			pkInfo.isAttacker = false
			pkInfo.isPK = false
			local hp = unactivePlayer:getHP()
			local mp = unactivePlayer:getMP()
			pkInfo.hp = hp
			pkInfo.mp = mp
		end
	end
	-- 如果有出战宠物要添加到战斗当中
	local roleList1 = {}
	local roleList2 = {}
	for _, role in pairs(playerList1 or {}) do
		table.insert(roleList1, role)
		local petID = role:getFollowPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			if pet then
				table.insert(roleList1, pet)
			end
		end
	end

	for _, role in pairs(playerList2 or {}) do
		table.insert(roleList2, role)
		local petID = role:getFollowPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			if pet then
				table.insert(roleList2, pet)
			end
		end
	end
	-- 拉玩家进入PK
	local fightID = g_fightMgr:startPvpFight(roleList1, roleList2, 2, fightType)
	if flag then
		fightIDs[fightID] = true
	end
end

-- 判断玩家的条件
function PKManager:checkPKCondition(player, tgPlayer)
	-- 判断目标玩家的状态 如果组队player一定是队长
	local teamHandler1 = player:getHandler(HandlerDef_Team)
	local teamHandler2 = tgPlayer:getHandler(HandlerDef_Team)
	local leaderID
	-- 判断玩家组队情况
	if teamHandler1:isTeam() then
		if teamHandler2:isTeam() then
			if teamHandler1:getTeamID() == teamHandler2:getTeamID() then
				print("您邀请的玩家和你同属一个队伍，不能发起PK")
				return 1
			else
				local teamID = teamHandler2:getTeamID()
				local team = g_teamMgr:getTeam(teamID)
				leaderID = team:getLeaderID()
			end
		end
	else
		if teamHandler2:isTeam() then
			local teamID = teamHandler2:getTeamID()
			local team = g_teamMgr:getTeam(teamID)
			leaderID = team:getLeaderID()
		end
	end

	-- 判断玩家的交易状态
	local state = player:getActionState()
	if state == PlayerStates.P2NTrade or state == PlayerStates.P2PTradeAndTeam or state == PlayerStates.P2PTrade then
		print("您现在正在忙，不能进行此项操作")
		return 2
	end
	-- 在检查状态时检测目标玩家队长的状态
	if leaderID then
		curtgPlayer = g_entityMgr:getPlayerByID(leaderID)
	else
		curtgPlayer = tgPlayer
	end
	local state = curtgPlayer:getActionState()
	if state == PlayerStates.P2NTrade or state == PlayerStates.P2PTradeAndTeam or state == PlayerStates.P2PTrade then
		print("目标正在忙，不能进行此项操作")
		return 3
	end

	-- 玩家是否是在战斗状态
	local fightState = curtgPlayer:getStatus()
	if fightState == ePlayerFight then
		print("目标玩家已在战斗中")
		return 4
	end
	
	-- 要分PK和强制PK
	local reSult = self:checkPKStyle(player, curtgPlayer)
	if reSult == PKStyle.ForcePK then
		--如果是强制PK，则加仇人
		local enemyInfo = {enemyDBID = player:getDBID(),enemyName = player:getName()}
		local event = Event.getEvent(FriendEvent_SB_AddPlayerToBlcaklistInEnemy,curtgPlayer:getDBID(),player:getDBID(),enemyInfo)
		g_eventMgr:fireWorldsEvent(event, SocialWorldID)

		-- 强制pk地图 有没有杀气，不死不休buff这些判断
		local forcePKValue = self:checkForcePK(player, curtgPlayer)
		if forcePKValue == 0 then
			-- 先判断所有玩家是否有杀气值
			if not self:getPlayerKillAir(player, curtgPlayer) then
				-- 可以进行强制PK呢-- 对主动玩家加杀气
				self:addPlayerKillAir(player)
			end
			self:setPK(player, curtgPlayer, true)
		else
			-- 强制PK不满足条件的提示消息
			return forcePKValue
		end
		
	elseif reSult == PKStyle.ComparePK then
		-- 切磋PK地图 要发消息给目标玩家
		local number = self:requestRecord(player, curtgPlayer)
		if number == 0 then
			local playerID = player:getID()
			local event = Event.getEvent(PK_SC_Request, playerID)
			g_eventMgr:fireRemoteEvent(event, curtgPlayer)
		else
			-- 发number消息
			return number
		end
	else
		-- 最后的提示消息根据reSult值来写
		return reSult
	end
end


-- 切磋PK记录玩家请求被被请求的信息
function PKManager:requestRecord(player, curtgPlayer)
	local playerList1 = {}
	local playerList2 = {}
	local playerID = player:getID()
	local tgPlayerID = curtgPlayer:getID()
	local pkInfo1 = player:getPkInfo()
	local pkInfo2 = curtgPlayer:getPkInfo()
	if pkInfo1 then
		local busyState1 = pkInfo1.busy
		if not busyState1 then
			if not pkInfo2.busy then
				pkInfo1.busy = true
				pkInfo2.busy = true
				self.requestList[tgPlayerID] = {}
				self.requestList[tgPlayerID].activiPlayerID = playerID
			else
				print("目标玩家正在忙，请稍后邀请")
				return 3
			end
		else
			print("您正在忙，不能邀请切磋PK")
			return 2
		end
	end
	return 0
end

-- 检测PK类型 和能否PK这个地方要做补充的
function PKManager:checkPKStyle(player, tgPlayer)
	local mapID1 = player:getScene():getMapID()
	local mapID2 = tgPlayer:getScene():getMapID()
	if mapID1 == mapID2 then
		-- 这里坐判断地图类型
		local mapConfig = mapDB[mapID1]
		local mapType = mapConfig.mapType
		if mapType == MapType.City then
			-- 切磋PK地图
			local compareArea = mapConfig.compareArea
			if compareArea then
				for _, value in pairs(compareArea or {}) do
					local pos = player:getPos()
					local tgPos = tgPlayer:getPos()
					if pos[2] <= value.x2 and pos[2] >= value.x1 and pos[3] <= value.y2 and pos[3] >= value.y1 then
						if tgPos[2] <= value.x2 and tgPos[2] >= value.x1 and tgPos[3] <= value.y2 and tgPos[3] >= value.y1 then
							return PKStyle.ComparePK
						else
							print("目标玩家不在切磋区域")
							return 5
						end
					else
						print("当前位置不能发起切磋PK")
						return 6
					end

				end
			else
				print("此地图发起切磋PK")
				return 7
			end
		elseif mapType == MapType.Wild then
			return PKStyle.ForcePK
		else
			print("此地图不能PK")
			return 8
		end
	else
		print("两玩家不在同一地图，不能邀请")
		return 9
	end
end

function PKManager:doInvitePK(player, tgPlayer)
	-- 组队的话tgPlayer是队长
	local reSult = self:checkPKCondition(player, tgPlayer)
	if reSult then
		-- 提示信息
		self:sendPKMessage(player, reSult)
	end
end

-- 玩家下线清理切磋PK请求列表
function PKManager:onPlayerCheckOut(player)
	local playerID = player:getID()
	-- 被邀请玩家下线
	local findID
	if self.requestList[playerID] then
		findID = self.requestList[playerID].activiPlayerID
		if findID then
			self.requestList[playerID] = nil
			local tgPlayer = g_entityMgr:getPlayerByID(findID)
			print("对方拒绝您的切磋PK邀请")
			self:sendPKMessage(tgPlayer, 10)
			-- 设置主动邀请PK玩家的状态
			if tgPlayer then
				local pkInfo = tgPlayer:getPkInfo()
				if pkInfo then
					pkInfo.busy = false
				end
			end
		end
	end
end

-- 对方玩家拒绝切磋PK roleID发起切磋PK玩家ID， tgPlayerID 是被邀请的玩家
function PKManager:doCancelPK(roleID, tgPlayerID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local tgPlayer = g_entityMgr:getPlayerByID(tgPlayerID)
	if not player then
		print("邀请PK的玩家下线")
		--self:sendPKMessage(tgPlayer, 14)
		return
	end
	-- 发邀请PK玩家在线
	local pkInfo1 = player:getPkInfo()
	local pkInfo2 = tgPlayer:getPkInfo()
	if pkInfo1.busy and pkInfo2.busy then
		pkInfo1.busy =false
		pkInfo2.busy =false
	end
	-- 发一个消息给发切磋PK的玩家
	local player = g_entityMgr:getPlayerByID(roleID)
	local tgPlayer = g_entityMgr:getPlayerByID(tgPlayerID)
	local tgName = tgPlayer:getName()
	if player then
		print("对方拒绝您的切磋PK邀请")
		self:sendPKMessage(player, 10)
	end
end

-- 玩家接受切磋PK roleID发起切磋PK玩家ID， tgPlayerID 是被邀请的玩家
function PKManager:doAcceptPK(roleID, tgPlayerID)
	-- 再就把当前玩家和目标玩家(组队就是队长)
	local player = g_entityMgr:getPlayerByID(roleID)
	local tgPlayer = g_entityMgr:getPlayerByID(tgPlayerID) 
	if not player then
		print("邀请的玩家下线")
		self:sendPKMessage(tgPlayer, 11)
		return
	end
	-- 设置每个玩家
	local pkInfo1 = player:getPkInfo()
	local pkInfo2 = tgPlayer:getPkInfo()
	pkInfo1.busy = false
	pkInfo2.busy = false
	self:setPK(player, tgPlayer, false)
end

-- 检测强制PK
function PKManager:checkForcePK(player, tgPlayer)
	local playerList1 = {}
	local playerList2 = {}
	local teamHandler1 = player:getHandler(HandlerDef_Team)
	local playerList 
	if teamHandler1:isTeam() then
		playerList1 = teamHandler1:getTeamPlayerList()
	else
		table.insert(playerList1, player)
	end

	-- 目标玩家做下判断
	local teamHandler2 = tgPlayer:getHandler(HandlerDef_Team)
	if teamHandler2:isTeam() then
		playerList2 = teamHandler2:getTeamPlayerList()
	else
		table.insert(playerList2, tgPlayer)
	end

	local reSult = self:getTgPlayerKillAir(playerList2)
	if reSult then
		-- 目标玩家都有杀气,邀请玩家不需要判断有没有不死不休buff，只需判断目标玩家等级
		if self:getPlayerMaxKillAir(playerList1) then
			print("当前玩家当中有最大杀气值，不能强制PK")
			return 12
		end

		if not self:getTgPlayerLevel(playerList2) then
			print("目标玩家等级低于20级，不能PK")
			return 13
		end

		-- 判断目标玩家有没有PK保护buff
		if self:getPKProtectBuffer(playerList2) then
			print("目标玩家有PK保护buff，不能邀请")
			return 14
		end
		-- 可以强制PK
		return 0
	else
		-- 此时邀请玩家都需要有不死不休buff，还要判断目标玩家等级 
		if not self:getPKUseBuffer(playerList1) then
			print("无不死不休buff，不能邀请PK")
			return 15
		end

		if self:getPlayerMaxKillAir(playerList1) then
			print("当前玩家当中有最大杀气值，不能强制PK")
			return 12
		end

		if not self:getTgPlayerLevel(playerList2) then
			print("目标玩家等级低于20级，不能PK")
			return 13
		end
		
		if self:getPKProtectBuffer(playerList2) then
			print("目标玩家有PK保护buff，不能邀请")
			return 14
		end
		-- 可以强制PK ,记录一下需要消掉buff
		return 0
	end
end

-- 如果被邀请有一个杀气值为0 则强制pK玩家需要生死状
function PKManager:getTgPlayerKillAir(playerList)
	-- 如果目标玩家都有杀气值
	for _, player in pairs(playerList or {}) do
		local killAir = player:getAttrValue(player_kill)
		if killAir <= 0 then
			return false
		end
	end
	-- 所有目标玩家都有杀气值
	return true 
end

-- 发起强制切磋PK玩家当中是否有杀气值为最大
function PKManager:getPlayerMaxKillAir(playerList)
	for _, player in pairs(playerList or {}) do
		local killAir = player:getAttrValue(player_kill)
		if killAir >= 15 then
			return true
		end 
	end
	return false
end

-- 获取目标玩家等级
function PKManager:getTgPlayerLevel(playerList)
	for _, player in pairs(playerList or {}) do
		if player:getLevel() < 20 then
			return false
		end
	end
	return true
end

-- 判断玩家是否有杀气值
function PKManager:getPlayerKillAir(player , tgPlayer)
	local playerList1 = {}
	local playerList2 = {}
	local teamHandler1 = player:getHandler(HandlerDef_Team)
	local playerList 
	if teamHandler1:isTeam() then
		playerList1 = teamHandler1:getTeamPlayerList()
	else
		table.insert(playerList1, player)
	end

	-- 目标玩家做下判断
	local teamHandler2 = tgPlayer:getHandler(HandlerDef_Team)
	if teamHandler2:isTeam() then
		playerList2 = teamHandler2:getTeamPlayerList()
	else
		table.insert(playerList2, tgPlayer)
	end

	for _, player1 in pairs(playerList1 or {}) do 
		local killAir = player1:getAttrValue(player_kill)
		if killAir <= 0 then
			return false
		end
	end

	for _, player2 in pairs(playerList2 or {}) do
		local killAir = player2:getAttrValue(player_kill)
		if killAir <= 0 then
			return false
		end
	end
	return true
end

-- 增加主动强制PK玩家的杀气
function PKManager:addPlayerKillAir(player)
	local playerList1 = {}
	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		playerList1 = teamHandler:getTeamPlayerList()
	else
		table.insert(playerList1, player)
	end
	for _, activePlayer in pairs(playerList1 or {}) do
		local killAir = activePlayer:getAttrValue(player_kill)
		if killAir < PlayerMaxKill then
			killAir = killAir + 1
			activePlayer:setAttrValue(player_kill, killAir)
		end
	end
end

function PKManager:sendPKMessage(player, msgID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_PK, msgID)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 强制PK保护buff判断只要有一个被邀请的队员有次buff，就不能被PK
function PKManager:getPKProtectBuffer(playerList)
	for _, player in pairs(playerList) do
		local buffHandler = player:getHandler(HandlerDef_Buff)
		local buff = buffHandler:findBuffByID(10011)
		if buff then
			return true
		end
	end
	return false
end

-- 主动强制PK获取主动PK玩家的不死不休buff, 每个队员都需要
function PKManager:getPKUseBuffer(playerList)
	for _, player in pairs(playerList or {}) do
		local buffHandler = player:getHandler(HandlerDef_Buff)
		local buff = buffHandler:findBuffByID(10009)
		if not buff then
			return false
		end
	end
	return true
end

-- 主动PK获取当前玩家是否有不死不休buff
function PKManager:getPKBuffer(player)
	local buffHandler = player:getHandler(HandlerDef_Buff)
	local buff = buffHandler:findBuffByID(10009)
	if buff then
		return true
	else
		return false
	end
end

-- 移除主动PK玩家身上的buff
function PKManager:remveBuff(playerList)
	for _, player in pairs(playerList or {}) do
		local buffHandler = player:getHandler(HandlerDef_Buff)
		if buffHandler then
			buffHandler:cancelBuff(10009)
		end
	end
end

function PKManager:onFightEnd(event)
	local params = event:getParams()
	local results = params[1]
	local fightID = params[4]
	if not fightIDs[fightID] then
		return
	end

	--fightIDs[fightID] = nil
	
	local bUnchanged = false
	for playerID, isWin in pairs(results) do

		local player = g_entityMgr:getPlayerByID(playerID)
		if player  and (not isWin) then
			local buffHandler = player:getHandler(HandlerDef_Buff)
			if buffHandler:getGodBless() then
				bUnchanged = true
				--g_buffMgr:onFightEndGodBless(player)
			end
		end
	end

	if bUnchanged then
		return
	end

	for playerID, isWin in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if player and (not isWin) and player:getHP() ==0 then
			--玩家死亡
			local mapID = WildRevivePoint.mapID
			local x = WildRevivePoint.x
			local y = WildRevivePoint.y
			g_sceneMgr:enterPublicScene(mapID, player, x, y)
		end
	end
end

function PKManager:onFightEndReset(event)
	local params = event:getParams()
	local results = params[1]
	local fightID = params[4]
	if not fightIDs[fightID] then
		return
	end

	fightIDs[fightID] = nil
	
	for playerID, isWin in pairs(results) do
		local player = g_entityMgr:getPlayerByID(playerID)
		if instanceof(player,Player) then
			local pkInfo = player:getPkInfo()
			if not pkInfo.isPK then
				player:setHP(pkInfo.hp)
				player:setMP(pkInfo.mp)
				player:flushPropBatch()
			end
			pkInfo.isPK = nil
		end
	end

end

function PKManager.getInstance()
	return PKManager()
end

g_eventMgr:addEventListener(PKManager.getInstance())