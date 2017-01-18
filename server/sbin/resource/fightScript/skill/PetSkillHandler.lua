--[[PetSkillHandler.lua
	描述：
]]

PetSkillHandler = class()

require "skill.PetSkillHandlerAtom"

local PetSkillDB				= PetSkillDB			-- 技能定义
local PetSkillDataDB			= PetSkillDataDB		-- 技能数据

function PetSkillHandler:__init(role)
	self.role 				= role		-- 所有者
	self.skills 			= {}		-- 所有技能
	self.statePassiveList	= {}		-- 状态被动属性集
	self.results			= {}		-- 被动技能结果集
	
	self:initSkills()
	self:updateSkillAttr()
	
	self.revivalTimes = 0		--复活次数
end

function PetSkillHandler:__release()
	self.role 				= nil
	self.skills 			= nil
	self.statePassiveList	= nil
	self.results			= nil
	
	self.revivalTimes 		= nil
end

--[[
	获得一个技能
]]
function PetSkillHandler:getSkill(skillID)
	return self.skills[skillID]
end

--[[
	宠物技能加载
]]
function PetSkillHandler:initSkills()
	-- print ("宠物拥有的技能:", toString(self.role:getSkills()))
	local skills = self.role:getSkills()
	local skill
	for id, level in pairs(skills) do
		local skillDB = PetSkillDB[id]
		if skillDB then
			-- 排除属性被动技能
			if skillDB.skill_type == PetSkillType.AttrPassive then
			-- 状态被动初始化
			elseif skillDB.skill_type == PetSkillType.StatePassive then
				self:initSatePassiveSkill(id, level)
			else
				skill = PetSkill(self.role, id, level)
				table.insert(self.skills, id, skill)
			end
		else
			print(("没有这个技能,技能ID是 %d"):format(id))
		end
	end
end

--[[
	状态被动技能初始化
]]
function PetSkillHandler:initSatePassiveSkill(id, level)
	local skill = PetSkillDB[id].skill
	local type = (unpack(skill)).type
	-- 根据状态被动类型获取对应初始化方法
	local funcStr = PetPassiveType2FuncStr[type]
	local func = self[funcStr]
	if func then
		print("被动技能初始化:", id, funcStr)
		func(self, id, level)
	end
end

--[[
	被动影响技能属性数据(初始化时执行)
]]
function PetSkillHandler:updateSkillAttr()
	-- 法力消耗减少
	local isTrue, value, addType = self:getMpConsumeReduce()
	if isTrue then
		for id, skill in pairs(self.skills) do
			local change = 0
			local consumeValue = 0
			local type = skill:getConsumeType()
			if type and type == ConsumeType.Mp then
				consumeValue = skill:getConsumeValue()
				change = SkillUtils.getProperValue(consumeValue, value, addType)
				skill:setRealConsumeValue(change)
				print("技能法力原始消耗，消耗减少后:", consumeValue, change)
			end
		end
	end
end

--[[
]]
function PetSkillHandler:getStatePassiveList(passiveName)
	return self.statePassiveList[passiveName]
end

--[[
	判断是否触发
]]
function PetSkillHandler:isTrigger(prob)
	return math.random(100) < tonumber(prob)
end

--[[
	添加被动技能结果集
]]
function PetSkillHandler:addResults(result)
	if result and table.size(result) > 0 then
		table.insert(self.results, result)
	end
end

--[[
	执行每回合触发型的被动技能效果
]]
function PetSkillHandler:onRoundPassSkill()
	self.results = {}
	self:doRoundSkillAction()
	-- print("回合结果集：", toString(self.results))
	return self.results
end

--[[
	执行每回合触发的技能
]]
function PetSkillHandler:doRoundSkillAction()
	local skill_1 = self:getRoundMpHeal()
	local skill_2 = self:getRoundHpHeal()
	local skill_3 = self:getRoundDeBuffDispel()
	local role = self.role
	if skill_1 then
		local result = skill_1:perform(role)
		self:addResults(result)
	end
	if skill_2 then
		local result = skill_2:perform(role)
		self:addResults(result)
	end
	if skill_3 then
		local handler = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
		if handler:isHasDeBuff() then
			local result = skill_3:perform(role)
			self:addResults(result)
		end
	end
end

--[[
	被使用障碍BUFF回复HP、MP（暂未使用）
]]
function PetSkillHandler:beUsedDisorderResume()
	local skill_1 = self:getUseDisorderAddHp()
	local skill_2 = self:getUseDisorderAddMp()
	-- 是否存在障碍回复类被动技能
	if skill_1 or skill_2 then
		local buffHandler = self.role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
		local hasDisorderBuff = false
		-- 判断身上是否有障碍类BUFF
		for _, kind in ipairs(DisorderBuffKindMap) do
			if buffHandler:hasBuffKind(kind) then
				hasDisorderBuff = true
				break
			end
		end
		if hasDisorderBuff then
			if skill_1 then
				local result = skill_1:perform(self.role)
				self:addResults(result)
			end
			if skill_2 then
				local result = skill_2:perform(self.role)
				self:addResults(result)
			end
		end
	end
end

--[[
	被使用辅助类BUFF回复HP、MP（暂未使用）
]]
function PetSkillHandler:beUsedAssistanceResume()
	local skill_1 = self:getUseAssistanceAddHp()
	local skill_2 = self:getUseAssistanceAddMp()
	-- 是否存在辅助回复类被动技能
	if skill_1 or skill_2 then
		local buffHandler = self.role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
		local hasDisorderBuff = false
		-- 判断身上是否有辅助类BUFF
		for _, kind in ipairs(AssistBuffKindMap) do
			if buffHandler:hasBuffKind(kind) then
				hasDisorderBuff = true
				break
			end
		end
		if hasDisorderBuff then
			if skill_1 then
				local result = skill_1:perform(self.role)
				self:addResults(result)
			end
			if skill_2 then
				local result = skill_2:perform(self.role)
				self:addResults(result)
			end
		end
	end
end

local maxRevivalTimes = 3
--[[
	复活
]]
function PetSkillHandler:useRevival()
	local times = self.revivalTimes
	local skill = self:getRevival()
	print("复活次数", times)
	if skill and times < maxRevivalTimes then
		if skill:perform(self.role) then
			-- 返回动作集合
			return skill:getPerformResult():getActionList()
		end
	end
end

--[[
	获取复活次数
]]
function PetSkillHandler:addRevivalTimes(value)
	self.revivalTimes = self.revivalTimes + value
end

