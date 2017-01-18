--[[ExperienceManager.lua
	描述：历练管理类
--]]

ExperienceManager = class(nil, Singleton)

function ExperienceManager:__init()
end

function ExperienceManager:__release()
end

--加载数据库的类容
function ExperienceManager:loadExperience(player, experienceRecord)
	local experienceHandler = player:getHandler(HandlerDef_Experience)
	experienceHandler:setExperience(experienceRecord)
	self:setExperience(player)
end

-- @TestOnly
local __unsupport_add_inc = {
	[player_add_max_hp] = true,
	[player_inc_max_hp] = true,
	[player_add_max_mp] = true,
	[player_inc_max_mp] = true,
}

-- 设置玩家的历练属性数据
function ExperienceManager:setExperience(player)
	local experienceHandler = player:getHandler(HandlerDef_Experience)
	local experience = experienceHandler:getExperience()
	for expSkillID, expSkillLev in pairs(experience or {}) do 
		local expDBInfo = ExperienceDB[expSkillID]
		local effect = expDBInfo.effect
		local value = effect[expSkillLev]
		local attrType = expDBInfo.attrType
		if value then
			player:addAttrValue(attrType, value)
		end
	end
	player:flushPropBatch()
	--把玩家历练等级表发送到客户端
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(Experience_SC_SendLevel, experience), player
	)
end

--玩家下线时保存历练数据等级
function ExperienceManager:saveExperienceData(player)
	local experienceHandler = player:getHandler(HandlerDef_Experience)
	if not experienceHandler then
		return
	end
	experienceHandler:saveExperience()
end

function ExperienceManager.getInstance()
	return ExperienceManager()
end