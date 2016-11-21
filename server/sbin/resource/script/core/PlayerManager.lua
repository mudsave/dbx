--[[PlayerManager.lua
√Ë ˆ£∫
	playerπ‹¿Ì∆˜
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
		self:onPlayerLogin(hLink, pLoginInfo)
	elseif msgId == MSG_W_G_PLAYER_LOGOUT then
		local pLogoutInfo = tolua.cast(msg, "_MsgGW_PlayerLogoutInfo")
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
	LuaDBAccess.loadPlayer(dbId, PlayerManager.onPlayerLoaded, dbId)
end

function PlayerManager:onPlayerLogout(pLogoutInfo)
	local roleId = pLogoutInfo.roleId
	local reason = pLogoutInfo.reason
	self._players[roleId] = nil
	local player = g_entityMgr:getPlayerByDBID(roleId)
	g_entityMgr:removePlayer(player:getID())
end

function PlayerManager.onPlayerLoaded(recordList, dbId)
	local player = g_playerMgr:getPlayer(dbId)
	if not player then
		print("[ERROR]PlayerManager.onPlayerLoaded(), error(no player), dbId = ", dbId)
		return
	end

	player:loadBasicData(recordList)
	player:setStatus(eEntityNormal)
	g_world:send_MsgWG_PlayerLogin_ResultInfo(player._hGateLink, dbId, 1)
	g_sceneMgr:enterPublicScene()
	System.OnPlayerLogined()
end

function PlayerManager.getInstance()
	return PlayerManager()
end