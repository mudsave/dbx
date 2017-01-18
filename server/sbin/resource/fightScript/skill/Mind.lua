--[[Mind.lua
描述：
	
--]]

Mind = class()

function Mind:__init(handler, role, id, level)
	self.handler	= handler
	self.role		= role			-- 所属角色
	self.id			= id			-- 心法ID
	self.level		= level			-- 心法等级
	self.db			= MindDB[id]	-- 心法ID对应的配置数据
end

--[[
	根据心法自己产生战斗技能
]]
function Mind:getSkillsByMind()
	local ret = {}
	local mindDB = self.db
	local skillID = 0
	local skill = nil
	for i = 1,4 do
		if mindDB['skill'..i..'_level'] and mindDB['skill'..i..'_level'] <= self.level then
			skillID = mindDB['skill'..i]
			if FightSkillDB[skillID] then
				local skillType = FightSkillDB[skillID].skill_type
				-- 排除掉传送技能、道具制作技能、被动技能
				if skillType ~= Skill_Type.Transport and skillType ~= Skill_Type.ToolMake 
				and skillType ~= Skill_Type.Passive then
					skill = PlayerSkill(self.role, skillID, self.level)
					table.insert(ret, skillID, skill)
				end
			end
		end
	end
	return ret
end

--根据心法自己产生战斗技能（已不再使用）
function Mind:gen_skills()
	local skills = {}
	local db = self.db
	local sk = 0
	for i = 1,4 do
		if db['skill'..i..'_level'] and db['skill'..i..'_level'] <= self.level then
			sk = PlayerSkill(self.role, db['skill'..i], self.level)
			table.insert(skills, sk.id, sk)
		end
	end
	return skills
end
