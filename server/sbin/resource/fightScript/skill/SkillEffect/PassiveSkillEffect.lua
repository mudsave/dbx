--[[PassiveSkillEffect.lua
	描述：
		NormalEffect扩展
		被动技能逻辑处理
]]

---------- 被动系被动 -------------
--[[
	幸运-宠物被动：不会受到暴击攻击，并有几率躲避敌人的法术攻击(被)
]]
function NormalEffect:petCritImmune(target)
	if instanceof(target, FightPet) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue = handler:getCritImmune()
		if isTrue then
			self:addCritProb(0 - MustCriticalValue)
			print("幸运不会受到暴击")
		end
	end
end

--[[
	宠物被动：攻击闪避(被)
]]
function NormalEffect:petATDodge(target)
	if instanceof(target, FightPet) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		if self:getAtType() == AtType.At then
			local isTrue = handler:getPhysicalATDodge()
			if isTrue then
				self:addHitRate(0 - MustHitValue)
				print("物理攻击闪避：", self.hitRate)
			end
		else
			local isTrue = handler:getMagicalATDodge()
			if isTrue then
				self:addHitRate(0 - MustHitValue)
				print("法术攻击闪避：", self.hitRate)
			end
		end
	end
end

--[[
	气血转化-宠物被动：伤害免疫恢复hp(被)
]]
function NormalEffect:dmgImmunity(handler, target, damage)
	local isTrue, value, addType = handler:getDmgImmuneConvertToHp()
	-- isTrue, value, addType = true, 50, 1
	if isTrue then
		hpHeal = SkillUtils.getProperValue(damage, value, addType)
		hpHeal = SkillUtils.getHpChange(target, hpHeal)
		-- 设置目标HP改变量(用于构造协议)
		self:setTargetHpChange(target, 0)
		local skill = self.skill
		skill:getPerformResult():addNormalResumeValue(target:getID(), hpHeal)
		-- 添加到攻击系技能目标列表(用于反击)
		self:addAttackedTarget(target)
		print("伤害免疫恢复HP:", hpHeal)
		return true
	end
	return false
end

--[[
	汲取物伤,汲取法伤-宠物被动：(被)
]]
function NormalEffect:reduceDmg(handler, damage, damageType)
	local change = 0
	local isTrue, value, addType
	if damageType == AtType.At then
		isTrue, value, addType = handler:getPhysicalDmgReduce()
	else
		isTrue, value, addType = handler:getMagicalDmgReduce()
	end
	if isTrue then
		change = SkillUtils.getProperValue(damage, value, addType)
		print("原始伤害，宠物物理/法术伤害汲取数值:", damage, change)
	end
	return damage - change
end

--[[
	以法续命-宠物被动：法力替代生命(被)
]]
function NormalEffect:replaceHpWithMp(handler, target, damage)
	local change = 0
	local isTrue, value, addType = handler:getReplaceHpWithMp()
	if isTrue then
		-- 获取能够替代生命的实际法力
		local mpChange = SkillUtils.getProperValue(target:getMp(), value, addType)
		mpChange = damage > mpChange and mpChange or damage
		mpChange = SkillUtils.getMpChange(target, 0 - mpChange)	
		change = mpChange
		-- 用于界面更新MP显示数值
		local skill = self.skill
		skill:getPerformResult():addNormalResumeValue(target:getID(), false, mpChange)
		print("以法续命扣减法力:", 0 - change)
	end
	return damage + change
end

---------- 主动系被动 -------------

--[[
	吸血-宠物被动：物理吸血(主)
]]
function NormalEffect:petSuckBlood(handler, hpChange)
	if self:getAtType() == AtType.At then
		local isTrue, value, addType = handler:getPATWithBloodSucking()
		if isTrue then
			local role = self.role
			local hpHeal = SkillUtils.getProperValue(0 - hpChange, value, addType)
			hpHeal = SkillUtils.getHpChange(role, hpHeal)	
			local skill = self.skill
			skill:getPerformResult():addNormalResumeValue(role:getID(), hpHeal)
			print("物理吸血:", hpChange, hpHeal)
		end
	end
end

--[[
	必杀-宠物被动：物理暴击，伤害结果加倍(主)
]]
function NormalEffect:petPhysicalATCrit()
	local role = self.role
	if instanceof(role, FightPet) then
		local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue, value = handler:getPhysicalATCrit()
		if isTrue then
			self:addCritProb(value)
			local incCritEffect = 0.5
			print("必杀暴击率增加：", value)
			return incCritEffect
		end	
	end
end

--[[
	法术暴击-宠物被动：法术攻击有几率法术伤害提高(主)
]]
function NormalEffect:petMagicalATCrit(handler, target, damage)
	local rtValue = damage
	local isTrue, value, addType = handler:getMagicalATCrit()
	if isTrue then
		rtValue = SkillUtils.calcNumAdd(rtValue, value, addType)
		print("法术暴击(原始伤害，暴击后伤害):", damage, rtValue)
	end	
	return rtValue
end

--[[
	法术波动-宠物被动：法术攻击伤害波动(主)
]]
function NormalEffect:petMagicalATDmgFluctuate(handler, target, damage)
	local rtValue = damage
	local isTrue, value, addType = handler:getMagicalATDmgFluctuate()
	if isTrue then
		local value_1, value_2 = unpack(value)
		value_1 = value_1 / 10 
		value_2 = value_2 / 10
		local min = SkillUtils.calcNumAdd(damage, value_1, addType)
		local max = SkillUtils.calcNumAdd(damage, value_2, addType)
		rtValue = SkillUtils.getRangeValue(min, max)
		-- rtValue = SkillUtils.getFluctuateValue(rtValue, value, value * 2)
		print("法术波动(原始伤害，波动后伤害):", damage, rtValue)
	end	
	return rtValue
end

--[[
	开天-宠物被动：几率伤害加倍，几率恢复血量提高伤害(主)
]]
function NormalEffect:petDmgRedoubleORHpHealWithDmgInc(handler, target, damage)
	local rtValue = damage
	local isTrue, value_1, addType_1, value_2, addType_2 = handler:getDmgIncORHpHeal()
	if isTrue then
		if value_1 then
			local hpHeal = SkillUtils.getProperValue(damage, value_1, addType_1)
			rtValue = SkillUtils.calcNumAdd(damage, value_2, addType_2)
			local role = self.role
			hpHeal = SkillUtils.getHpChange(role, hpHeal)	
			local skill = self.skill
			skill:getPerformResult():addNormalResumeValue(role:getID(), hpHeal)
			print("开天(恢复生命，伤害加成后):", hpHeal, rtValue)
		else
			rtValue = rtValue * 2
			print("开天2倍伤害:", rtValue)
		end
	end	
	return rtValue
end

--[[
	法术汲取-宠物被动：吸蓝(主)
]]
function NormalEffect:petSuckMp(handler, target)
	if not instanceof(target, FightMonster) then
		local isTrue, value, addType = handler:getATWithMpSucking()
		-- isTrue, value, addType = true, 50, 1
		if isTrue then
			local role = self.role
			local pre = target:getMp()
			local pre_r = role:getMp()
			
			local mpChange = SkillUtils.getProperValue(target:getMp(), value, addType)
			mpChange = SkillUtils.getMpChange(target, 0 - mpChange)	
			local suckMp = SkillUtils.getMpChange(role, 0 - mpChange)	
			local cur = target:getMp()
			local cur_r = role:getMp()
			print("目标原先蓝量,流失蓝量,现在蓝量:", pre, mpChange, cur)
			print("自身原先蓝量,吸收蓝量,现在蓝量:", pre_r, suckMp, cur_r)
			local skill = self.skill
			skill:getPerformResult():addNormalResumeValue(target:getID(), false, mpChange)
			skill:getPerformResult():addNormalResumeValue(role:getID(), false, suckMp)
		end
	end
end

--[[
	法术流失-宠物被动：流失蓝(主)
]]
function NormalEffect:petOutflowMp(handler, target)
	if not instanceof(target, FightMonster) then
		local isTrue, value, addType = handler:getATWithMpOutflow()
		-- isTrue, value, addType = true, 50, 1
		if isTrue then
			local pre = target:getMp()
			local mpChange = SkillUtils.getProperValue(target:getMp(), value, addType)
			mpChange = SkillUtils.getMpChange(target, 0 - mpChange)	
			local cur = target:getMp()
			print("目标原先蓝量,流失蓝量,现在蓝量:", pre, mpChange, cur)
			local skill = self.skill
			skill:getPerformResult():addNormalResumeValue(target:getID(), false, mpChange)
		end
	end
end

--[[
	宠物被动：使用攻击技能附带BUFF效果(主)
]]
function NormalEffect:petAttackWithBuff(handler, target, damage)
	local rtValue = damage
	-- 强力破防
	local isTrue, buffID, value, addType = handler:getATWithBreakDefense()
	if isTrue then
		self:onSingleBuff(target, buffID)
		local targetHandler = target:getHandler(FightEntityHandlerType.SkillHandler)
		-- 防御技能列表
		local defenseSkills = {1031, 1032}
		-- 如果对方有防御或高级防御技能，将造成额外伤害（尚未处理）
		for _, id in ipairs(defenseSkills) do
			if targetHandler:getSkill(id) then
				rtValue = SkillUtils.calcNumAdd(damage, value, addType)
				print("破防额外伤害加成后:", rtValue)
				break
			end
		end
	end
	-- 强力重伤
	isTrue, buffID = handler:getATWithInjured()
	if isTrue then
		self:onSingleBuff(target, buffID)
	end
	return rtValue
end

--[[
	对存活目标添加BUFF
]]
function NormalEffect:onSingleBuff(target, buffID)
	if target and target:is_alive() then
		-- 添加目标到技能目标列表
		self:addTarget(target)	
		-- 设置目标BUFFID
		self:setTargetBuffID(target, buffID)
		local hitStatus = 0
		local level = self.skill:getSkillLevel()
		-- 添加BUFF
		if not g_fightBuffMgr:addBuff(self.role, target, buffID, level) then
			local handler = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
			hitStatus = handler:getHitStatus()
		end
		-- 设置BUFF命中状态
		self:setBuffHitStatus(target, hitStatus)

		Flog:log("ID:"..self.role:getID().." 添加BUFF".." ID:"..target:getID())
	end
end

local maxPursuitTimes = 1
--[[
	连击-宠物被动：追击(主)(暂不使用)
]]
function NormalEffect:petPursuit(target)
	local role = self.role
	if instanceof(role, FightPet) then
		local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
		-- 使用物理攻击技能触发追击
		if self:getAtType() == AtType.At then
			local isTrue = handler:getPhysicalPursuit()
			-- 限制追击次数,避免死循环
			local times = self.pursuitTimes
			if isTrue and times <= maxPursuitTimes then
				-- 如果对方有反震技能，只能攻击一次
				if instanceof(target, FightPet) then
					local targetHandler = target:getHandler(FightEntityHandlerType.SkillHandler)
					if targetHandler:getCounterFight() then
						return
					end
				end
				self:addPursuitTime()
				-- print("触发追击")
				self:perform(target)
			end
		-- 使用法术攻击技能触发追击
		else
			local isTrue = handler:getMagicalPursuit()
			-- 限制追击次数,避免死循环
			local times = self.pursuitTimes
			if isTrue and times < maxPursuitTimes then
				
				print("法术连击", target:getID())
				self:addPursuitTime()
				-- self:doPurse(target)
				self:perform(target)
				self:resetData()
			end
		end
	end
end

--[[
	物理连击-宠物被动(主)
]]
function NormalEffect:petAtPursuit(target)
	local role = self.role
	if instanceof(role, FightPet) then
		local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
		-- 使用物理攻击技能触发追击
		local isTrue = handler:getPhysicalPursuit()
		-- 限制追击次数,避免死循环
		local times = self.pursuitTimes
		if isTrue and times < maxPursuitTimes then
			-- 如果对方有反震技能，只能攻击一次
			if instanceof(target, FightPet) then
				local targetHandler = target:getHandler(FightEntityHandlerType.SkillHandler)
				if targetHandler:getCounterFight() then
					print("对方有反震技能，只能攻击一次")
					return
				end
			end
			self:addPursuitTime()
			print("物理连击")
			self:perform(target)
			self:resetData()
		end
	end
end

--[[
	法术连击-宠物被动(主))
]]
function NormalEffect:petMtPursuit(target)
	local role = self.role
	if instanceof(role, FightPet) then
		local handler = role:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue = handler:getMagicalPursuit()
		-- 限制追击次数,避免死循环
		local times = self.pursuitTimes
		if isTrue and times < maxPursuitTimes then
			print("法术连击")
			self:addPursuitTime()
			self:perform(target)
			self:resetData()
		end
	end
end