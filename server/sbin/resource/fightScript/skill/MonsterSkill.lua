--[[MonsterSkill.lua
	描述：
--]]

local SkillDB		= MonsterSkillDB				--技能定义
local SkillDataDB	= MonsterSkillDataDB			--技能数据

MonsterSkill = class(Performable)

function MonsterSkill:__init(role, skillID, level)
	self.role 				= role					-- 技能所属角色
	self.id 				= skillID				-- 技能ID
	self.level 				= level					-- 技能等级
	
	self.skillType			= false					-- 技能类型
	self.phaseType			= false					-- 相性类型
	self.effects			= {}					-- 技能效果(对应MonsterSkillDB里的skill表)
	self.coolRound 			= 0						-- 技能冷却时间
	
	-- 状态集合,每次使用技能前都要重置
	self.status				= {}					-- 技能状态集合
	self.deadList	 		= false					-- 死亡角色列表
	self.attackedTargets	= false					-- 保存攻击系技能目标用于反击
	self.performResult		= false					-- 技能结果集合
	
	self:initConfig(skillID)
end

function MonsterSkill:__release()
	self.role 				= nil
	self.id 				= nil
	self.level 				= nil
	
	self.skillType			= nil	
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
function MonsterSkill:initConfig(skillID)
	local data = SkillDB[skillID]
	if data then
		self.skillType		= data.skill_type
		self.phaseType		= data.phase_type

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
function MonsterSkill:initEffect(effect)
	local numID = effect.num_id
	local ret = {
		type 		= effect.type,												-- 效果类型
		numID 		= numID,													-- 效果ID
		targetType 	= effect.target_type,										-- 目标类型
		targetNum 	= SkillDataDB[effect.target_num_id][self.level],			-- 目标数量
	}
	if effect.type ~= SkillEff.Buff and numID then
		local data = SkillDataDB[numID]
		ret.numType 	= data and data.type		-- 效果加成类型
		ret.numValue 	= data and data[self.level]	-- 效果数值
	end
	return ret
end

--[[
	初始化技能状态集
]]
function MonsterSkill:initStatus()
	self.status = {
		startRound = 0 - self.coolRound,
	}
end

--[[
	判断技能能否使用
]]
function MonsterSkill:canUseSkill()
	-- 是否冷却
	return self:coolRoundCheck()
end

--[[
	执行技能前初始化,成功执行返回结果集(重写)
]]
function MonsterSkill:perform(dest)
	-- 怪物技能传入的目标与player、pet的不一样,特殊处理
	local target = unpack(dest or {})
	--[[
	-- 使用技能前:技能使用者和目标的障碍状态判断,能否对目标使用技能
	if not target or not self:disorderStatesCheck(target) then
		return false 
	end
	--]]
	-- 每次释放技能需要重置相关内容
	self.deadList 			= {}
	self.attackedTargets	= {} 	-- 保存攻击系技能目标
	self:updateStatus()
	
	-- 初始化结果集
	local result = PerformResult()
	self.performResult = result
	
	if self:onSkillAction(target) > 0 then
		return result:getResult(self), self.deadList, self.attackedTargets
	end
end

