--[[FightSystemCheck.lua
描述：
	系统动作校验:动作能否执行(对应于ScriptFightConditionType)
--]]

require "base.base"


FightSystemActionChecker = class(nil, Singleton)


function FightSystemActionChecker:__init()
	
end
local function CompareAttrValue(curValue,conParams)
			if conParams["<"] then
				if curValue < conParams["<"] then
					return true
				end
			elseif conParams["<="] then
				if curValue <= conParams["<="] then
					return true
				end
			elseif conParams[">"] then
				if curValue > conParams[">"] then
					return true
				end
			elseif conParams[">="] then
				if curValue >= conParams[">="] then
					return true
				end
			elseif conParams["="] then
				if curValue == conParams["="] then
					return true
				end
			else
				return false
			end
				
end
--[[
params={role = role,attrType = "hp"("mp"),curValue = 1}
]]
function FightSystemActionChecker.AttrValueChanged(fight,params,condition)
		
				
		if condition and condition.type == ScriptFightConditionType.AttrValue then
			local conParams = condition.params
			local DBID = conParams.DBID
			if params and  DBID == params.role:getDBID() and conParams.type == params.attrType then
				return CompareAttrValue(params.curValue*100,conParams)
			elseif not params then
				local members = fight:getMembers()
				local monsters = members[FightStand.B]
				for _,monster in pairs(monsters) do
					if monster:getDBID() == DBID then
						local value
						if conParams.type == "hp" then
							value = monster:getHp()*100/monster:getMaxHp()
						elseif conParams.type == "mp" then
							value = monster:getMp()*100/monster:getMaxMp()
						elseif conParams.type == "kill" then
							return false
						end
						local bOk = CompareAttrValue(value,conParams)
						if bOk then
							return true
						end
					end
				end
			end
		end
		return false
end

--[[
params=nil
]]
function FightSystemActionChecker.isIDExist(fight,params,condition)
		if table.size(condition) == 0 then
			return true
		end
		local DBID = condition.params.DBID
		if condition and condition.type == ScriptFightConditionType.IDExist then
			local relation = condition.params.relation
			local count = fight:getMonsterNum(DBID)
			local value = condition.params.value
			if relation == ">" then
				return count > value
			elseif relation == ">=" then
				return count >= value
			elseif relation == "=" then
				return count == value
			elseif relation == "<" then
				return count < value
			elseif relation == "<=" then
				return count <= value
			else
				return false
			end
		end
		return false
end

--[[
params=nil
]]
function FightSystemActionChecker.isRoundCount(fight,params,condition)
		if table.size(condition) == 0 then
				return true
		end
		local roundCount = condition.params.round
		if condition and condition.type == ScriptFightConditionType.RoundCount then
			if roundCount == fight:getRoundCount() then
				return true
			end
		end
		return false
end
--[[
params=nil
condition.params={period = 2,startRound = 2}
]]
function FightSystemActionChecker.isRoundInterval(fight,params,condition)
	local startRound = condition.params.startRound or 1
	local period = condition.params.period
	local curRound = fight:getRoundCount()
	if curRound < startRound then
		return false
	end
	if (curRound - startRound) %  period == 0 then
		return true
	end
	return false
end

--[[
params = nil
condition.params = {targetType = ScriptFightTargetType.AnyOfEnemys,buffID = 1(or type=BuffKind.Dot),},或 {DBID = {1},buffID = 1(or type=BuffKind.Dot),}
]]
function FightSystemActionChecker.isBuffStatus(fight,params,condition)
		if table.size(condition) == 0 then
				return true
		end
		
		local DBIDs = condition.params.DBID--有任意满足即可
		local buffID = condition.params.buffID
		local type =  condition.params.type
		local targetType = condition.params.targetType
		if condition and condition.type == ScriptFightConditionType.BuffStatus then
			--是根据DBID判定
			if DBIDs then
				local members = fight:getMembers()
				local monsters = members[FightStand.B]
				for _,monster in pairs(monsters) do
					if table.contains(DBIDs,monster:getDBID()) then
						local bh = monster:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
						if bh:hasBuffID(buffID) or bh:hasBuffKind(type) then
							return true
						end
					end
				end
			--是根据目标类型判定
			elseif targetType then
				local members = fight:getMembers()
				local roles
				if targetType == ScriptFightTargetType.AnyOfEnemys then
					roles = members[FightStand.A]
				elseif targetType == ScriptFightTargetType.AnyOfFriends then 
					roles = members[FightStand.B]
				end
				for _,role in pairs(roles) do
					local bh = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
					if bh:hasBuffID(buffID) or bh:hasBuffKind(type) then
						return true
					end
				end
			end
		end
		return false
end

--[[
params = nil
]]
function FightSystemActionChecker.isLiveNum(fight,params,condition)
		if table.size(condition) == 0 then
				return true
		end
		local isEnemy = condition.params.isEnemy
		local num = condition.params.count
		if condition and condition.type == ScriptFightConditionType.LiveNum then
			local side 
			if isEnemy then
				side = FightStand.A
			else
				side = FightStand.B
			end
			local members = fight:getMembers()
			local curCount =FightUtils.getLiveNum(members[side])
			if curCount >= num then
				return true
			end
		end
		return false
end

--[[
params =nil
]]
function FightSystemActionChecker.isAttacked(fight,params,condition)
		if table.size(condition) == 0 then
				return true
		end
		
		local DBIDs = condition.params.DBID
		if condition and condition.type == ScriptFightConditionType.IsAttacked then
			local members = fight:getMembers()
			local monsters = members[FightStand.B]
			for _,monster in pairs(monsters) do
				if table.contains(DBIDs,monster:getDBID()) and monster:getIsInjured() then
					return true
				end
			end
		end
		return false
end
--[[
params =passedTime(s)
]]
function FightSystemActionChecker.isFightPeriod(fight,params,condition)
		if table.size(condition) == 0 then
				return true
		end
		local passedTime = math.floor(params/60)
		if condition and condition.type == ScriptFightConditionType.FightPeriod then
			if passedTime >= condition.params.time then
				return true
			end
		end
		return false
end
--[[
params = role
condition.params={type = ScriptFightDeadType.PlayerOrPet}
]]
function FightSystemActionChecker.isPlayerDead(fight,params,condition)
		if table.size(condition) == 0 then
				return true
		end
		local role = params
		if condition and condition.type == ScriptFightConditionType.PlayerDead then
			
			local roleType = condition.params.type
			if role then
				if role:getLifeState() ~= RoleLifeState.Dead then
					return false
				end
				if (not roleType) or roleType == ScriptFightDeadType.PlayerOrPet then
					return true
				elseif roleType == ScriptFightDeadType.Player and instanceof( role,FightPlayer)then
					return true
				elseif roleType == ScriptFightDeadType.Pet and instanceof( role,FightPet) then
					return true
				end
			else
				local members = fight:getMembers()
				local roles = members[FightStand.A]
				for _,role in pairs(roles) do
					if role:getLifeState() == RoleLifeState.Dead then
						if (not roleType) or roleType == ScriptFightDeadType.PlayerOrPet then
							return true
						elseif roleType == ScriptFightDeadType.Player and instanceof( role,FightPlayer)then
							return true
						elseif roleType == ScriptFightDeadType.Pet and instanceof( role,FightPet) then
							return true
						end
					end
				end
				
			end
			
		end
		return false
end

--[[
params = monsterDBID
condition.params ={DBID = {1052},}
]]
function FightSystemActionChecker.isMonsterCatched(fight,params,condition)
	if not params then
		return
	end
	local monsterDBID = params
	for _,ID in pairs(condition.params.DBID) do
		if ID == monsterDBID then
			return true
		end
	end
	return false
end

--[[
params = nil
condition.params ={relation =">", value = 1,},
]]
function FightSystemActionChecker.isScoreReached(fight,params,condition)
	local curScore = fight:getScore()
	local relation = condition.params.relation
	local value = condition.params.value
	if relation == ">" then
		return curScore> value
	elseif relation == ">=" then
		return curScore >= value
	elseif relation == "=" then
		return curScore == value
	elseif relation == "<=" then
		return curScore <= value
	elseif relation == "<" then
		return curScore < value
	else
		return false
	end
	
end