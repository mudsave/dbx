--[[CommonSkill.lua
描述：
	普攻
--]]

require "base.base"


CommonSkill = class()


function CommonSkill:__init(owner)
	self._owner = owner
end

function CommonSkill:setOwner(role)
	self._owner = role
end

function CommonSkill:getOwner()
	return self._owner
end

function CommonSkill:getLevel()
	return self._level
end
function CommonSkill:setLevel(level)
	 self._level = level
end

function CommonSkill:doHpDamage(role ,target,damage,result,isCounter,attackType,deadList,protectNum)
	local actualDamage = damage
	
	--增加目标怒气值
	if  instanceof(target, FightPlayer) then
		local curAnger = target:get_anger()
		local maxAnger = target:get_max_anger()
		local finalAnger = curAnger + EachPassiveKillValue
		if finalAnger > maxAnger then
			finalAnger = maxAnger
		end
		target:set_anger(finalAnger)
		result.anger = finalAnger
	end
	
	local curHp
	--是否闪避
	local isHit = FightUtils.isHit(role,target)
	if isHit == false then
		result.ID = target:getID()
		result.status = ResultStatusType.Miss
		return
	end
	
	--是否反震
	local isCounter = isCounter and FightUtils.isCounter(target)
	--是否暴击(会覆盖反震)
	local isCrit = FightUtils.isCritical(role,target)
	
	--防御和暴击反震之一组合
	local isDefense = target:getIsDefense()
	if isDefense then
		result.status = ResultStatusType.Defense
		--随机一个
		if isCrit and isCounter then
			local rand = math.random(100)
			if rand>=0 and rand<=50 then
				result.status = ResultStatusType.CriticalAndDefense
				isCrit = true
				isCounter = false
			else
				result.status = ResultStatusType.DefenseAndCounter
				isCrit = false
				isCounter = true
			end
		elseif isCrit then
			result.status = ResultStatusType.CriticalAndDefense
			isCrit = true
		elseif isCounter then
			result.status = ResultStatusType.DefenseAndCounter
			isCounter = true
		end
	--暴击和反震组合
	else
		if isCrit and isCounter then
			result.status = ResultStatusType.CriticalAndCounter
			isCrit = true
			isCounter = true
		elseif isCrit then
			result.status = ResultStatusType.Critical
			isCrit = true
		elseif isCounter then
			result.status = ResultStatusType.Counter
			isCounter = true
		end
	end

	--暴击
	if isCrit  then
		actualDamage = FightUtils.getCritical(role,actualDamage)
	end
	--保护
	actualDamage = actualDamage /(protectNum + 1)
	
	--防御
	if isDefense then
		actualDamage = FightUtils.getDefenseDamage(target,actualDamage)
	end
	-- 考虑护盾
	actualDamage =  SkillUtils.calcShield(target,actualDamage, attackType)
	if actualDamage < 1 then
		actualDamage = 1
	end
	--反震扣血
	if isCounter  then
		local counterDamage = FightUtils.getCounter(target,actualDamage)
		if counterDamage < 1 then
			counterDamage = 1
		end
		-- 考虑护盾
		counterDamage =  SkillUtils.calcShield(target,0-counterDamage, attackType)
		counterDamage = 0 - counterDamage
		
		--反震扣血
		counterDamage = math.floor(counterDamage)
		local oldValue1 = role:getHp()
		local curHp1 = oldValue1 - counterDamage
		if curHp1 < 0 then
			curHp1 = 0
			counterDamage = oldValue1
		end

		role:setHp(curHp1)
		result.counterValue = counterDamage*(-1)
		--如果被震死亡
		if  curHp1 == 0 then
			role:setLifeState(RoleLifeState.Dead)
			table.insert(deadList,role:getID())
		end

	end
	
	--目标昏睡被打醒
	if target:getLifeState() == RoleLifeState.Sopor then
		if actualDamage >0 then
			local h = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
			h:doRemoveSoporBuff()

		end
	end

	--设置hp
	local oldValue = target:getHp()
	actualDamage = math.floor(actualDamage)
	curHp = oldValue - actualDamage
	if curHp < 0 then
		curHp = 0
		--actualDamage = oldValue
	end
	target:setHp(curHp)
	
	--设置返回协议
	result.ID = target:getID()
	result.attrType = ResultAttrType.Hp
	result.changedValue = actualDamage*(-1)

	--local strLog = role:getName().."("..tostring(role:getPos()[3])..")".."攻击"..target:getName().."("..tostring(target:getPos()[3])..")" .."="..tostring(result.changedValue)
	local strLog = role:getName().."()".."攻击"..target:getName().."()" .."="..tostring(result.changedValue)--TODO 完善
	Flog:log(strLog) --TODO　del

	--如果死亡
	if  curHp == 0 then
		result.lifeState = RoleLifeState.Dead
		target:setLifeState(RoleLifeState.Dead)
		table.insert(deadList,target:getID())
	end
	
end

local DeadList = {}
function CommonSkill:use(targets,result)
	table.clear(DeadList)
	-- 攻减防
	local target = targets[1]
	local at = self._owner:ft_get_at()
	local af = target:ft_get_af()
	local mt = self._owner:ft_get_mt()
	local mf = target:ft_get_mf()
	if instanceof(self._owner, FightPet) then
		 local ratio = self._owner:getCounterHitRatio()
		 if ratio then
			at = at * ratio
			mt = mt * ratio
			self._owner:setCounterHitRatio(nil)
		 end
	end
	local startDamageAt = at - af
	local startDamageMt = mt - mf
	local startDamage,attackType

	if instanceof(self._owner,FightPlayer)  then
		--有物攻
		if School2AttackType[self._owner:getSchool()] == AttackType.Phisical then 
			startDamage = startDamageAt
			attackType = AttackType.Phisical
		--有法攻
		elseif School2AttackType[self._owner:getSchool()] == AttackType.magic then
			startDamage = startDamageMt
			attackType = AttackType.Magic
		else
			startDamage = startDamageAt
			attackType = AttackType.Phisical
		end
	elseif  instanceof(self._owner,FightPet) then
		local configID = self._owner:getDBID()
		local petConfig = PetDB[configID]
		local petAttackType = petConfig.attackType
		if petAttackType == PetAttackType.Physics then
			startDamage = startDamageAt
			attackType = AttackType.Phisical
		elseif petAttackType == PetAttackType.Magic then
			startDamage = startDamageMt
			attackType = AttackType.Magic
		end
	else
		startDamage = startDamageAt
		attackType = AttackType.Phisical
		if startDamageMt > startDamageAt then
			startDamage = startDamageMt
			attackType = AttackType.Magic
		end
	end

	local damage = startDamage --总伤害
	local hpDamage = PlayerCommonSkillEffect[self._level or 1] or 12
	if instanceof(self._owner,FightMonster) then
		hpDamage = MonsterCommonSkillEffect[self._level or 1]  or 10
	elseif instanceof(self._owner,FightPet) then
		hpDamage = PetCommonSkillEffect[self._level or 1]  or 11
	end
	
	damage = damage + hpDamage
	if damage <= 1 then
		damage = 1
	end

	--最后算总伤害
	local targetInfo = {}
	result.actionList = targetInfo
	
	
	local targetID = target:getID()
	local protectors = FightUtils.getValidProtectors(target:getProtectors())
	local protectorNum = table.size(protectors)
	--print("protectorNum=",protectorNum)
	local finalDamage = damage
	if finalDamage < 1 then
		finalDamage = 1
	end
	--有保护
	if protectorNum >= 1 then

		result.protectors = {[targetID]= {}}
		for protectID ,_ in pairs(protectors) do
			local protector = g_fightEntityMgr:getRole(protectID)
			local protectorInfo = {}
			table.insert(result.protectors[targetID], protectorInfo )
			self:doHpDamage(self._owner,protector,finalDamage,protectorInfo,false,attackType,DeadList,protectorNum )
		end
		self:doHpDamage(self._owner,target,finalDamage,targetInfo,true,attackType,DeadList,protectorNum )
	--无保护
	else
		self:doHpDamage(self._owner,target,finalDamage,targetInfo,true,attackType,DeadList,0)
	end

	--增加怒气值
	if instanceof(self._owner, FightPlayer) then
		local curKill = self._owner:get_anger()
		local maxKill = self._owner:get_max_anger()
		local finalKill = curKill + EachActiveKillValue
		if finalKill > maxKill then
			finalKill = maxKill
		end
		self._owner:set_anger(finalKill)
		result.anger = finalKill
	end
	return DeadList
	
end

function CommonSkill:__release()
	self._level = nil
	self._owner = nil
end


