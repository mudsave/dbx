--[[appEntry.lua
描述：
	战斗服务器对应的脚本文件
--]]

package.path = "../resource/fightScript/?.lua;../../../share/lua/?.lua;../resource/common/?.lua;".. package.path
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
end

local function loadDB()
	require "constant.Constant"
	require "misc.constant"
	require "attribute.PlayerAttrDefine"
	require "attribute.PlayerAttrFormula"
	require "attribute.PetAttrDefine"
	require "attribute.PetAttrFormula"
	require "attribute.MonsterAttrDefine"
	require "attribute.MonsterAttrFormula"
	require "misc.PetConstant"

	require "data.MonsterDB"
	require "data.MonsterAttrDB"
	require "data.MonsterLvlAttrDB"
	require "data.NpcDB.NpcDB"
	require "data.PetDB"
	require "data.EquipDB.EquipmentDB"
	require "data.WarrantDB"
	require "data.MedicamentDB"
	require "data.BuffDB.FightingBuffDB"
	require "data.BuffDB.BuffEffectValueDB"
	
	require "data.SkillDB.MindDB"
	require "data.SkillDB.FightSkillDataDB"
	require "data.SkillDB.FightSkillDB"
	require "data.SkillDB.PetSkillDataDB"
	require "data.SkillDB.PetSkillDB"
	require "data.SkillDB.MonsterSkillDataDB"
	require "data.SkillDB.MonsterSkillDB"
	require "data.SkillDB.SystemSkillDB"
end

local function loadSystem()
	g_eventMgr				= EventManager.getInstance()
	g_timerMgr				= TimerManager.getInstance()

	require "FightSystem"
	require "buff.FightBuffManager"
	require "item.FightItemManager"
	require "chatSystem.ChatSystem"
		
	g_fightMgr 				= FightManager.getInstance()
	g_fightFactory			= FightFactory.getInstance()
	g_fightEntityFactory 	= FightEntityFactory.getInstance()
	g_fightEntityMgr 		= FightEntityManager.getInstance()
	g_SystemSkillMgr 		= SystemSkillManager.getInstance()
	g_fightBuffMgr			= FightBuffManager.getInstance()
	g_fightItemMgr			= FightItemManager.getInstance()
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
	loadDB()
	loadSystem()
	ManagedApp.State = ServerState.run
end

function ManagedApp.timerFired(timerID, state)
	if state == ScriptTimerNormal then
		g_timerMgr:update(timerID)
	else
		g_timerMgr:notify(timerID, state)
	end
end

function ManagedApp.close()
	print("Fight Server is closing!")
	ManagedApp.State = ServerState.stop
end

function ManagedApp.onReceive(...)
	return RemoteEventProxy.receive(...)
end

function ManagedApp.onWReceive(...)
	return RemoteEventProxy.wreceive(...)
end


-- lua出错处理接口
-- 可提供的功能
-- 1,直接返回错误信息,供C++层打印
-- 2,在该函数中重定向错误信息
function ManagedApp.onLuaError(errMsg)
	print(("%s\n%s"):format(tostring(errMsg),debug.traceback()))
end

ManagedApp.State = ServerState.load
