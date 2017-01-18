--[[FightItemManager.lua
描述:
	战斗内道具管理
]]

-- 存储所有道具的数据表
tItemDB = {}
table.deepCopy(tWarrantDB, tItemDB)
table.deepCopy(tMedicamentDB, tItemDB)
table.deepCopy(tEquipmentDB, tItemDB)

FightItemManager = class(nil, Singleton)

function FightItemManager:__init()
end

function FightItemManager:__release()
end

-- 判断药品类道具能否使用
function FightItemManager:canUseMedicament(player, itemGuid, target)
	print("---判断药品类道具能否使用-----------得到----------")
	local role = player
	--使用主人的包裹
	if (instanceof(player, FightPet)) then
		local ownerID = player:getOwnerID()
		role = g_fightEntityMgr:getRole(ownerID)
	end
	local fightItemHandler = role:getHandler(FightEntityHandlerType.HandlerDef_FightItem)
	local battlePack = fightItemHandler:getBattlePack()
	local itemInfo = battlePack[itemGuid]
	if not itemInfo then
		-- 战斗包裹没有此道具
		return false
	end
	-- 数量不能小于1
	if itemInfo.itemNum < 1 then
		return false
	end

	local medicamentConfig = tMedicamentDB[itemInfo.itemID]
	if not medicamentConfig then
		return false
	end
	-- 判断使用等级
	local playerLvl = player:getLevel()
	if playerLvl < medicamentConfig.UseNeedLvl then
		return false
	end
	-- 判断战斗状态
	if medicamentConfig.UseNeedState < MedicamentUseState.Fight then
		return false
	end
	-- 判断道具使用次数
	if medicamentConfig.UseTimesOneDay > 0 then
		if itemInfo.useTimes >= medicamentConfig.UseTimesOneDay then
			return false
		end
	end
	-- 判断对指定目标能否使用
	return true
end

-- 使用药品类道具
function FightItemManager:useMedicament(player, itemGuid, target)
	local role = player
	--使用主人的包裹
	if (instanceof(player, FightPet)) then
		local ownerID = player:getOwnerID()
		role = g_fightEntityMgr:getRole(ownerID)
	end

	local fightItemHandler = role:getHandler(FightEntityHandlerType.HandlerDef_FightItem)
	local battlePack = fightItemHandler:getBattlePack()
	local itemInfo = battlePack[itemGuid]
	if not itemInfo then
		-- 战斗包裹没有此道具
		return
	end
	local medicamentConfig = tMedicamentDB[itemInfo.itemID]
	if not medicamentConfig then
		return
	end
	local actionList = {}
	local addHp, addMp, addBuffID = 0, 0, 0
	if medicamentConfig.ReactType == MedicamentReactType.AddBuff then
		if fightItemHandler:removeBattleItem(itemGuid, 1) then
			addBuffID = medicamentConfig.ReactExtraParam1
			g_fightBuffMgr:addBuff(target, medicamentConfig.ReactExtraParam1, medicamentConfig.ReactExtraParam2)
		end
	elseif medicamentConfig.ReactType == MedicamentReactType.ChangeHp then
		if fightItemHandler:removeBattleItem(itemGuid, 1) then
			addHp = medicamentConfig.ReactExtraParam1
			local maxHp = target:getMaxHp()
			local curHp = target:getHp()
			curHp = curHp + addHp
			if curHp > maxHp then
				addHp = addHp - (curHp - maxHp)
				curHp = maxHp
			end
			if curHp < 0 then
				curHp = 0
			end
			target:setHp(curHp)
			if curHp > 0 then
				target:setLifeState(RoleLifeState.Normal)
			end
		end
	elseif medicamentConfig.ReactType == MedicamentReactType.ChangeMp then
		if fightItemHandler:removeBattleItem(itemGuid, 1) then
			addMp = medicamentConfig.ReactExtraParam1
			local maxMp = target:getMaxMp()
			local curMp = target:getMp()
			curMp = curMp + addMp
			if curMp > maxMp then
				addMp = addMp - (curMp - maxMp)
				curMp = maxMp
			end
			if curMp < 0 then
				curMp = 0
			end
			target:setMp(curMp)
		end
	elseif medicamentConfig.ReactType == MedicamentReactType.UseHpPool then
		local maxHp = target:getMaxHp()
		local curHp = target:getHp()
		addHp = maxHp - curHp
		local leftHpValue = itemInfo.effect
		if addHp > 0 then
			if fightItemHandler:removeBattleItem(itemGuid, addHp) and leftHpValue > 0 then
				if leftHpValue > addHp then
					-- 直接加满血量
					target:setHp(maxHp)
				else
					curHp = curHp + leftHpValue
					target:setHp(curHp)
				end
			end
		else
			-- 无需使用
		end
	elseif medicamentConfig.ReactType == MedicamentReactType.UseMpPool then
		local maxMp = target:getMaxMp()
		local curMp = target:getMp()
		addMp = maxMp - curMp
		local leftMpValue = itemInfo.effect
		if addMp > 0 then
			if fightItemHandler:removeBattleItem(itemGuid, addMp) and leftMpValue > 0 then
				if leftMpValue > addMp then
					-- 直接加满血量
					target:setMp(maxMp)
				else
					curMp = curMp + leftMpValue
					target:setMp(curMp)
				end
			end
		else
			-- 无需使用
		end
	else
		print("FightItemManager:useMedicament 逻辑错误")
	end
	table.insert(actionList, {id = target:getID(), lifeState = target:getLifeState(),hp = addHp, mp = addMp, buffId = addBuffID})
	return actionList
end

-- 道具奖励
function FightItemManager:addItemPrize(player, itemID, itemNum)
	if not tItemDB[itemID] then
		-- 道具不存在
		return
	end
	local fightItemHandler = player:getHandler(FightEntityHandlerType.HandlerDef_FightItem)
	fightItemHandler:addItemToBattlePack(itemID, itemNum)
end

function FightItemManager.getInstance()
	return FightItemManager()
end
