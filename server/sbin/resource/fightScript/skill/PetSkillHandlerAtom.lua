--[[PetSkillHandlerAtom.lua
	描述：宠物状态被动技能的初始化和获得
]]

local PetSkillDataDB			= PetSkillDataDB		-- 技能数据
local PetSkillDB				= PetSkillDB		-- 技能数据

--[[
	获取第一个技能效果数值、第二个技能效果的数值和加成类型
]]
function PetSkillHandler:getThreeValue(id, level)
	local skill = PetSkillDB[id].skill
	local effect_1, effect_2 = unpack(skill)
	local data_1 = PetSkillDataDB[effect_1.num_id]
	if effect_2 then
		local data_2 = PetSkillDataDB[effect_2.num_id]
		return data_1[level], data_2[level], data_2.type
	end
	return data_1[level]
end

--[[
	获取第一个技能效果的数值和加成类型
]]
function PetSkillHandler:getTwoValue(id, level)
	local skill = PetSkillDB[id].skill
	local effect_1 = unpack(skill)
	local data_1 = PetSkillDataDB[effect_1.num_id]
	return data_1[level], data_1.type
end

--[[
	战斗属性相关
]]
-- 物理攻击力改变
function PetSkillHandler:physicalATKChange(value, addType)
	if value then
		value = value / 10 --百分比加成
		print("宠物物理攻击加成:", value, addType)
		self.role:ft_add_at(value, addType == AddType.percent)
	end
end

-- 法术攻击力改变
function PetSkillHandler:magicalATKChange(value, addType)
	if value then
		value = value / 10 --百分比加成
		print("宠物法术攻击加成:", value, addType)
		self.role:ft_add_mt(value, addType == AddType.percent)
	end
end

-- 法术防御力改变
function PetSkillHandler:magicalDEFChange(value, addType)
	if value then
		value = value / 10 --百分比加成
		print("宠物法术防御力加成:", value, addType)
		self.role:ft_add_mf(value, addType == AddType.percent)
	end
end

--[[
	主动触发
]]
-- 连击：使用物理技能攻击时，有几率触发连击效果，拥有此技能物理攻击效果会降低
function PetSkillHandler:pPhysicalPursuit(id, level)
	local value_1, value_2, addType = self:getThreeValue(id, level)
	value_1 = value_1 / 10
	value_2 = value_2 / 10
	self:physicalATKChange(value_2, addType)
	self.statePassiveList[PetPassiveEffect.PhysicalPursuit] = value_1
end

function PetSkillHandler:getPhysicalPursuit()
	local tmp = self.statePassiveList[PetPassiveEffect.PhysicalPursuit]
	if tmp and math.random(100) < tmp then
		return true
	end
	return false
end

-- 必杀：物理暴击几率提高，出现必杀时伤害结果会加倍
function PetSkillHandler:pPhysicalATCrit(id, level)
	local value = self:getTwoValue(id, level)
	value = value / 10
	self.statePassiveList[PetPassiveEffect.PhysicalATCritAdd] = value
end

function PetSkillHandler:getPhysicalATCrit()
	local tmp = self.statePassiveList[PetPassiveEffect.PhysicalATCritAdd]
	if tmp then
		return true, tmp
	end
end

-- 偷袭：反击反震免疫，攻击提高
function PetSkillHandler:pSBAndCFImmuneWithATKInc(id, level)
	local data = PetSkillDB[id].skill
	local _, _, effect_3 = unpack(data)
	local data_3 = PetSkillDataDB[effect_3.num_id]
	local value = data_3[level] / 10
	local addType = data_3.type
	self:physicalATKChange(value, addType)
	self:magicalATKChange(value, addType)
	self.statePassiveList[PetPassiveEffect.CounterFightImmune] = true
	self.statePassiveList[PetPassiveEffect.StrikeBackImmune] = true
end

-- 反击免疫
function PetSkillHandler:getStrikeBackImmune()
	return self.statePassiveList[PetPassiveEffect.StrikeBackImmune]
end

-- 反震免疫
function PetSkillHandler:getCounterFightImmune()
	return self.statePassiveList[PetPassiveEffect.CounterFightImmune]
end

-- 法术连击：使用法术攻击目标时有几率连续2次攻击敌人
function PetSkillHandler:pMagicalPursuit(id, level)
	local value = self:getTwoValue(id, level)
	value = value / 10
	self.statePassiveList[PetPassiveEffect.MagicalPursuit] = value
end

function PetSkillHandler:getMagicalPursuit()
	local tmp = self.statePassiveList[PetPassiveEffect.MagicalPursuit]
	if tmp and math.random(100) < tmp then
		return true
	end
	return false
end

-- 法术暴击：法术攻击有几率法术伤害提高
function PetSkillHandler:pMagicalATCrit(id, level)
	local value_1, value_2, addType = self:getThreeValue(id, level)
	local tmp = {}
	tmp.prob = value_1 / 10
	tmp.value = value_2 / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.MagicalATCrit] = tmp 
end

function PetSkillHandler:getMagicalATCrit()
	local tmp = self.statePassiveList[PetPassiveEffect.MagicalATCrit]
	if  tmp and math.random(100) < tmp.prob then
		return true, tmp.value, tmp.addType
	end
	return false
end

-- 法术波动：法术攻击伤害波动
function PetSkillHandler:pMagicalATDmgFluctuate(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.MagicalATDmgFluctuate] = tmp 
end

function PetSkillHandler:getMagicalATDmgFluctuate()
	local tmp = self.statePassiveList[PetPassiveEffect.MagicalATDmgFluctuate]
	if  tmp then
		return true, tmp.value, tmp.addType
	end
	return false
end

-- 开天：几率伤害加倍，几率恢复血量提高伤害
function PetSkillHandler:pDmgIncORHpHeal(id, level)
	local skill = PetSkillDB[id].skill
	local effect_1, effect_2, effect_3, effect_4 = unpack(skill)
	local data_1 = PetSkillDataDB[effect_1.num_id]
	local data_2 = PetSkillDataDB[effect_2.num_id]
	local data_3 = PetSkillDataDB[effect_3.num_id]
	local data_4 = PetSkillDataDB[effect_4.num_id]
	local tmp = {}
	tmp.prob_1 = data_1[level] / 10
	tmp.prob_2 = data_2[level] / 10
	tmp.value_1 = data_3[level] / 10
	tmp.addType_1 = data_3.type
	tmp.value_2 = data_4[level] / 10
	tmp.addType_2 = data_4.type
	self.statePassiveList[PetPassiveEffect.DmgIncORHpHeal] = tmp 
end

function PetSkillHandler:getDmgIncORHpHeal()
	local tmp = self.statePassiveList[PetPassiveEffect.DmgIncORHpHeal]
	if  tmp then
		local randNum = math.random(100)
		local prob = tmp.prob_1
		if randNum < prob then
			return true
		elseif randNum < (prob + tmp.prob_2) then
			return true, tmp.value_1, tmp.addType_1, tmp.value_2, tmp.addType_2
		end
	end
	return false
end

--[[
	主动触发：攻击附带效果
]]
-- 吸血：物理攻击时，吸收攻击主目标伤害值的一定比例血量
function PetSkillHandler:pPATWithBloodSucking(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.PATWithBloodSucking] = tmp
end

function PetSkillHandler:getPATWithBloodSucking()
	local tmp = self.statePassiveList[PetPassiveEffect.PATWithBloodSucking]
	if tmp then
		return true, tmp.value, tmp.addType
	end
	return false
end

-- 破防：攻击附带破防，对方有防御技能造成额外伤害
function PetSkillHandler:pATWithBreakDefense(id, level)
	local skill = PetSkillDB[id].skill
	local effect_1, effect_2, effect_3 = unpack(skill)
	local data_1 = PetSkillDataDB[effect_1.num_id]
	local data_3 = PetSkillDataDB[effect_3.num_id]
	local tmp = {}
	tmp.prob = data_1[level] / 10
	tmp.buffID = effect_2.num_id
	tmp.value = data_3[level] / 10
	tmp.addType = data_3.type
	self.statePassiveList[PetPassiveEffect.ATWithBreakDefense] = tmp 
end

function PetSkillHandler:getATWithBreakDefense()
	local tmp = self.statePassiveList[PetPassiveEffect.ATWithBreakDefense]
	if  tmp and math.random(100) < tmp.prob then
		return true, tmp.buffID, tmp.value, tmp.addType
	end
	return false
end

-- 重伤：攻击附带重伤BUFF
function PetSkillHandler:pATWithInjured(id, level)
	local skill = PetSkillDB[id].skill
	local effect_1, effect_2 = unpack(skill)
	local data_1 = PetSkillDataDB[effect_1.num_id]
	local tmp = {}
	tmp.prob = data_1[level] / 10
	tmp.buffID = effect_2.num_id
	self.statePassiveList[PetPassiveEffect.ATWithInjured] = tmp 
end

function PetSkillHandler:getATWithInjured()
	local tmp = self.statePassiveList[PetPassiveEffect.ATWithInjured]
	if  tmp and math.random(100) < tmp.prob then
		return true, tmp.buffID
	end
	return false
end

-- 法术汲取：攻击吸收法力
function PetSkillHandler:pATWithMpSucking(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.ATWithMpSucking] = tmp
end

function PetSkillHandler:getATWithMpSucking()
	local tmp = self.statePassiveList[PetPassiveEffect.ATWithMpSucking]
	if tmp then
		return true, tmp.value, tmp.addType
	end
	return false
end

-- 法术流失：攻击敌方目标时附带让敌人流失一定比例的法力
function PetSkillHandler:pATWithMpOutflow(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.ATWithMpOutflow] = tmp
end

function PetSkillHandler:getATWithMpOutflow()
	local tmp = self.statePassiveList[PetPassiveEffect.ATWithMpOutflow]
	if tmp then
		return true, 0 - tmp.value, tmp.addType
	end
	return false
end

--[[
	被动触发
]]
-- 物理反击：受到物理攻击时有几率普通攻击反击，反击伤害为普通伤害一定比例 
function PetSkillHandler:pNormalStrikeBack(id, level)
	local value_1, value_2, addType = self:getThreeValue(id, level)
	local tmp = {}
	tmp.prob = value_1 / 10
	tmp.value = value_2 / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.NormalStrikeBack] = tmp 
end

function PetSkillHandler:getNormalStrikeBack()
	local tmp = self.statePassiveList[PetPassiveEffect.NormalStrikeBack]
	if  tmp and math.random(100) < tmp.prob then
		return true, tmp.value, tmp.addType
	end
	return false
end

-- 法术反击：受到法术攻击时有几率自动使用固定法术技能反击 
function PetSkillHandler:pMagicalStrikeBack(id, level)
	local value_1, value_2 = self:getThreeValue(id, level)
	local tmp = {}
	tmp.prob = value_1 / 10
	tmp.value = value_2
	self.statePassiveList[PetPassiveEffect.MagicalStrikeBack] = tmp 
end

function PetSkillHandler:getMagicalStrikeBack()
	local tmp = self.statePassiveList[PetPassiveEffect.MagicalStrikeBack]
	if  tmp and math.random(100) < tmp.prob then
		local value = tmp.value
		local tableMap = {}
		-- 初级法术技能
		if value == 1 then
			tableMap = PetPrimaryMagicalSkills
		-- 高级法术技能
		else
			tableMap = PetAdvancedMagicalSkills
		end
		for _, id in ipairs(tableMap) do
			local skill = self:getSkill(id)
			if skill then
				return true, id
			end
		end
	end
	return false
end

-- 反震：受到物理攻击时有几率自动反震，反震伤害为所受伤害一定比例
function PetSkillHandler:pCounterFight(id, level)
	local value_1, value_2, addType = self:getThreeValue(id, level)
	local tmp = {}
	tmp.prob = value_1 / 10
	tmp.value = value_2 / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.CounterFight] = tmp 
end

function PetSkillHandler:getCounterFight()
	local tmp = self.statePassiveList[PetPassiveEffect.CounterFight]
	if  tmp and math.random(100) < tmp.prob then
		return true, tmp.value, tmp.addType
	end
	return false
end

-- 幸运：不会受到暴击攻击，并有几率躲避敌人的法术攻击
function PetSkillHandler:pCritImmuneAndMATDodge(id, level)
	local skill = PetSkillDB[id].skill
	local _, effect_2 = unpack(skill)
	local tmp = 0
	if effect_2 then
		local data_2 = PetSkillDataDB[effect_2.num_id]
		self:magicalATDodge(data_2[level])
	end
	self.statePassiveList[PetPassiveEffect.CritImmune] = tmp 
end

function PetSkillHandler:getCritImmune()
	local tmp = self.statePassiveList[PetPassiveEffect.CritImmune]
	if tmp then return true end
end

-- 法术攻击闪避
function PetSkillHandler:magicalATDodge(value)
	local tmp = value / 10
	self.statePassiveList[PetPassiveEffect.MagicalATDodge] = tmp 
end

function PetSkillHandler:getMagicalATDodge()
	local tmp = self.statePassiveList[PetPassiveEffect.MagicalATDodge]
	if tmp and math.random(100) < tmp then
		return true
	end
end

-- 招架：物理攻击闪避
function PetSkillHandler:pPhysicalATDodge(id, level)
	local value = self:getTwoValue(id, level)
	self:physicalATDodge(value)
end

-- 物理攻击闪避
function PetSkillHandler:physicalATDodge(value)
	local tmp = value / 10
	self.statePassiveList[PetPassiveEffect.PhysicalATDodge] = tmp 
end

function PetSkillHandler:getPhysicalATDodge()
	local tmp = self.statePassiveList[PetPassiveEffect.PhysicalATDodge]
	if tmp and math.random(100) < tmp then
		return true
	end
end

-- 涅槃：有几率复活恢复生命
function PetSkillHandler:pRevival(id, level)
	self.statePassiveList[PetPassiveEffect.Revival] = PetSkill(self.role, id, level)
end

function PetSkillHandler:getRevival()
	return self.statePassiveList[PetPassiveEffect.Revival]
end

--[[
	被动触发：伤害减免、免疫
]]
-- 汲取物伤：减免物理伤害
function PetSkillHandler:pPhysicalDmgReduce(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value / 10
	tmp.addType= addType
	self.statePassiveList[PetPassiveEffect.PhysicalDmgReduce] = tmp
end

function PetSkillHandler:getPhysicalDmgReduce()
	local tmp = self.statePassiveList[PetPassiveEffect.PhysicalDmgReduce]
	if tmp then
		return true, tmp.value, tmp.addType 
	end
	return false
end

-- 汲取法伤：减免法术伤害
function PetSkillHandler:pMagicalDmgReduce(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value / 10
	tmp.addType= addType
	self.statePassiveList[PetPassiveEffect.MagicalDmgReduce] = tmp
end

function PetSkillHandler:getMagicalDmgReduce()
	local tmp = self.statePassiveList[PetPassiveEffect.MagicalDmgReduce]
	if tmp then
		return true, tmp.value, tmp.addType 
	end
	return false
end

-- 法术免疫：有几率法术伤害免疫
function PetSkillHandler:pMagicalDmgImmune(id, level)
	local value = self:getTwoValue(id, level)
	value = value / 10
	self.statePassiveList[PetPassiveEffect.MagicalDmgImmune] = value
end

function PetSkillHandler:getMagicalDmgImmune()
	local tmp = self.statePassiveList[PetPassiveEffect.MagicalDmgImmune]
	if tmp and math.random(100) < tmp then
		return true
	end
	return false
end

-- 汲取相攻：减免相性伤害
function PetSkillHandler:pPhaseDmgReduce(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value / 10
	tmp.addType= addType
	self.statePassiveList[PetPassiveEffect.PhaseDmgReduce] = tmp
end

function PetSkillHandler:getPhaseDmgReduce()
	local tmp = self.statePassiveList[PetPassiveEffect.PhaseDmgReduce]
	if tmp then
		return true, tmp.value, tmp.addType 
	end
	return false
end

-- 相性免疫：有几率相性伤害免疫
function PetSkillHandler:pPhaseDmgImmune(id, level)
	local value = self:getTwoValue(id, level)
	value = value / 10
	self.statePassiveList[PetPassiveEffect.PhaseDmgImmune] = value
end

function PetSkillHandler:getPhaseDmgImmune()
	local tmp = self.statePassiveList[PetPassiveEffect.PhaseDmgImmune]
	if tmp and math.random(100) < tmp then
		return true
	end
	return false
end

-- 气血转化：有几率伤害免疫同时转换为血量
function PetSkillHandler:pDmgImmuneConvertToHp(id, level)
	local value_1, value_2, addType = self:getThreeValue(id, level)
	local tmp = {}
	tmp.prob = value_1 / 10
	tmp.value = value_2 / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.DmgImmuneConvertToHp] = tmp 
end

function PetSkillHandler:getDmgImmuneConvertToHp()
	local tmp = self.statePassiveList[PetPassiveEffect.DmgImmuneConvertToHp]
	if  tmp and math.random(100) < tmp.prob then
		return true, tmp.value, tmp.addType
	end
	return false
end

-- 以法续命：受到攻击有几率会通过减扣法力值来替代生命值
function PetSkillHandler:pReplaceHpWithMp(id, level)
	local value_1, value_2, addType = self:getThreeValue(id, level)
	local tmp = {}
	tmp.prob = value_1 / 10
	tmp.value = value_2 / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.ReplaceHpWithMp] = tmp 
end

function PetSkillHandler:getReplaceHpWithMp()
	local tmp = self.statePassiveList[PetPassiveEffect.ReplaceHpWithMp]
	if  tmp and math.random(100) < tmp.prob then
		return true, tmp.value, tmp.addType
	end
	return false
end

--[[
	被动触发增益
]]
-- 永恒：受到辅助类技能持续回合增加
function PetSkillHandler:pAcceptAssistRoundAdd(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.AcceptAssistRoundAdd] = tmp 
end

function PetSkillHandler:getAcceptAssistRoundAdd()
	local tmp = self.statePassiveList[PetPassiveEffect.AcceptAssistRoundAdd]
	if tmp then
		return true, tmp.value, tmp.addType
	end
end

-- 提神：接受治疗效果提高
function PetSkillHandler:pAcceptHealEffectInc(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.AcceptHealEffectInc] = tmp 
end

function PetSkillHandler:getAcceptHealEffectInc()
	local tmp = self.statePassiveList[PetPassiveEffect.AcceptHealEffectInc]
	if tmp then
		return true, tmp.value, tmp.addType
	end
end

--[[
	进入战斗即触发
]]
-- 慧根：法力消耗降低
function PetSkillHandler:pMpConsumeReduce(id, level)
	local value, addType = self:getTwoValue(id, level)
	local tmp = {}
	tmp.value = value / 10
	tmp.addType = addType
	self.statePassiveList[PetPassiveEffect.MpConsumeReduce] = tmp
end

function PetSkillHandler:getMpConsumeReduce()
	local tmp = self.statePassiveList[PetPassiveEffect.MpConsumeReduce]
	if tmp then
		return true, tmp.value, tmp.addType
	end
	return false
end

-- 魔之心：法术攻击力提高
function PetSkillHandler:pMagicalATKInc(id, level)
	local value, addType = self:getTwoValue(id, level)
	value = value / 10
	self:magicalATKChange(value, addType)
end

-- 法术抵抗：抵抗法术伤害即魔防提高，物理攻击下降
function PetSkillHandler:pMDEFIncAndPATKReduce(id, level)
	local value_1, value_2, addType = self:getThreeValue(id, level)
	value_1 = value_1 / 10
	value_2 = value_2 / 10
	self:magicalDEFChange(value_1, AddType.percent)
	self:physicalATKChange(value_2, addType)
end

--[[
	回合触发
]]
-- 再生：每回合固定恢复一定比例的血量
function PetSkillHandler:pRoundHpHeal(id, level)
	self.statePassiveList[PetPassiveEffect.RoundHpHeal] = PetSkill(self.role, id, level)
end

function PetSkillHandler:getRoundHpHeal()
	return self.statePassiveList[PetPassiveEffect.RoundHpHeal]
end

-- 冥思：回合恢复一定比例蓝量
function PetSkillHandler:pRoundMpHeal(id, level)
	self.statePassiveList[PetPassiveEffect.RoundMpHeal] = PetSkill(self.role, id, level)
end

function PetSkillHandler:getRoundMpHeal()
	return self.statePassiveList[PetPassiveEffect.RoundMpHeal]
end

-- 神迹：有几率回合减益驱散
function PetSkillHandler:pRoundDeBuffDispel(id, level)
	self.statePassiveList[PetPassiveEffect.RoundDeBuffDispel] = PetSkill(self.role, id, level)
end

function PetSkillHandler:getRoundDeBuffDispel()
	return self.statePassiveList[PetPassiveEffect.RoundDeBuffDispel]
end

