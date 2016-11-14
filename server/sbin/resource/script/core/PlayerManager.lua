--[[PlayerManager.lua
描述：
	player管理器
--]]

require "base.base"

PlayerManager = class(nil, Singleton)

function PlayerManager:__init()
	self._players = {}
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

function PlayerManager:onPlayerLogout(hGateLink, pLogoutInfo)
	local roleId = pLogoutInfo.roleId
	local reason = pLogoutInfo.reason
end

function PlayerManager.onPlayerLoaded(recordList, dbId)
	local player = self._players[dbId]
	if not player then
		printf(" PlayerManager.onPlayerLoaded(), error(no player), dbId = ", dbId)
	end

	--从recordList加载玩家信息
	--同步玩家信息到propset
	player:setStatus(eEntityNormal)
	--发送MSG_G_W_ACK_PLAYER_LOGIN到gateway
	--加入视野管理，同步信息到客户端
end

function PlayerManager.getInstance()
	return PlayerManager()
end