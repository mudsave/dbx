--[[ConfCore.lua
描述�?
	核心脚本加载
--]]

require "base.base"
require "misc.constant"
require "core.TimerManager"

require "system"

require "EventDef"
require "event.Event"
require "event.EventSetDoer"
require "event.RemoteEventProxy"
require "event.EventManager"

require "core.LuaDBAccess"
require "core.PlayerManager"
require "scene.Scene"
require "scene.SceneManager"

require "entity.EntityFactory"
require "entity.EntityManager"
require "entity.Entity"
require "entity.FollowEntity"
require "entity.Player"
require "entity.Npc"
require "entity.MineNpc"

require "entity.handler.PacketHandler"
require "entity.handler.DepotHandler"
require "entity.handler.EquipHandler"
require "entity.handler.RideHandler"
require "entity.handler.TeamHandler"
require "entity.handler.FollowHandler"


function loadCore(serverID)
	g_serverId = serverID

	g_eventMgr = EventManager.getInstance()
	g_timerMgr = TimerManager.getInstance()
	g_playerMgr = PlayerManager.getInstance()
	g_sceneMgr = SceneManager.getInstance()

	g_entityFct = EntityFactory.getInstance()
	g_entityMgr = EntityManager.getInstance()
	
	math.randomseed(os.time())
	math.random()
end