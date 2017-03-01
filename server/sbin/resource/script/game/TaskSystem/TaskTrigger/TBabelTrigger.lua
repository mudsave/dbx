--[[TBabelTrigger.lua
	通天塔任务触发器
--]]

function Triggers.challengeNpcTrace(roleID, param, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local config =
	{	
		taskID = task:getID(),
		npcID = param.npcID,
		mapID = param.mapID,
		x = param.x,
		y = param.y,
	}
	-- 这个主要是作为对话公共场景NPC对话的条件
	local privateHandler = player:getHandler(HandlerDef_TaskPrData)
	privateHandler:addTraceInfo(task:getID(), param.npcID)
	g_taskSystem:onSetDirect(player, config)
	-- 添加客户端匹配NPCID
	g_taskSystem:addMatchNpc(player, param.npcID)
end

--[[
function Triggers.talkNpcTrace(roleID, param, task, isRandom)
	local player = g_entityMgr:getPlayerByID(roleID)
	local config =
	{	
		taskID = task:getID(),
		npcID = param.npcID,
		mapID = param.mapID,
		x = param.x,
		y = param.y,
	}
	g_taskSystem:onSetDirect(player, config)
end
--]]