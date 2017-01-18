--[[appEntry.lua
描述：
	游戏的主服务器脚本
--]]

package.path = "../resource/script/?.lua;../../../share/lua/?.lua;../resource/common/?.lua;" .. package.path
print("package.path = ", package.path)

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
	g_playerMgr:onPlayerMessage(hLink, msg)
end

function ManagedApp.onTileChange(playerID)
	--print (playerID, " walking ...")
	local player = g_entityMgr:getPlayerByID(playerID)
	if player then
		local mapID, xPos, yPos = player:getCurPos()
		TaskCallBack.onEntityPosChanged(player:getID(), mapID, xPos, yPos)
		local mineHandler = player:getHandler(HandlerDef_Mine)
		mineHandler:onMove()
	end
end

function ManagedApp.close()
	print("Server is closing!")
	g_playerMgr:kickAllPlayer()
end
