--[[FightActionCheck.lua
描述：
	战斗动作校验:动作能否执行(对应于战斗动作类型SkillACtionType)
--]]

require "base.base"


FightActionCheck = class(nil, Singleton)


function FightActionCheck:__init()
	
end
--[[
context:{target=pos}
]]

function FightActionCheck.commonAttack(fight,role, context)

	if role:getLifeState() == RoleLifeState.Poison then
		return false
	end
	local target = fight:getRole(context.target)
	if target then
		if not FightUtils.isFriend(role,target) then
			return true
		else
			return false
		end
	end
	
	return true
end

--[[
context:{skillID = 10000,target=pos1}}
]]
function FightActionCheck.skilAction(fight,role, context)
	
	local skillID = context.skillID

	local state = role:getLifeState()
	if state == RoleLifeState.Silence then
		if SkillUtils.ConsumeTypeCheck(role, skillID, ConsumeType.Mp) then
			return false
		end
	end
	
	if instanceof(role,FightPlayer) or instanceof(role,FightPet) then
		local bPass = role:canUseSkill(skillID)
		return bPass
	end
	
	return true
end

function FightActionCheck.auto(fight,role, context)
	
	return true
end

--[[
context:{target=pos}
]]
function FightActionCheck.protect(fight,role, context)
	
	local target = fight:getRole(context.target) 
	if (not target) or  (target:getLifeState() == RoleLifeState.Dead) or  target == role then
		return false
	else
		if  FightUtils.isFriend(role,target) then
			return true
		else
			return false
		end
	end
	return true

end

function FightActionCheck.defense(fight,role, context)
	
	return true
end

function FightActionCheck.escape(fight,role,context)

	return true
end


--[[
context:{itemGuid = 道具Guid,target=pos}
]]
function FightActionCheck.UseMaterial(fight,role,context)
    local target = fight:getRole(context.target)
	local isOK = g_fightItemMgr:canUseMedicament(role, context.itemGuid, target)
	return isOK
end

--[[
context:{petID = 1 }
]]
function FightActionCheck.call(fight,role,context)

	if instanceof(role,FightMonster) then
		return true
	end
	
	if instanceof(role,FightPet) then
		return false
	end

	local petID = context.petID
	
	
	local pet = FightUtils.getMyPetByWorldPetID(role,petID)
	if not pet then
		return false
	end
	local curPet = FightUtils.findMyPet(role)
	if curPet == pet then
		return false
	end

	if pet:getLifeState() == RoleLifeState.Dead then
		return false
	end

	if pet:getIsEscaped() then
		return false
	end

	local petLevel = pet:getLevel()
	local playerLevel = role:getLevel()
	if playerLevel < petLevel - CallPetLevelNeed then
		return false
	end

	if pet:getStatus() == PetStatus.Ready then
		return false
	end

    return true
end


function FightActionCheck.callBack(fight,role,context)

	if instanceof(role,FightMonster) then
		return true
	end
	
	if instanceof(role,FightPet) then
		return false
	end

	--是否已有宠物
	if FightUtils.findMyPet(role) then
		return true
			
	end

    return false
end

--[[
context:{target = pos }
]]
function FightActionCheck.catch(fight,role,context)
	local target = fight:getRole(context.target)
	if not target then
		return false
	end
	if target:getLifeState() == RoleLifeState.Dead then
		return false
	end
	if not instanceof(target, FightMonster) then
		return false
	end

	return true
end
