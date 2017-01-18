--[[PlayerSkill.lua
	描述：
]]

local SkillDB			= FightSkillDB				--技能定义
local SkillDataDB		= FightSkillDataDB			--技能数据

PlayerSkill = class(Performable)

function PlayerSkill:__init(role, skillID, level)
	self.role 				= role					-- 技能所属角色
	self.id 				= skillID				-- 技能ID
	self.level 				= level					-- 技能等级
	
	self.skillType			= false					-- 技能类型
	self.consumeType		= false					-- 技能消耗类型
	self.consumeValue		= false					-- 技能消耗数值
	self.phaseType			= false					-- 相性类型
	self.effects			= {}					-- 技能效果(对应FightSkillDB里的skill表)
	self.coolRound 			= 0						-- 技能冷却时间
	self._gatheringRound    = nil					--	蓄力回合
	-- 状态集合,每次使用技能前都要重置
	self.status				= {}					-- 技能状态集合
	self.deadList	 		= false					-- 死亡角色列表
	self.attackedTargets	= false					-- 保存攻击系技能目标用于反击
	self.performResult		= false					-- 技能结果集合
	
	self:initConfig(skillID)
	self:initStatus()
end

function PlayerSkill:__release()
	self.role 				= nil
	self.id 				= nil
	self.level 				= nil
	
	self.skillType			= nil	
	self.consumeType		= nil
	self.consumeValue		= nil
	self.phaseType			= nil	
	self.effects			= nil	
	self.coolRound 			= 0
	
	self.status				= nil
	self.deadList	 		= nil
	self.attackedTargets	= nil
	self.performResult		= nil
end

--[[
	初始化技能数据
]]
function PlayerSkill:initConfig(skillID)
	local data = SkillDB[skillID]
	if data then
		self.skillType		= data.skill_type
		self.phaseType		= data.phase_type
		self.consumeType	= data.consume_type
		
		local consumeID = data.consume_id
		-- 根据配置计算消耗数值
		if consumeID then
			local consumeData = SkillDataDB[consumeID]
			local value 		= consumeData[self.level]
			local addType 		= consumeData.type
			self.consumeValue	= self:initConsumeValue(self.consumeType, value, addType)
		end
		self.coolRound		= data.cool_round or 0
		
		-- 使用技能时初始化效果数值(每次使用都要查询) or 加载技能时初始化效果数值
		if data.skill then
			for i, effect in ipairs(data.skill) do
				-- 初始化技能效果
				if effect.type then
					self.effects[i] = self:initEffect(effect)
				end
			end
		end
	else
		print("没有配置的技能ID",skillID or "空的技能ID")
		return
	end
end

--[[
	初始化技能效果数据,以便读取
]]
function PlayerSkill:initEffect(effect)
	local numID = effect.num_id
	local level = self.level
	local ret = {
		type 		= effect.type,										-- 效果类型
		numID 		= numID,											-- 效果ID
		targetType 	= effect.target_type,								-- 目标类型
		targetNum 	= SkillDataDB[effect.target_num_id][level],			-- 目标数量
	}
	if effect.type ~= SkillEff.Buff and numID then
		local data = SkillDataDB[numID]
		ret.numType 	= data and data.type			-- 效果加成类型
		ret.numValue 	= data and data[level]			-- 效果数值
	end
	return ret
end

--[[
	根据消耗计算类型初始化技能消耗数值
]]
function PlayerSkill:initConsumeValue(type, value, addType)
	if not type then
		return false
	end
	local tmpValue = 0
	if addType == AddType.percent then
		local role = self.role
		local maxValue = role:getConsumeAttrMaxValue(type)
		tmpValue =  math.floor(maxValue * value / 100)
	else
		tmpValue = value
	end
	local decSpell = self.role:get_dec_spell_cost()
	tmpValue = math.floor(tmpValue * (100 - decSpell) / 100)
	return tmpValue
end

--[[
	初始化技能状态集
]]
function PlayerSkill:initStatus()
	self.status = {
		realConsumeValue = self.consumeValue,
		startRound = 0 - self.coolRound,
	}
end

--[[
	获取技能配置的消耗数值
]]
function PlayerSkill:getConsumeValue()
	return self.consumeValue
end

--[[
	获取技能实际消耗数值
]]
function PlayerSkill:getRealConsumeValue()
	local temp = self.status
	return temp and temp.realConsumeValue
end

--[[
	设置技能实际消耗数值
]]
function PlayerSkill:setRealConsumeValue(value)
	local status = self.status
	if status and status.realConsumeValue then
		status.realConsumeValue = tonumber(value)
	end
end

--[[
	判断技能是否满足消耗
]]
function PlayerSkill:consumeCheck()
	local type = self.consumeType
	if not type then
		print("该技能无消耗类型")
		return true
	end
	local role = self.role
	-- 根据消耗类型获取对应角色属性值
	local curValue = role:getConsumeAttrValue(type)
	local tmpValue = self:getRealConsumeValue() or 0
	return tmpValue <= curValue
end

--[[
	判断技能能否使用
]]
function PlayerSkill:canUseSkill()
	-- 是否冷却 是否满足消耗
	return self:coolRoundCheck() and self:consumeCheck()
end


