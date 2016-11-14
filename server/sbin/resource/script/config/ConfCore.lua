--[[ConfCore.lua
ÃèÊö£º
	ºËĞÄ½Å±¾¼ÓÔØ
--]]

require "base.base"

require "core.LuaDBAccess"
require "core.PlayerManager"
require "core.TimerManager"

require "entity.Entity"
require "entity.Player"
require "entity.EntityFactory"
require "entity.EntityManager"

function LoadCore(serverID)
	math.randomseed(os.time())
	math.random()

	g_serverId = serverID

	g_timerMgr	= TimerManager.getInstance()
	g_playerMgr = PlayerManager.getInstance()

	g_entityFct = EntityFactory.getInstance()
	g_entityMgr = EntityManager.getInstance()
end