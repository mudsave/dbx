--ChooseCondition.lua
 
 require "data.FightAIDB"
 require "data.SpeakAIDB"
 

ChooseCondition = class(nil,Singleton)

function ChooseCondition:__init()
end

local function getRoles(me,fight,isEnemy)
	local roles
	if isEnemy then
		local enemySide = FightUtils.getEnemySide(me)
		roles = fight:getMembers()[enemySide]
	else
		local mySide = me:getPos()[2]
		roles = fight:getMembers()[mySide]
	end
	return roles
end

--[[
params ={isEnemy = true,type = AIAttrType.Hp,relation ="<=",value = 0.2,count = 1 }
或params ={ ID = DBID,type = AIAttrType.Hp,relation ="<=",value = 0.2}

]]

function ChooseCondition.isAttrPercent(me,fight,params)
	--如果指定单位ID
	local type = params.type
	local relation = params.relation
	local value = params.value
	
	if params.ID then
		local members = fight:getMembers()
		for _,roles in pairs(members) do
			for _,role in pairs(roles) do
				if instanceof(role,FightMonster) and role:getDBID() == params.ID then
					--取比例值
					local percent = 0
					if type == AIAttrType.Hp then
						percent = role:getHp()/role:getMaxHp()
					elseif type == AIAttrType.Mp then
						percent = role:getMp()/(role:getMaxMp() or 1)
					elseif type == AIAttrType.Anger then
						--percent = role:get_anger()/(role:get_max_anger() or 1)
						return false
					else
						return nil
					end
					--比较
					local bPass =  FightUtils.CompareOfAI(relation ,percent,value)
					if bPass then
						return true
					end
				end
			end
		end
		return false
	end
	
	--如果指定敌友
	if params.isEnemy ~= nil then
		local roles = getRoles(me,fight,params.isEnemy)
		local curCount = 0
		local totalCount = params.count or 1
		for _,role in pairs(roles) do
					--取比例值
					local percent = 0
					if type == AIAttrType.Hp then
						percent = role:getHp()/role:getMaxHp()
					elseif type == AIAttrType.Mp then
						percent = role:getMp()/(role:getMaxMp() or 1)
					elseif type == AIAttrType.Anger then
						if instanceof(role,FightMonster) then
							return false
						else
							percent = role:get_anger()/(role:get_max_anger() or 1)
						end
					else
						return nil
					end
					--比较
					local bPass =  FightUtils.CompareOfAI(relation ,percent,value)
					if bPass then
						curCount = curCount + 1
						if curCount >= totalCount then
							return true
						end
					end
			
		end

		return curCount >= totalCount
	end
end
--[[
params ={ID = 1}或params ={ID = 1,relation= ">",value = 1 }
]]
function ChooseCondition.isIDExist(me,fight,params)
			local DBID = params.ID
			local count = fight:getMonsterNum(DBID)
			local relation = params.relation
			local value = params.value
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

--[[
params ={round = 1}
]]
function ChooseCondition.isRoundCount(me,fight,params)
		if params.round == fight:getRoundCount() then
			return true
		end
		return false
end
--[[
params={period = 2,startRound = 2}
]]
function ChooseCondition.isRoundInterval(me,fight,params)
	local startRound = params.startRound or 1
	local period = params.period
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
params ={isEnemy = true,buffID = 1( or type = BuffKind.Dot),count = 1 }
或者 ={ ID = DBID,buffID = 1( or type = BuffKind.Dot) }

]]
function ChooseCondition.isBuffStatus(me,fight,params)
		local ID = params.ID
		local buffID = params.buffID
		local type =  params.type
		local count = 0
		local totalCount = params.count or 1

		--如果指定单位ID
		if ID then
				local members = fight:getMembers()
				for _ ,roles in pairs(members) do
					for _,role in pairs(roles) do
						if instanceof(role,FightMonster) and role:getDBID() == ID then
							local bh = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
							if bh:hasBuffID(buffID) or bh:hasBuffKind(type) then
								return true
							end
							
						end
					end
				end
			return false
		end
		--如果指定敌友
		if params.isEnemy ~= nil then
			local roles = getRoles(me,fight,params.isEnemy)
			for _,role in pairs(roles) do
				local bh = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
				if bh:hasBuffID(buffID) or bh:hasBuffKind(type) then
					if  count < totalCount then
						count = count + 1
					end
				end
				if count >= totalCount then
					return true
				end
				
			end
			return count >= totalCount
		end

end
--[[
params = {isEnemy = true,count = 1}
]]
function ChooseCondition.isLiveNum(me,fight,params)
		local isEnemy = params.isEnemy
		local num = params.count or 1
		
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
		
		return false
end

--[[
params={round = {2}}或params={round = 2,period =2}
]]
function ChooseCondition.isAttacked(me,fight,params)

	local round = fight:getRoundCount()
	if type(params.round) == "table" then
		if table.contains(params.round,round) then
			if  me:getIsInjured() then
				return true
			end
		end
	elseif type(params.round) == "number" then
		if (round - params.round) % params.period == 0 then
				if  me:getIsInjured() then
					return true
				end
		end
	end
	
	return false
end

--[[
--门派类别
SchoolType = {
	PM          = 0x00,
	QYD         = 0x01,
	JXS         = 0x02,
	ZYM         = 0x03,
	YXG         = 0x04,
	TYD         = 0x05,
	PLG         = 0x06,
}
params = {isEnemy = true,school = SchoolType.QYD}
]]
function ChooseCondition.isSchool(me,fight,params)
	local roles = getRoles(me,fight,params.isEnemy)
	local count = 0
	local totalCount = params.count or 1
	for _, role in pairs(roles) do
			if instanceof(role,FightPlayer) then
				local school = role:getSchool()
				if school == params.school and count < totalCount then
					count = count + 1
				end
				if count >= totalCount then
					return true
				end
			end
	end
	return false
end
--[[
--相性类型
PhaseType = {
	Soil = 1, 		--土
	Ice = 2, 		--冰
	Fire = 3,		--火
	Poison = 4,		--毒
	Thunder = 5,	--雷
	Wind = 6, 		--风
}
params = {isEnemy = true,phase = PhaseType.Soil}
]]
function ChooseCondition.isPhase(me,fight,params)
	local roles = getRoles(me,fight,params.isEnemy)
	local count = 0
	local totalCount = params.count or 1
	print("111111111111",params.phase)
	for _, role in pairs(roles) do
			local phase = role:get_phase_type()
			print(phase)
			if phase == params.phase and count < totalCount then
				count = count + 1
			end
			if count >= totalCount then
				return true
			end
			
	end
	return false
end

--[[
params = {isEnemy = true,count = 1}
或 = {ID = 1,}
]]
function ChooseCondition.isDead(me,fight,params)
		local ID = params.ID
		local count = 0
		local totalCount = params.count or 1

		--如果指定单位ID
		if ID then
			local members = fight:getMembers()
			for _ ,roles in pairs(members) do
				for _,role in pairs(roles) do
					if instanceof(role,FightMonster) and role:getDBID() == ID then
						if  role:getIsGBH()  then
							return true
						end
						
					end
				end
			end
			return false
		end
		--如果指定敌友
		if params.isEnemy ~= nil then
			local roles = getRoles(me,fight,params.isEnemy)
			for _,role in pairs(roles) do
				if instanceof(role,FightMonster) and role:getIsGBH() then
					count = count + 1
				end
				if count >= totalCount then
					return true
				end
				
			end
			return false
		end

end

--[[
params = {prob= 0.5}
]]
function ChooseCondition.isProb(me,fight,params)
	local rand = math.random(1000)
	local prob = params.prob*1000
	if rand > 0 and rand <= prob  then 
		return true
	end
	return false
end
function ChooseCondition.getInstance()
	return ChooseCondition()
end
