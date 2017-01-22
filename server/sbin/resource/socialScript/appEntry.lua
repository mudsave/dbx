--[[appEntry.lua
描述：
	社会服对应的脚本文件
--]]

package.path = "../resource/socialScript/?.lua;../../../share/lua/?.lua;".. package.path
print("[Lua] package.path = ", package.path)


local function loadCore()
	require "base.base"
	require "EventDef"
	require "EventConstant"
	require "event.Event"
	require "event.EventSetDoer"
	require "event.RemoteEventProxy"
	require "event.EventManager"
	require "core.TimerManager"
	require "core.LuaDBAccess"

	g_eventMgr	= EventManager.getInstance()
	g_timerMgr	= TimerManager.getInstance()

end

local function loadSystem()
	require "SocialSystem"
	require "FriendSystem.FriendSystem"
	require "GroupSystem.GroupSystem"
	require "FactionSystem.FactionSystem"
	require "BroadCastSystem.BroadCastSystem"
	require "EncodeSystem.EncodeSysMgr"
	require "SelfProtectionSystem.SelfProtectionMgr"
	require "SystemSetSystem.SystemSetSystem"
	require "entity.SocialEntityManager"

	g_groupSysMgr 			= GroupSysMgr.getInstance()
	g_factionSysMgr			= FactionSysMgr.getInstance()
	g_friendSysMgr 			= FriendSysMgr.getInstance()
	g_playerfactory 		= PlayerFactory.getInstance()
	g_playerMgr 			= PlayerManager.getInstance()
	g_socialEntityManager 	= SocialEntityManager.getInstance()
	g_selfProtectionMgr 	= SelfProtectionMgr.getInstance()
	g_encodeSysMgr 			= EncodeSysMgr.getInstance()
	g_chatMgr 				= ChatManager.getInstance()
	g_systemSetMgr			= SystemSetSysMgr.getInstance()

end

ServerState = 
{
	load	= 1, --加载完脚本文件
	run		= 2, --脚本已启动
	stop	= 3, --脚本已停止
}

ManagedApp = {}

function ManagedApp.start(serverId)
	g_serverId	= serverId
	math.randomseed(os.time())
	math.random()
	loadCore()
	loadSystem()
	ManagedApp.State = ServerState.run
end

function ManagedApp.onExeSP(operationID, recordList, errorCode)
	LuaDBAccess.onExeSP(operationID, recordList, errorCode)
end

function ManagedApp.close()
	print("Social Server is closing!")
	ManagedApp.State = ServerState.stop
end

ManagedApp.State = ServerState.load
