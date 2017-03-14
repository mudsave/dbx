--[[FightAction.lua
描述：
	战斗动作(对应于战斗动作类型SkillUIType)
--]]

require "base.base"


FightAction = class(nil, Singleton)


function FightAction:__init()
	
end
--[[
context:{target=pos}
]]
local commonAttackTargets = {}

function FightAction.doCommonAttack(role, context, result)
	local revival_result 
	table.clear(commonAttackTargets)
	local fightID = role:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	local target = fight:getRole(context.target)
	--传入context数据不一样
	if type(context.target) == "table" then
		target = context.target
	end
	--如果逃跑了或死了
	if (not target) or target:getLifeState() ==  RoleLifeState.Dead then
		local enemySide = FightUtils.getEnemySide(role)
		local roles = fight:getMembers()[enemySide]
		target = FightUtils.findRandomTarget(roles)
		context.target = target:getPos()[3]
	end
	table.insert(commonAttackTargets,target)
	--使用普攻
	local skill = role:getCommonSkill()
	local deadList = skill:use(commonAttackTargets,result)
	table.clear(commonAttackTargets)
	--处理复活
	revival_result = FightUtils.doPostDead(deadList)
	if revival_result then
		return revival_result
	end
end

--[[
玩家,宠物context:{skillID = 10000,target=pos1}}
怪物context:{skillID = 10000,targets={},isEnemy = true  }}
]]
local skillAttackTargets = {}
function FightAction.doSkilAction(role, context)
	print("技能开始--skillID, target",context.skillID, toString(context.target))
	local result, dead_list,attackedTargets
	if instanceof(role,FightPlayer) or instanceof(role,FightPet) then
		 result, dead_list, attackedTargets = role:useSkill(context.skillID, context.target)
		 if not result then
		 	result = {}
		 	dead_list = {}
			attackedTargets = {}
		 end
	
	elseif instanceof(role,FightMonster) then
		local targetSide 
		local isEnemy = context.isEnemy
		if isEnemy then
			targetSide = FightUtils.getEnemySide(role)
		else
			targetSide = role:getPos()[2]
		end

		if type(context.targets) == 'table' and table.size(context.targets) == 0 then
			context.targets = nil
		end
		result, dead_list, attackedTargets = role:useSkill(context.skillID, context.targets,targetSide)
		if not result then
			result = {}
			dead_list = {}
			attackedTargets = {}
		end
		context.targets = nil
	end
	print ('dead_list:', toString(dead_list) )
	print ('result:')
	print (toString(result) )
	local revival_result = FightUtils.doPostDead(dead_list)
	--print ('revival_result:')
	--print ( toString (revival_result) )
	return result, revival_result,attackedTargets
end

function FightAction.doAuto(role, result)
	
	--执行
end

--[[
context:{target=pos}
result:nil
]]
function FightAction.doProtect(role, context, result)
	
	--执行
	local fightID = role:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	local target = fight:getRole(context.target)
	
	target:setProtectors(role)
	role:setProtectee(target)
	if instanceof(target,FightMonster) then
		print("保护对象为怪物！",context.target)
	end
	
	
end

--[[
context:nil
result:nil
]]
function FightAction.doDefense(role, context, result)
	
	--执行
	role:setIsDefense(true)
	
	
end


function FightAction.doEscape(role, context, result)
	if instanceof(role,FightMonster)  then
		local fightID = role:getFightID()
		local fight = g_fightMgr:getFight(fightID)
		local bOk = fight:removeRole(role,false)
		if bOk then
			result.isOk = true
			print("monster left!")
			return 
		end
		return
	end
	local bSuccess = FightUtils.isEscape(role)
	local bForce = role:getForceLeave()
	if bSuccess or bForce then
		local fightID = role:getFightID()
		local fight = g_fightMgr:getFight(fightID)
		local side = role:getPos()[2]
		local head = FightUtils.getTeamHead(fight,side)
		local bOk = fight:removeRole(role,true)
		if bOk then
			result.isOk = true
			result.escapedRoles={role:getID()}
			if instanceof(role ,FightPlayer) then
				fight:addEscapedRole(role)
				local pet = FightUtils.findMyPet(role)
				if pet then
					fight:removeRole(pet,true)
					fight:addEscapedRole(pet)
					table.insert(result.escapedRoles,pet:getID())
				end
				--队伍相关处理
				if role:getIsInTeam() then
					local myID = role:getDBID()
					local list = head:getTeamMemberList()
					--转让队长
					if role:getIsTeamHead() then
						role:setIsTeamHead(false)
						local bStart = false
						for _,DBID in ipairs(list) do
							if bStart then
								local secondPlayer = FightUtils.getPlayerByDBID(fight,side,DBID)
								if secondPlayer then
									secondPlayer:setIsTeamHead(true)
									secondPlayer:setTeamMemberList(list)
									break
								end
							elseif (not bStart) and DBID == myID then
								bStart = true
							end
						end
					end
					--从队伍列表中删除
					table.removeValue(list,myID)
				end

			elseif instanceof(role ,FightPet) then
				role:setIsEscaped(true)
			end
			
		end
	else
		result.isOk = false
	end
end

--[[
context:{itemGuid = 道具Guid,target=pos1}}
]]
local matTargets = {}
function FightAction.doUseMaterial(role, context, result)
	
	table.clear(matTargets)
	result.itemGuid = context.itemGuid
	local fightID = role:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	
	local target = fight:getRole(context.target)
	table.insert(matTargets,target)
	
	result.actionList = g_fightItemMgr:useMedicament(role, context.itemGuid, target)
end

--[[
context ={members = {{ID = 11,count = 1}} }--怪物
context ={petID=1} }--宠物
]]
function FightAction.doCall(role, context, result)
	local fightID = role:getFightID()
	local fight = g_fightMgr:getFight(fightID)

	if instanceof(role,FightMonster) then
		FightSystemAction.EntityEnter(fight,context.members,nil,nil,result)
		return
	elseif instanceof(role,FightPlayer) then
		local petID = context.petID
		local pet = FightUtils.getMyPetByWorldPetID(role,petID)
		local curPet = FightUtils.findMyPet(role)
		local curPetID 
		--战斗场景中有当前宠物则替换
		if curPet then
			local side = curPet:getPos()[2]
			local pos = curPet:getPos()[3]
			fight:removeRole(curPet,true)
			fight:addRole(side,pos,pet)
			curPetID = curPet:getID()
			--curPet:setStatus(PetStatus.Rest)
			curPet:setIsEscaped(true)--不能再参战了
		--无宠物
		else
			--玩家有出战宠，修改状态
			for _, petID in pairs(role:getPetList()) do
					local pet1 = g_fightEntityMgr:getRole(petID)
					if pet1:getStatus() == PetStatus.Fight  then
						--pet1:setStatus(PetStatus.Rest)
						--break
					end
			end
			local side = role:getPos()[2]
			local totalPlayerCount =  fight:getPlayerMembers(side)
			local pos = fight:getRolePos(StandRoleType.Pet, side, totalPlayerCount,nil,role)
			fight:addRole(side,pos,pet)
		end
		--pet:setStatus(PetStatus.Fight)
		role:setPetID(petID)
				
		--减寿命
		if pet:getLifeState() ~= RoleLifeState.Dead then
			local rand = math.random(EachLifeReduction[1],EachLifeReduction[2])
			local cur = pet:getLife()
			local left = cur - rand
			if left < 0 then
				left = 0
			end
			pet:setLife(left)
		end
		--设战斗标记
		pet:setAlready(true)
		--填充客户端协议
		local petInfo ={}
		FightSystem():setPetInfo4Client(petInfo,pet)
		result.actionType = FightActionType.Call
		result.roleID = role:getID()
		result.targetsInfo={petInfo}
		result.success = true
		result.oldPetID = curPetID
		result.callType = FightCallType.Pet
	end
end

--[[

context ={ }
]]
function FightAction.doCallBack(role, context, result)
	local fightID = role:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	
	if instanceof(role,FightMonster) then
		return
	elseif instanceof(role,FightPlayer) then

		local pet = FightUtils.findMyPet(role)
		
		fight:removeRole(pet, true)
		--pet:setStatus(PetStatus.Rest)
		pet:setIsEscaped(true)--不能再参战了

		result.actionType = FightActionType.CallBack
		result.roleID = role:getID()
		result.targetID = pet:getID()
		result.success = true
		result.callType = FightCallType.Pet
	end
end

--[[

context ={ target = pos}
]]
function FightAction.doCatch(role,context,result)
	local fightID = role:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	local target = fight:getRole(context.target)
	local bResult = FightUtils.canCatch(role,target)
	--成功
	if bResult == 1 then
		local monsterCofigID = target:getDBID()
		local config = MonsterDB[monsterCofigID] or NpcDB[monsterCofigID]
		local petID = config.makePetID
		if petID then
			local event = Event(FightEvents_FS_CreatePet, g_serverId, role:getDBID(),petID )
			g_eventMgr:fireWorldsEvent(event, fight:getSrcWorldID())
		end

		fight:removeRole(target, true)
		if instanceof(fight, FightScript) then
			fight:onMonsterCatched(monsterCofigID)
		end
	end

	
	result.actionType = FightActionType.Catch
	result.roleID = role:getID()
	result.targetID = target:getID()
	result.errorCode = bResult
end