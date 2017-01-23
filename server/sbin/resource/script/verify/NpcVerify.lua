--[[NpcVerify.lua
	npc检测条件
]]

NpcVerify = class(nil, Singleton)

function NpcVerify:__init()
	
end

function NpcVerify:CheckOwner(player, param, npcID)
	local npc = g_entityMgr:getNpc(npcID)
	local ownerNpc = g_entityMgr:getBossTaskEntityByID(player:getDBID(),param.taskID)
	if npc ~= ownerNpc then
		return false,  param.errorID and param.errorID or 21
	end
	return true
end

function NpcVerify.getInstance()
	return NpcVerify()
end