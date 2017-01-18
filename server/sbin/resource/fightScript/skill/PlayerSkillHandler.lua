--[[PlayerSkillHandler.lua
	描述：
--]]

SkillHandler = class()

function SkillHandler:__init( role )
	self.role		= role
	self.minds		= {}
	self.skills		= {}
	
	self:initMinds()
	self:initSkills()

	self.revivalTimes = 0		--复活次数
end

function SkillHandler:__release()
	self.role = nil
	self.minds = nil
	self.skills = nil	
	
	self.revivalTimes = nil
end

--[[
	初始化心法
]]
function SkillHandler:initMinds()
	-- temp = {[心法ID] = 心法等级, ... }
	local temp = self.role:getMinds()
	local mind = nil
	for mindID, level in pairs(temp) do
		mind = Mind(self, self.role, mindID, level)
		table.insert(self.minds, mindID, mind)
	end
end

--[[
	初始化技能
]]
function SkillHandler:initSkills()
	for _, mind in pairs(self.minds) do
		local skills = mind:getSkillsByMind()
		for skillID, skill in pairs(skills) do
			table.insert(self.skills, skillID, skill)
			---[[
			if skill.skillType == Skill_Type.Revival then
				self.revivalSkill = skill
			end
			--]]
		end
	end
	--[[调试用（可删除）
	local temp = {}
	for i,_ in pairs(self.skills) do
		table.insert(temp, i)
	end
	print(self.role:getID(),"角色所拥有的技能:", toString(temp))
	--]]
end

--[[
	根据技能id获取技能
]]
function SkillHandler:getSkill(id)
	return self.skills and self.skills[id]
end

local maxRevivalTimes = 1
--[[
	复活
]]
function SkillHandler:useRevival()
	local times = self.revivalTimes
	local skill = self.revivalSkill
	print("复活次数:", times)
	if skill and times < maxRevivalTimes then
		if skill:perform(self.role) then
			-- 返回动作集合
			return skill:getPerformResult():getActionList()
		end
	else
		return nil
	end
end

--[[
	获取复活次数
]]
function SkillHandler:addRevivalTimes(value)
	self.revivalTimes = self.revivalTimes + value
end

