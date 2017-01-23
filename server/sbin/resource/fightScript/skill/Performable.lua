--[[Performable.lua
	描述： 可释放,主要用于 判定技能释放对象 和 保存技能释放的过程 （结果集）
--]]

Performable = class()

--[[
	执行技能前初始化,成功执行返回结果集
]]
function Performable:perform(dest)
	-- 每次释放技能需要重置相关内容
	self.deadList 			= {}
	self.attackedTargets	= {} 	-- 保存攻击系技能目标用于反击
	self:updateStatus()
	
	-- 初始化结果集
	local result = PerformResult()
	self.performResult = result

	if self:onSkillAction(dest) > 0 then
		local consumeType = self.consumeType
		if consumeType then
			-- 根据技能消耗类型更新角色相应属性
			self:updateConsumeAttr(self:getRealConsumeValue(), consumeType)
		end
		return result:getResult(self), self.deadList, self.attackedTargets
	end
end

--[[
	获取初始化技能效果对象,用于执行效果
]]
function Performable:getSkillEffects()
	local effects = self:getSortedEffects()
	for index, effect in ipairs(effects) do
		local type = effect.type
		local effectName = unpack(SkillEffect2ActionMap[type])
		local skillEffect = _G[effectName]
		-- 初始化SkillEffect对象
		effects[index] = skillEffect(self, effect)
	end
	return effects
end

--[[
	技能效果排序
]]
function Performable:getSortedEffects()
	-- 技能类型和效果排序策略映射表
	local sortMap = SkillTypeEff[self:getSkillType()]
	local effects = self:getEffects()
	local ret = {}
	-- skillEff：技能效果常量值
	for _, skillEff in pairs(sortMap) do
		for _, effect in pairs(effects) do
			if effect.type and effect.type == skillEff then
				ret[#ret + 1] = effect
			end
		end
	end
	return ret
end

--[[
	技能执行入口
]]
function Performable:onSkillAction(dest)

	-- 动作计数器
	local count = 0
	local effects = self:getSkillEffects()	
	if not effects then return count end
	for _, effect in pairs(effects) do
		repeat
		local targetType = effect.targetType
		-- 获取有效技能目标(无目标或目标死亡处理)
		dest = self:getValidTarget(dest, targetType, effect.type)
		-- 技能目标选择判断:选取的目标是否符合技能的目标类型
		if not SkillUtils.chooseTargetCheck(self.role, dest, targetType) then
			-- print("技能目标不符合")
			dest = self:getTargetByType(targetType)
		end
		-- 技能使用者和目标的障碍状态判断,能否对目标使用技能
		if not dest or not self:disorderStatesCheck(dest) then
			-- print("目标不存在或者状态障碍")
			-- 某个技能效果未能实现时候，继续下一个技能效果
			break
		end
		if self.skillType == Skill_Type.Gathering then
			local round = self._gatheringRound or 0
			if round == 0 then
				self.role:setIsGathering(true)
			end
			if round < GatheringRound and  effect.type ~= SkillEff.Buff then
				break
			end
			if round > 0 and effect.type == SkillEff.Buff then
				if round >= GatheringRound then
					self.role:setIsGathering(false)
				end
				break
			end
			if round >= GatheringRound then
				self.role:setIsGathering(false)
			end
		end
		-- print("技能效果目标ID:", dest:getID(), dest:getLifeState())
		if effect:perform(dest) then
			count = count + 1
		end
		until true
	end
	if self.skillType == Skill_Type.Gathering then
		local round = self._gatheringRound or 0
		self._gatheringRound = round + 1
		if self._gatheringRound > 1 then 
			self._gatheringRound = nil 
		end 
	end
	return count
end

--[[
	获取有效技能目标(无目标或目标死亡处理)
]]
function Performable:getValidTarget(target, targetType, effectType)
	-- 无目标时随机获取目标
	if not target then
		target = self:getTargetByType(targetType)
	end
	-- 复活技能特殊处理
	if self.skillType == Skill_Type.Revival or effectType == PetPassiveEffect.Revival then
	-- if self.skillType == Skill_Type.Revival then
		return target
	end
	if target and not target:is_alive() then
		print("目标死亡，获取另一有效目标")
		target = self:getTargetByType(targetType)
	end
	return target
end

--[[
	根据技能目标类型获取有效目标
]]
function Performable:getTargetByType(targetType)
	local target
	if targetType == TargetType.friend or targetType == TargetType.friend_g then
		-- 包括role自己
		target = SkillUtils.getAcceptableHelpPartner(self.role, true)
	elseif targetType == TargetType.self then
		local role = self.role
		if role:is_alive() then
			target = role
		end
	else
		target = SkillUtils.getCanBeAttackedEnemy(self.role)
	end
	return target
end

--[[
	技能使用者和目标的障碍状态判断,能否对目标使用技能
]]
function Performable:disorderStatesCheck(target)
	local role = self.role
	if SkillUtils.isEnemy(role, target) then
		return SkillUtils.canAttackEnemy(self, target)
	elseif SkillUtils.isFriend(role, target) then
		return SkillUtils.canHelpFriend(self, target)
	else
		return SkillUtils.canHelpMyself(self)
	end
end

--[[
	更新技能状态集
]]
function Performable:updateStatus()
	if self.coolRound ~=0 then
		self.status.startRound = self:getCurRoundCount()
	end
end

--[[
	获取技能开始使用时的回合数
]]
function Performable:getStartRound()
	local status = self.status
	return status and status.startRound
end

--[[
	获取当前回合数
]]
function Performable:getCurRoundCount()
	return SkillUtils.getRoundCount(self.role)
end

--[[
	判断技能是否冷却
]]
function Performable:coolRoundCheck()
	local coolRound = self.coolRound
	if coolRound and coolRound > 0 then
		local start = self:getStartRound()
		local cur = self:getCurRoundCount()
		if cur - start < coolRound then
			print("技能冷却中:", start, cur, coolRound)
			return false
		end
		--[[蓄力
		if self.role:getIsGathering() then
			return true
		end
		--]]
	end
	-- print("该技能无冷却限制")
	return true
end

--[[
	获取技能类型
]]
function Performable:getPerformResult()
	return self.performResult
end

--[[
	获取技能类型
]]
function Performable:getSkillLevel()
	return self.level
end

--[[
	获取技能类型
]]
function Performable:getSkillType()
	return self.skillType
end

--[[
	获取技能id
]]
function Performable:getSkillID()
	return self.id
end

--[[
	获取技能role
]]
function Performable:getSkillRole()
	return self.role
end

--[[
	获取技能消耗类型
]]
function Performable:getConsumeType()
	return self.consumeType
end

--[[
	获取技能status集合
]]
function Performable:getStatus()
	return self.status
end

--[[
	获取技能deadList集合
]]
function Performable:getDeadList()
	return self.deadList
end

--[[
	判断是否为耗蓝技能
]]
function Performable:isConsumeMp()
	return (self.consumeType == ConsumeType.Mp)
end

--[[
	获取技能效果集
]]
function Performable:getEffects()
	return self.effects
end

--[[
	获取技能效果集
]]
function Performable:getPhaseType()
	return self.phaseType
end

--[[
	获取role角色的障碍buff的状态集合
]]
function Performable:getDisorderState(role)
	local handler = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	return handler:getDisorderState()
end

--[[
	检测角色是否存活(判断血量再设置生命状态标志)
]]
function Performable:checkAlive(role)
	if role:getHp() < 1 then
		role:setLifeState(RoleLifeState.Dead)
		table.insert(self.deadList, role:getID())
		return false
	end
	return true
end

--[[
	根据技能消耗类型更新角色相应属性
]]
function Performable:updateConsumeAttr(change, type)
	if type then
		if type == ConsumeType.Mp then
			self.role:inc_mp(0-change)
		elseif type == ConsumeType.Hp then
			self.role:inc_hp(0-change)
		elseif type == ConsumeType.Anger then
			self.role:inc_anger(0-change)
		elseif type == ConsumeType.vit then
			self.role:inc_vigor(0-change)
		end
	end
end

--[[
	添加攻击系技能目标
]]
function Performable:addAttackedTarget(target)
	local id = target:getID()	
	local targets = self.attackedTargets
	-- 不存在则添加
	if not targets[id] then
		targets[id] = target
	end
end

--[[
	获得方法映射表中的函数
]]
function Performable:attainSequence(table)
	local a, b, c, d = unpack(table)
	return self[a], self[b], self[c], self[d]
end




