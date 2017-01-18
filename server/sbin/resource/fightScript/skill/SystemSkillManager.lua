--[[SystemSkillManager.lua
描述：
	
--]]

SystemSkillManager = class(nil, Singleton)

function SystemSkillManager:__init()
	self.skills = {}
end

function SystemSkillManager:__release()
	self.skills = {}
end

function SystemSkillManager:getSkill(skillID,skillLevel)
	if not self.skills[skillID] then
		self.skills[skillID] = SystemSkill(skillID,skillLevel)
	end
	return self.skills[skillID]
end

function SystemSkillManager.getInstance()
	return SystemSkillManager()
end