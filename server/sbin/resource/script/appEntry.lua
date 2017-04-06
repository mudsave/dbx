--[[appEntry.lua
描述：
	游戏的主服务器脚本
--]]

package.path = "../resource/script/?.lua;../../../share/lua/?.lua;../resource/common/?.lua;" .. package.path
print("package.path = ", package.path)

ServerState = 
{
	load	= 1, --加载完脚本文件
	run		= 2, --脚本已启动
	stop	= 3, --脚本已停止
}

ManagedApp = {}

function ManagedApp.start(serverID)
	require "prop.UnitProp"
	require "prop.PlayerProp"
	require "prop.PetProp"
	require "prop.NpcProp"
	require "config.ConfCore"
	require "config.ConfDB"
	require "config.ConfSystem"
	loadCore(serverID)
	loadSystem()
	g_sceneMgr:loadPublicScenes()
	g_sceneMgr:loadSystemByScene()
	ManagedApp.State = ServerState.run
end

function ManagedApp.timerFired(timerID, state)
	if state == ScriptTimerNormal then
		g_timerMgr:update(timerID)
	else
		g_timerMgr:notify(timerID, state)
	end
end

function ManagedApp.onExeSP(operationID, recordList, errorCode)
	LuaDBAccess.onExeSP(operationID, recordList, errorCode)
end

function ManagedApp.EntityStartMove(entityId)
	if ManagedApp.State ~= ServerState.run then
		return
	end
	local entity = g_entityMgr:getPlayerByID(entityId) or g_entityMgr:getPet(entityId)
	--是玩家
	if entity then
		local moveHandler = entity:getHandler(HandlerDef_Move)
		moveHandler:SetIsInMove(true)
		local event = Event.getEvent(MoveEvent_SS_OnStartMove,entityId)
		g_eventMgr:fireEvent(event)
	end
end

function ManagedApp.EntityEndMove(entityId)
	if ManagedApp.State ~= ServerState.run then
		return
	end
	local entity = g_entityMgr:getPlayerByID(entityId) or g_entityMgr:getPet(entityId) or g_entityMgr:getPatrolNpc(entityId)
	--是玩家, 宠物， 巡逻NPC
	if entity then
		local moveHandler = entity:getHandler(HandlerDef_Move)
		moveHandler:SetIsInMove(false)
		local event = Event.getEvent(MoveEvent_SS_OnStopMove,entityId)
		g_eventMgr:fireEvent(event)
	end
end

function ManagedApp.onPlayerMessage(hLink, msg)
	if ManagedApp.State ~= ServerState.run then
		return
	end
	g_playerMgr:onPlayerMessage(hLink, msg)
end

function ManagedApp.onTileChange(playerID)
	if ManagedApp.State ~= ServerState.run then
		return
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if player then
		local mapID, xPos, yPos = player:getCurPos()
		TaskCallBack.onEntityPosChanged(player:getID(), mapID, xPos, yPos)
		local mineHandler = player:getHandler(HandlerDef_Mine)
		mineHandler:onMove()
	end
end

function ManagedApp.onReceive(...)
	return RemoteEventProxy.receive(...)
end

function ManagedApp.onWReceive(...)
	return RemoteEventProxy.wreceive(...)
end

function ManagedApp.onAReceive(...)
	return RemoteEventProxy.areceive(...)
end

-- lua出错处理接口
-- 可提供的功能
-- 1,直接返回错误信息,供C++层打印
-- 2,在该函数中重定向错误信息
function ManagedApp.onLuaError(errMsg)
	print(("%s\n%s"):format(tostring(errMsg),debug.traceback()))
end

function ManagedApp.close()
	print("World Server is closing!")
	g_serverMgr:saveServerData()
	g_playerMgr:kickAllPlayer()
	ManagedApp.State = ServerState.stop
end

ManagedApp.State = ServerState.load
