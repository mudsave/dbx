--[[PKSystem.lua
描述：
	PK系统消息的接受
--]]

require "game.PKSystem.PKManager"

PKSystem = class(EventSetDoer, Singleton)

function PKSystem:__init()
	self._doer = {
		-- 邀请玩家进行pk
		[PK_CS_Invite]			= PKSystem.doInvitePK,
		-- 玩家拒绝切磋PK
		[PK_CS_Cancel]			= PKSystem.doCancelPK,
		-- 玩家接受切磋PK
		[PK_CS_Accept]			= PKSystem.doAcceptPK,
	}  
end

function PKSystem:doInvitePK(event)
	local roleID = event.playerID
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end
	local params = event:getParams()
	local targetID = params[1]
	local tgPlayer = g_entityMgr:getPlayerByID(targetID)
	if not tgPlayer then
		return
	end
	--玩家首次点击PK
	g_PKMgr:doInvitePK(player, tgPlayer)
end

-- 对方玩家拒绝切磋PK
function PKSystem:doCancelPK(event)
	local params = event:getParams()
	local roleID = params[1]
	local tgPlayerID = params[2]
	g_PKMgr:doCancelPK(tgPlayerID, roleID)
end

-- 玩家同意接受PK
function PKSystem:doAcceptPK(event)
	local params = event:getParams()
	local roleID = params[1]
	local tgPlayerID = params[2]
	g_PKMgr:doAcceptPK(tgPlayerID, roleID)
end

function PKSystem.getInstance()
	return PKSystem()
end

g_eventMgr:addEventListener(PKSystem.getInstance())