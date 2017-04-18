--[[FightBuffHandler.lua
描述：
	实体的FightBuffHandler
--]]

FightBuffHandler = class()

function FightBuffHandler:__init(entity)
	-- buff的持有者
	self.owner = entity
	-- buff的记录
	self.buffList = {}
	-- 持有者障碍buff的状态
	self.disorderState = disorderNormal
	-- 清楚buff特效
	self.clearBuffLightList = {}
	--0 正常情况 1障碍闪避 miss  2不能添加 无法添加
	self.hitStatus = 0
	-- 障碍类buff
	self.disorderBuff = nil
	-- 对特殊buff的操作
	-- 自身障碍免疫状态
	self.immunity = false
	-- 命中 
	self.mustHit = false
	-- 暴击
	self.mustCritical = false
	-- 抗暴击
	self.mustTenacity = false
	-- 最快速度
	self.fastestSpeed = false
	-- 对中毒效果的记录
	self.poisonEffect = nil
end
 
function FightBuffHandler:__release()
	self.owner = nil
	self.buffList = nil
	self.disorderState = nil
	self.clearBuffLightList = nil
	self.hitStatus = nil
	self.disorderBuff = nil
	self.immunity = nil
	self.mustHit = nil
	self.mustCritical = nil
	self.mustTenacity = nil
	self.fastestSpeed = nil
end

-- 增加buff
function FightBuffHandler:addBuff(buff)
	local buffKind = buff:getKind()
	-- 有障碍buff,就先上障碍buff
	if DisorderBuffMap[buffKind] then
		return self:addDisorderBuff(buff)
	end
	-- 其他buff
	if FightBuffMap[buffKind] then
		local curBuff = self.buffList[buffKind]
		local funcName = FightBuffMap[buffKind]
		--有同种buff的时候先清除,在从新创建
		if curBuff then
			curBuff[funcName[3]](curBuff,true)
			release(curBuff)
			self.buffList[buffKind] = nil
		end
		--添加到buff表中
		self.buffList[buffKind] = buff
		return buff[funcName[1]](buff)
	end
	print ("ERROR: add_buff")
	return false
end

-- 回合前作用
function FightBuffHandler:onRoundStartCalc()
	local allAttrReduceBuff = self.buffList[BuffKind.AllAttrReduce]
	if allAttrReduceBuff then
		allAttrReduceBuff:doReduceLoyalty()
	end
end

-- 回合后减持续值
function FightBuffHandler:calc()
	if self.disorderBuff then
		if not self.disorderBuff:calcDisorder() then
			self.disorderBuff = nil
		end
	end
	for idx,iter in pairs(self.buffList) do
		if not iter:calc() then
			self.buffList[idx] = nil
		end
	end
end

--[[
	障碍类buff 判断是否命中 抗性几率
	公式：
	xx障碍命中几率 = （0.5+道行影响值）*（全部障碍命中加成+ xx障碍命中加成-全部障碍抗性加成- xx障碍抗性加成）
]] 
function FightBuffHandler:isAddDisorderSucess(buff)
	local target = buff:getOwner()
	local src = buff:getSrcEntity()
	local buffType = buff:getKind()
	local funcName = DisorderResistMapping[buffType]
	local effect = SkillUtils.getBarrierEffect(src, target)
	local targetResist = target[funcName](target)
	local targetAllResist = target:get_add_obstacle_resist()

	-- xx障碍命中加成
	local obstacleIncHit = src:getObstacleIncHitByType(buffType)
	local hitRate = (0.5 + effect) * (src:get_add_obstacle_resist() + obstacleIncHit - targetAllResist - targetResist + 1)
	hitRate = math.floor(hitRate * 100)
	local tmpStr = nil
	if math.random(100) >= hitRate then
		tmpStr = " ~障碍buff没命中(" .. hitRate .. "%)~ "
		Flog:log(tmpStr)
		self.hitStatus = 1
		return false	
	else
		tmpStr = " ~障碍buff命中(" .. hitRate .."%)~ "
		Flog:log(tmpStr)
	end
	-- 判断是否免疫
	if self.immunity == true then
		self.hitStatus = 2
		Flog:log("障碍免疫")
		return false
	end
	return true
end

-- 	除冰冻障碍不能被除本身之外的其他障碍顶替
function FightBuffHandler:isFreezeObstacleReplace(buff)
	if self.disorderBuff then
		if self.disorderBuff:getKind() == BuffKind.FreezeObstacle then
			if buff:getKind() ~= BuffKind.FreezeObstacle then
				self.hitStatus = 2
				return false
			end
		end
	end
	return true
end

-- 添加障碍buff
function FightBuffHandler:addDisorderBuff(buff)
	-- 判断是否命中 抗性几率
	if not self:isAddDisorderSucess(buff) then
		return false
	end
	-- 冰冻障碍的特殊替代
	if not self:isFreezeObstacleReplace(buff) then
		return false
	end
	-- 是否已经存在障碍
	if self.disorderBuff then
		-- 需要存在光效
		if self.disorderBuff:getKind() == buff:getKind() then
			self.disorderBuff:stopDisorder(true)
		else
			self.disorderBuff:stopDisorder()
		end	
		release(self.disorderBuff)
		self.disorderBuff = nil
	end
	self.disorderBuff = buff
	-- 如果是中毒障碍，会被其它障碍效果顶替，而毒伤害效果不会被顶替
	if buff:getKind() == BuffKind.PoisonObstacle then
		self:addPoisonEffect(buff)
	end
	local funcName = DisorderBuffMap[buff:getKind()]
	return buff[funcName[1]](buff)
end

-- 得到持有者障碍buff的状态
function FightBuffHandler:getDisorderState()
	return self.disorderState
end

-- 设置持有者障碍buff的状态
function FightBuffHandler:setDisorderState(disorderState)
	self.disorderState = disorderState
end

-- 得到清除链表
function FightBuffHandler:getClearBuffLightList()
	return self.clearBuffLightList
end

-- 加入到清除链表中
function FightBuffHandler:addClearBuffLightList(BuffID)
	table.insert(self.clearBuffLightList, BuffID)
end

-- 设置清除链表为空
function FightBuffHandler:setClearBuffListNil()
	table.clear(self.clearBuffLightList)
end

--获得护盾效果与护盾值
function FightBuffHandler:getShieldEffect()
	local stayValue = 0
	local shieldBuff = self.buffList[BuffKind.Shield]
	if shieldBuff then
		local effectType = shieldBuff:getFirstEffectType()
		if effectType == EffectType.AbsorbMtDmgDa 
			or effectType == EffectType.AbsorbAtDmgDa 
			or effectType == EffectType.AbsorbAllDmgDa then
			stayValue = shieldBuff:getFirstEffectValue()
		elseif effectType == EffectType.MtShield then
			stayValue = self.owner:getMp()
			--roleMp = self.owner:getMp()
			--roleMaxMp = self.owner:getMaxMp()
			--stayValue = shieldBuff:getFirstEffectValue()
			--stayValue = math.ceil(roleMaxMp*stayValue / 100)
		end
		if stayValue ~= 0 then
			return true ,effectType, stayValue
		else
			return nil
		end
	end
	return nil
end

--设回护盾值
function FightBuffHandler:setShieldEffect(stayValue)
	local shieldBuff = self.buffList[BuffKind.Shield]
	if shieldBuff then
		local effectType = shieldBuff:getFirstEffectType()
		if effectType == EffectType.AbsorbMtDmgDa 
			or effectType == EffectType.AbsorbAtDmgDa 
			or effectType == EffectType.AbsorbAllDmgDa then
				shieldBuff:setFirstEffectValue(stayValue)
		elseif effectType == EffectType.MtShield then
			Flog:log("以法替蓝--剩余",stayValue)
			self.owner:setMp(stayValue)
			--roleMp = self.owner:getMp()
			--self.owner:setMp(roleMp - shield_value)
		end
	end
end

-- 施嘲讽技能实体
function FightBuffHandler:getObstacleSrcEntity()
	if self.disorderBuff and self.disorderBuff:getKind() == BuffKind.TauntObstacle then
		return self.disorderBuff:getSrcEntity()
	end
	return nil
end

-- 添加中毒效果
function FightBuffHandler:addPoisonEffect(buff)
	self.poisonEffect = {}
	self.poisonEffect.value = buff:getFirstEffectValue()
	self.poisonEffect.stayValue = buff:getStayValue()
	self.poisonEffect.stayType = buff:getFirstEffectAddType()
end

-- 得到中毒buff
function FightBuffHandler:getPoisonHpdot()
	if self.poisonEffect then
		self.poisonEffect.stayValue = self.poisonEffect.stayValue - 1
		if self.poisonEffect.stayValue < 0 then
			self.poisonEffect = nil
			return false
		end
		return true,self.poisonEffect.value,self.poisonEffect.stayType
	end
	return false
end

-- 治疗减少
function FightBuffHandler:getHealReduce()
	local healBuff = self.buffList[BuffKind.HealReduce]
	if healBuff then
		return true, healBuff:getFirstEffectValue(), healBuff:getFirstEffectAddType()
	end
	return false
end

-- 返回是否存在驱散 
function FightBuffHandler:getDispel()
	local dispelBuff = self.buffList[BuffKind.PhaseRestrain]
	if dispelBuff then
		return true
	end
	return false
end

-- 相性克制
function FightBuffHandler:getPhaseRestrain()
	local pRBuff = self.buffList[BuffKind.PhaseRestrain]
	if pRBuff then
		return true, pRBuff:getFirstEffectValue(), pRBuff:getSecondEffectValue()
	end
	return false
end

-- 是否有反震buff
function FightBuffHandler:getCouterDmg()
	local couterBuff = self.buffList[BuffKind.CouterDmg]
	if couterBuff then 
		return true,couterBuff:getFirstEffectValue(),couterBuff:getFirstEffectAddType()
	end
	return false
end


-- 得到掉血的数值和种类
function FightBuffHandler:getHpDot()
	local hpDot = self.buffList[BuffKind.Dot]
	if hpDot then
		return true, hpDot:getFirstEffects()
	end
	return false
end

-- 得到掉蓝的数值和种类
function FightBuffHandler:getMpDot()
	local mpDot = self.buffList[BuffKind.MpDot]
	if mpDot then
		return true, mpDot:getFirstEffectValue(),mpDot:getFirstEffectAddType()
	end
	return false
end

-- 得到回血的数值和种类
function FightBuffHandler:getHpRestore()
	local hpRestore = self.buffList[BuffKind.RestoreHp]
	if hpRestore then
		return true, hpRestore:getFirstEffectValue(),hpRestore:getFirstEffectAddType()
	end
	return false
end

-- 得到回蓝的数值和种类
function FightBuffHandler:getMpRestore()
	local mpRestore = self.buffList[BuffKind.RestoreMp]
	if mpRestore then
		return true, mpRestore:getFirstEffectValue(),mpRestore:getFirstEffectAddType()
	end
	return false
end

-- 获取记录中所有的buff
function FightBuffHandler:getBuffList()
	local tmpList = {}
	-- 障碍buff
	if self.disorderBuff then
		table.insert(tmpList,self.disorderBuff)
	end
	-- 其他buff
	for _,iter in pairs(self.buffList) do
		table.insert(tmpList, iter)
	end
	return tmpList
end

--[[
{	插入的结果集
	{[10003] = {value = 50, type = ResultAttrType.Hp}, actionType = FightActionType.Buff},
	{[10003] = {value = 50, type = ResultAttrType.Hp}, actionType = FightActionType.Buff},
}
--]]
function FightBuffHandler:getBuffOP()
	local results = {}
	local dbid = self.owner:getID()
	local result = {}
	result.actionType = FightActionType.Buff
	result[dbid] = {}
	local tmpValue,lifeState = self:doHpDot()
	if tmpValue then
		result[dbid].value = tmpValue
		result[dbid].type = ResultAttrType.Hp
		if lifeState then
			result[dbid].lifeState = lifeState
		end
		table.insert(results, result)
	end
	result = {}
	result.actionType = FightActionType.Buff
	result[dbid] = {}
	tmpValue = self:doRestoreHp()
	if tmpValue then
		result[dbid].value = tmpValue
		result[dbid].type = ResultAttrType.Hp
		table.insert(results, result)
	end
	result = {}
	result.actionType = FightActionType.Buff
	result[dbid] = {}
	tmpValue = self:doMpDot()
	if tmp then
		result[dbid].value = tmpValue
		result[dbid].type = ResultAttrType.Mp
		table.insert(results, result)
	end
	result = {}
	result.actionType = FightActionType.Buff
	result[dbid] = {}
	tmpValue = self:doRestoreMp()
	if tmpValue then
		result[dbid].value = tmpValue
		result[dbid].type = ResultAttrType.Mp
		table.insert(results, result)
	end
	return results
end

-- 获得buff伤害值,并掉血 
function FightBuffHandler:doHpDot()
	local changeHp = 0
	local tempChange = 0
	local isHpDot, effect = self:getHpDot()
	local isPoison,pChangeHp,pChangType = self:getPoisonHpdot()
	local lifeState = nil
	if isHpDot or isPoison then
		if isHpDot then
			-- 百分比
			if effect.addType == EffectAddType.Percent then
				if effect.effectType == EffectType.MaxHpDot then 
					changeHp = self.owner:getMaxHp() * effect.effectValue/100
				elseif effect.effectType == EffectType.Dot then 
					changeHp = self.owner:getHp() * effect.effectValue/100
				end 
			else
				changeHp = effect.effectValue
			end
		end
		if isPoison then 
			if pChangType == EffectAddType.Percent then
				tempChange = self.owner:getHp() * pChangeHp/100
			else
				tempChange = pChangeHp
			end
		end
		changeHp = changeHp + tempChange
		changeHp = SkillUtils.getHpChange(self.owner, 0-changeHp)
		Flog:log("$$ 持续掉血buff:",changeHp)
		-- 是否死亡和复活
		local curHp = self.owner:getHp()
		if curHp == 0 then
			local deadList = {}
			table.insert(deadList, self.owner:getID())
			local revivalResult = FightUtils.doPostDead(deadList)
			if revivalResult then
				local fightID = self.owner:getFightID()
				local fight = g_fightMgr:getFight(fightID)
				FightUtils.insertFightResult(fight, revivalResult)
			else
				self.owner:setLifeState(RoleLifeState.Dead)
				lifeState = RoleLifeState.Dead
			end
		end
		return changeHp,lifeState
	end
	return nil
end

-- 做回血
function FightBuffHandler:doRestoreHp()
	local isHpRestore,changeHp,changeType= self:getHpRestore()
	if isHpRestore then 
		-- 百分比
		if changeType == EffectAddType.Percent then
			changeHp = self.owner:getHp() * changeHp/100
		end
		changeHp = SkillUtils.getHpChange(self.owner, changeHp)
		Flog:log("$$ 持续回血buff恢复:",changeHp)
		return changeHp
	end
	return nil
end

-- 做掉蓝
function FightBuffHandler:doMpDot()
	-- 如果目标是怪物 返回空
	if SkillUtils.getRoleType(self.owner) == RoleType.Monster then
		return nil
	end
	local isMpDot,changeMp,changeType = self:getMpDot()
	if isMpDot then 
		if changeType == EffectAddType.Percent then
			changeMp = self.owner:getMp() * changeMp/100
		end
		changeMp = SkillUtils.set_mp_change(0-changeMp,self.owner)
		Flog:log("持续掉蓝Buff丢失："..changeMp.."\n")
		return changeMp
	end
	return nil
end

-- 做回蓝
function FightBuffHandler:doRestoreMp()
	-- 如果目标是怪物 返回空
	if SkillUtils.getRoleType(self.owner) == RoleType.Monster then
		return nil
	end
	local isMpDot,changeMp,changeType = self:getMpDot()
	if isMpDot then 
		if changeType == EffectAddType.Percent then
			changeMp = self.owner:getMp() * changeMp/100
		end
		changeMp = SkillUtils.set_mp_change(changeMp,self.owner)
		Flog:log("$$ 回蓝buff 恢复"..changeMp)
		return changeMp
	end
	return nil
end

--是否有buffID
function FightBuffHandler:hasBuffID(buffID)
	-- 障碍buff
	if self.disorderBuff and self.disorderBuff:getID() == buffID then
		return true
	end
	for _,buff in pairs(self.buffList) do
		local ID = buff:getID()
		if buffID == ID then
			return true
		end
	end
	return false
end

-- 根据buffID获取buff
function FightBuffHandler:getBuffByID(buffID)
	for _, buff in pairs(self.buffList) do
		if buffID == buff:getID() then
			return buff
		end
	end
end

-- 判断是否是辅助类buff
function FightBuffHandler:isAssistBuff(buff)
	local buffKind = buff:getKind()
	for _, kind in ipairs(AssistBuffKindMap) do
		if kind == buffKind then
			return true
		end
	end
	return false
end

-- 判断是否有减益BUFF
function FightBuffHandler:isHasDeBuff()
	local buffList = self.buffList
	for kind,_ in pairs(buffList) do
		for _, deBuff in ipairs(DeBuff) do
			if deBuff == kind then
				return true
			end
		end
	end
end

-- 增加buff持续回合数
function FightBuffHandler:addBuffStayValue(buff, value, percent)
	buff:addStayValue(value, percent)
end

-- 是否有这种类型的buff
function FightBuffHandler:hasBuffKind(kind)
	-- 障碍buff
	if self.disorderBuff and self.disorderBuff:getKind() == kind then
		return true
	end
	-- 其他buff
	for _,buff in pairs(self.buffList) do
		if buff:getKind() == kind then
			return true
		end
	end
	return false
end

-- 得到buff的最大持续值
function FightBuffHandler:getBuffStayPeriod(srcEntity,role,id,level)
	buffDB = tFightingBuffDB[id]
	if buffDB.stayType == BuffStayType.Bout then
		return tBuffEffectValueDB[buffDB.stayID][level]
	end
	if buffDB.stayType == BuffStayType.Tao then
		local affect = SkillUtils.getBarrierEffect(srcEntity,role)
		local round = tBuffEffectValueDB[buffDB.stayID][level]
		if affect >= 2 then
			round = round + 2
		elseif affect < 2 and affect >= 1 then
			round = round + 1
		elseif affect < 1 and affect >= -1 then
		elseif affect < -1 and affect >= -2 then
			round = round - 1
		else
			round = round - 2
		end
		return round > 0 and round or 1
	end
	return nil
end

-- 移除buff by ID
function FightBuffHandler:doRemoveBuffByID(id)
	-- 障碍buff
	if self.disorderBuff and self.disorderBuff:getID() == id then
		self.disorderBuff:stopDisorder()
		self.disorderBuff = nil
		return true
	end
	for _,buff in pairs(self.buffList) do
		if buff:getID() == id then
			buff:stop()
			self.buffList[buff:getKind()] = nil
			return true
		end
	end
	return false
end

-- 被打醒移除昏睡buff
function FightBuffHandler:doRemoveSoporBuff()
	if self.disorderBuff and self.disorderBuff:getKind() == BuffKind.SoporObstacle then
		self.disorderBuff:stopDisorder()
		self.disorderBuff = nil
		return true
	end
	return false
end

-- 自身的状态
function FightBuffHandler:getHitStatus()
	local tmp = self.hitStatus
	self.hitStatus = 0
	return tmp
end

-- 战斗结束清除所有的buff
function FightBuffHandler:doFightEndClearAllBuff()
	-- 障碍buff
	if self.disorderBuff and self.disorderBuff:getDeathCleanup() then
		self.disorderBuff:stopDisorder()
		self.disorderBuff = nil
	end
	-- 其他buff
	for idx,iter in pairs(self.buffList) do
		iter:stop()
		release(iter)
		self.buffList[idx] = nil
	end
end

-- 死亡清除
function FightBuffHandler:doDeadClearBuff()
	-- 障碍buff
	if self.disorderBuff and self.disorderBuff:getDeathCleanup() then
		self.disorderBuff:stopDisorder()
		self.disorderBuff = nil
	end
	-- 其他buff
	for idx,iter in pairs(self.buffList) do
		if iter:getDeathCleanup() then
			iter:stop()
			release(iter)
			self.buffList[idx] = nil
		end
	end
end

-- 驱散所有的增益buff
function FightBuffHandler:doClearAddBuff()
	local buffList = self.buffList
	for kind,buff in pairs(buffList or {}) do
		-- 判断是否是增益类型
		for _,goodKind in ipairs(GoodBuff) do
			if kind == goodKind and buff:getDisperse() then
				buff:stop()
				release(buff)
				self.buffList[kind] = nil
			end
		end
	end
end

-- 驱散所有的减益buff
function FightBuffHandler:doClearDeBuff()
	local buffList = self.buffList
	for kind, buff in pairs(buffList or {}) do
		-- 判断是否是减益类型
		for _,deBuff in ipairs(DeBuff) do
			if kind == deBuff and buff:getDisperse() then
				buff:stop()
				release(buff)
				self.buffList[kind] = nil
			end
		end
	end
end

-- 驱散所有的可驱散buff
function FightBuffHandler:doClearCanDisperseBuff()
	local buffList = self.buffList
	for kind, buff in pairs(buffList or {}) do
		if buff:getDisperse() then
			buff:stop()
			release(buff)
			self.buffList[kind] = nil
		end
	end
end

-- 对特殊buff的操作
-- 免疫
function FightBuffHandler:getImmunity()
	return self.immunity and self.immunity or false
end

function FightBuffHandler:setImmunity(bool)
	self.immunity = bool
end

-- 命中
function FightBuffHandler:getMustHit()
	return self.mustHit and self.mustHit or false
end

function FightBuffHandler:setMustHit(bool)
	self.mustHit = bool
end

-- 抗暴击
function FightBuffHandler:getMustTenacity()
	return self.mustTenacity and self.mustTenacity or false
end

function FightBuffHandler:setMustTenacity(bool)
	self.mustTenacity = bool
end

-- 暴击
function FightBuffHandler:getMustCritical()
	if self.mustCritical then
		-- 移除该buff 暴击一次 这个是紫阳门的蓄力攻击效果
		--local criticalBuff = self.buffList[BuffKind.ZYMXuLi]
		--if criticalBuff then
		--	self:doRemoveBuffByID(criticalBuff:getID())
		--end
		return true
	end
	return false
end

function FightBuffHandler:setMustCritical(bool)
	self.mustCritical = bool
end

-- 速度
function FightBuffHandler:getFastestSpeed()
	return self.fastestSpeed and self.fastestSpeed or false
end

function FightBuffHandler:setFastestSpeed(bool)
	self.fastestSpeed = bool
end

