--[[ItemEffect.lua
描述:
	物品效果
]]

ItemEffect = {}

-- 移除标志
--local removeFlag = true

-- 增加Buff
function ItemEffect.addBuff(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local buffID = medicamentConfig.ReactExtraParam1
	g_buffMgr:addBuff(targetEntity, buffID)
	removeFlag = true
	return removeFlag
end

-- 移除buff
function ItemEffect.cancelBuff(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local buffID = medicamentConfig.ReactExtraParam1
	local buffHandler = targetEntity:getHandler(HandlerDef_Buff)
	-- 判断是否已经有buff
	if nil == buffHandler:findBuffByID(buffID) then
		removeFlag = false
		return removeFlag
	end
	buffHandler:cancelBuff(buffID)
	removeFlag = true
	return removeFlag
end

-- 执行Lua函数
function ItemEffect.exeLuaFun(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local targetFunction = _G[medicamentConfig.ReactExtraParam1]
	if type(targetFunction) == 'function' then
		removeFlag = targetFunction(targetEntity, medicament)
	end
	return removeFlag
end

-- 改变生命 即能改变
function ItemEffect.changeHp(targetEntity, medicament, medicamentConfig, targetEntityID)
	local removeFlag = false
	-- 如果有作用目标的话
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	if not curEntity then
		return
	end
	local maxHp = curEntity:getMaxHP()
	local curHp = curEntity:getHP()
	
	-- 判断是否已经是最大值
	if curHp == maxHp then
		removeFlag = false
		return removeFlag, 7	
	end
	-- 可以改变值
	local changeHp = medicamentConfig.ReactExtraParam1
	curHp = curHp + changeHp
	if curHp > maxHp then
		curHp = maxHp
	end
	if curHp < 0 then
		curHp = 0
	end
	curEntity:setHP(curHp)
	curEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变法力
function ItemEffect.changeMp(targetEntity, medicament, medicamentConfig, targetEntityID)
	local removeFlag = true
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	if not curEntity then
		return
	end
	local maxMp = curEntity:getMaxMP()
	local curMp = curEntity:getMP()
	
	if curMp == maxMp then
		removeFlag = false
		return removeFlag, 7	
	end
	local changeMp = medicamentConfig.ReactExtraParam1
	curMp = curMp + changeMp
	if curMp > maxMp then
		curMp = maxMp
	end
	if curMp < 0 then
		curMp = 0
	end
	curEntity:setMP(curMp)
	curEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变生命和法力
function ItemEffect.changeHpMp(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local maxHp = targetEntity:getMaxHP()
	local curHp = targetEntity:getHP()
	local maxMp = targetEntity:getMaxMP()
	local curMp = targetEntity:getMP()
	local changeHp = medicamentConfig.ReactExtraParam1
	local changeMp = medicamentConfig.ReactExtraParam2
	if curHp == maxHp and curMp == maxMp then
		removeFlag = false
		return removeFlag, 7
	end
	curHp = curHp + changeHp
	curMp = curMp + changeMp
	if curHp > maxHp then
		curHp = maxHp
	end
	if curHp < 0 then
		curHp = 0
	end
	if curMp > maxMp then
		curMp = maxMp
	end
	if curMp < 0 then
		curMp = 0
	end
	targetEntity:setHP(curHp)
	targetEntity:setMP(curMp)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变怒气
function ItemEffect.changeAngerValue(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local maxAngerValue = targetEntity:getAttrValue(player_max_anger)
	local curAngerValue = targetEntity:getAttrValue(player_anger)
	local changeAngerValue = medicamentConfig.ReactExtraParam1
	if maxAngerValue == curAngerValue then
		removeFlag = false
		return removeFlag
	end
	curAngerValue = curAngerValue + changeAngerValue
	if curAngerValue > maxAngerValue then
		curAngerValue = maxAngerValue
	end
	if curAngerValue < 0 then
		curAngerValue = 0
	end
	targetEntity:setAttrValue(player_anger, curAngerValue)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变PK值
function ItemEffect.changePkValue(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local curKillValue = targetEntity:getAttrValue(player_kill)
	local changeKillValue = medicamentConfig.ReactExtraParam1
	if PlayerMaxKill == curKillValue then
		removeFlag = false
		return removeFlag
	end
	curKillValue = curKillValue + changeKillValue
	if curKillValue > PlayerMaxKill then
		curKillValue = PlayerMaxKill
	end
	if curKillValue < 0 then
		curKillValue = 0
	end
	targetEntity:setAttrValue(player_kill, curKillValue)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变绑银
function ItemEffect.changeBindMoney(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local curBindMoney =  targetEntity:getSubMoney()
	local changeBindMoney = medicamentConfig.ReactExtraParam1
	local fun_Change = ItemEffectFuncs[changeBindMoney]
	if fun_Change then
		changeBindMoney = fun_Change(targetEntity)
	end
	curBindMoney = curBindMoney + changeBindMoney
	if curBindMoney < 0 then
		removeFlag = false
		return removeFlag
	end
	targetEntity:setSubMoney(curBindMoney)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变银两
function ItemEffect.changeMoney(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local curMoney = targetEntity:getMoney()
	local changeMoney = medicamentConfig.ReactExtraParam1
	local fun_Change = ItemEffectFuncs[changeMoney]
	if fun_Change then
		changeMoney = fun_Change(targetEntity)
	end
	curMoney = curMoney + changeMoney
	if curMoney < 0 then
		removeFlag = false
		return removeFlag
	end
	targetEntity:setMoney(curMoney)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变经验
function ItemEffect.changeExpValue(targetEntity, medicament, medicamentConfig, targetEntityID)
	local removeFlag = false
	-- 判断等级
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	local changeExpValue = medicamentConfig.ReactExtraParam1
	local fun_Change = ItemEffectFuncs[changeExpValue]
	if fun_Change then
		changeExpValue = fun_Change(curEntity)
	end

	if instanceof(curEntity,Player)then
		local curLevel = curEntity:getAttrValue(player_lvl)
		if curLevel == MaxPlayerLevel then
			removeFlag = false
			return removeFlag
		end
		curEntity:addXp(changeExpValue)
		curEntity:flushPropBatch()
		removeFlag = true
	elseif instanceof(curEntity,Pet) then
		local level = curEntity:getLevel()
		if level < medicamentConfig.UseNeedLvl then
			removeFlag = false
			return removeFlag, 9
		end
		curEntity:addXp(changeExpValue)
		curEntity:flushPropBatch()
		removeFlag = true
	end
	return removeFlag
end

-- 改变礼金
function ItemEffect.changeCashMoney(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local curCashMoney = targetEntity:getCashMoney()
	local changeCashMoney = medicamentConfig.ReactExtraParam1
	curCashMoney = curCashMoney + changeCashMoney
	targetEntity:setCashMoney(curCashMoney)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变元宝
function ItemEffect.changeGoldCoin(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local curGoldCoin = targetEntity:getGoldCoin()
	local changeGoldCoin = medicamentConfig.ReactExtraParam1
	curGoldCoin = curGoldCoin + changeGoldCoin
	targetEntity:setGoldCoin(curGoldCoin)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end


--entity:getEntityType() == eClsTypePet
--entity:getEntityType() == eClsTypePlayer
-- 改变道行人物和宠物公用
function ItemEffect.changeTaoValue(targetEntity, medicament, medicamentConfig, targetEntityID)
	local removeFlag = true
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	local changeTaoValue = medicamentConfig.ReactExtraParam1
	local fun_Change = ItemEffectFuncs[changeTaoValue]
	if fun_Change then
		changeTaoValue = fun_Change(curEntity)
	end
	if instanceof(curEntity,Player)then
		curEntity:addAttrValue(player_tao,changeTaoValue)
		curEntity:flushPropBatch()
		removeFlag = true
	elseif instanceof(curEntity,Pet) then
		local curPetTao = curEntity:getAttrValue(pet_tao)
		if curPetTao >= MaxPetTao then
			removeFlag = false
			return removeFlag
		end
		curPetTao = curPetTao + changeTaoValue
		if curPetTao > MaxPetTao then
			curPetTao = MaxPetTao
		end
		curEntity:setAttrValue(pet_tao, curPetTao)
		curEntity:flushPropBatch()
		removeFlag = true
	end
	return removeFlag
end

-- 改变潜能
function ItemEffect.changePotential(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local curPotential = targetEntity:getAttrValue(player_pot)
	local changePotential = medicamentConfig.ReactExtraParam1
	local fun_Change = ItemEffectFuncs[changePotential]
	if fun_Change then
		changePotential = fun_Change(targetEntity)
	end
	curPotential = curPotential + changePotential
	targetEntity:setAttrValue(player_pot, curPotential)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变历练
function ItemEffect.changeExpoint(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local curExpoint = targetEntity:getAttrValue(player_expoint)
	local changExpoint = medicamentConfig.ReactExtraParam1
	local func_Change = ItemEffectFuncs[changeExpoint]
	if func_Change then
		changeExpoint = func_Change(targetEntity)
	end
	curExpoint = curExpoint + changExpoint
	targetEntity:setAttrValue(player_expoint, curExpoint)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变战绩
function ItemEffect.changeCombatNum(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local curCombatNum = targetEntity:getAttrValue(player_combat)
	local changeCombatNum = medicamentConfig.ReactExtraParam1
	curCombatNum = curCombatNum + changeCombatNum
	targetEntity:setAttrValue(player_combat, curCombatNum)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变帮贡
function ItemEffect.changeContribution(targetEntity, medicament, medicamentConfig)

end

-- 改变体力
function ItemEffect.changeVigor(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local maxVigor = targetEntity:getMaxVigor()
	local curVigor = targetEntity:getVigor()
	local changeVigor =  medicamentConfig.ReactExtraParam1
	if maxVigor == curVigor then
		removeFlag = false
		return removeFlag
	end
	curVigor = curVigor + changeVigor
	if curVigor > maxVigor then
		curVigor = maxVigor
	end
	if curVigor < 0 then
		curVigor = 0
	end
	targetEntity:setVigor(curVigor)
	targetEntity:flushPropBatch()
	removeFlag = true
	return removeFlag
end

-- 改变宠物忠诚
function ItemEffect.changePetLoyalty(targetEntity, medicament, medicamentConfig, targetEntityID)
	local removeFlag = false
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	if curEntity then
		local curLoyalty = curEntity:getLoyalty()
		if curLoyalty < MaxPetLoyalty then
			local value = medicamentConfig.ReactExtraParam1
			curLoyalty = curLoyalty + value
			if curLoyalty >= MaxPetLoyalty then
				curLoyalty = MaxPetLoyalty
			end
			curEntity:setLoyalty(curLoyalty)
			curEntity:flushPropBatch()
			removeFlag = true
		end
	end
	return removeFlag
end

-- 改变宠物寿命
function ItemEffect.changePetLife(targetEntity, medicament, medicamentConfig, targetEntityID)
	local removeFlag = false
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	if curEntity then
		local petLife = curEntity:getAttrValue(pet_life)
		local petLifeMax = curEntity:getAttrValue(pet_life_max)
		if petLife >= petLifeMax then
			removeFlag = false
			return removeFlag
		else
			local value = medicamentConfig.ReactExtraParam1
			curPetLife = petLife + value
			if curPetLife >= petLifeMax then
				curPetLife = petLifeMax
			end
			curEntity:setAttrValue(pet_life, curPetLife)
			curEntity:flushPropBatch()
			removeFlag = true
			return removeFlag
		end
	end
end

-- 使用生命池
function ItemEffect.useHpPoolItem(targetEntity, medicament, medicamentConfig,targetEntityID)
	local removeFlag = false
	if not targetEntity then
		return
	end
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	local role = targetEntity
	if instanceof(curEntity,Pet)then
		pet = curEntity
	end

	local roleMaxHp = role:getMaxHP()
	local roleCurHp = role:getHP()
	local roleAddHp = roleMaxHp - roleCurHp
	local petMaxHp = 0
	local petCurHp = 0
	local petAddHp = 0
	if pet then
		petMaxHp = pet:getMaxHP()
		petCurHp = pet:getHP()
		petAddHp = petMaxHp - petCurHp
	end
	if petAddHp + roleAddHp > 0 then
		local leftHpValue = medicament:getEffect()
		if leftHpValue > roleAddHp + petAddHp then
			leftHpValue = leftHpValue - roleAddHp - petAddHp
			medicament:setEffect(leftHpValue)
			-- 直接加满生命力
			role:setHP(roleMaxHp)
			role:flushPropBatch()
			if pet then
				pet:setHP(petMaxHp)
				pet:flushPropBatch(role)
			end
			-- 通知客户端背包物品变化
			local changeInfo = {}
			local gridIndex = medicament:getGridIndex()
			changeInfo[gridIndex] = {}
			changeInfo[gridIndex].effect = medicament:getEffect()
			changeInfo[gridIndex].guid = medicament:getGuid()
			local event = Event.getEvent(ItemEvents_SC_UpdateInfo, 1, medicament:getPackIndex(), changeInfo)
			g_eventMgr:fireRemoteEvent(event, targetEntity)
		else
			if leftHpValue > roleAddHp then
				role:setHP(roleMaxHp)
				if pet then
					pet:setHP(petCurHp+leftHpValue - roleAddHp)
					pet:flushPropBatch(role)
				end
			else
				role:setHP(roleCurHp + leftHpValue)
				role:flushPropBatch()
			end
			removeFlag = true
		end
	else
		-- 无需使用
	end
	return removeFlag
end

-- 使用法力池
function ItemEffect.useMpPoolItem(targetEntity, medicament, medicamentConfig)
	local removeFlag = false
	if not targetEntity then
		return
	end
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	local role = targetEntity
	if instanceof(curEntity,Pet)then
		pet = curEntity
	end

	local roleMaxMp = role:getMaxMP()
	local roleCurMp = role:getMP()
	local roleAddMp = roleMaxMp - roleCurMp
	local petMaxMp = 0
	local petCurMp = 0
	local petAddMp = 0
	if pet then
		petMaxMp = pet:getMaxMP()
		petCurMp = pet:getMP()
		petAddMp = petMaxMp - petCurMp
	end
	if petAddMp + roleAddMp > 0 then
		local leftMpValue = medicament:getEffect()
		if leftMpValue > roleAddMp + petAddMp then
			leftMpValue = leftMpValue - roleAddMp - petAddMp
			medicament:setEffect(leftMpValue)
			-- 直接加满法力
			role:setMP(roleMaxMp)
			role:flushPropBatch()
			if pet then
				pet:setMP(petMaxMp)
				pet:flushPropBatch()
			end
			-- 通知客户端背包物品变化
			local changeInfo = {}
			local gridIndex = medicament:getGridIndex()
			changeInfo[gridIndex] = {}
			changeInfo[gridIndex].effect = medicament:getEffect()
			changeInfo[gridIndex].guid = medicament:getGuid()
			local event = Event.getEvent(ItemEvents_SC_UpdateInfo, 1, medicament:getPackIndex(), changeInfo)
			g_eventMgr:fireRemoteEvent(event, targetEntity)
		else
			if leftMpValue > roleAddMp then
				role:setMP(roleMaxMp)
				if pet then
					pet:setMP(petCurMp+leftMpValue - roleAddMp)
				end
			else
				role:setMP(roleCurMp + leftMpValue)
			end
			if pet then
				pet:flushPropBatch()
			end
			role:flushPropBatch()
			removeFlag = true
		end
	else
		-- 无需使用
	end
	return removeFlag
end

-- 添加宠物
function ItemEffect.addPet(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local petID = medicamentConfig.ReactExtraParam1
	if petID then
		-- 判断能否添加宠物
		if targetEntity:canAddPet() then
			local pet = g_entityFct:createPet(petID)
			pet:setOwner(targetEntity)
			targetEntity:addPet(pet)
			removeFlag = true
		else
			print("玩家宠物已经达到上限，不能添加宠物")
			removeFlag = false
		end
	else
		removeFlag = false
	end
	return removeFlag
end

-- 添加坐骑
function ItemEffect.addRide(targetEntity, medicament, medicamentConfig)
	local removeFlag = true
	local rideID = medicamentConfig.ReactExtraParam1
	local isAdd = g_rideMgr:addRide(targetEntity,rideID)
	if isAdd == 1 then 
		removeFlag = false 
	end
	return removeFlag
end

-- 对作用目标的效果
function ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	local removeFlag = true
	local curEntity = nil
	local reactTarget = medicamentConfig.ReactTarget
	if reactTarget == MedicamentReactTarget.Self then
		curEntity = targetEntity
	elseif reactTarget == MedicamentReactTarget.Pet or reactTarget == MedicamentReactTarget.SelfAndPet then
		if targetEntityID then
			local curPet = g_entityMgr:getPet(targetEntityID)
			if curPet then
				curEntity = curPet
			end
		else
			local curFollowPetID = targetEntity:getFightPetID()
			if curFollowPetID then
				local curFollowPet = g_entityMgr:getPet(curFollowPetID)
				curEntity = curFollowPet
			end
		end
	elseif reactTarget == MedicamentReactTarget.Friend then
		if not targetEntityID then
			curEntity = targetEntity
		else
			local curPet = g_entityMgr:getPet(targetEntityID)
			if curPet then
				curEntity = curPet
			else
				curEntity = g_entityMgr:getPlayerByID(targetEntityID)
			end
		end
	end
	return curEntity
end

-- 改变人物 和 宠物所有属性加点
function ItemEffect.changeAllAttr(targetEntity, medicament, medicamentConfig, targetEntityID)
	local removeFlag = false
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	if curEntity then
		if curEntity:getEntityType() == eClsTypePlayer then
			removeFlag = ItemEffect.washPlayerAllAttr(curEntity)
		elseif curEntity:getEntityType() == eClsTypePet then
			removeFlag = ItemEffect.washPetAllAttr(curEntity)
			if removeFlag then
				curEntity:flushPropBatch()
			end
		end
	end
	return removeFlag
end

local PlayerCleanAttrs = {
	player_str_point,
	player_int_point,
	player_sta_point,
	player_spi_point,
	player_dex_point,
}

-- 清除玩家所有属性加点
function ItemEffect.washPlayerAllAttr(player)
	local freePoint = 0
	for _,attrName in ipairs(PlayerCleanAttrs) do
		local pnt = player:getAttrValue(attrName)
		if pnt > 0 then
			player:setAttrValue(attrName,0)
			freePoint = freePoint + pnt
		end
	end

	local attrPoint = player:getAttrValue(player_attr_point)

	if freePoint < 1 then
		print("玩家没有可还原的属性点")
		return false
	end

	player:setAttrValue(player_attr_point,
		player:getAttrValue(
			player_attr_point
		) + freePoint
	)

	local curHp = player:getAttrValue(player_hp)
	local maxHp = player:getAttrValue(player_max_hp)
	local curMp = player:getAttrValue(player_mp)
	local maxMp = player:getAttrValue(player_max_mp)
	if curHp > maxHp then
		player:setAttrValue(player_hp, maxHp)
	end

	if curMp > maxMp then
		player:setAttrValue(player_mp, maxMp)
	end
	return true
end

local PetCleanAttrs = {
	pet_str_point,
	pet_int_point,
	pet_sta_point,
	pet_spi_point,
	pet_dex_point,	
}

-- 清楚宠物所有属性加点
function ItemEffect.washPetAllAttr(pet)
	local freePoint = 0

	for _,attrName in ipairs(PetCleanAttrs) do
		local pnt = pet:getAttrValue(attrName)
		if pnt > 0 then
			pet:setAttrValue(attrName,0)
			freePoint = freePoint + pnt
		end
	end


	if freePoint < 1 then
		print("宠物没有可还原的属性点")
		return false
	end

	pet:setAttrValue(pet_attr_point,
		pet:getAttrValue(pet_attr_point) + freePoint
	)

	local curHp = pet:getAttrValue(pet_hp)
	local maxHp = pet:getAttrValue(pet_max_hp)
	local curMp = pet:getAttrValue(pet_mp)
	local maxMp = pet:getAttrValue(pet_max_mp)
	if curHp > maxHp then
		pet:setAttrValue(pet_hp, maxHp)
	end

	if curMp > maxMp then
		pet:setAttrValue(pet_mp, maxMp)
	end
	return true
end

-- 玩家、宠物所有抗性
function ItemEffect.changeAllPhase(targetEntity, medicament, medicamentConfig, targetEntityID)
	local removeFlag = false
	local curEntity = ItemEffect.getTargetEntity(targetEntity, medicamentConfig, targetEntityID)
	if curEntity:getEntityType() == eClsTypePlayer then
		removeFlag = ItemEffect.washPlayerAllPhase(curEntity)
	elseif curEntity:getEntityType() == eClsTypePet then
		removeFlag = ItemEffect.washPetAllPhase(curEntity)
		if removeFlag then
			curEntity:flushPropBatch()
		end
	end
	return removeFlag
end

-- 玩家清除的相性属性
local PlayerCleanPhases = {
	player_win_phase_point,
	player_thu_phase_point,
	player_ice_phase_point,
	player_soi_phase_point,
	player_fir_phase_point,
	player_poi_phase_point,
}

-- 清除玩家所有相性加点
function ItemEffect.washPlayerAllPhase(player)
	--获取所有的属性加点
	local freePoint = 0
	for _,attrName in ipairs(PlayerCleanPhases) do
		local pnt = player:getAttrValue(attrName)
		if pnt > 0 then
			player:setAttrValue(attrName,0)
			freePoint = freePoint + pnt
		end
	end

	if freePoint < 1 then
		print("玩家没有可还原的相性点")
		return false
	end

	player:setAttrValue(player_phase_point, 
		player:getAttrValue(
			player_phase_point
		) + freePoint
	)

	local curHp = player:getAttrValue(player_hp)
	local maxHp = player:getAttrValue(player_max_hp)
	local curMp = player:getAttrValue(player_mp)
	local maxMp = player:getAttrValue(player_max_mp)
	if curHp > maxHp then
		player:setAttrValue(player_hp, maxHp)
	end

	if curMp > maxMp then
		player:setAttrValue(player_mp, maxMp)
	end
	player:flushPropBatch()
	return true
end

-- 宠物需要清除的相性属性
local PetCleanPhases = {
	pet_fir_phase_point,pet_soi_phase_point,
	pet_win_phase_point,pet_poi_phase_point,
	pet_ice_phase_point,pet_thu_phase_point,
	pet_chaos_phase_point,pet_taunt_phase_point,
	pet_sopor_phase_point,pet_silent_phase_point,
	pet_freeze_phase_point,pet_toxicosis_phase_point,
	pet_chaos_phase_point,pet_taunt_phase_point,
	pet_sopor_phase_point,pet_silent_phase_point,
	pet_freeze_phase_point,pet_toxicosis_phase_point,
}

-- 宠物所有抗性
function ItemEffect.washPetAllPhase(targetEntity)
	local flag = false
	local value = 0
	local point = 0
	for _,attrName in ipairs(PetCleanPhases) do
		point = targetEntity:getAttrValue(attrName)
		if point > 0 then
			targetEntity:setAttrValue(attrName, 0)
			value = value + point
			flag = true
		end
	end
	
	if flag then
		local petPhasePoint = targetEntity:getAttrValue(pet_phase_point)
		petPhasePoint = petPhasePoint + value
		targetEntity:setAttrValue(pet_phase_point, petPhasePoint)

		local curHp = targetEntity:getAttrValue(pet_hp)
		local maxHp = targetEntity:getAttrValue(pet_max_hp)
		local curMp = targetEntity:getAttrValue(pet_mp)
		local maxMp = targetEntity:getAttrValue(pet_max_mp)
		if curHp > maxHp then
			targetEntity:setAttrValue(pet_hp, maxHp)
		end
		if curMp > maxMp then
			targetEntity:setAttrValue(pet_mp, maxMp)
		end
		targetEntity:flushPropBatch()
		return true
	else
		return false
	end
end

-- 添加宠物经验
function ItemEffect.changePetExp(targetEntity, medicament, medicamentConfig, targetEntityID)
	local curEntity
	if targetEntityID then
		-- 针对所选则的宠物
		local pet = g_entityMgr:getPet(targetEntityID)
		if pet then
			curEntity = pet
		else
			return false
		end
	else
		-- 只针对出战宠物
		local curFollowPetID = targetEntity:getFightPetID()
		if curFollowPetID then
			local curFollowPet = g_entityMgr:getPet(curFollowPetID)
			curEntity = curFollowPet
		else 
			return false
		end
	end

	if curEntity then
		local value = medicamentConfig.ReactExtraParam1
		curEntity:addXp(value)
		curEntity:flushPropBatch()
		removeFlag = true
		return removeFlag
	end
end

--增加坐骑体力值
function ItemEffect.changeRideVigor(player, medicament, medicamentConfig, targetEntityID)
	local removeFlag = true
	local rideHandler = player:getHandler(HandlerDef_Ride)
	local ride = nil
	if not targetEntityID then
		ride = rideHandler:getRidingMount()
	else
		ride = rideHandler:getRide(targetEntityID)
	end
	if not ride then
		removeFlag = false
		return removeFlag
	end
	local addVigor = medicamentConfig.ReactExtraParam1
	local vigor 
	if ride:getVigor() < RideDB[ride:getID()].vigor then
		vigor = ride:getVigor()+addVigor
		--坐骑体力允许超出最大上限
		ride:setVigor(vigor)
	else
		removeFlag = false
		local event = Event.getEvent(ClientEvents_SC_PromptMsg,eventGroup_Item, 10,errCode)
		g_eventMgr:fireRemoteEvent(event,player)
		return removeFlag
	end
	local event = Event.getEvent(RideEvent_SC_AddRideVigor,ride:getGuid(),vigor)
	g_eventMgr:fireRemoteEvent(event,player)
	return removeFlag
end

-- 使用物品可能完成任务
function ItemEffect.finishTask(targetEntity, medicament, medicamentConfig)
	local taskHandler = targetEntity:getHandler(HandlerDef_Task)
	local taskID = medicamentConfig.ReactExtraParam1
	local task = taskHandler:getTask(taskID)
	if not task then
		print("当前你没有这个任务")
		removeFlag = false
		return removeFlag
	end
	-- 有这个任务也不行，还要判断当前任务目标是这个购买物品，
	local targetType = task:getTargetType()
	local targetIndex = task:getTargetIdx()
	if targetType ~= LoopTaskTargetType.mysteryBus then
		print("当前任务目标不对应，不能够使用该物品")
		removeFlag =false
		return removeFlag
	end
	g_taskDoer:doDeleteTask(targetEntity, taskID)
	local loopTask = g_taskFty:createLoopTask(targetEntity, taskID, LoopTaskTargetType.itemTalk)
	loopTask:setReceiveTaskLvl(targetEntity:getLevel())
	taskHandler:addTask(loopTask)
	
	taskHandler:updateTaskList(taskID, false)
	removeFlag = true
	return removeFlag
end

-- 使用藏宝图可能打开宝藏
function ItemEffect.openTreasure(targetEntity, medicament, medicamentConfig)
	-- 删除标识为不删除
	removeFlag = false
	-- 是否组队 是否是队长
	local teamHandler = targetEntity:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() and not teamHandler:isLeader() then
		return removeFlag
	end
	
	-- 判断是否已经创建
	local treasureHandler = targetEntity:getHandler(HandlerDef_Treasure)
	local guid = medicament:getGuid()
	local treasureID = medicamentConfig.ReactExtraParam1
	
	if not medicament:getBindFlag() then
		local packIndex = medicament:getPackIndex()
		local gridIndex	= medicament:getGridIndex()
		
		local packetHandler = targetEntity:getHandler(HandlerDef_Packet)
		local packet = packetHandler:getPacket()
		
		local item = g_itemMgr:createItem(medicamentConfig.ReactExtraParam1, 1)
		packet:removeItemsFromGrid(packIndex, gridIndex, false)
		packet:addItemsToGrid(item, packIndex, gridIndex, true)
		treasureID = tItemDB[medicamentConfig.ReactExtraParam1].ReactExtraParam1
		guid = item:getGuid()
	end
	
	-- 创建宝藏 
	if not g_treasureMgr:createTreasure(targetEntity,treasureID,guid) then
		-- 把物品设置为绑定
		local isTrue,msgID,msgParams = treasureHandler:doClickTreasure(guid)
		if isTrue then
			removeFlag = true
			return removeFlag
		else
			treasureHandler:sendTreasureMessage(msgID,msgParams)
			return removeFlag
		end
	end
end

-- 为宠物添加技能
function ItemEffect.addPetSkill(targetEntity,item,itemConfig,targetEntityID)
	local targetPet
	if targetEntityID then
		local pet = g_entityMgr:getPet(targetEntityID)
		if pet and pet:getOwnerID() == targetEntity:getID() then
			targetPet = pet
		end
	end
	if not targetPet then
		local followID = targetEntity:getFightPetID()
		local pet = followID and g_entityMgr:getPet(followID)
		if pet then
			targetPet = pet
		end
	end
	if not targetPet then
		g_eventMgr:fireRemoteEvent(
			Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet, PetError.NoPetLearn), targetEntity
		)
		return false	--不删除物品
	end

	local skillHandler = targetPet:getHandler(HandlerDef_PetSkill)
	local errCode = skillHandler:canRead(item:getItemID())
	if errCode == 0 then
		skillHandler:readBook(item:getItemID())
		return true
	end
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet,errCode),targetEntity
	)
	return false
end

-- 添加一个任务
function ItemEffect.addTask(targetEntity,item,itemConfig,targetEntityID)
	-- 删除标识为不删除
	local taskID = itemConfig.ReactExtraParam1
	local removeFlag = g_taskDoer:doRecetiveTask(targetEntity,taskID )
	if not removeFlag then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Task, 14)
		g_eventMgr:fireRemoteEvent(event, targetEntity)
	end
	return removeFlag
end

--完成一个任务
function ItemEffect.completeTask(targetEntity,item,itemConfig,targetEntityID)
	local removeFlag = false
	local taskID = itemConfig.ReactExtraParam1
	if targetEntity:getHandler(HandlerDef_Task):finishTaskByID(taskID) then
		removeFlag = true
	end
	return removeFlag
end

--改变宠物忠诚度并把剩余值添加一个buff
function ItemEffect.changeLoyaltyAndAddBuff(targetEntity,item,itemConfig,targetEntityID)
	local removeFlag = true
	local pet
	if targetEntityID then
		-- 针对所选则的宠物
		pet = g_entityMgr:getPet(targetEntityID)
		if not pet then
			removeFlag = false
		end
	else
		-- 只针对出战宠物
		local curFollowPetID = targetEntity:getFightPetID()
		if curFollowPetID then
			local curFollowPet = g_entityMgr:getPet(curFollowPetID)
			pet = curFollowPet
		else
			removeFlag = false
		end
	end
	if pet then
		local buffID = itemConfig.ReactExtraParam1
		local curLoyalty = pet:getLoyalty()
		if curLoyalty >= MaxPetLoyalty then
			g_buffMgr:addBuff(targetEntity, buffID)
			removeFlag = true
		else
			local buffConfig = FightOutBuffDB[buffID]
			local value = buffConfig.last_num
			local subValue = 0
			if curLoyalty + value >= MaxPetLoyalty then
				subValue = value-(MaxPetLoyalty - curLoyalty)
				curLoyalty = MaxPetLoyalty
				local buff = Buff(buffID, targetEntity)
				buff.lastValue = subValue
				targetEntity:getHandler(HandlerDef_Buff):addBuff(buff)
			else
				curLoyalty = curLoyalty + value
			end
			pet:setLoyalty(curLoyalty)
			pet:flushPropBatch()
			removeFlag = true
		end
	else
		local buffID = itemConfig.ReactExtraParam1
		g_buffMgr:addBuff(targetEntity, buffID)
		removeFlag = true
	end
	return removeFlag
end

--改变生命并把剩余值添加一个buff
function ItemEffect.changeHpAndAddBuff(targetEntity,item,itemConfig,targetEntityID)
	local removeFlag = true
	if not targetEntity then
		return
	end
	-- 如果有作用目标的话
	local pet
	if targetEntityID then
		local pet = g_entityMgr:getPet(targetEntityID)
	else
		-- 只针对出战宠物
		local curFollowPetID = targetEntity:getFightPetID()
		if curFollowPetID then
			pet = g_entityMgr:getPet(curFollowPetID)
		end
	end
	local role = targetEntity

	local buffID = itemConfig.ReactExtraParam1
	local buffConfig = FightOutBuffDB[buffID]
	local value = buffConfig.last_num
	
	local roleMaxHp = role:getMaxHP()
	local roleCurHp = role:getHP()
	-- 可以改变值
	if roleCurHp + value >= roleMaxHp then
		value = value - (roleMaxHp-roleCurHp)
		role:setHP(roleMaxHp)
	else
		role:setHP(roleCurHp + value)
		value = 0
	end
	
	if pet then
		local petMaxHp = pet:getMaxHP()
		local petCurHp = pet:getHP()
		if petCurHp + value >= petMaxHp then
			value = value - (petMaxHp-petCurHp)
			pet:setHP(petMaxHp)
		else
			pet:setHP(petCurHp + value)
			value = 0
		end
		pet:flushPropBatch()
	end

	if value > 0 then
		local buff = Buff(buffID, targetEntity)
		buff.lastValue = value
		targetEntity:getHandler(HandlerDef_Buff):addBuff(buff)
	end
	removeFlag = true
	return removeFlag
end


--改变法力并把剩余值添加一个buff
function ItemEffect.changeMpAndAddBuff(targetEntity,item,itemConfig,targetEntityID)
	local removeFlag = true
	if not targetEntity then
		return
	end
	-- 如果有作用目标的话
	local pet
	if targetEntityID then
		local pet = g_entityMgr:getPet(targetEntityID)
	else
		-- 只针对出战宠物
		local curFollowPetID = targetEntity:getFightPetID()
		if curFollowPetID then
			pet = g_entityMgr:getPet(curFollowPetID)
		end
	end
	local role = targetEntity

	local buffID = itemConfig.ReactExtraParam1
	local buffConfig = FightOutBuffDB[buffID]
	local value = buffConfig.last_num
	
	local roleMaxMp = role:getMaxMP()
	local roleCurMp = role:getMP()
	-- 可以改变值
	if roleCurMp + value >= roleMaxMp then
		value = value - (roleMaxMp-roleCurMp)
		role:setMP(roleMaxMp)
	else
		role:setMP(roleCurMp + value)
		value = 0
	end
	
	if pet then
		local petMaxMp = pet:getMaxMP()
		local petCurMp = pet:getMP()
		if petCurMp + value >= petMaxMp then
			value = value - (petMaxMp-petCurMp)
			pet:setMP(petMaxMp)
		else
			pet:setMP(petCurMp + value)
			value = 0
		end
		pet:flushPropBatch()
	end

	if value > 0 then
		local buff = Buff(buffID, targetEntity)
		buff.lastValue = value
		targetEntity:getHandler(HandlerDef_Buff):addBuff(buff)
	end
	removeFlag = true
	return removeFlag
end

