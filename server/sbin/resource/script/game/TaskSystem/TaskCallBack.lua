--[[TaskCallBack.lua
描述：
	其他系统通知任务系统(任务系统)
--]]

TaskCallBack = {}

function TaskCallBack.script(player, scriptID, isWin)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onScriptDone", scriptID, isWin)
	end
end

function TaskCallBack.onEntityPosChanged(roleID, mapID, x, y)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onPosChanged", mapID, x, y)
	end
end

function TaskCallBack.onLearnSkill(roleID, skillID, skillLevel)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onLearnDone", skillID, skillLevel)
	end
end

function TaskCallBack.onObtainPet(roleID, petID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onObtainPet", petID)
	end
end

function TaskCallBack.onBuyItem(roleID, itemID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onBuyItem", itemID)
	end
end

function TaskCallBack.onRemoveItem(roleID, itemID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onRemoveItem", itemID)
	end
end

function TaskCallBack.onCatchPet(roleID, petID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onCatchPet", petID)
	end
end

function TaskCallBack.onRemovePet(roleID, petID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onRemovePet", petID)
	end
end

function TaskCallBack.onContactSeal(roleID, sealID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onContactSeal", sealID)
	end
end

function TaskCallBack.onCommitEquip(roleID, subClass, equipClass, level, quality)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onCommitEquip", subClass, equipClass, level, quality)
	end
end

function TaskCallBack.onCommitItem(roleID, itemInfo)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onCommitItem", itemInfo)
	end
end

function TaskCallBack.onPaidItem(roleID, itemGuid, itemNum)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onPaidItem", itemGuid, itemNum)
	end
end

-- 宠物ID在任务目标当中去找
function TaskCallBack.onPaidPet(roleID, taskID, petID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onPaidPet", taskID, petID)
	end
end

function TaskCallBack.onAddItem(roleID, itemID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onAddItem", itemID)
	end
end

-- 等级目标
function TaskCallBack.onAttainLevel(roleID, level)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onAttainLevel", level)
	end
end

-- 对话添加尾随NPC
function TaskCallBack.onAddFollowNpc(roleID, followNpcID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onAddFollowNpc", followNpcID)
	end
end

-- 上装
function TaskCallBack.onWearEquip(roleID, equipID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onWearEquip", equipID)
	end
end

-- 下装
function TaskCallBack.onDownEquip(roleID, equipID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onDownEquip", equipID)
	end
end

--采集物品
function TaskCallBack.onCollectItem(roleID, itemInfo)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onCollectItem", itemInfo)
	end
end

-- 指引任务
function TaskCallBack.onGuideTask(player,taskID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onGuideTask",taskID)
	end
end

-- 加入帮派
function TaskCallBack.onjoinFaction(player,flag)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onjoinFaction",flag)
	end
end

--上坐骑
function TaskCallBack.onUpRide(player, rideID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onUpRide", rideID)
	end
end

--野外杀怪
function TaskCallBack.onKillMonster(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	local eventHandler = player:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:notifyWatchers("onKillMonster")
	end
end