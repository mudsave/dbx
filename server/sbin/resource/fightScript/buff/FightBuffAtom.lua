--[[FightBuffAtom.lua
描述:
	Buff类
]]

-- 障碍类buff
-- 混乱障碍
function Buff:startChaosObstacle()
	self.owner:setLifeState(RoleLifeState.Chaos)
	self.handler:setDisorderState(disorderChaos)
	return true
end

-- 中毒障碍
function  Buff:startPoisonObstacle()
	self.owner:setLifeState(RoleLifeState.Poison)
	self.handler:setDisorderState(disorderPoison)
	return true
end

-- 冰冻障碍
function  Buff:startFreezeObstacle()
	self.owner:setLifeState(RoleLifeState.Freeze)
	self.handler:setDisorderState(disorderFreeze)
	return true
end

-- 沉默障碍
function  Buff:startSilenceObstacle()
	self.owner:setLifeState(RoleLifeState.Silence)
	self.handler:setDisorderState(disorderSilence)
	return true
end

-- 嘲讽障碍
function  Buff:startTauntObstacle()
	self.owner:setLifeState(RoleLifeState.Taunt)
	self.handler:setDisorderState(disorderTaunt)
	return true
end

-- 昏睡障碍
function  Buff:startSoporObstacle()
	self.owner:setLifeState(RoleLifeState.Sopor)
	self.handler:setDisorderState(disorderSopor)
	return true
end

function Buff:calcDisorder()
	return self:calcBuffPeriod("stopDisorder")
end

function Buff:stopDisorder(isStopLight)
	if self.owner:getHp() > 0 then
		self.owner:setLifeState(RoleLifeState.Normal)
	end
	self.handler:setDisorderState(disorderNormal)
	-- 是否需要存在光效
	print("是否需要存在光效",isStopLight)
	if not isStopLight then
	print("是否需要存在光效2")
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 护盾
function Buff:startShield()
	return true
end

function Buff:calcShield()
	if self:getFirstEffectValue() <= 0 then
		self:stopShield()
		return false
	end
	return self:calcBuffPeriod("stopShield")
end

function Buff:stopShield(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 相性增益
function Buff:startAddPhase()
	self:startChangeAttrEffect(true)
	return true
end

function Buff:calcAddPhase()
	return self:calcBuffPeriod("stopAddPhase")
end

function Buff:stopAddPhase(isStopLight)
	self:stopChangeAttrEffect()
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 属性增益
function Buff:startAddAttr()
	self:startChangeAttrEffect(true)
	return true
end

function Buff:calcAddAttr()
	return self:calcBuffPeriod("stopAddAttr")
end

function Buff:stopAddAttr(isStopLight)
	self:stopChangeAttrEffect()
	if isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 减益
function Buff:startSub()
	self:startChangeAttrEffect(false)
	return true
end

function Buff:calcSub()
	return self:calcBuffPeriod("stopSub")
end

function Buff:stopSub(isStopLight)
	self:stopChangeAttrEffect()
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 特殊类buff
-- 乾元岛蓄力
function Buff:startQYDAccrue()
	self.handler:setImmunity(true)
	self:startChangeAttrEffect(true)
	return true
end

function Buff:calcQYDAccrue()
	return self:calcBuffPeriod("stopQYDAccrue")
end

function Buff:stopQYDAccrue(isStopLight)
	self.handler:setImmunity(false)
	self:stopChangeAttrEffect()
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 金霞山变身
function Buff:startJXSTrans()
	self:startChangeAttrEffect(true)
	return true
end

function Buff:calcJXSTrans()
	return self:calcBuffPeriod("stopJXSTrans")
end

function Buff:stopJXSTrans(isStopLight)
	self:stopChangeAttrEffect()
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 乾元岛虚弱
function Buff:startQYDXuRuo()
	self:startChangeAttrEffect(true)
	return true
end

function Buff:calcQYDXuRuo()
	return self:calcBuffPeriod("stopQYDXuRuo")
end

function Buff:stopQYDXuRuo(isStopLight)
	self:stopChangeAttrEffect()
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 紫阳门蓄力
function Buff:startZYMAccrue()
	self.handler:setMustCritical(true)
	return true
end

function Buff:calcZYMAccrue()
	return self:calcBuffPeriod("stopZYMAccrue")
end

function Buff:stopZYMAccrue(isStopLight)
	self.handler:setMustCritical(false)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 宠物buff
-- 治疗下降buff
function Buff:startHealReduce()
	return true
end
function Buff:calcHealReduceBuff()
	return self:calcBuffPeriod("stopHealReduceBuff")
end
function Buff:stopHealReduceBuff(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 降低宠物忠诚度,宠物忠诚度低于xx离开战场
function Buff:doReduceLoyalty()
	local owner = self.owner
	if instanceof(owner, FightPet) then
		local effect = self.effects[2]
		if math.random(100) < effect.effectValue then
			effect = self.effects[3]
			local loyalty = owner:getLoyalty()
			Flog:log("\n宠物ID:"..owner:getID().." 当前忠诚度:"..loyalty.." ")
			if effect.add_type == EffectAddType.FixedValue then
				loyalty = loyalty - effect.effectValue
			else
				loyalty = math.floor(loyalty * (100 - effect.effectValue) / 100)
			end
			loyalty = loyalty < 0 or 0 and loyalty
			owner:setLoyalty(loyalty)
			Flog:log("buff后忠诚度:"..loyalty.."\n")
			effect = self.effects[4]
			if loyalty < MaxPetLoyalty * effect.effectValue / 100 then
				FightUtils.ForcePetLeave(owner)
			end
		end
	end
end

-- 所有属性下降
function Buff:startAllAttrReduce()
	local func = nil
	local effect = self.effects[1]	
	if effect.addType == EffectAddType.FixedValue then
		for _, doStr in pairs(EffectTypeAction) do
			if doStr ~= "ft_add_all_attack" and doStr ~= "ft_add_all_defense" then 
				func = self.owner[doStr]
				effect.addValue = func(self.owner, 0 - effect.effectValue)
			end
		end	
	else
		effect.effectValue = effect.effectValue / 100
		local allAttrValue = {}
		for _, doStr in pairs(EffectTypeAction) do
			if doStr ~= "ft_add_all_attack" and doStr ~= "ft_add_all_defense" then
				func = self.owner[doStr]		
				allAttrValue[doStr] = func(self.owner, 0 - effect.effectValue, true)
				effect.addValue = allAttrValue
			end
		end
	end
	self:doReduceLoyalty()
	return true
end

function Buff:calcAllAttrReduce()
	return self:calcBuffPeriod("stopAllAttrReduce")
end

function Buff:stopAllAttrReduce(isStopLight)
	local effect = self.effects[1]
	if effect.addType == EffectAddType.FixedValue then
		for _, doStr in pairs(EffectTypeAction) do
			if doStr ~= "ft_add_all_attack" and doStr ~= "ft_add_all_defense" then
				func = self.owner[doStr]
				func(self.owner, 0 - effect.addValue)
			end	
		end
	else
		for _, doStr in pairs(EffectTypeAction) do
			if doStr ~= "ft_add_all_attack" and doStr ~= "ft_add_all_defense" then
				func = self.owner[doStr]
				func(self.owner, 0 - effect.addValue[doStr])
			end
		end
	end	
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 驱散buff
function Buff:startDispel()
	return true
end

function Buff:calcDispel()
	self.handler:doClearAddBuff()
	return self:calcBuffPeriod("stopDispel")
end

function Buff:stopDispel(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 相性克制buff
function Buff:startPhaseRestrain()
	return true
end
function Buff:calcPhaseRestrain()
	return self:calcBuffPeriod("stopPhaseRestrain")
end
function Buff:stopPhaseRestrain(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 反震伤害buff
function Buff:startCouterDmg()
	return true
end

function Buff:calcCouterDmg()
	return self:calcBuffPeriod("stopCouterDmg")
end

function Buff:stopCouterDmg(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 掉蓝 掉血 回血 回蓝 对于 表必须在开始时就插入到结果上
function Buff:startHpDot()
	return true
end

function Buff:calcHpDot()
	return self:calcBuffPeriod("stoptHpDot")
end

function Buff:stoptHpDot(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 持续加血buff
function Buff:startRestoreHp()
	return true
end

function Buff:calcRestoreHp()
	return self:calcBuffPeriod("stopRestoreHp")
end

function Buff:stopRestoreHp(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 持续掉蓝buff
function Buff:startMpDot()
	return true
end

function Buff:calcMpDot()
	return self:calcBuffPeriod("stopMpDot")
end

function Buff:stopMpDot(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end

-- 持续增加蓝buff
function Buff:startRestoreMp()
	return true
end

function Buff:calcRestoreMp()
	return self:calcBuffPeriod("stoptRestoreMp")
end

function Buff:stoptRestoreMp(isStopLight)
	-- 是否需要存在光效
	if not isStopLight then
		self.handler:addClearBuffLightList(self.buffID)
	end
	return true
end