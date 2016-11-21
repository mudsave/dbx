--[[ConfCore.lua
ÃèÊö£º
	ºËĞÄ½Å±¾¼ÓÔØ
--]]

require "base.base"
require "misc.constant"

require "core.LuaDBAccess"
require "core.PlayerManager"
require "core.TimerManager"

require "scene.Scene"
require "scene.SceneManager"

require "entity.EntityFactory"
require "entity.EntityManager"
require "entity.Entity"
require "entity.Player"
require "entity.Npc"
require "entity.MineNpc"


function loadCore(serverID)
	g_serverId = serverID

	g_timerMgr = TimerManager.getInstance()
	g_playerMgr = PlayerManager.getInstance()
	g_SceneMgr = SceneManager.getInstance()

	g_entityFct = EntityFactory.getInstance()
	g_entityMgr = EntityManager.getInstance()

	math.randomseed(os.time())
	math.random()
end