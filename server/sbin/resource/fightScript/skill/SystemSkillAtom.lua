--[[SystemSkillAtom.lua
描述：
	伤害的计算
--]]

-- 计算伤害加到临时目标改变中
function SystemSkill:calcDmg(target,dmgChange,dmgType)
	-- 相性伤害
	-- 人物状态为防御
	if target:getIsDefense() then
		dmgChange = dmgChange / 2
	end
	-- 护盾
	dmgChange = SkillUtils.calcShield(target,dmgChange,dmgType)
	local hpChange = SkillUtils.getHpChange(target,0-dmgChange)
	-- 提升怒气
	if SkillUtils.getRoleType(target) == RoleType.Player then
		target:inc_anger(10)
	end
	-- 检查是否死亡
	self:checkAlive(target)
	-- 把目标加到表中
	self:addTargetsList(target)
	self:setTargetHpChange(target,hpChange)
end

-- 单体物理伤害
function SystemSkill:doSingleAt(skillEffect,target)
	print("单体物理伤害")
	if not target:is_alive() then
		return false
	end
	-- 计算
	local addType = MonsterSkillDataDB[skillEffect.num_id].type
	print("ss",self.level)
	local addValue = MonsterSkillDataDB[skillEffect.num_id][self.level]
	local at = SkillUtils.calcNumAdd(0,addValue,addType)
	local af = target:ft_get_af()
	local dmgChange = 0
	if at >= af then
		dmgChange = at - af
	end
	return self:calcDmg(target,dmgChange,AtType.At)
end

-- 单体法伤
function SystemSkill:doSingleMt(skillEffect,target)
	if not target:is_alive() then
		return false
	end
	-- 计算
	local addType = MonsterSkillDataDB[skillEffect.num_id].type
	local addValue = MonsterSkillDataDB[skillEffect.num_id][self.level]
	local mt = SkillUtils.calcNumAdd(0,addValue,addType)
	local mf = target:ft_get_mf()
	local dmgChange = 0
	if mt >= mf then
		dmgChange = mt - mf
	end
	return self:calcDmg(target,dmgChange,AtType.Mt)
end

-- 单体加buff
function SystemSkill:doSingleAddBuff(skillEffect,target)
	if not target:is_alive() then
		return false
	end
	local buffID = skillEffect.num_id
	if g_fightBuffMgr:addBuff(nil,target,buffID,self.level) then
		-- 把目标加到表中
		self:addTargetsList(target)
		self:setTargetBuff(target,buffID)
	end
end

-- 单体恢复hp
function SystemSkill:doSingleHpHeal(skillEffect,target)
	if not target:is_alive() then
		return false
	end
	local addType = MonsterSkillDataDB[skillEffect.num_id].type
	local addValue = MonsterSkillDataDB[skillEffect.num_id][self.level]
	local hpchange = addValue
	if addType == AddType.percent then
		hpchange = math.floor(target:getHp() * addValue / 100)
	end
	hpchange = SkillUtils.getHpChange(target,hpchange)
	self:addTargetsList(target)
	self:setTargetHpChange(target,hpchange)
end

-- 单体恢复mp
function SystemSkill:doSingleMpheal(skillEffect,target)
	if not target:is_alive() then
		return false
	end
	local addType = MonsterSkillDataDB[skillEffect.num_id].type
	local addValue = MonsterSkillDataDB[skillEffect.num_id][self.level]
	local mpchange = addValue
	if addType == AddType.percent then
		mpchange = math.floor(target:getMp() * addValue / 100)
	end
	hpchange = SkillUtils.getHpChange(target,mpchange)
	self:addTargetsList(target)
	self:setTargetMpChange(target,mpchange)
end

-- 驱散
function SystemSkill:doSingleDispel(skillEffect,target)
	if not target:is_alive() then
		return false
	end
	g_fightBuffMgr:onClearAddBuff(target)
end
