--[[SkillEffect.lua
	描述：处理技能效果相关逻辑以及伤害计算(基类)
		通过skill更新attackedTargets、deadList数据;
		自身维护protectList、targetList,用于生成技能释放结果;
]]

SkillEffect = class()

require "skill.SkillEffect.UnionEffect"
require "skill.SkillEffect.ResumeEffect"
require "skill.SkillEffect.NormalEffect"
require "skill.SkillEffect.AddBuffEffect"
require "skill.SkillEffect.RevivalEffect"
require "skill.SkillEffect.DispelEffect"
require "skill.SkillEffect.PassiveSkillEffect"

function SkillEffect:__init(skill, effect)
	self.role				= skill:getSkillRole()			-- 所属角色
	self.skill				= skill							-- 所属技能

	self.type 				= effect.type					-- 效果类型
	self.numID 				= effect.numID					-- 效果公式ID
	self.targetType 		= effect.targetType				-- 目标类型
	self.targetNum			= effect.targetNum				-- 目标数量
	self.numType			= effect.numType				-- 效果加成类型
	self.numValue			= effect.numValue				-- 效果数值

	self.notProtect			= nil							-- 无保护标志
	self.pursuitTimes		= 0								-- 追击次数
	
	self.targetList			= nil							-- 效果目标状态集合
	self.protectList 		= nil							-- 保护角色列表
end

function SkillEffect:__release()
	self.role				= nil
	self.skill				= nil
	
	self.type 				= nil
	self.numID 				= nil
	self.targetType 		= nil
	self.targetNum			= nil
	self.numType			= nil
	self.numValue			= nil
	
	self.notProtect			= nil
	self.pursuitTimes		= nil
	
	self.targetList			= nil
	self.protectList 		= nil
end

--[[
	重置数据
]]
function SkillEffect:resetData()
	self.targetList 	= {}
	self.protectList 	= nil
end

--[[
	执行效果
]]
function SkillEffect:perform(target)
	local _, doActionStr = unpack(SkillEffect2ActionMap[self.type])
	local doAction = self[doActionStr]
	if doAction then
		-- 执行效果前初始化并清空技能目标列表,避免上一次效果的影响
		self:resetData()
		if doAction(self, target) then
			local targetList = self.targetList
			if table.size(targetList) > 0 then
				local skill = self.skill
				local result = skill:getPerformResult()
				-- 合成结果集
				result:compoundResult(skill, targetList, self.type)
				return true
			end
		end
	end
	return false
end

--[[
	添加role到保护列表集合
]]
function SkillEffect:addProtectList(role)
	local id = role:getID()
	local protectors = self.protectList
	-- 不存在则初始化
	if not protectors then
		self.protectList = {}
		protectors = self.protectList
	end
	-- 不存在则添加
	local entity = protectors[id]
	if not entity then
		protectors[id] = {
			role = role,
		}
	end
end

--[[
	设置保护者改变值和改变属性
]]
function SkillEffect:setProtectChanged(id, value, type)
	local protectors = self.protectList[id]
	if protectors then
		protectors.attrType 	= type
		protectors.changedValue = value
	end
end

--[[
	添加攻击系技能目标
]]
function SkillEffect:addAttackedTarget(target)
	self.skill:addAttackedTarget(target)
end

--[[
	检测角色是否存活(判断血量再设置生命状态标志)
]]
function SkillEffect:checkAlive(role)
	return self.skill:checkAlive(role)
end

--[[
	追击次数加一
]]
function SkillEffect:addPursuitTime()
	self.pursuitTimes = self.pursuitTimes + 1
end

--[[
	设置不保护
]]
function SkillEffect:setNotProtect()
	self.notProtect = true
end

--[[
	添加新目标到技能效果目标集合
]]
function SkillEffect:addTarget(target)
	local id = target:getID()
	local targetList = self.targetList
	-- 不存在则添加
	if not targetList[id] then
		targetList[id] = {
			target = target,
		}
	end
end

--[[
	获取目标target的状态集合
]]
function SkillEffect:getTargetStatus(target)
	local id = target:getID()
	return self.targetList[id]
end

--[[
	设置目标结果集属性改变值
]]
function SkillEffect:setTargetBuffID(target, id)
	local targetStatus = self:getTargetStatus(target)
	if targetStatus then
		targetStatus.buffID = id
	end
end

--[[
	设置技能目标BUFF命中状态
]]
function SkillEffect:setBuffHitStatus(target, status)
	local targetStatus = self:getTargetStatus(target)
	if targetStatus then
		targetStatus.hitStatus = status
	end
end

--[[
	设置目标结果集属性改变值
]]
function SkillEffect:setTargetHpChange(target, value)
	local targetStatus = self:getTargetStatus(target)
	if targetStatus then
		-- 已存在则累加
		targetStatus.hp = targetStatus.hp or 0 + value
	end
end

--[[
	设置目标结果集属性改变值
]]
function SkillEffect:setTargetMpChange(target, value)
	local targetStatus = self:getTargetStatus(target)
	if targetStatus then
		-- 已存在则累加
		targetStatus.mp = targetStatus.mp or 0 + value
	end
end

--[[
	玩家角色增加怒气
]]
function SkillEffect:incAnger(role, value)
	if instanceof(role, FightPlayer) then
		role:inc_anger(value)
	end
end

--[[
	物理攻击效果(子类已重写)
]]
function SkillEffect:doAt(target)
	local addNum = self:getAddAttackTargetNum()
	if addNum == 0 and self.targetType == TargetType.enemy then
		self:onSingleAt(target)
	-- elseif self.targetType == TargetType.enemy_g then
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
	法术攻击效果(子类已重写)
]]
function SkillEffect:doMt(target)
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

--[[
	追击效果(子类已重写)
]]
function SkillEffect:doPurse(target)
	if math.random(100) < self.numValue / 10 then
		local handler = self.role:getHandler(FightEntityHandlerType.SkillHandler)
		local skill = handler:getSkill(self.id)
		local effects = skill:getSkillEffects()
		-- 复制要重复执行的效果
		effect = unpack(effects)
		doActionStr = SkillEffect2Action[effect.type]
		local doAction = self[doActionStr]
		if doAction then
			-- 更新追击次数
			self:addPursuitTime()
			return doAction(self, target)
		end
	end
	return false
end

--[[
	添加BUFF效果(子类已重写)
]]
function SkillEffect:doAddBuff(target)
	-- 判断是否是单体效果
	if SkillUtils.isSingleEffect(self.targetType) then
		self:onSingleBuff(target, self.numID)
	else
		local targets = SkillUtils.getPartners(target, self.targetNum, true)
		for _, target in pairs(targets) do
			self:onSingleBuff(target, self.numID)
		end
	end
	return true
end

--[[
	HP恢复效果(子类已重写)
]]
function SkillEffect:doHpHeal(target)
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
	MP恢复效果(子类已重写)
]]
function SkillEffect:doMpHeal(target)
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
	合击效果(子类已重写)
]]
function SkillEffect:doUnionAt(target)
	return true
end

--[[
	增加暴击率效果
]]
function SkillEffect:doAddCrit(target)
	local critical = target:ft_get_critical()
	local addNum = SkillUtils.getProperValue(critical, self.numValue, self.numType)
	return true
end

--[[
	复活效果(子类已重写)
]]
function SkillEffect:doRevival(target)
	local prob = self.numValue / 10
	-- 测试
	-- prob = 100
	if (math.random(100) <= prob) then
		self.role:setLifeState(RoleLifeState.Normal)
		return true
	end
	return false
end

--[[
	增益驱散效果(子类已重写)
]]
function SkillEffect:doDispel(target)
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
	烧蓝效果(子类已重写)
]]
function SkillEffect:doMpReduce(target)
	if SkillUtils.getRoleType(target) == RoleType.Monster then
		return false
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
	攻击系技能增加攻击目标(子类已重写)
]]
function SkillEffect:getAddAttackTargetNum()
	return 0
end

--[[
	设置驱散标志
]]
function SkillEffect:setDispelFlag(target)
	local id = target:getID()
	local temp = self.targetList[id]
	if temp then
		temp.dispel = true
	end
end

--[[
	设置闪避标志
]]
function SkillEffect:setDodgeFlag(target)
	local id = target:getID()
	local temp = self.targetList[id]
	if temp then
		temp.isDodge = true
	end
end

--[[
	设置暴击标志
]]
function SkillEffect:setCriticalFlag(target)
	local status = self:getTargetStatus(target)
	if status then
		status.isCritical = true
	end
end

--[[
	设置反震标志和反震值
]]
function SkillEffect:setCounter(target, value)
	if value and value > 0 then
		local role = self.role
		local change = SkillUtils.getHpChange(role, 0-value)
		local curHp = role:getHp()
		if curHp <= 0 then
			role:setLifeState(RoleLifeState.Dead)
		end
		local status = self:getTargetStatus(target)
		if status then
			status.counterValue = change
			status.isCounter = true
		end
	end
end

--[[
	设置防御标志
]]
function SkillEffect:setDefenseFlag(target)
	local status = self:getTargetStatus(target)
	if status then
		status.isDefense = true
	end
end

--[[
	设置无效标志
]]
function SkillEffect:setInvalidFlag(target)
	local status = self:getTargetStatus(target)
	if status then
		status.isValid = true
	end
end

--[[
	设置目标受击状态
]]
function SkillEffect:setResultStatusType(target)
	local type = self:getResultStatusType(target:getID())
	local targetStatus = self:getTargetStatus(target)
	if targetStatus then
		targetStatus.statusType = type
	end
end

--[[
	获取目标受击状态(暂时这样实现)
]]
function SkillEffect:getResultStatusType(targetID)
	local status = self.targetList[targetID]
	if status then
		-- 闪避
		if status.isDodge then
			return ResultStatusType.Miss
		-- 爆击
		elseif status.isCritical then
			-- 爆击+反弹
			if status.isCounter then
				return ResultStatusType.CriticalAndCounter
			end
			-- 爆击+防御
			if status.isDefense then
				return ResultStatusType.CriticalAndDefense
			end
			return ResultStatusType.Critical
		-- 反弹
		elseif status.isCounter then
			-- 防御+反弹
			if status.isDefense then
				return ResultStatusType.DefenseAndCounter
			end
			-- 爆击+反弹
			if status.isCritical then
				return ResultStatusType.CriticalAndCounter
			end
			return ResultStatusType.Counter
		-- 防御
		elseif status.isDefense then
			-- 防御+反弹
			if status.isCounter then
				return ResultStatusType.DefenseAndCounter
			end
			-- 爆击+防御
			if status.isCritical then
				return ResultStatusType.CriticalAndDefense
			end
			return ResultStatusType.Defense
		-- 无效
		elseif status.isValid then
			return ResultStatusType.Invalid
		end
	end
	return 0
end



