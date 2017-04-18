--[[BuffManager.lua
描述:
	Buff管理
]]

BuffManager = class(nil, Singleton)

function BuffManager:__init()
end

function BuffManager:__release()
end

-- 加buff
function BuffManager:addBuff(desEntity, buffID)
	local handler = desEntity:getHandler(HandlerDef_Buff)
	local buff = Buff(buffID, desEntity)
	return handler:addBuff(buff)
end

-- 手动取消buff
function BuffManager:cancelBuff(player, buffID)
	local handler = player:getHandler(HandlerDef_Buff)
	return handler:cancelBuffByFlag(buffID)
end

-- 战斗结束
function BuffManager:onFightEnd(desEntity)
	if instanceof(desEntity, Player) then
		local handler = desEntity:getHandler(HandlerDef_Buff)
		print ("  $$  onFightEnd", desEntity:getHP(), desEntity:getMP())
		handler:useHpPool(desEntity)
		handler:useMpPool(desEntity)
		desEntity:flushPropBatch()	
	end
	if instanceof(desEntity, Pet) then
		print ("  $$  onFightEnd Pet", desEntity:getHP(), desEntity:getMP())
		local playerID = desEntity:getOwnerID()
		local player = g_entityMgr:getPlayerByID(playerID)
		local handler = player:getHandler(HandlerDef_Buff)
		handler:useHpPool(desEntity)
		handler:useMpPool(desEntity)
		handler:useLoyaltyPool(desEntity)
		desEntity:flushPropBatch()
	end
end

-- 使用护心丹
function BuffManager:onFightEndGodBless(desEntity)
	local handler = desEntity:getHandler(HandlerDef_Buff)
	return handler:useGodBless()
end

-- 从数据库加载buff
function BuffManager:loadPlayerBuffFromDB(player, buffsRecord)
	--print ("  $$  loadPlayerBuffFromDB", toString(buffsRecord))
	if not buffsRecord then
		return false
	end
	local handler = player:getHandler(HandlerDef_Buff)
	return handler:loadBuff(buffsRecord)
end

-- 更新数据库
function BuffManager:updateRoleBuff(entity)
	print ("  $$  updateRoleBuff")
	local handler = entity:getHandler(HandlerDef_Buff)
	return handler:saveBuff()
end

function BuffManager.getInstance()
	return BuffManager()
end