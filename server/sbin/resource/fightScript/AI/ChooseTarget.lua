--ChooseTarget.lua
 
 require "data.FightAIDB"
 require "data.SpeakAIDB"
 

ChooseTarget = class(nil,Singleton)
local choosedTargets = {}
function ChooseTarget:__init()
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

function ChooseTarget.getMe(me, fight,params)
	table.clear(choosedTargets)
	table.insert(choosedTargets,me)
	return choosedTargets
	
end

function ChooseTarget.getAnyOfFriend(me, fight,params)
	table.clear(choosedTargets)
	local members = fight:getMembers()
	local mySide = me:getPos()[2]
	local friends = members[mySide]
	local count = table.size(friends)
	local rand = math.random(count)
	local i = 1
	for _,role in pairs(friends) do
		if i == rand then
			table.insert(choosedTargets,role)
			return choosedTargets
		end
		i = i + 1
	end
	return choosedTargets
end

function ChooseTarget.getAnyOfEnemy(me, fight,params)
	table.clear(choosedTargets)
	local members = fight:getMembers()
	local enemySide = FightUtils.getEnemySide(me)
	local enemys = members[enemySide]
	local count = table.size(enemys)
	local rand = math.random(count)
	local i = 1
	for _,role in pairs(enemys) do
		if i == rand then
			table.insert(choosedTargets,role)
			return choosedTargets
		end
		i = i + 1
	end
	return choosedTargets
end

function ChooseTarget.getAnyOfFriendButMe(me, fight,params)
	table.clear(choosedTargets)
	local members = fight:getMembers()
	local mySide = me:getPos()[2]
	local friends = members[mySide]
	local friend = FightUtils.findRandomElement(friends,me)
	table.insert(choosedTargets,friend)
	return choosedTargets
end


function ChooseTarget.getAllOfEnemy(me, fight,params)
	table.clear(choosedTargets)
	local members = fight:getMembers()
	local enemySide = FightUtils.getEnemySide(me)
	local enemys = members[enemySide]
	for _,enemy in pairs(enemys) do
		table.insert(choosedTargets,enemy)
	end

	return choosedTargets

end


function ChooseTarget.getAllOfFriend(me, fight,params)
	table.clear(choosedTargets)
	local members = fight:getMembers()
	local mySide = me:getPos()[2]
	local friends = members[mySide]
	for _,friend in pairs(friends) do
		table.insert(choosedTargets,friend)
	end

	return choosedTargets
end


function ChooseTarget.getAllRoleOfEnemy(me, fight,params)
	table.clear(choosedTargets)
	local members = fight:getMembers()
	local enemySide = FightUtils.getEnemySide(me)
	local enemys = members[enemySide]
	for _,enemy in pairs(enemys) do
		if not instanceof(enemy,FightPet) then
			table.insert(choosedTargets,enemy)
		end
	end

	return choosedTargets
end


function ChooseTarget.getAllPetOfEnemy(me, fight,params)
	table.clear(choosedTargets)
	local members = fight:getMembers()
	local enemySide = FightUtils.getEnemySide(me)
	local enemys = members[enemySide]
	for _,enemy in pairs(enemys) do
		if instanceof(enemy,FightPet) then
			table.insert(choosedTargets,enemy)
		end
	end

	return choosedTargets
end


function ChooseTarget.getAnyRoleOfEnemy(me, fight,params)
	table.clear(choosedTargets)
	local allRole = ChooseTarget.getAllRoleOfEnemy(me, fight,params)
	local role = FightUtils.findRandomElement(allRole,nil)
	table.insert(choosedTargets,role)
	return choosedTargets
end

function ChooseTarget.getAnyPetOfEnemy(me, fight,params)
	table.clear(choosedTargets)
	local allPet = ChooseTarget.getAllPetOfEnemy(me, fight,params)
	local role = FightUtils.findRandomElement(allPet,nil)
	table.insert(choosedTargets,role)
	return choosedTargets
end

--[[
params ={isEnemy = true,type = AIAttrType.Hp,relation ="<=",value = 0.2,count = 1 }
]]

function ChooseTarget.getAttrPercentTargets(me, fight,params)
	table.clear(choosedTargets)
	local roles = getRoles(me,fight,params.isEnemy)
	
	local startCount = 0
	local type = params.type
	local relation = params.relation
	local value = params.value
	local totalCount = params.count
	for _,role in pairs(roles) do
		--取比例值
		local percent = 0
		if type == AIAttrType.Hp then
			percent = role:getHp()/role:getMaxHp()
		elseif type == AIAttrType.Mp then
			percent = role:getMp()/(role:getMaxMp() or 1)
		elseif type == AIAttrType.Anger then
			if instanceof(role,FightMonster) then
				percent = 0
			else
				percent = role:get_anger()/(role:get_max_anger() or 1)
			end
		else
			return nil
		end
		--比较
		local bPass =  FightUtils.CompareOfAI(relation ,percent,value)
		
		--符合条件，放入集合
		if bPass and startCount < totalCount then
			table.insert(choosedTargets,role)
			startCount = startCount + 1
		end
		if startCount >= totalCount then
			return choosedTargets
		end
	end

	return choosedTargets
end


--[[
params ={isEnemy = true,type ="min" or "max" }
]]
 
function ChooseTarget.getLevelTargets(me, fight,params)--TODO 伪pvp
	table.clear(choosedTargets)
	local roles = getRoles(me,fight,params.isEnemy)
	local target
	if params.type == "min" then
		local minLevel = 0xFFFFFF
		for _, role in pairs(roles) do
			if instanceof(role,FightPlayer) then
				local level = role:getLevel()
				if level < minLevel then
					target = role
					minLevel = level
				end
			end
		end
	elseif params.type == "max" then
		local maxLevel = (-1)*0xFFFFFF
		for _, role in pairs(roles) do
			if instanceof(role,FightPlayer) then
				local level = role:getLevel()
				if level > maxLevel then
					target = role
					maxLevel = level
				end
			end
		end
	else
		
	end
	table.insert(choosedTargets,target)
	return choosedTargets
end


--[[
params ={isEnemy = true,type =schoolType,count = 1 }--TODO schoolType
]]
 
function ChooseTarget.getSchoolTargets(me, fight,params)
	table.clear(choosedTargets)
	local roles = getRoles(me,fight,params.isEnemy)
	local count = 0
	local totalCount = params.count or 1
	for _, role in pairs(roles) do
			if instanceof(role,FightPlayer) then
				local school = role:getSchool()
				if school == params.type and count < totalCount then
					table.insert(choosedTargets,role)
					count = count + 1
				end
				if count >= totalCount then
					return choosedTargets
				end
			end
	end
	return choosedTargets
end

--[[

PhaseType = {
	Soil = 1, 		--土
	Ice = 2, 		--冰
	Fire = 3,		--火
	Poison = 4,		--毒
	Thunder = 5,	--雷
	Wind = 6, 		--风
}

params ={isEnemy = true,type = PhaseType.Soil,count = 1 }
]]
function ChooseTarget.getPhaseTargets(me, fight,params)
	table.clear(choosedTargets)
	local roles = getRoles(me,fight,params.isEnemy)
	local count = 0
	local totalCount = params.count or 1

	for _, role in pairs(roles) do
			
			local phase = role:get_phase_type()
			if phase == params.type and count < totalCount then
				table.insert(choosedTargets,role)
				count = count + 1
			end
			if count >= totalCount then
				return choosedTargets
			end
			
	end
	return choosedTargets
end
--[[
function ChooseTarget.getAttackTypeTargets(me, fight,params)--TODO 攻击类型
end
]]

--[[
params ={isEnemy = true,buffID = 1( or type = BuffKind.Dot),count = 1 }
或者 ={ ID = DBID,buffID = 1( or type = BuffKind.Dot) }

]]
function ChooseTarget.getStatusTargets(me, fight,params)
		table.clear(choosedTargets)
		 
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
							if  count < totalCount then
								table.insert(choosedTargets,role)
								count = count + 1
							end
						end
						if count >= totalCount then
							return choosedTargets
						end
					end
					
				end
			end
			return choosedTargets
		end
		
		--如果指定敌友
		
		if params.isEnemy ~= nil then
			local roles = getRoles(me,fight,params.isEnemy)
			for _,role in pairs(roles) do
				local bh = role:getHandler(FightEntityHandlerType.HandlerDef_FightBuff)
				if bh:hasBuffID(buffID) or bh:hasBuffKind(type) then
					if  count < totalCount then
						table.insert(choosedTargets,role)
						count = count + 1
					end
				end
				if count >= totalCount then
					return choosedTargets
				end
				
			end
			return choosedTargets
		end
		
end

--[[
params ={ ID = DBID,count = 1 }
]]
function ChooseTarget.getDBIDTargets(me, fight,params)
		table.clear(choosedTargets)
		local count = 0
		local totalCount = params.count or 1
		local members = fight:getMembers()
		for _ ,roles in pairs(members) do
			for _,role in pairs(roles) do
				if instanceof(role,FightMonster)  then
					if role:getDBID() == ID then
						if  count < totalCount then
							table.insert(choosedTargets,role)
							count = count + 1
						end
					end
					if count >= totalCount then
						return choosedTargets
					end
				end
			end
		end
		return choosedTargets
end

--[[
params ={ pos = 10 }
]]
function ChooseTarget.getPositionTargets(me, fight,params)
		table.clear(choosedTargets)
		local targetPos =  params.pos
		local members = fight:getMembers()
		for _ ,roles in pairs(members) do
			for pos,role in pairs(roles) do
				if pos == targetPos then
						table.insert(choosedTargets,role)
						return choosedTargets
				end
			end
		end
		return choosedTargets
end

local RandomDeadRoles = {}
function ChooseTarget.getDeadFriendTargets(me, fight,params)
	table.clear(choosedTargets)
	table.clear(RandomDeadRoles)
	local roles = getRoles(me,fight,false)
	for _,role in pairs(roles) do
		if (instanceof(role,FightMonster) and role:getIsGBH() ) then
			table.insert(RandomDeadRoles,role)
		end
	end
	local num = table.size(RandomDeadRoles)
	if num > 0 then
		local rand = math.random(num)
		local target = RandomDeadRoles[rand]
		table.insert(choosedTargets,target)
			
	end
	return choosedTargets
end


--[[
params ={isEnemy = true,type = AIAttrType.Hp,relation = "min" }
]]
function ChooseTarget.getAttrMinMaxTargets(me, fight,params)

	table.clear(choosedTargets)
	local roles = getRoles(me,fight,params.isEnemy)
	local type = params.type
	local relation = params.relation
	local target
	local curValue
	if relation == "min" then
		curValue = 0xFFFFFFFF 
	elseif relation == "max" then
		curValue = (-1)*0xFFFFFFFF 
	else
		print("getAttrMinMaxTargets config error!")
		return choosedTargets
	end


	for _,role in pairs(roles) do

		local value = FightUtils.getValueOfAI(role,type)
		if relation == "min" then
			if value <  curValue then
				target = role
				curValue = value
			end
		elseif relation == "max" then
			if value >  curValue then
				target = role
				curValue = value
			end
		
		end
	end

	table.insert(choosedTargets,target)
	return choosedTargets

end
function ChooseTarget.getInstance()
	return ChooseTarget()
end
