--[[SystemSkill.lua
描述：
	系统技能
--]]

SystemSkill = class()

function SystemSkill:__init(skillID,skillLevel)
	-- 技能的ID
	self.id = skillID
	-- 等级默认为 1
	self.level = skillLevel
	-- 配置
	self.comfig = SystemSkillDB[self.id]
end

function SystemSkill:__release()
	self.id = nil
	self.level = nil
	self.comfig = nil
end

local SystemSkillEffMap = 
{
	[SkillEff.At] 		= {"doSingleAt"},		--物理伤害
	[SkillEff.Mt] 		= {"doSingleMt"},		--法术伤害
	[SkillEff.Buff] 	= {"doSingleAddBuff"},	--buff
	[SkillEff.HpHeal] 	= {"doSingleHpHeal"},	--生命恢复
	[SkillEff.MpHeal] 	= {"doSingleMpheal"},	--法力恢复
	[SkillEff.Dispel] 	= {"doSingleDispel"},	--增益驱散
}

-- 技能的使用函数
function SystemSkill:perform(targets)
	Flog:log("系统技能开始".." skill:"..self.id.."\n")	
	-- 死亡记录
	self.deadList = {}
	-- 技能的结果集 记录
	self.result = {}
	-- 目标集 临时记录变化数据
	self.targetsList = {}
	-- 是否是多目标 记录
	-- 判断是否存在攻击目标
	if not targets or #targets == 0 then
		return nil
	end
	-- 把目标存储到组里
	self.targetGroup = targets
	-- 处理伤害 构建结果集
	for _,skillEffect in pairs(self.comfig.skill) do
		local funName = SystemSkillEffMap[skillEffect.type]
		self:doChooseTargetNum(skillEffect,funName[1])
	end
	-- 把设置技能结果集
	self:setSystemResult()
	Flog:log("技能结束\n")
	return self.result, self.deadList
end

-- 选择出技能施放的目标并用对应的函数
function SystemSkill:doChooseTargetNum(skillEffect,funcName)
	-- 判断是群体还是单体
	if SkillUtils.isSingleEffect(skillEffect.target_type) then
		for _,target in pairs(self.targetGroup) do
			self[funcName](self,skillEffect,target)
		end
	else
		--判断目标中有对应的两方人物
		local aSizeTarget,bSizeTarget = SkillUtils.getGroupEnemy(self.targetGroup)
		-- 得到攻击的数量
		local targetNum = MonsterSkillDataDB[skillEffect.target_id][self.level]
		if aSizeTarget then
			local aTargets = SkillUtils.getCanBeAttackedPartners(aSizeTarget, targetNum, true)
			for _,target in pairs(aTargets) do
				self[funcName](self,skillEffect,target)
			end
		end
		if bSizeTarget then
			local bTargets = SkillUtils.getCanBeAttackedPartners(bSizeTarget, targetNum, true)
			for _,target in pairs(bTargets) do
				self[funcName](self,skillEffect,target)
			end
		end
	end
end

-- 检测角色生命是否存活
function SystemSkill:checkAlive(role)
	if role:getHp() == 0 then
		role:setLifeState(RoleLifeState.Dead)
		if SkillUtils.canRevival(role) then
			table.insert(self.deadList, role:getID())
		end
		return false
	end
	return true
end

-- 加入到改变集
function SystemSkill:addTargetsList(target)
	local id = target:getID()
	-- 不存在则添加
	if not self.targetsList[id] then
		 self.targetsList[id] = {
			target = target,
		}
	end
end

-- 获取目标target的状态集合
function SystemSkill:getTargetStatus(target)
	local id = target:getID()
	if self.targetsList[id] then
		return self.targetsList[id]
	end
	return nil
end

-- 设置目标结果集属性改变值
function SystemSkill:setTargetHpChange(target, value)
	local status = self:getTargetStatus(target)
	if status then
		local hp = status.hp and status.hp or 0
		status.hp = hp + value
	end
end

-- 设置目标结果集属性改变值
function SystemSkill:setTargetMpChange(target, value)
	local status = self:getTargetStatus(target)
	if status then
		local mp = status.mp and status.mp or 0
		status.mp = mp + value
	end
end

-- 设置技能目标BUFF命中状态
function SystemSkill:setTargetBuff(target, buffID)
	local status = self:getTargetStatus(target)
	if status then
		status.buffId = buffID
	end
end

-- 设置技能目标受击状态
function SystemSkill:setTargetStatus(target, status)
	local status = self:getTargetStatus(target)
	if status then
		status.status = status
	end
end

function SystemSkill:getResultStatusType(targetID)
	local status = self.targetsList[targetID]
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

require "skill.SystemSkillAtom"
require "skill.SystemSkillResult"



