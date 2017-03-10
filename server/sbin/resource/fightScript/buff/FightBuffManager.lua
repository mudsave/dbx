--[[FightBuffManager.lua
描述:
	战斗内Buff管理
]]
require "buff.Buff"

FightBuffManager = class(nil, Singleton)

function FightBuffManager:__init()
end

function FightBuffManager:__release()
end

-- 管理添加buff
function FightBuffManager:addBuff(srcEntity, desEntity, buffID, skillLevel)
	print("添加buff:buffID, skillLevel", buffID, skillLevel)
	local handler = desEntity:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	local buff = Buff(buffID, desEntity, srcEntity, skillLevel)
	if handler:addBuff(buff) then
		return true
	end
	Flog:log("添加buff失败,检查是否有限制的状态\n")
	print("添加buff失败,检查是否有限制的状态")
	return false
end

-- 执行动作前结算buff
function FightBuffManager:onRoundStart(entity)
	local handler = entity:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	handler:onRoundStartCalc()
	if (table.size((handler:getClearBuffLightList())) > 0) then
		print("--- 执行动作前结算dot clear buff --- roleid="..entity:getID(), toString(handler.clearBuffLightList) )
	end
	for _,iter in pairs(handler:getClearBuffLightList()) do
		self:sendRemoveBuff(entity, iter)
	end
	-- 清空清除链表
	handler:setClearBuffListNil()
end

-- 回合结束结算buff持续值
function FightBuffManager:onRoundEnd(entity)
	local handler = entity:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	handler:calc()
	if (table.size((handler:getClearBuffLightList())) > 0) then
		print ("--- 回合结束结算 clear buff --- roleid="..entity:getID(), toString(handler:getClearBuffLightList()) )
	end
	for _,iter in pairs(handler:getClearBuffLightList()) do
		self:sendRemoveBuff(entity, iter)
	end
	-- 清空清除链表
	handler:setClearBuffListNil()
end

-- 战斗结束清除所有的buff
function FightBuffManager:onFightEnd(entity)
	local handler = entity:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	-- 清除所有的buff
	handler:doFightEndClearAllBuff()
end

-- 死亡时清除buff
function FightBuffManager:onDeadClearBuff(entity)
	local handler = entity:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	handler:doDeadClearBuff()
end

-- 清除增益buff
function FightBuffManager:onClearAddBuff(entity)
	local handler = entity:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	handler:doClearAddBuff()
end

-- 清除减益buff
function FightBuffManager:onClearDeBuff(entity)
	local handler = entity:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	handler:doClearDeBuff()
end

-- 添加buff发消息到客户端删除光效
function FightBuffManager:sendRemoveBuff(entity, buffID)
	local fightID = entity:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	local fightMembers = fight:getMembers()
	for side,poses in pairs(fightMembers) do
		for _,role in pairs(poses) do
			if instanceof(role,FightPlayer) then
				local event = Event.getEvent(BuffEvents_FC_RemoveBuff, entity:getID(), buffID)
				g_eventMgr:fireRemoteEvent(event, role)
			end
		end
	end
end

-- 根据buffID移除buff
function FightBuffManager:doRemoveBuffByID(entity, buffID)
	local handler = entity:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	if handler:doRemoveBuffByID(buffID) then
		return true
	end
	return false
end

function FightBuffManager.getInstance()
	return FightBuffManager()
end