--[[ExperienceHandler.lua
	历练技能ID对应的等级
	描述：实体的历练handler
--]]
ExperienceHandler = class()

function ExperienceHandler:__init(entity)
	self._entity = entity
	self.experience = {}

	self.experience[ExpSkilID.attackLev] = 0
	self.experience[ExpSkilID.defenseLev] = 0
	self.experience[ExpSkilID.criticalLev] = 0
	self.experience[ExpSkilID.intifadaLev] = 0
	self.experience[ExpSkilID.speedLev] = 0
	self.experience[ExpSkilID.hitLev] = 0
	self.experience[ExpSkilID.dodgeLev] = 0
	self.experience[ExpSkilID.biphasicLev] = 0
end

function ExperienceHandler:__release()
	self._entity = nil
	self.experience = nil
end

-- 设置数据库的数据
function ExperienceHandler:setExperience(experienceRecord)
	for _, experienceData in pairs(experienceRecord or {}) do 
		local expSkillID = experienceData.expSkillID
		local level = experienceData.level
		self.experience[expSkillID] = level
	end
end

-- 获取玩家的属性值
function ExperienceHandler:getExperience()
	return self.experience
end

-- 获取对应技能ID对应的等级
function ExperienceHandler:getExpSkillLev(expSkillID)
	return self.experience[expSkillID]
end

-- 设置玩家对应技能ID对应的等级
function ExperienceHandler:setExpSkillLev(expSkillID, level)
	self.experience[expSkillID] = level
end

-- 保存玩家数据
function ExperienceHandler:saveExperience()
	local playerDBID = self._entity:getDBID()
	for expSkillID,expLevel in pairs(self.experience) do
		LuaDBAccess.updatePlayerExperience(playerDBID, expSkillID, expLevel)
	end
end