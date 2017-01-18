--[[ResumeEffect.lua
	描述：处理技能效果相关逻辑以及伤害计算
]]

ResumeEffect  = class(SkillEffect)

--[[
	HP恢复效果
]]
function ResumeEffect:doHpHeal(target)
	-- 判断是否是单体效果
	if SkillUtils.isSingleEffect(self.targetType) then
		self:onSingleHpHeal(target)
	else
		local targets = SkillUtils.getPartners(target, self.targetNum, true)
		for _, target in pairs(targets) do
			self:onSingleHpHeal(target)
		end
	end
	return true
end

--[[
	MP恢复效果
]]
function ResumeEffect:doMpHeal(target)
	if instanceof(target, FightMonster) then
		return false
	end
	-- 判断是否是单体效果
	if SkillUtils.isSingleEffect(self.targetType) then
		self:onSingleMpChange(target, self.numValue, self.numType)
	else
		local targets = SkillUtils.getPartners(target, self.targetNum, true)
		for _, target in pairs(targets) do
			self:onSingleMpChange(target, self.numValue, self.numType)
		end
	end
	return true
end

--[[
	烧蓝效果
]]
function ResumeEffect:doMpReduce(target)
	if instanceof(target, FightMonster) then
		--return false
	end
	-- 判断是否是单体效果
	if SkillUtils.isSingleEffect(self.targetType) then
		self:onSingleMpChange(target, 0 - self.numValue, self.numType)
	else
		local targets = SkillUtils.getCanBeAttackedPartners(target, self.targetNum, true)
		for _, target in pairs(targets) do
			self:onSingleMpChange(target, 0 - self.numValue, self.numType)
		end
	end
	return true
end

--[[
	执行单体HP恢复
]]
function ResumeEffect:onSingleHpHeal(target)
	if not target:is_alive() then return end
	
	-- 根据计算类型得到恢复的数值
	local numValue = self.numValue
	local numType = self.numType
	local change = numValue
	if numType == AddType.percent then
		change = math.floor(target:getMaxHp() * numValue / 1000)
	end
	
	change = self:calcHpHealChange(target, change)
	
	-- 添加目标到技能目标列表
	self:addTarget(target)	
	local hpChange = SkillUtils.getHpChange(target, change)
	self:setTargetHpChange(target, hpChange)
	
	Flog:log(target:getID() .." 恢复HP"..":"..hpChange.."\n")
end

--[[
	计算由于被动或BUFF引起的治疗效果改变
]]
function ResumeEffect:calcHpHealChange(target, resumpHp)
	local rtValue = resumpHp
	-- 判断是否有治疗效果减益buff
	local buffHandler = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	local isTrue, value, addType = buffHandler:getHealReduce()
	if isTrue then
		rtValue = SkillUtils.calcNumAdd(rtValue, 0 - value, addType)
		rtValue = rtValue > 0 and rtValue or 0
		Flog:log("治疗效果减少为:"..rtValue.."\n")
	end
	-- 提神-宠物接受治疗效果增加
	if instanceof(target, FightPet) then
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		local isTrue, value, addType = handler:getAcceptHealEffectInc()
		-- isTrue, value, addType = true, 50, 1
		if isTrue then
			resumpHp = rtValue
			rtValue = SkillUtils.calcNumAdd(resumpHp, value, addType)
			print("原始治疗量，治疗量加成后:", resumpHp, rtValue)
		end
	end
	return rtValue
end

--[[
	执行单体MP恢复
]]
function ResumeEffect:onSingleMpChange(target, value, addType)
	if not target:is_alive() then return end
	
	-- 根据计算类型得到改变的数值
	local numType = addType
	local numValue = value
	local change = numValue
	
	if numType == AddType.percent then
		change = math.floor(target:getMaxMp() * numValue / 1000)
	end  
	-- 添加目标到技能目标列表
	self:addTarget(target)	
	local mpChange = SkillUtils.getMpChange(target, change)
	self:setTargetMpChange(target, mpChange)
	
	Flog:log(target:getID() .." 恢复MP"..":"..mpChange.."\n")
end


