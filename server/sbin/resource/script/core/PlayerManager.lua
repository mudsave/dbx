--[[PlayerManager.lua
描述：
	player管理器
--]]

PlayerManager = class(nil,Timer,Singleton)
local getPropValue = getPropValue
local setPropValue = setPropValue

--心跳定时器1分钟
local ePlayerOfflineInterval = 60
-- 起始玩家登录状态为false
local loadState = false

--掉线时间2分钟没收到心跳就设置为离线状态，离线超过3分钟，就下线
local ePlayerInactiveTimeout = 60*2
local ePlayerOfflineTimeout = 60*3

function PlayerManager:__init()
	self._players = {}
	self.checkPlayerOffline = g_timerMgr:regTimer(self, ePlayerOfflineInterval*1000,
		ePlayerOfflineInterval*1000, "PlayerManager中掉线玩家检测")
end

-- 定时器回调检测心跳
function PlayerManager:update(timerID)
	if timerID == self.checkPlayerOffline then
		local releasePlayers = {}
		for dbID,player in pairs(self._players or {}) do
			if not self:validatePlayer(player) then
				table.insert(releasePlayers,dbID,player)
			end
		end
		for dbID,player in pairs(releasePlayers or {}) do
			self:doPlayerLogout(dbID,LOGOUT_REASON_WORLD_HEART)
		end
		table.clear(releasePlayers)
	end
end

function PlayerManager:validatePlayer(player)
	local span = os.time() - player:getLastActive()
	if span >= ePlayerInactiveTimeout then
		local status = player:getStatus()
		if status < ePlayerInactive then
			System.onPlayerDettached(player)
			return true
		elseif span > ePlayerOfflineTimeout then
			return false
		end
	end
	return true
end

--设置最近心跳时间
function PlayerManager:doPlayerHeartBeat(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	player:setLastActive(os.time())
	local status = player:getStatus()
	if status == ePlayerInactive or ePlayerInactive == ePlayerInactiveFight then
		System.onPlayerReAttached(player)
	end
end

function PlayerManager:getPlayer(id)
	return self._players[dbId]
end

function PlayerManager:onPlayerMessage(hLink, msg)
	local msgId = msg.msgId
	if msgId == MSG_W_G_PLAYER_LOGIN then
		local pLoginInfo = tolua.cast(msg, "_MsgGW_PlayerLoginInfo")
		print(pLoginInfo.roleId,"begin Online")
		local player = self._players[pLoginInfo.roleId]
		if not player then
			self:onPlayerLogin(hLink, pLoginInfo)
		else
			self:onPlayerReLogin(hLink, pLoginInfo, player)
		end
	elseif msgId == MSG_W_G_PLAYER_LOGOUT then
		local pLogoutInfo = tolua.cast(msg, "_MsgGW_PlayerLogoutInfo")
		print(pLogoutInfo.roleId,"begin Offline")
		self:onPlayerLogout(pLogoutInfo.roleId,pLogoutInfo.reason)

	else
		print("PlayerManager:onPeerMessage(), error msgId = ", msgId)
	end
end

function PlayerManager:onPlayerLogin(hGateLink, pLoginInfo)
	local roleId = pLoginInfo.roleId
	local gatewayId = pLoginInfo.gatewayId
	local hClientLink = pLoginInfo.hClientLink
	local player = g_entityFct:createPlayer(roleId, gatewayId, hClientLink, hGateLink)
	player:setVersion(pLoginInfo.version)
	self._players[roleId] = player
	g_entityMgr:addPlayer(player)
	player:setStatus(ePlayerLoading)
	LuaDBAccess.loadPlayer(roleId, PlayerManager.onPlayerLoaded, roleId)
	-- 在加载服务器等级
	if loadState then
		local serverLevel = g_serverMgr:getServerLevel()
		player:setAttrValue(player_server_level, serverLevel)
		return 
	end
	self:loadServerRecord()
end

function PlayerManager:onPlayerReLogin(hGateLink, pLoginInfo, player)
	print(pLoginInfo.roleId,"begin ReOnline")
	local roleId = pLoginInfo.roleId
	local gatewayId = pLoginInfo.gatewayId
	local hClientLink = pLoginInfo.hClientLink
	local oldGateLink = player:getGateLink()
	player:setVersion(pLoginInfo.version)
	player:setGateLink(hGateLink)
	player:setClientLink(hClientLink)
	player:setGatewayID(gatewayId)
	g_world:send_MsgWG_PlayerLogin_ResultInfo(hGateLink, roleId, player:getVersion(), 0)
	if oldGateLink ~= hGateLink then
		g_world:send_MsgWG_PlayerLogout_ResultInfo(oldGateLink, roleId, player:getVersion(), 0, LOGOUT_REASON_RELOGIN_OTHER_GATE)
	end
	g_sceneMgr:reEnterScene(player)

	local status = player:getStatus()
	player:setLastActive(os.time())
	if status == ePlayerInactiveFight then
		player:setStatus(ePlayerFight)
		local accountID = player:getAccountID()
		g_world:send_MsgWS_ClearOffFightInfo(accountID, player:getVersion())

		System.onPlayerReloginBeforeFight(player)

		local fightServerID = player:getFightServerID()
		local event = Event.getEvent(FrameEvents_SS_playerOnLine, player:getDBID(),OnlineReason.Relogin,gatewayId,hClientLink)
		g_eventMgr:fireWorldsEvent(event,fightServerID)
	else
		player:setStatus(ePlayerNormal)
	end
	player:setIsFightClose(false)
	
	System.onPlayerReloginAfterFight(player)
	
	print(roleId,"end ReOnline")
end

function PlayerManager:onPlayerLogout(roleId,reason)
	local player = self._players[roleId]
	local gateLink = player:getGateLink()
	local state = player:getStatus()
	--处理战斗中强关客户端掉线
	if state == ePlayerFight and reason ~= LOGOUT_REASON_CLIENT_LITTLEBACK then
		g_world:send_MsgWG_OfflineInFight(gateLink, roleId, player:getVersion())
		player:setStatus(ePlayerInactiveFight)
		player:setIsFightClose(true)
		
		--local event = Event(FrameEvents_SS_playerDropLine, player:getID(), ePlayerInactiveFight)
		--g_eventMgr:fireEvent(event)
		System.onPlayerLogOutByForce(player)
		local fightServerID = player:getFightServerID()
		local event = Event.getEvent(FrameEvents_SS_playerDropLine, player:getDBID(), ePlayerInactiveFight)
		g_eventMgr:fireWorldsEvent(event,fightServerID)

		g_world:send_MsgWG_PlayerLogout_ResultInfo(gateLink, roleId, player:getVersion(), 0, reason)

		print(player:getDBID(),"begin fight offline")
		return
	--处理正常下线
	elseif state == ePlayerNormal then
		self:doPlayerLogout(roleId, reason)
	--处理没有心跳的战斗状态
	elseif state == ePlayerInactiveFight and  (not player:getIsFightClose())then
		player:setIsFightClose(true)
		g_world:send_MsgWG_PlayerLogout_ResultInfo(gateLink, roleId, player:getVersion(), 0, reason)
	end
	
end

function PlayerManager.onPlayerLoaded(recordList, dbId)
	print(dbId,"begin load!")
	local player = g_playerMgr._players[dbId]
	if not player then
		print("[ERROR]PlayerManager.onPlayerLoaded(), error(no player), dbId = ", dbId)
		return
	end
	player:setStatus(ePlayerNormal)
	player:setLastActive(os.time())
	player:setMaxPet(DefPetNum)
	player:loadBasicDataFromDB(recordList)
	g_world:send_MsgWG_PlayerLogin_ResultInfo(player._hGateLink, dbId, player:getVersion(), 0)

	local posInfo = player:getLoginPos()
	local mapID = posInfo[1]
	local x = posInfo[2]
	local y = posInfo[3]

	if mapID == -1 and x == -1 and y == -1 then
		mapID =  PlayerBornPos.mapID
		x = PlayerBornPos.x
		y = PlayerBornPos.y
	else
		local bValid = g_sceneMgr:isPosValidate(mapID, x, y)
		if not bValid then
			mapID =  RightPos4Error.mapID
			x = RightPos4Error.x
			y = RightPos4Error.y
		end
	end
	g_sceneMgr:enterPublicScene(mapID, player, x, y)
	System._LoadWorldServerData(player,recordList[24][1])
	System._LoadSocialServerData(player,recordList[26][1],recordList[39][1],recordList[40][1])
	System.OnPlayerLoaded(player, recordList)

	g_entityMgr:setPlayerName(player:getName(),dbId)
	-- 设置可接任务列表, 在帮派设置完毕之后
	g_taskDoer:loadCanRecetiveTask(player)
	player:markAllLoaded()
	print(dbId, "end load!", player._hGateLink)
end

-- 踢整个world所有用户下线
function PlayerManager:kickAllPlayer()
	g_world:send_MsgWG_WorldPlayersLogout_ResultInfo(g_serverId)
	for dbId,_ in pairs(self._players) do
		self:doPlayerLogout(dbId, LOGOUT_REASON_WORLD_KICK_ALL, true)
	end
end

-- 踢某个用户下线
function PlayerManager:kickOutPlayer(playerDBID)
	self:doPlayerLogout(playerDBID, LOGOUT_REASON_WORLD_KICK)
end

function PlayerManager:doPlayerLogout(playerDBID, reason, isAll)
	-- 发消息到gateway
	print(playerDBID,"begin logout!")
	local player = g_entityMgr:getPlayerByDBID(playerDBID)
	
	if not isAll then
		g_world:send_MsgWG_PlayerLogout_ResultInfo(player._hGateLink, playerDBID, player:getVersion(), 0, reason)
	end

	-- 相关信息存数据库
	player:onPlayerLogout(reason)
	System.OnPlayerLogout(player, reason)

	-- 退出场景
	local scene = player:getScene()
	scene:detachEntity(player)

	--销毁玩家
	self._players[playerDBID] = nil
	g_entityMgr:removePlayer(player:getID())
end

-- 首个玩家登录
function PlayerManager:loadServerRecord()
	if not loadState then
		loadState = true
		LuaDBAccess.loadServer(dataBaseServerID, ServerManager.onServerStart, g_serverMgr)
	end
end

function PlayerManager.getInstance()
	return PlayerManager()
end
