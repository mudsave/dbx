--[[FightUtils.lua
描述：
	战斗工具
--]]

require "base.base"


FightUtils = class(nil,Singleton)


function FightUtils:__init()
	
end

		
--[[
members ={[Id]=target1,[id2]=target2}
]]
local validRandomMembers={}
function FightUtils.findRandomTarget(members,exceptOne)

	table.clear(validRandomMembers)
	for _,tar in pairs(members) do
		local s = tar:getLifeState()
		if (tar ~= exceptOne) and ( s ~= RoleLifeState.Dead) then
			table.insert(validRandomMembers,tar)
		end
	end
	local count = table.size(validRandomMembers)
	if count == 0 then
		return nil
	end
	local target 
	local rand = math.random(count)
	local j = 1
	for _,role in pairs(validRandomMembers) do
		if j == rand then
			target = role
			break
		end
		j = j +1
	end
	table.clear(validRandomMembers)
	return target
end

local Elements ={}
function FightUtils.findRandomElement(array,exceptValue)
	table.clear(Elements)
	for _,tar in pairs(array) do
		if (tar ~= exceptValue)  then
			table.insert(Elements,tar)
		end
	end
	local target 
	if 0 == table.size(Elements) then
		print(debug.traceback())
	end
	local rand = math.random(table.size(Elements))
	local target = Elements[rand]
	table.clear(Elements)
	return target
end


local AllRandomMembers={}
function FightUtils.findRandomPos(members,exceptOne,poses)

	table.clear(AllRandomMembers)
	for _,tar in pairs(members) do
		if (tar ~= exceptOne)  then
			table.insert(AllRandomMembers,tar)
		end
	end

	if #AllRandomMembers == 0 then
		
		local myPos
		if exceptOne then
			myPos = exceptOne:getPos()[3]
		end
		local randPos = FightUtils.findRandomElement(poses,myPos)
		table.clear(AllRandomMembers)
		return randPos

	else
		local target 
		local rand = math.random(table.size(AllRandomMembers))
		target = AllRandomMembers[rand]
		table.clear(AllRandomMembers)
		return target:getPos()[3]
	end
	
end

local RandomTargetOfDBID = {}
function FightUtils.getRandomTargetByDBID(members,DBID)
	table.clear(RandomTargetOfDBID)
	for pos,target in pairs(members) do
		if target:getDBID() == DBID then
			table.insert(RandomTargetOfDBID,pos)
		end
	end
	local count = #RandomTargetOfDBID
	if count > 0 then
		local rand = math.random(count)
		return members[RandomTargetOfDBID[rand]]
	end
	return nil
end
--[[
members:某边的全体成员
]]
function FightUtils.getTargetsByDBID(members,DBID)
	local result = {}
	local anotherMembers
	--某边的
	for pos,target in pairs(members) do
		if not anotherMembers then
			 local anotherSide = FightUtils.getEnemySide(target)
			 local fightID = target:getFightID()
			 local fight = g_fightMgr:getFight(fightID)
			 anotherMembers = fight:getMembers()[anotherSide]	
		end
		if target:getDBID() == DBID and target:getLifeState() == RoleLifeState.Normal then
			table.insert(result,target:getID())
		end
	end
	--加上另一边的
	if anotherMembers then
		for pos,target in pairs(anotherMembers) do
			if instanceof(target, FightMonster) and target:getDBID() == DBID and target:getLifeState() == RoleLifeState.Normal then
				table.insert(result,target:getID())
			end
		end
	end
	return result
end

function FightUtils.getPlayerByDBID(fight,side,DBID)
	local members = fight:getMembers()[side]
	for pos,target in pairs(members) do
		if instanceof(target,FightPlayer) and target:getDBID() == DBID then
			return target
		end
	end
	return nil
end

function FightUtils.getTeamHead(fight,side)
	local members = fight:getMembers()[side]
	for pos,target in pairs(members) do
		if instanceof(target,FightPlayer) and target:getIsTeamHead() == true then
			return target
		end
	end
	return nil
end

function FightUtils.getLiveNum(members)
	local count = 0
	for _,tar in pairs(members) do
		if  ( tar:getLifeState() == RoleLifeState.Normal  ) then
			count = count + 1
		end
	end
	return count
end

--混乱障碍动作
function FightUtils.doChaosThing(fight,actionInfo)
	local role = actionInfo.role
	--获取随机数
	local rand = math.random(1, 100)
	--一半的概率混乱
	if rand <= 50 then
		actionInfo.actionType = FightUIType.CommonAttack
		local rand1 = math.random(1, 100)
		--一半的概率攻击友方
		if rand1 <= 50 then
			--获取所有位置信息
			local members = fight:getMembers()
			local targets = members[role:getPos()[2]]
			local target = FightUtils.findRandomTarget(targets,role) 
			if target then
				local pos = target:getPos()[3]
				actionInfo.context.target = pos
			else
				actionInfo.context.target = (-1)*0xFFFFFFFF
			end
		else
			actionInfo.context.target = (-1)*0xFFFFFFFF
		end
		return true
	end
	return false
end

function FightUtils.doTauntThings(action)
		local role = action.role
		action.actionType = FightUIType.CommonAttack
		action.context = {}
		local bh = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff) 
		local attacker = bh:getObstacleSrcEntity()
		if attacker and attacker:getLifeState() ~= RoleLifeState.Dead  then
			action.context.target = attacker:getPos()[3]
		else
			action.context.target = NonExistEntityPos
		end
end

function FightUtils.findMyPet(player)
	local fightID = player:getFightID()
	local fight = g_fightMgr:getFight(fightID)

	local members = fight:getMembers()
	local side = player:getPos()[2]
	local playerID = player:getID()
	local pet
	for _,role1 in pairs(members[side]) do
		if instanceof(role1, FightPet) then
			local ownerID = role1:getOwnerID()
			if ownerID == playerID then
				pet = role1
				break
			end		
		end
	end
	return pet
end
-------------------------------设置客户端面板状态(不用了)-------------------------------------------------------------------------------------------

function FightUtils._setRolePanelStatus(role,panelInfo)
	for type,_ in pairs(FightUIType) do
		panelInfo[type] = true
	end
	--是否禁止逃跑
	local fightID = role:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	if fight.isNoEscape then
		panelInfo[FightUIType.Escape] = false
	end 
	--状态审核
	if role:getLifeState() == RoleLifeState.Dead or role:getLifeState() == RoleLifeState.Freeze or role:getLifeState() == RoleLifeState.Sopor or role:getIsGathering() == true then
			for type,_ in pairs(FightUIType) do
				panelInfo[type] = false
			end
	elseif role:getLifeState() == RoleLifeState.Taunt then
			for type,_ in pairs(FightUIType) do
				if type ~= FightUIType.CommonAttack then
					panelInfo[type] = false
				end
			end
	elseif role:getLifeState() == RoleLifeState.Poison then
			panelInfo[FightUIType.CommonAttack] = false
	end
end

function FightUtils._setPanelStatus(role,panelStatus)
	--对于玩家
	local playeInfo = panelStatus.player
	FightUtils._setRolePanelStatus(role,playeInfo)
	-- 宠物
	local pet = role:getPet()
	if not pet then
		return
	end
	local petInfo =  panelStatus.pet
	FightUtils._setRolePanelStatus(pet,petInfo)
end

--通知客户端回合开始------------------------------------
local panelStatus = { player={},pet={}}
local function clearPanel()
				table.clear(panelStatus.player)
				table.clear(panelStatus.pet)
end
function FightUtils.informRoundStart(fight,roundCount)

	local members = fight:getMembers()
	for _,rolesInfo in pairs(members) do
		for _,role in pairs(rolesInfo) do
			if instanceof(role,FightPlayer) then
				--clearPanel()
				--FightUtils._setPanelStatus(role,panelStatus)
				--local event = Event.getEvent(FightEvents_FC_StartRound,roundCount,panelStatus)
				local event = Event.getEvent(FightEvents_FC_StartRound,roundCount)
				g_eventMgr:fireRemoteEvent(event,role)
			end
		end
	end
	
end
-----------------------------------------------------------------------------------------------------------------------------
function FightUtils.setPlayerChangedAttrInfo(role,attrInfo)
	local attrSet = role:getAttributeSet()
	for attrType,attr in pairs(attrSet) do
		if (not PlayerAttrDefine[attrType].expr) and role:isChanged(attrType) then
			attrInfo[attrType] = role:getAttrValue(attrType)
		end
	end
	attrInfo.dbID = role:getDBID()
	-- 怒气值清0
	attrInfo[player_anger] = 0
	local itemHandler = role:getHandler(FightEntityHandlerType.HandlerDef_FightItem)
	attrInfo.pack = itemHandler:getBattlePack()
end

function FightUtils.setPetChangedAttrInfo(role,attrInfo)
	local attrSet = role:getAttributeSet()
	for attrType,attr in pairs(attrSet) do
		if (not PetAttrDefine[attrType].expr) and role:isChanged(attrType) then
			attrInfo[attrType] = role:getAttrValue(attrType)
		end
	end
	attrInfo.dbID = role:getDBID()
	attrInfo.worldPetID = role:getWorldPetID()
	attrInfo.life = role:getLife()
	attrInfo.loyalty = role:getLoyalty()
	attrInfo.status = role:getStatus()
	attrInfo.isNew = role:getIsNew()	
	
end

function FightUtils.setMonsterInfo4Client(monsters,info,context)
	for _, v in pairs( monsters ) do
		local monster = {}
		monster['monsterDBID']	= v:getDBID()
		monster['monsterID'] 	= v:getID()
		monster['fightIdx'] 	= v:getPos()[3]
		monster['maxHp'] 		= v:getAttrValue(monster_max_hp)
		monster['hp'] 			= v:getAttrValue(monster_hp)
		monster['ModelID'] 	    = v:getModelID()
		monster['type']			= eClsTypeMonster
		monster["actionID"]		= v:getEnterActionID()
		monster["effectID"]     = v:getEnterEffectID()
		if context then
			monster.isSpecialAction = context.isSpecialAction
		end
		table.insert(info, monster)
	end
end

function FightUtils.getEnemySide(role)
	local mySide = role:getPos()[2]
	local enemySide
	if mySide == FightStand.B then
		enemySide = FightStand.A
	else
		enemySide = FightStand.B
	end
	return enemySide
end

function FightUtils.getMinorMonsters(scriptConfig)
	local minorMonsters = {}
	local config = scriptConfig.monsters
	local count = config.maxCount

	for i = 1, count do

		local curWeight = 0
		local totalWeight = 0
		for _,info in ipairs(config) do
			totalWeight = totalWeight + info.weight
		end

		local rand = math.random(totalWeight)

		for k,info in ipairs(config) do
			if rand >= curWeight and rand <=  curWeight + info.weight then
				table.insert(minorMonsters,info.ID)
				break
			end
			curWeight = curWeight + info.weight
		end
	end

	return minorMonsters
end

function FightUtils.ForcePetLeave(pet)
	local fightID = pet:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	fight:removeRole(pet,true)
	local result = { actionType = FightUIType.Escape ,roleID = pet:getID(), isOk = true }
	FightUtils.insertFightResult(fight,result)
	pet:setIsEscaped(true)
end

function FightUtils.ForcePlayerLeave(player)
	local fightID = player:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	local result = { actionType = FightUIType.Escape ,roleID = player:getID(), isOk = true }
	FightUtils.insertFightResult(fight,result)
	
	local pet = FightUtils.findMyPet(player)
	if pet then
		local result1 = { actionType = FightUIType.Escape ,roleID = pet:getID(), isOk = true }
		FightUtils.insertFightResult(fight,result1)
		fight:removeRole(pet,true)
	end
	--生成玩家属性集
	local AttrsPool4transfer = {{},}
	local storedPets4transfer ={{},{},{},{},{},{},{},{},{},{}}
	FightUtils.setPlayerChangedAttrInfo(player,AttrsPool4transfer[1])
	AttrsPool4transfer[1].isPlayer = 1
	AttrsPool4transfer[1].isWin = false
	local j = 1
	for _ ,petID in pairs(player:getPetList()) do
		local pet = g_fightEntityMgr:getRole(petID)
		--生成宠物属性集
		storedPets4transfer[j].isPlayer = 0
		storedPets4transfer[j].isWin = false
		FightUtils.setPetChangedAttrInfo(pet,storedPets4transfer[j])
		j = j + 1
	end
	--通知世界服和自己的客户端
	local scriptID 
	if fight._fightType == FightType.Script then
		scriptID = fight:getScriptID()
	end
	local event = Event.getEvent(FightEvents_FS_FightEnd,AttrsPool4transfer,scriptID,fight._allMonsterDBIDs,storedPets4transfer,fight:getFightID())
	print("另一种战斗结束",AttrsPool4transfer,scriptID,fight._allMonsterDBIDs,storedPets4transfer,fight:getFightID())
	-- RemoteEventProxy.sendToWorld(event,fight._srcWorldID)
	g_eventMgr:fireWorldsEvent(event,fight._srcWorldID)
	event = Event.getEvent(FightEvents_FC_QuitFight)
	g_eventMgr:fireRemoteEvent(event,player)
	--销毁玩家和宠物
	fight:removeRole(player)

end

function FightUtils.insertFightResult(fight,result,bInsert)
	local curResultIndex = fight:getCurResultIndex()
	if not bInsert then
		fight:setCurResult(curResultIndex,result)
	else
		--print("ppppppppppppppppppppppppp")
		--print(toString(FightResults))
		fight:insertCurResult(curResultIndex-2,result)
		--print(toString(FightResults),toString(result))

		--print("ssssssssssssss",curResultIndex)
	end
	local nextIndex = curResultIndex + 1
	fight:setCurResultIndex(nextIndex)
	
end
--实体死亡后处理(现在主要是复活)
function FightUtils.doPostDead(dead_list)
	local actionList
	for _,ID in pairs(dead_list) do
		local role = g_fightEntityMgr:getRole(ID)
		if role and instanceof(role,FightMonster) then
			local fight = g_fightMgr:getFight(role:getFightID())
			local fightType = fight:getType()
			if fightType == FightType.Script then
				fight:onRoleDead(role)
			end
		end
		if role and (instanceof(role,FightPlayer) or instanceof(role,FightPet))then
			local tmp_actionList = role:useRevivalSkill()
			if tmp_actionList then
				if not actionList then
					actionList = {}
				end
				-- 解析返回的actionList插入到复活结果集的actionList中
				for _, action in pairs(tmp_actionList) do
					table.insert( actionList, action )
				end
			else
				--死亡清理buff
				g_fightBuffMgr:onDeadClearBuff(role)
				local protectee = role:getProtectee()
				if protectee then
					protectee:clearProtector(role)
					role:setProtectee(nil)
				end

				if instanceof(role,FightPlayer) then
					--通知脚本战斗
					local fight = g_fightMgr:getFight(role:getFightID())
					local fightType = fight:getType()
					if fightType == FightType.Script then
						fight:onRoleDead(role)
					end
				end

				if instanceof(role,FightPet) then
					--减忠诚
					local cur = role:getLoyalty()
					local left = cur - EachLoyaltyDeadReduction
					if left < 0 then
						left = 0
					end
					role:setLoyalty(left)
					--减寿命
					local rand = math.random(EachLifeDeadReduction[1],EachLifeDeadReduction[2])
					cur = role:getLife()
					left = cur - rand
					if left < 0 then
						left = 0
					end
					role:setLife(left)
					--从场景移除
					local fight = g_fightMgr:getFight(role:getFightID())
					local oldPos = role:getPos()
					local side,pos = oldPos[2], oldPos[3]
					fight:removeRole(role,true)
					--fight:decreaseWaitActionNum()
					--换上掠阵的宠物

					local player = g_fightEntityMgr:getRole(role:getOwnerID())
					local followPet = player:getPet()
					if followPet == role then
						for _, petID in pairs(player:getPetList()) do
							local pet = g_fightEntityMgr:getRole(petID)
							--是掠阵，没上过场，正常状态
							if pet:getStatus() == PetStatus.Ready and (not pet:getAlready()) and pet:getLifeState() == RoleLifeState.Normal then
								fight:addRole(side,pos,pet)
								--修改状态
								pet:setAlready(true)
								--role:setStatus(PetStatus.Rest)
								--pet:setStatus(PetStatus.Fight)
								--player:setPetID(pet:getID())
								--填充协议
								local petInfo ={}
								FightSystem():setPetInfo4Client(petInfo,pet)
								local ResultCallMembers = {actionType = FightActionType.Call,roleID = player:getID(),targetsInfo={petInfo},success = true,callType = FightCallType.Pet}
								FightUtils.insertFightResult(fight,ResultCallMembers)
								--减寿命
								local rand = math.random(EachLifeReduction[1],EachLifeReduction[2])
								local cur = role:getLife()
								local left = cur - rand
								if left < 0 then
									left = 0
								end
								role:setLife(left)	
								break
							end
						end
					end

				end
			end
		end
	end
	if actionList then
		local revival_result = {}
		revival_result.actionList = actionList
		revival_result.actionType = FightActionType.Relive
		return revival_result
	end
	return nil
	
end
------------------------------------------------------------------------------------------------------------------

-- 是否命中
function FightUtils.isHit(role,target)
	local rH = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	local tH = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	-- buff命中影响
	if rH:getMustHit() then
		return true
	end
	local hit = 0
	hit = (role:ft_get_hit()/FinalHitRateCoef)*FinalHitRateCoef1
	local dodge = 0 
	dodge = (target:ft_get_dodge()/FinalHitRateCoef)*FinalHitRateCoef1
	--local result = (FinalHitRateConst + hit - dodge)*100
	local result = math.floor(100*FinalHitRateConst*hit/(FinalHitRateConst*hit + dodge))
	--print("闪避",hit,dodge,result)
	local rand = math.random(100)
	if  rand >= 0 and rand <= result then
		return true
	else
		return false
	end
end

function FightUtils.isCritical(role,target)

	local rH = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
	local tH = target:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)

	if rH:getMustCritical() then
		Flog:log("buff的暴击成功")
		return true
	end
	if tH:getMustTenacity() then--TODO　两个都有？
		Flog:log("buff的抗暴击成功")
		return false
	end

	local crit = 0
	crit = (role:ft_get_critical()/FinalCritRateCoef)*FinalCritRateCoef1
	
	local uncrit = 0 
	uncrit =  (target:ft_get_tenacity()/FinalCritRateCoef)*FinalCritRateCoef1

	local result = math.floor(100*FinalCritRateConst*crit/(FinalCritRateConst*crit + uncrit))
	--print("暴击率",result)
	local rand = math.random(100)
	if  rand >= 0 and rand <= result then
		return true
	else
		return false
	end
end

function FightUtils.getCritical(role,damage)
	local inc = 0
	inc = role:getInc_critical()

	local result = (FinalCriticalDamageConst + inc)*damage
	return result 
end

function FightUtils.isCounter(role)
	local counter = role:getCounter()*100
	local rand = math.random(100)
	if  rand >= 0 and rand <= counter then
		return true
	else
		return false
	end

end

function FightUtils.getCounter(role,damage)
	local inc_counter = role:getInc_Counter()
	local result = damage*(inc_counter + CounterIncConst)
	--print("inc_counter",inc_counter)
	return result
end

-- 判断该技能的子技能类型是否含有指定type
function FightUtils.isExistSkillEffType(role, id, type)
	local data = false
	if instanceof(role, FightPet) then
		data = PetSkillDB[id]
	elseif instanceof(role, FightMonster) then
		data = MonsterSkillDB[id]
	else
		data = FightSkillDB[id]
	end
	if data then
		local skill = data.skill
		print(toString(skill))
		for _, effect in ipairs(skill) do
			if effect.type == type then
				return true
			end
		end
	end
end

function FightUtils.isUnhit(role, target, skillID)
	-- 目标是宠物时处理
	if instanceof(target,FightPet) then
		if instanceof(role,FightPet) then
			local roleHandler = role:getHandler(FightEntityHandlerType.SkillHandler)
			-- 是否反击免疫
			if roleHandler:getStrikeBackImmune() then
				print("反击免疫")
				return false
			end
		end
		local handler = target:getHandler(FightEntityHandlerType.SkillHandler)
		local unhit = target:getUnhit()*100
		local rand = math.random(100)
		if  rand >= 0 and rand <= unhit then
			return true
		else
			-- 物理反击
			local isTrue, ratio = handler:getNormalStrikeBack()
			if isTrue and FightUtils.isExistSkillEffType(role, skillID, SkillEff.At) then
				target:setCounterHitRatio(ratio/100)
				print("物理反击，伤害比例：", ratio)
				return true
			end
			-- 法术反击
			local isTrue, strikeBackSkillID = handler:getMagicalStrikeBack()
			if isTrue and strikeBackSkillID and FightUtils.isExistSkillEffType(role, skillID, SkillEff.Mt) then
				-- 返回用于反击的技能ID
				print("法术反击，使用技能：", strikeBackSkillID)
				return isTrue, strikeBackSkillID
			end
			target:setCounterHitRatio(nil)
			return false
		end
	elseif instanceof(target,FightMonster) then
		local configID = target:getDBID()
		local monsterConfig = MonsterDB[configID] or NpcDB[configID]
		if monsterConfig.unhitRate then
			local rand = math.random(100)
			if  rand >= 0 and rand <= monsterConfig.unhitRate*100 then
				return true
			end
		end
		return false
	end
end

function FightUtils.canCatch(player,monster)
	local monsterCofigID = monster:getDBID()
	local config = MonsterDB[monsterCofigID] or NpcDB[monsterCofigID]
	local petID = config.makePetID
	if not petID then
		return -1
	end
	--怪物等级是否超过玩家的等级
	local monsterLevel = monster:getLevel()
	local playerLevel = player:getLevel()
	if monsterLevel > playerLevel then
		return -3
	end
	--是否超过最大宠物数
	local curPetNum = player:getPetAmount()
	local maxNum = player:getAttrValue(player_max_pet)
	if (not maxNum ) or maxNum == 0 then
		maxNum = MaxPetNum
	end
	print("catchNum:",curPetNum,maxNum,MaxPetNum)
	if curPetNum >= MaxPetNum then
		return -2
	end
	local addRate = player:ft_get_add_catchpet_rate()
	--不同宠物类型的捕获率
	local petConfig = PetDB[petID]
	local type = petConfig.petType
	local rate1 = 0
	if type == PetType.Wild then
		rate1 = 80 + addRate
	elseif type == PetType.Baby then
		rate1 = 60 + addRate
	elseif type == PetType.Spirit then
		rate1 = 30 + addRate
	elseif type == PetType.Varient then
		rate1 = 50 + addRate
	elseif type == PetType.God then
		rate1 = 20 + addRate
	else
		return -1
	end

	--最终捕获率
	local bMust = player:getIsMustCatch()
	if bMust then
		return 1
	end
	local maxHP = monster:getAttrValue(monster_max_hp)
	local hp = monster:getAttrValue(monster_hp)
	local rate = math.floor(100*(maxHP*3-hp*2)/(maxHP*3)*rate1/30)
	--计算结果
	local rand = math.random(100)
	if rand <= rate then
		return 1
	else
		return 0
	end

end

function FightUtils.reduceWinPet(pet,bWin)
	if bWin and pet:getAlready() and pet:getLifeState() ~= RoleLifeState.Dead then
		local curLife = pet:getLife()
		local rand = math.random(PetWinReduceLife[1],PetWinReduceLife[2])
		local final = curLife - rand
		if final < 0 then
			final = 0
		end
		pet:setLife(final)
	end
end

function FightUtils.getMyPetByWorldPetID(player,petID)
	for _, ID in ipairs(player:getPetList()) do
		local pet = g_fightEntityMgr:getRole(ID)
		if pet:getWorldPetID() == petID then
			return pet
		end
	end

	return nil
end

-- 获取技能目标(暂不再使用)
function FightUtils.getSkillTargetsID(actionInfo, skillID, filter)
	local handler = actionInfo.role:getHandler(FightEntityHandlerType.SkillHandler)
	local targets_id
	if handler.skills and handler.skills[skillID] then
		if filter then
			local skill_type = handler.skills[skillID]:getSkillType()
			for _, type in ipairs(filter) do
				if skill_type == type then
					targets_id = handler.skills[skillID]:get_result_targets()
				end
			end
		else
			targets_id = handler.skills[skillID]:get_result_targets()
		end
	end
	return targets_id
end

-----------------------------------------------------------------------------------
function FightUtils.isEscape(role)
	--TODO 逃跑属性
	local addRate = 0
	if instanceof(role, FightPlayer) then
		local pkInfo = role:getPkInfo()
		if pkInfo.isPK and pkInfo.isAttacker then
			return false
		
		end
		addRate = role:ft_get_add_escape_rate()
		--获取敌方队长的逃跑率减值
		local fightID = role:getFightID()
		local fight = g_fightMgr:getFight(fightID)
		local enemySide = FightUtils.getEnemySide(role)
		local roles = fight:getMembers()[enemySide]
		for _,role1 in pairs(roles) do
			if instanceof(role1, FightPlayer) then
				if role1:getIsTeamHead() then
					local reduceRate = role1:ft_get_reduce_escape_rate()
					addRate = addRate - reduceRate
					break
				end
			end
		end
	end

	local rand = math.random(100)
	local rate = 50 + addRate
	
	if  rand >= 0 and rand <= rate then
		return true
	else
		return false
	end

end

function FightUtils.getDefenseDamage(role,damage)
	return DefenseDamageConst*damage
end

function FightUtils.isFriend(role,target)
	local myside = role:getPos()[2]
	local otherSide = target:getPos()[2]

	return myside==otherSide
end

function FightUtils.getValueOfAI(role,type)
		if type == AIAttrType.Hp then
			value = role:getHp()
		elseif type == AIAttrType.Mp then
			value = role:getMp()
		elseif type == AIAttrType.At then
			value = role:ft_get_at()
		elseif type == AIAttrType.Mt then
			value = role:get_Mt()
		elseif type == AIAttrType.Af then
			value = role:ft_get_af()
		elseif type == AIAttrType.Mf then
			value = role:get_Mf()
		elseif type == AIAttrType.Anger then
			value = role:get_anger()
		elseif type == AIAttrType.win_phase then
			value = role:ft_get_phase_at(PhaseType.Wind)
		elseif type == AIAttrType.thu_phase then
			value = role:ft_get_phase_at(PhaseType.Thunder)
		elseif type == AIAttrType.ice_phase then
			value = role:ft_get_phase_at(PhaseType.Ice)
		elseif type == AIAttrType.soi_phase then
			value = role:ft_get_phase_at(PhaseType.Soil)
		elseif type == AIAttrType.fir_phase then
			value = role:ft_get_phase_at(PhaseType.Fire)
		elseif type == AIAttrType.poi_phase then
			value = role:ft_get_phase_at(PhaseType.Poison)
		else
			return nil
		end
		return value
end

function FightUtils.CompareOfAI(relation ,value,configValue)
	if relation == ">=" then
		return value >= configValue
	elseif relation == ">" then
		return value > configValue
	elseif relation == "<=" then
		return value <= configValue
	elseif relation == "<" then
		return value < configValue
	elseif relation == "=" then
		return value == configValue
	else
		return false
	end
end
--[[
生命值、法力值、怒气值、武力、智力、根骨、灵性、身法、物攻、法攻、物防、法防、暴击、抗暴、闪避、命中、速度、六相性攻击、六相性防御
]]
function FightUtils.printFightInfo(fight)
	local sideAInfo = "\n\nA边:"
	local sideBInfo = "\nB边:"
	local AMembers = fight:getMembers()[FightStand.A]
	local BMembers = fight:getMembers()[FightStand.B]
	for pos, role in pairs(AMembers) do
		sideAInfo = sideAInfo .. Flog:role_info(role)
		sideAInfo = sideAInfo .. Flog:buff_info(role)
	end
	for pos, role in pairs(BMembers) do
		sideBInfo = sideBInfo .. Flog:role_info(role)
		sideBInfo = sideBInfo .. Flog:buff_info(role)
	end
	Flog:log(sideAInfo) print(sideAInfo)
	Flog:log(sideBInfo) print(sideBInfo)
end

local validProtectors = {}
function FightUtils.getValidProtectors(protectors)
	table.clear(validProtectors)
	local num = 0
	for ID,_ in pairs(protectors) do
		local protector = g_fightEntityMgr:getRole(ID)
		local lifeState = protector:getLifeState()
		if lifeState ~= RoleLifeState.Freeze and lifeState ~= RoleLifeState.Taunt and lifeState ~= RoleLifeState.Silence then
			validProtectors[ID] = true
		end
		
	end
	return validProtectors
end
