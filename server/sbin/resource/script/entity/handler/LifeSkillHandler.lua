--[[LifeSkillHandler.lua
    描述：
        实体的生活技Handler
--]]  
require "misc.LifeSkillConstant"
LifeSkillHandler = class ()

function LifeSkillHandler:__init(entity)
    self._entity = entity
	self.lifeSkills = {}
    self.lifeSkills[LifeSkillID.castArmLev] = 0
	self.lifeSkills[LifeSkillID.tailorLev] = 0
	self.lifeSkills[LifeSkillID.gemLev] = 0
	self.lifeSkills[LifeSkillID.cookLev] = 0
	self.lifeSkills[LifeSkillID.makeDruagLev] = 0
	self.lifeSkills[LifeSkillID.refineLev] = 0
	self.lifeSkills[LifeSkillID.reconLev] = 0
	self.lifeSkills[LifeSkillID.catchLev] = 0
end

function LifeSkillHandler:__release()
	self._entity = nil
	self.lifeSkills = nil
end

-- 设置数据库的数据
function LifeSkillHandler:setlifeSkills(lifeSkillsRecord)
	for _, lifeSkillsData in pairs(lifeSkillsRecord or {}) do
		local LifeSkillID = lifeSkillsData.lifeSkillID
		local level = lifeSkillsData.level
		self.lifeSkills[LifeSkillID] = level
	end
end

-- 获取玩家的技能属性值
function LifeSkillHandler:getLifeSkills()
	return self.lifeSkills
end

-- 获取对应技能ID对应的等级
function LifeSkillHandler:getLifeSkillLev(LifeSkillID)
	return self.lifeSkills[LifeSkillID] 
end

-- 设置玩家对应技能ID对应的等级
function LifeSkillHandler:setLifeSkillLev(LifeSkillID, level)
	self.lifeSkills[LifeSkillID] = level
end

-- 保存玩家生活技能数据
function LifeSkillHandler:saveLifeSkills()
	local playerDBID = self._entity:getDBID()
	for LifeSkillID,skillLevel in pairs(self.lifeSkills) do
		LuaDBAccess.updatePlayerLifeSkill(playerDBID, LifeSkillID, skillLevel)
	end
end