--[[NormalEffect.lua
	描述：处理技能效果相关逻辑
]]

--[[
	伤害计算公式：
	最终伤害 = ((物理/法术攻击力 + 附加伤害)*(相性攻击-相性防御+1)- 物理/法术防御力)*(1±克制系数)
]]

NormalEffect = class(SkillEffect)

function NormalEffect:__init(skill, effect)
	self.atType				= nil			-- 攻击类型(物理or魔法)
	self.recordDmg			= 0				-- 记录伤害值
	self.critProb			= 0				-- 记录暴击几率(10即表示暴击率10%)
	self.hitRate			= 0				-- 记录命中率
end

function NormalEffect:__release()
end

--[[
	重置记录的数据
]]
function NormalEffect:resetRecordData()
	self.recordDmg 			= 0
	self.critProb			= 0
	self.hitRate			= 0
end

function NormalEffect:initPurse()
	self.numID 				= effect.numID					-- 效果公式ID
	self.targetType 		= effect.targetType				-- 目标类型
	self.targetNum		= effect.targetNum				-- 目标数量
	self.numType			= effect.numType				-- 效果加成类型
	self.numValue		= effect.numValue				-- 效果数值
end 

--[[
	记录伤害值增加
]]
function NormalEffect:addToRecordDmg(value)
	self.recordDmg = self.recordDmg + value
end

--[[
	设置攻击伤害类型
]]
function NormalEffect:setAtType(type)
	self.atType = type
end

--[[
	获取攻击伤害类型
]]
function NormalEffect:getAtType()
	return self.atType
end

--[[
	增加暴击几率
]]
function NormalEffect:addCritProb(value)
	self.critProb = self.critProb + value
end

--[[
	增加命中率
]]
function NormalEffect:addHitRate(value)
	self.hitRate = self.hitRate + value
end

--[[
	物理攻击效果
]]
function NormalEffect:doAt(target)
	self:setAtType(AtType.At)
	self:petAtPursuit(target)
	local addNum = self:getAddAttackTargetNum()
	if addNum == 0 and self.targetType == TargetType.enemy then
		self:onSingleAt(target)
	else
		-- 群体攻击不进行保护
		self:setNotProtect()
		local num = addNum + self.targetNum
		local targets = SkillUtils.getCanBeAttackedPartners(target, num, true)
		for _, target in pairs(targets) do
			self:onSingleAt(target)
		end
	end
	return true
end

--[[
	法术攻击效果
]]
function NormalEffect:doMt(target)
	self:setAtType(AtType.Mt)
	self:petMtPursuit(target)
	local addNum = self:getAddAttackTargetNum()
	if addNum == 0 and self.targetType == TargetType.enemy then
		self:onSingleMt(target)
	else
		-- 群体攻击不进行保护
		self:setNotProtect()
		local num = addNum + self.targetNum
		local targets = SkillUtils.getCanBeAttackedPartners(target, num, true)
		for _, target in pairs(targets) do
			self:onSingleMt(target)
		end
	end
	return true
end

local maxPursuitTimes = 1
--[[
	追击效果
]]
function NormalEffect:doPurse(target)
	local prob = self.numValue / 10
	local pursuitTimes = self.pursuitTimes
	if math.random(100) < prob and pursuitTimes < maxPursuitTimes then
		local effects = self.skill:getEffects()
		-- 复制要重复执行的效果
		effect = unpack(effects)
		_,doActionStr = unpack(SkillEffect2ActionMap[effect.type])
		print(doActionStr)
		local doAction = self[doActionStr]
		if doAction then
			-- 更新追击次数
			self:addPursuitTime()
			self:initPurse()
			return doAction(self, target)
		end
	end
	return false
end

--[[
	执行单体物伤
]]
function NormalEffect:onSingleAt(target)
	if not target:is_alive() then
		target = SkillUtils.getCanBeAttackedPartner(target)
	end
	if target then
		-- 添加目标到技能目标列表
		self:addTarget(target)
		Flog:log("ID:"..self.role:getID().." 物攻".." ID:"..target:getID().." ")
		print("ID:"..self.role:getID().." 物攻".." ID:"..target:getID().." ")
		self:incAnger(target, BeAttackIncAnger)
		self:incAnger(self.role, AttackIncAnger)
		self:resetRecordData()
		-- 判断是否命中
		if self:isHit(target) then
			local addType = self.numType
			local numValue = self.numValue
			local phaseType = self.skill:getPhaseType()
			self:calcAtDmg(target, numValue, addType, phaseType)
			self:calcDmg(target, phaseType)
		end
		self:setResultStatusType(target)
	end
end

--[[
	执行单体法伤
]]
function NormalEffect:onSingleMt(target)
	if not target:is_alive() then
		target = SkillUtils.getCanBeAttackedPartner(target)
	end
	if target then
		-- 添加目标到技能目标列表
		self:addTarget(target)
		Flog:log("ID:"..self.role:getID().." 法攻".." ID:"..target:getID().." ")
		self:incAnger(target, BeAttackIncAnger)
		self:incAnger(self.role, AttackIncAnger)
		self:resetRecordData()
		-- 判断是否命中
		if self:isHit(target) then
			local addType = self.numType
			local numValue = self.numValue
			local phaseType = self.skill:getPhaseType()
			self:calcMtDmg(target, numValue, addType, phaseType)
			self:calcDmg(target, phaseType)
		end
		self:setResultStatusType(target)
	end
end

--[[
	计算物理攻击伤害
]]
function NormalEffect:calcAtDmg(target, value, addType, phaseType)
	-- 是否有物理免疫
	if self:isATKImmunity(target) then
		return
	end
	local role = self.role
	-- 物理攻击力+附加伤害
	local physicATK = role:ft_get_at()
	print("自身物理攻击力,技能数值,加成类型,相性类型:", physicATK, toString(value), addType, phaseType)
	if addType == AddType.mix then
		local value_1, value_2 = unpack(value)
		value_1 = value_1 / 10
		-- 波动数值计算
		local addValue = SkillUtils.getFluctuateValue(value_2, FluctuateFactor)
		if phaseType then
			-- 是否相性免疫
			if self:isPhaseImmunity(target) then
				addValue = 0
			else
				-- 计算相性附加伤害改变
				addValue = self:calcPhaseChange(target, addValue)
			end
		end
		print("附加伤害:", addValue)
		physicATK = physicATK * (value_1 / 100) + addValue
	else
		physicATK = SkillUtils.calcNumAdd(role:ft_get_at(), value, addType)
	end
	
	local phaseDmg = self:getAttrPhaseDmg(target)
	print("技能面板伤害:", physicATK)
	print("相性攻击-相性防御+1 = ", phaseDmg)
	physicATK = physicATK * phaseDmg
	-- 目标物理防御力
	local physicDEF = target:ft_get_af()
	physicDEF = self:calcDEFChange(physicDEF)
	
	local damage = 0
	if physicATK >= physicDEF then
		damage = physicATK - physicDEF
	end
	damage = damage > 0 and damage or 0
	
	-- 测试
	-- damage = 50
	-- if instanceof(target, FightPet) then end
	print("计算防御力后：", damage)
	self:addToRecordDmg(damage)
end

--[[
	计算魔法攻击伤害
]]
function NormalEffect:calcMtDmg(target, value, addType, phaseType)
	-- 是否有魔法免疫
	if self:isATKImmunity(target) then
		return
	end
	local role = self.role
	-- 魔法攻击力+附加伤害
	local magicATK = role:ft_get_mt()
	print("自身法术攻击力,技能数值,加成类型,相性类型:", magicATK, toString(value), addType, phaseType)
	if addType == AddType.mix then
		local value_1, value_2 = unpack(value)
		value_1 = value_1 / 10
		-- 波动数值计算
		local addValue = SkillUtils.getFluctuateValue(value_2, FluctuateFactor)
		if phaseType then
			-- 是否相性免疫
			if self:isPhaseImmunity(target) then
				addValue = 0
			else
				-- 计算相性附加伤害改变
				addValue = self:calcPhaseChange(target, addValue)
			end
		end
		print("附加伤害:", addValue)
		magicATK = magicATK * (value_1 / 100) + addValue
	else
		magicATK = SkillUtils.calcNumAdd(role:ft_get_at(), value, addType)
	end
	
	local phaseDmg = self:getAttrPhaseDmg(target)
	print("技能面板伤害:", magicATK)
	print("相性攻击-相性防御+1 = ", phaseDmg)
	magicATK = magicATK * phaseDmg
	-- 目标魔法防御力
	local magicDEF = target:ft_get_mf()
	magicDEF = self:calcDEFChange(magicDEF)
	local damage = 0
	if magicATK >= magicDEF then
		damage = magicATK - magicDEF
	end
	damage = damage > 0 and damage or 0
	
	-- 测试
	-- damage = 100
	print("计算防御力后：", damage)
	self:addToRecordDmg(damage)
end

--[[
	物理/法术攻击免疫判断
]]
function NormalEffect:isATKImmunity(target)
	local atType = self.atType
	if instanceof(target, FightPet) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue = false
		if atType == AtType.At then
		else
			-- 宠物法术免疫
			isTrue = handler:getMagicalDmgImmune()
		end
		if isTrue then
			local hpChange = SkillUtils.getHpChange(target, 0)
			-- 设置目标HP改变量(用于构造协议)
			self:setTargetHpChange(target, hpChange)
			print("法术伤害免疫")
			return true
		end
	end
end

--[[
	计算防御力改变(破防效果)
]]
function NormalEffect:calcDEFChange(DEF)
	local rtValue = DEF
	-- 破防效果
	local role = self.role
	local ruptureRate = role:get_rupture_rate()
	if math.random(100) < ruptureRate then
		local ruptureEff = role:get_inc_rupture_effect()
		rtValue = math.floor(rtValue * (100 - ruptureEff) / 100)
	end
	return rtValue
end

--[[
	根据角色相性属性计算相性伤害(相性攻击-相性防御+1)
]]
function NormalEffect:getAttrPhaseDmg(target)
	local role = self.role
	local phaseType = role:get_phase_type()
	if not phaseType then
		return 1
	end
	-- 相性攻击力
	local phaseATK = role:ft_get_phase_at(phaseType) or 0
	-- 目标相性防御力
	local phaseDEF = target:ft_get_phase_resist(phaseType) or 0
	local damage = 0
	damage = phaseATK - phaseDEF + 1
	damage = damage > 0 and damage or 0.1
	
	-- Flog:log("  攻击相性:"..PhaseName[phaseType].."值："..phaseATK..
		-- " 对方相性:"..PhaseName[target:get_phase_type()].."值："..phaseDEF.." 相性伤害:"..damage.."  ")
	-- self:addToRecordDmg(damage)
	return damage
end

--[[
	相性免疫判断
]]
function NormalEffect:isPhaseImmunity(target)
	if instanceof(target, FightPet) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		local isImmunity = handler:getPhaseDmgImmune()
		if isImmunity then
			print("相性免疫")
			return true
		end
	end
	return false
end

--[[
	计算由于被动或其他因素引起的相性伤害改变
]]
function NormalEffect:calcPhaseChange(target, phasedmg)
	local change = 0
	if instanceof(target, FightPet) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue, value, addType = handler:getPhaseDmgReduce()
		if isTrue then
			change = SkillUtils.getProperValue(phasedmg, value, addType)
			print("原始相性伤害，相性减免数值:", phasedmg, change)
		end
	end
	return phasedmg - change
end

--[[
	计算克制系数
]]
function NormalEffect:calcRestraintCoef(target, phaseType)
	local targetPhaseType = target:get_phase_type()
	local coef = 1
	-- 目标无相性或技能无相性直接返回
	if not phaseType or not targetPhaseType then
		return coef
	end
	-- 获取克制类型(克制,不克制,被克制)
	local type = SkillUtils.getRestraintType(phaseType, targetPhaseType)
	coef = RestraintCoef[type]
	
	local roleHandler = self.role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	local targetHandler = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)

	-- 是否带有buff标志,克制效果减益,被克制效果增益
	local r_HasBuff, r_Reduce, r_Raise = roleHandler:getPhaseRestrain()
	local t_HasBuff, t_Reduce, t_Raise = targetHandler:getPhaseRestrain()

	if r_HasBuff or t_HasBuff then
		-- 克制系数
		if type == RestraintType.Restrain then
			r_Reduce = r_Reduce or 0
			t_Raise	= t_Raise or 0
			coef = coef * (100 - r_Reduce + t_Raise) / 100
		-- 被克制系数
		elseif type == RestraintType.BeRestrained then
			r_Raise = r_Raise or 0
			t_Reduce = t_Reduce or 0
			coef = coef * (100 - r_Raise + t_Reduce) / 100
		end
	end

	if r_HasBuff then
		Flog:log("自身有相性克制buff,克制系数:"..coef.."\n")
	end
	if t_HasBuff then
		Flog:log("目标有相性克制buff,克制系数:"..coef.."\n")
	end
	return coef
end

--[[
	是否命中
]]
function NormalEffect:isHit(target)
	self:calculateHit(target)
	local hitRate = self.hitRate
	if math.random(100) <= hitRate then
		Flog:log("命中 ")
		return true
	end
	-- 设置闪避标志
	self:setDodgeFlag(target)
	Flog:log("闪避\n")
	return false
end

--[[
	计算命中率
]]
function NormalEffect:calculateHit(target)
	-- 获取自身命中系数
	local hit = self.role:ft_get_hit()
	-- 获取目标闪避系数
	local dodge = target:ft_get_dodge()
	local hitRatio = 0
	if hit == 0 then
		hitRatio = 100
	elseif dodge == 0 then
		hitRatio = -1
	else
		hitRatio = 100 * FinalHitRateConst*hit/(FinalHitRateConst*hit + dodge)
	end
	self:petATDodge(target)	
	Flog:log("命中率:"..hitRatio.." ")
	self:addHitRate(hitRatio)
end

--[[
	顺序：闪避→暴击→保护→防御→护盾→反震
	计算伤害伤害类型damageType:  1物理 2法术
]]
function NormalEffect:calcDmg(target, phaseType)
	-- 克制系数加成
	local coef = self:calcRestraintCoef(target, phaseType)
	print("克制系数:", coef)
	local damage = self.recordDmg * coef
	
	Flog:log("\n->原始伤害:"..damage)
	
	local damageType = self.atType
	-- 移除昏睡效果
	local handler = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	handler:doRemoveSoporBuff()

	-- 是否有伤害免疫
	local isTrue = false
	isTrue, damage = self:calcDmgChange(target, damage, damageType)	
	if isTrue then return end
	
	-- 计算暴击
	damage = self:calcCritDmg(target, damage)
	Flog:log(" ->暴击后:"..damage)
	
	-- 计算保护
	if not self.notProtect then
		damage = self:calcProtectDmg(target, damage, damageType)	
		Flog:log(" ->保护后:"..damage)
	end
	
	-- 计算防御
	damage = self:calcDefenseDmg(target, damage)
	Flog:log(" ->防御后:"..damage)

	-- 计算护盾
	local isMpShield, shieldChange
	damage, isMpShield, shieldChange = self:calcShield(target, damage, damageType)
	Flog:log(" ->护盾后:"..damage)
	if isMpShield then
		self:setTargetMpChange(target, shieldChange)
	end
	
	-- 计算反震
	self:calcCounter(target, damage, damageType)
	
	-- 追击伤害递减
	local times = self.pursuitTimes
	if times > 0 then
		if instanceof(self.role, FightPlayer) then
			damage = damage * (0.5^times)
		end
	end

	if damage == 0 then
		damage = 1
	end
	Flog:log(" ->最终伤害:"..damage.."\n")
	print("最终伤害：", damage)
	-- 更新目标血量并获取改变量
	local hpChange = SkillUtils.getHpChange(target, 0 - damage)
	self:checkAlive(target)
	-- 设置目标HP改变量(用于构造协议)
	self:setTargetHpChange(target, hpChange)
	-- 添加到攻击系技能目标列表(用于反击)
	self:addAttackedTarget(target)

	self:onPassiveSkillAfterDmg(target, hpChange)
end

--[[
	计算暴击伤害
]]
function NormalEffect:calcCritDmg(target, damage)
	if damage == 0 then
		return 0
	end
	local addValue = self:petPhysicalATCrit() or 0
	self:calcCriticalProb(target)
	local critProb = self.critProb
	if math.random(100) <= critProb then
		self:setCriticalFlag(target)
		local role = self.role
		-- 获取暴击效果加成比率
		local incRate = role:get_inc_critical_effect()
		incRate = incRate + addValue
		damage = math.floor(damage *(FinalCriticalDamageConst + incRate))	
		damage = self:calcCritDmgChange(target, damage)
		Flog:log("暴击率:"..critProb.." 暴击伤害加成:"..incRate.." ")
	end	
	return damage
end

--[[
	计算暴击几率
]]
function NormalEffect:calcCriticalProb(target)
	local role = self.role
	-- 获取暴击率
	local critical = role:ft_get_critical()
	-- 获取目标抗暴率
	local tenacity = target:ft_get_tenacity()

	local critProb = math.floor(100*FinalCritRateConst*critical/(FinalCritRateConst*critical + tenacity))
	-- 判断自己是否必暴、目标是否必定抗暴
	local r_handler = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	local t_handler = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	if r_handler:getMustCritical() then
		critProb = MustCriticalValue
	end
	if t_handler:getMustTenacity() then
		critProb = 0 - MustCriticalValue
	end
	self:petCritImmune(target)
	self:addCritProb(critProb)
end

--[[
	计算由于被动或其他因素引起的暴击伤害改变
]]
function NormalEffect:calcCritDmgChange(target, damage)
	--[[吸取暴击-宠物被动：减少暴击伤害(暂不使用)
	if instanceof(target, FightPet) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue, value, addType = handler:getReduceCritDmg()
		if isTrue then
			local change = SkillUtils.getProperValue(damage, value, addType)
			Flog:log(" 宠物被动减少暴击:"..change.."\n")
			damage = damage - change
		end
	end
	--]]
	return damage
end

--[[
	计算保护伤害
]]
function NormalEffect:calcProtectDmg(target, damage)
	local change = damage
	-- 获取保护者(群体攻击无保护者)
	local protectors = FightUtils.getValidProtectors(target:getProtectors())
	if protectors and table.size(protectors) ~= 0 then
		-- 用于添加结果集的保护列表
		local ret = {}
		local role = nil
		-- 伤害平均分配计数器
		local count = 0
		-- 添加保护者到保护列表
		for id,_ in pairs(protectors) do
			role = g_fightEntityMgr:getRole(id)
			self:addProtectList(role)
			count = count + 1
		end
		change = math.floor(damage / (count + 1))
		
		-- 用于当伤害为0时设置掉血1
		local temp = change
		if temp == 0 then
			temp = 1
		end
		-- 设置保护者血量变化
		local protectList = self.protectList
		for _, roleSet in pairs(protectList) do
			local role = roleSet.role
			local hpChange = SkillUtils.getHpChange(role, 0 - temp)
			self:setProtectChanged(role:getID(), hpChange, ResultAttrType.Hp)
			self:checkAlive(role)
		end
		self.skill:getPerformResult():addResultProtectors(target:getID(), protectList)
		
		-- 供测试用
		local str = " 触发保护: 平均伤害"..change.. "保护列表: "
		for _,roleSet in pairs(protectList) do
			local role = roleSet.role
			str = str..role:getID() .. ", "
		end
		Flog:log(str.."\n")	
		
	end
	return change
end

--[[
	计算防御伤害
]]
function NormalEffect:calcDefenseDmg(target, damage)
	if target:getIsDefense() then
		self:setDefenseFlag(target)
		Flog:log(" 触发防御 ")
		damage = math.floor(damage / 2)
	end
	return damage
end

--[[
	计算护盾后伤害
]]
function NormalEffect:calcShield(target, damage, damageType)
	if damage > 0 then
		return SkillUtils.calcShield(target, damage, damageType)
	end
	return 0
end

--[[
	计算反震伤害
]]
function NormalEffect:calcCounter(target, damage, damageType)
	if damage > 0 then
		local prob = target:getCounter()
		damage, prob = self:calcCounterDmgChange(target, damage, prob)
		if math.random(100) <= prob then 
			self:setCounter(target, damage)
			Flog:log(" 反震伤害:"..damage.." ")
			return SkillUtils.calcShield(self.role, damage, damageType)
		end
	end
	return 0
end

--[[
	计算反震几率
]]
function NormalEffect:calcCounterProb(target)
end

--[[
	计算由于被动或其他因素引起的反震伤害的改变
]]
function NormalEffect:calcCounterDmgChange(target, damage, prob)
	local prob = prob or 0
	local rtValue = damage
	-- 判断是否有反弹buff
	local buffHandler = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	local isTrue, value, addType = buffHandler:getCouterDmg()
	if isTrue then
		rtValue = SkillUtils.getProperValue(damage, value, addType)
		prob = 100
		-- return damage, prob
	end
	
	local addDmg = target:get_counter_dmg_add()
	rtValue = math.floor(rtValue * (addDmg + 0.1))
	if instanceof(target, FightPet) and self:getAtType() == AtType.At then
		-- 反震-宠物被动：物理反震(被)
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue, value, addType = handler:getCounterFight()
		if isTrue then
			prob = 100
			rtValue = SkillUtils.getProperValue(damage, value, addType)
			print("原始伤害，物理反震:", damage, rtValue)
		end
	end
	local role = self.role
	if instanceof(role, FightPet) then
		-- 反震免疫
		local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
		if handler:getCounterFightImmune() then
			prob = 0
			print("反震免疫")
		end
	end
	return rtValue, prob
end

--[[
	计算由于被动或其他因素引起的伤害改变
]]
function NormalEffect:calcDmgChange(target, damage, damageType)
	local role = self.role
	if instanceof(role, FightPet) then
		local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
		if self.atType == AtType.Mt then
			damage = self:petMagicalATDmgFluctuate(handler, target, damage)
			damage = self:petMagicalATCrit(handler, target, damage)
		end
		damage = self:petAttackWithBuff(handler, target, damage)
		damage = self:petDmgRedoubleORHpHealWithDmgInc(handler, target, damage)
	end
	if instanceof(target, FightPet) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		-- 伤害免疫判断
		if self:dmgImmunity(handler, target, damage) then
			return true
		end
		damage = self:reduceDmg(handler, damage, damageType)
		damage = self:replaceHpWithMp(handler, target, damage)
	end
	return false, damage
end

--[[
	结算伤害后处理被动技能
]]
function NormalEffect:onPassiveSkillAfterDmg(target, hpChange)
	local role = self.role
	if instanceof(role, FightPet) then
		local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
		self:petSuckBlood(handler, hpChange)
		self:petSuckMp(handler, target)
		self:petOutflowMp(handler, target)
	end
end

--[[
	攻击系技能增加攻击目标
]]
function NormalEffect:getAddAttackTargetNum()
	return 0
end

