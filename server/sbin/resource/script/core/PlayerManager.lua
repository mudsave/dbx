--[[PlayerManager.lua
描述：
	player管理器
--]]

PlayerManager = class(nil, Singleton)

function PlayerManager:__init()
	self._players = {}
end

function PlayerManager:getPlayer(id)
	return self._players[dbId]
end

function PlayerManager:onPlayerMessage(hLink, msg)
	local msgId = msg.msgId
	if msgId == MSG_W_G_PLAYER_LOGIN then
		local pLoginInfo = tolua.cast(msg, "_MsgGW_PlayerLoginInfo")
		print(pLoginInfo.roleId,"begin Online")
		self:onPlayerLogin(hLink, pLoginInfo)
	elseif msgId == MSG_W_G_PLAYER_LOGOUT then
		local pLogoutInfo = tolua.cast(msg, "_MsgGW_PlayerLogoutInfo")
		print(pLogoutInfo.roleId,"begin Offline")
		self:onPlayerLogout(pLogoutInfo)
	else
		print("PlayerManager:onPeerMessage(), error msgId = ", msgId)
	end
end

function PlayerManager:onPlayerLogin(hGateLink, pLoginInfo)
	local roleId = pLoginInfo.roleId
	local gatewayId = pLoginInfo.gatewayId
	local hClientLink = pLoginInfo.hClientLink

	local player = g_entityFct:createPlayer(roleId, gatewayId, hClientLink, hGateLink)
	self._players[roleId] = player
	g_entityMgr:addPlayer(player)
	player:setStatus(ePlayerLoading)
	LuaDBAccess.loadPlayer(roleId, PlayerManager.onPlayerLoaded, roleId)
end

function PlayerManager:onPlayerLogout(pLogoutInfo)
	local roleId = pLogoutInfo.roleId
	local reason = pLogoutInfo.reason
	local player = self._players[roleId]
	self:doPlayerLogout(roleId, reason)
end

function PlayerManager.onPlayerLoaded(recordList, dbId)
	print(dbId,"begin load!")
	local player = g_playerMgr._players[dbId]
	if not player then
		print("[ERROR]PlayerManager.onPlayerLoaded(), error(no player), dbId = ", dbId)
		return
	end

	player:setStatus(ePlayerNormal)
	player:loadBasicDataFromDB(recordList)
	System.OnPlayerLoaded(player, recordList)
	
	g_world:send_MsgWG_PlayerLogin_ResultInfo(player._hGateLink, dbId, 0)
	local posInfo = player:getPos()
	local mapID = posInfo[1]
	local x = posInfo[2]
	local y = posInfo[3]
	local bValid = g_sceneMgr:isPosValidate(mapID, x, y)
	if not bValid then
		mapID =  RightPos4Error.mapID
		x = RightPos4Error.x
		y = RightPos4Error.y
	end
	g_sceneMgr:enterPublicScene(mapID, player, x, y)
	System.OnPlayerLogined(player)
	System.OnPlayerLoaded(player,recordList)
	print(dbId,"end load!",player._hGateLink)
end

-- 踢整个world所有用户下线
function PlayerManager:kickAllPlayer()
	g_world:send_MsgWG_WorldPlayersLogout_ResultInfo(g_serverId)
	for dbId,_ in pairs(self._players) do
		self:doPlayerLogout(dbId, LOGOUT_REASON_WORLD_KICK, true)
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
		g_world:send_MsgWG_PlayerLogout_ResultInfo(player._hGateLink, playerDBID, 0, reason)
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
	print(playerDBID,"end logout!")
	
end

function PlayerManager.getInstance()
	return PlayerManager()
end
