--[[ConfCore.lua
描述:
	核心脚本加载
--]]

require "base.base"
require "constant.Constant"
require "misc.constant"
require "core.TimerManager"

require "system"

require "EventDef"
require "EventConstant"
require "event.Event"
require "event.EventSetDoer"
require "event.RemoteEventProxy"
require "event.EventManager"

require "core.FightServerLoad"
require "core.LuaDBAccess"
require "core.PlayerManager"
require "core.PeriodChecker"

require "scene.Scene"
require "scene.SceneManager"

require "verify.Verify"

require "entity.EntityFactory"
require "entity.EntityManager"
require "entity.Entity"
require "entity.FollowEntity"
require "entity.Player"
require "entity.Npc"
require "entity.Pet"
require "entity.MineNpc"
require "entity.GoodsNpc"
require "entity.PatrolNpc"
require "entity.EctypeObject"

require "entity.handler.MoveHandler"
require "entity.handler.EventHandler"
require "entity.handler.PacketHandler"
require "entity.handler.DepotHandler"
require "entity.handler.ShelfHandler"
require "entity.handler.RideHandler"
require "entity.handler.EquipHandler"
require "entity.handler.TeamHandler"
require "entity.handler.FollowHandler"
require "entity.handler.PetHandler"
require "entity.handler.TaskHandler"
require "entity.handler.DialogHandler"
require "entity.handler.TaskPrivateHandler"
require "entity.handler.EctypeHandler"
require "entity.handler.TransportationHandler"

require "entity.handler.LifeSkillHandler"
require "entity.handler.TreasureHandler"
require "entity.handler.PractiseHandler"
require "entity.handler.PetDepotHandler"
require "entity.handler.ExperienceHandler"
require "entity.handler.BuffHandler"
require "entity.handler.MindHandler"
require "entity.handler.SystemSetHandler"
require "entity.handler.MineHandler"
require "entity.handler.PetSkillHandler"
require "entity.handler.AutoPointHandler"

--add utils relation script
require "utils.TileUtils"

function loadCore(serverID)
	g_serverId = serverID

	g_fightServerLoad = FightServerLoad.getInstance()
	g_eventMgr = EventManager.getInstance()
	g_timerMgr = TimerManager.getInstance()
	g_playerMgr = PlayerManager.getInstance()
	g_sceneMgr = SceneManager.getInstance()

	g_entityFct = EntityFactory.getInstance()
	g_entityMgr = EntityManager.getInstance()

	math.randomseed(os.time())
	math.random()
end
