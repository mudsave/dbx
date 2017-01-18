--[[DispelEffect.lua
	描述：处理技能效果相关逻辑
]]

DispelEffect = class(SkillEffect)

--[[
	增益驱散效果
]]
function DispelEffect:doDispel(target)
	-- 判断是否是单体效果
	if SkillUtils.isSingleEffect(self.targetType) then
		self:onSingleDispel(target)
	else
		local targets = SkillUtils.getCanBeAttackedPartners(target, self.targetNum, true)
		for _, target in pairs(targets) do
			self:onSingleDispel(target)
		end
	end
	return true
end

--[[
	减益驱散效果
]]
function DispelEffect:doDeBuffDispel(target)
	-- 判断是否是单体效果
	if SkillUtils.isSingleEffect(self.targetType) then
		self:onSingleDeBuffDispel(target)
	else
		local targets = SkillUtils.getCanBeAttackedPartners(target, self.targetNum, true)
		for _, target in pairs(targets) do
			self:onSingleDeBuffDispel(target)
		end
	end
	return true
end

--[[
	执行单体增益驱散
]]
function DispelEffect:onSingleDispel(target, value)
	local prob = self.numValue / 10
	-- 测试
	-- prob = 100
	if math.floor(100) <= prob then
		-- 添加目标到技能目标列表
		self:addTarget(target)
		self:setDispelFlag(target)
		g_fightBuffMgr:onClearAddBuff(target)
		Flog:log(target:getID().." 增益buff被驱散\n")
	end
end

--[[
	执行单体减益驱散
]]
function DispelEffect:onSingleDeBuffDispel(target, value)
	local prob = self.numValue / 10
	-- prob = 90
	if math.floor(100) <= prob then
		-- 添加目标到技能目标列表
		self:addTarget(target)
		self:setDispelFlag(target)
		g_fightBuffMgr:onClearDeBuff(target)
	end
end