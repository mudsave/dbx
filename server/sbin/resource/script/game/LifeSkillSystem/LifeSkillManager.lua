--[[LifeSkillManager.lua
	描述：生活技能管理类
--]]

LifeSkillManager = class(nil, Singleton)

function LifeSkillManager:__init()

end

function LifeSkillManager:__release()

end

--加载数据库的类容
function LifeSkillManager:loadLifeSkill(player, lifeSkillRecord)
	local lifeSkillHandler = player:getHandler(HandlerDef_LifeSkill)
	lifeSkillHandler:setlifeSkills(lifeSkillRecord)
	self:setLifeSkill(player)
end  

 -- 设置玩家的生活技能数据
function LifeSkillManager:setLifeSkill(player)
	local lifeSkillHandler = player:getHandler(HandlerDef_LifeSkill)
	local lifeSkill = lifeSkillHandler:getLifeSkills()	
	--把玩家生活技能等级表发送到客户端
	local event = Event.getEvent(LifeSkillEvent_SC_SendLevel, lifeSkill)
	g_eventMgr:fireRemoteEvent(event, player)
end

--玩家下线时保存生活技能数据等级
function LifeSkillManager:saveLifeSkillData(player)
	local lifeSkillHandler = player:getHandler(HandlerDef_LifeSkill)
	if not lifeSkillHandler then
		return
	end
	lifeSkillHandler:saveLifeSkills()
end

function LifeSkillManager.getInstance()
	return LifeSkillManager()
end