--[[UnionEffect.lua
	描述：处理技能效果相关逻辑
]]

UnionEffect = class(SkillEffect)

--[[
	合击效果
]]
function UnionEffect:doUnionAt(target)
	if not target:is_alive() then
		target = SkillUtils.getCanBeAttackedPartner(target)
	end
	if target then
		--[[
		-- 添加目标到技能目标列表
		self:addTarget(target)
		--]]
		self:incAnger(target, AttackIncAnger)
		self:incAnger(self.role, BeAttackIncAnger)
		-- 获取乙方全体成员(包括自己)
		local members = SkillUtils.getPartners(self.role, false, true)
		for _, men in pairs(members) do
			local handler = men:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
			local state = handler:getDisorderState()
			-- 状态判断
			if state[toEnemy].can == 1 and state[toEnemy].joinUnionAt == 1  then
				self:onUnionSingleAt(target, men)
			end
		end
		
		-- 测试用
		local str = ""
		for _,mem in pairs(members) do
			str = str .. mem:getID() ..", "
		end
		str = str .. "合击:" .. target:getID() .."\n"
		Flog:log(str)
	end
	return true
end

--[[
	执行单体合击
]]
function UnionEffect:onUnionSingleAt(target, role)
	local numType = self.numType
	local numValue = self.numValue
	-- 物理攻击力
	local physicATK = numValue
	if numType == AddType.percent then
		physicATK = role:ft_get_at() * numValue / 1000
	end
	-- 目标物理防御力
	local physicDEF = target:ft_get_af()
	local damage = 0
	if physicATK >= physicDEF then
		damage = physicATK - physicDEF
	end
	if damage == 0 then
		damage = 1
	end
	local hpChange = SkillUtils.getHpChange(target, 0 - damage)
	
	self.targetList = {}
	self:addTarget(target)
	self:setResultStatusType(target)
	self:setUnionPartnerID(target, role:getID())
	self:checkAlive(target)
	self:setTargetHpChange(target, hpChange)
	self.skill:getPerformResult():addUnionResultAction(self.targetList)
	Flog:log(role:getID().." 合击物攻 "..target:getID().." 伤害: "..damage.."\n")
end

--[[
	设置合击技能合作者ID
]]
function UnionEffect:setUnionPartnerID(target, id)
	local status = self:getTargetStatus(target)
	if status then
		status.partnerID = id
	end
end