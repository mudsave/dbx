--[[MonsterSkillHandler.lua
	描述：
--]]

MonsterSkillHandler = class()

function MonsterSkillHandler:__init( role )
	self.role = role
	self.skills = {}
	
	self:initSkills()
end

function MonsterSkillHandler:__release()
	self.role = nil
	self.skills = nil
end

--[[
	初始化技能
]]
function MonsterSkillHandler:initSkills()
	local skills = self:getSkills()
	local skill = nil
	local level = self.role:getLevel()
	for _,id in pairs(skills) do
		skill = MonsterSkill(self.role, id, level)
		table.insert(self.skills, id, skill)
	end
	-- print("怪物拥有的技能：", toString(self.skills))
end

--[[
	获得一个技能
]]
function MonsterSkillHandler:getSkill(skillID)
	return self.skills and self.skills[skillID]
end

--[[
	获得怪物配置的技能
]]
function MonsterSkillHandler:getSkills()
	local dbid = self.role:getDBID()
	local monInfo = MonsterDB[dbid] or NpcDB[dbid]
	if monInfo then
		return monInfo.skillCfg or {}
	end
end

--复活
function MonsterSkillHandler:useRevival()
	return nil
end

