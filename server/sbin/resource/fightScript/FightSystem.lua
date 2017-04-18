--[[FightSystem.lua
描述：
	战斗系统客户端消息的接收
--]]

require "misc.FightConstant"
require "data.ScriptFightDB"
require "data.FightAIDB"
require "data.SpeakAIDB"
require "data.AIScriptDB"


require "base.base"
require "misc.PetConstant"
require "AI.ChooseTarget"
require "AI.ChooseCondition"
require "AI.ChooseAI"
require "AI.AIHandler"
require "AI.PlayerAIHandler"
require "AI.MonsterAIHandler"
require "AI.PetAIHandler"
require "fight.FightActionCheck"
require "fight.FightAction"
require "fight.FightSystemCheck"
require "fight.FightSystemAction"
require "fight.FightConfig"
require "fight.FSM"
require "fight.Fight"
require "fight.FightPVE"
require "fight.FightPVP"
require "fight.FightScript"
require "fight.FightScript_LuckyMonster"
require "fight.FightScript_Random"
require "fight.FightFSMConfig"
require "fight.FightFactory"
require "fight.FightManager"
require "fight.FightUtils"
require "entity.FightEntity"
require "entity.FightPlayer"
require "entity.FightMonster"
require "entity.FightPet"
require "entity.FightNpc"
require "entity.FightEntityFactory"
require "entity.FightEntityManager"
require "buff.FightBuffHandler"
require "item.FightItemHandler"
require "CommonAttack.CommonSkillConfig"
require "CommonAttack.CommonSkill"
require "skill.SkillSystem"

require "misc.ChatConstant"

FightSystem = class(EventSetDoer, Singleton, Timer)
local fightRolesA = {}
local fightRolesB = {}
local fightMonsters = {}
local fightNpcs = {}
function FightSystem:__init()
	self._doer = {
		[FightEvents_SF_StartFight]		= FightSystem.onStartFight,
		[FightEvents_CF_ChooseAction]		= FightSystem.onChoose,
		[FightEvents_CF_PlayOver]		= FightSystem.onPlayOver,
		[FightEvents_SF_StartScriptFight]	= FightSystem.onStartScriptFight,
		[FightEvents_FF_ExitWorld]		= FightSystem.onExitWorld,
		[FightEvents_SF_ExitFight]		= FightSystem.onExitFight,
		[FightEvents_SF_QueryAttr]      = FightSystem.onQueryAttr,
		[FightEvents_SF_SetAttr]        = FightSystem.onSetAttr,
		[FightEvents_SF_CreatePet]	    = FightSystem.onCreatePet,
		[FrameEvents_SS_playerDropLine] = FightSystem.onDropLine,
		[FrameEvents_SS_playerOnLine]	= FightSystem.onOnline,
		[FrameEvents_CS_Ping]			= FightSystem.onPingReturn,
	}
end
function FightSystem.onCollectGarbage()
	print("FightSystem.onCollectGarbage()",collectgarbage("count"),collectgarbage("collect"),collectgarbage("count"))
end
--pve,pvp
function FightSystem:onStartFight(event)
	print("FightSystem:onStartFight(event)")
	local params = event:getParams()
	local srcWorldID = event.srcWorldID
	local fightType = params[1]
	local role1Attrs = params[2]
	local monsterDBIDs = nil
	local role2Attrs = nil
	local playerLvl = nil
	if fightType == FightType.PVE then
		monsterDBIDs = params[3]
	elseif fightType == FightType.PVP then
		role2Attrs = params[3]
	end
	local storedPets = params[4]
	local mapID = params[5]
	local fightID = params[6] --在世界服唯一
	table.clear(fightRolesA)
	table.clear(fightRolesB)
	table.clear(fightMonsters)
	--生成A队玩家
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			--玩家
			if attrs.type == eClsTypePlayer then
				if attrs.isTeam then
					--在队伍的话用队长的等级
					if attrs.isTeamHead then
						playerLvl = attrs.level
					end
				else
					--不在队伍就用玩家自己的等级
					playerLvl = attrs.level
				end
				local player = g_fightEntityFactory:createPlayer(attrs)
				table.insert(fightRolesA, player)
			end
		end
	end

	--生成A队宠物
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			if attrs.type == eClsTypePet then
				local pet = g_fightEntityFactory:createPet(attrs,true)
				table.insert(fightRolesA, pet)
			end
		end
	end

	--生成怪物:pve
	if monsterDBIDs then
		for _, DBID in pairs(monsterDBIDs) do
			local monster = g_fightEntityFactory:createMonster(DBID, false, playerLvl)
			--[[（不需要了,在创建怪物的时候进行了处理）
			if monster:getAttrValue(monster_lvl) == -1 then
			    --根据玩家等级设置怪物等级，如果玩家一方是组队形式，就根据队长等级设置怪物等级
				monster:setAttrValue(monster_lvl, playerLvl)
				--等级变化后，最大血量也跟着变化，所以这里重设下怪物当前血量
				local maxHp = monster:getAttrValue(monster_max_hp)
				monster:setAttrValue(monster_hp, maxHp)
			end
			--]]
			table.insert(fightMonsters, monster)
		end
	end

	--生成B队玩家，宠物:pvp
	if role2Attrs then
		for _, attrs in pairs(role2Attrs) do
			if table.isEmpty(attrs) == false then
				--玩家
				if attrs.type == eClsTypePlayer then
					local player = g_fightEntityFactory:createPlayer(attrs)
					table.insert(fightRolesB, player)
				end
			end
		end

		for _, attrs in pairs(role2Attrs) do
			if table.isEmpty(attrs) == false then
				if attrs.type == eClsTypePet then
					local pet = g_fightEntityFactory:createPet(attrs,true)
					table.insert(fightRolesB, pet)
				end
			end
		end
	end
	
	--生成储备宠物
	for _, attrs in pairs( storedPets ) do
		if table.isEmpty(attrs) == false then
			g_fightEntityFactory:createPet(attrs,false)
		end
	end


	--生成战斗
	local fight = nil
	--print(fightType,FightType.PVE)
	if fightType == FightType.PVE then
		fight = g_fightFactory:createPveFight(fightRolesA,fightMonsters,mapID)
		fight:setFightID(fightID)
		self:sendPVEFightInfo2Client(srcWorldID, mapID, fightRolesA, fightMonsters,nil,nil ,fight:getID())
	elseif fightType == FightType.PVP then
		fight = g_fightFactory:createPvpFight(fightRolesA,fightRolesB,mapID)
		fight:setFightID(fightID)
		self:sendPVPFightInfo2Client(srcWorldID, mapID, fightRolesA, fightRolesB,nil,nil ,fight:getID())
	end
	FightUtils.printFightInfo(fight)
	fight:setSrcWorldID(srcWorldID)
	fight:setPlayerLevel(playerLvl)
	g_fightMgr:addFight(fight)
	--回合开始，等待客户端选动作
	fight:gotoState(FightState.RoundStart)
	--发世界消息，通知主服务器(然后由主服务器通知客户端进入战斗)
end

local ScriptMonsters = {}
local monsterCountMap = {}
local myMonsterConfig = {}
function FightSystem:_getScriptMonsters(monstersInfo,playerCount,bFullMonster)
	table.clear(ScriptMonsters)
	table.clear(monsterCountMap)
	table.clear(myMonsterConfig)

	local count = 1
	if playerCount == 1 then
		if bFullMonster then
			count = 3
		else
			count = math.random(1,3)
		end
	elseif playerCount == 2 then
		if bFullMonster then
			count = 5
		else
			count = math.random(3,5)
		end
	elseif playerCount == 3 then
		if bFullMonster then
			count = 6
		else
			count = math.random(5,6)
		end
	elseif playerCount == 4 then
		if bFullMonster then
			count = 8
		else
			count = math.random(6,8)
		end
	end
	table.copy(monstersInfo,myMonsterConfig)
	

	local maxCount = myMonsterConfig.maxCount or 0xFF

	local minCount = myMonsterConfig.minCount or 0

	local configCount = myMonsterConfig.count or 0xFF

	
	if configCount < count then
		count = configCount
	end

	if minCount >  count then
		count = minCount
	end

	if maxCount < count then
		count = maxCount
	end
    
	print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$count",minCount,maxCount,count)

	local finalCount = count
	for i = 1, count do
		for k,info in ipairs(myMonsterConfig) do
			if info.weight == -1 then
				table.insert(ScriptMonsters,info.ID)
				monsterCountMap[info.ID] = 	(monsterCountMap[info.ID] or 0) + 1
				if info.max and  monsterCountMap[info.ID] >= info.max then
					table.remove(myMonsterConfig,k)
				end
				finalCount = finalCount - 1
				break
			end
		end
	end
	
	for i = 1, finalCount do

		local curWeight = 0
		local totalWeight = 0
		for _,info in ipairs(myMonsterConfig) do
			if info.weight > 0 then
				totalWeight = totalWeight + info.weight
			end
		end

		local rand = math.random(totalWeight)

		for k,info in ipairs(myMonsterConfig) do
			if rand >= curWeight and rand <=  curWeight + info.weight then
				table.insert(ScriptMonsters,info.ID)
				monsterCountMap[info.ID] = 	(monsterCountMap[info.ID] or 0) + 1
				if info.max and  monsterCountMap[info.ID] >= info.max then
					table.remove(myMonsterConfig,k)
				end
				break
			end
			curWeight = curWeight + info.weight
		end
	end

	return ScriptMonsters
end

local function getPlayerCount(role1Attrs)
	local count = 0
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			--玩家
			if attrs.type == eClsTypePlayer then
				count = count + 1
			end
		end
	end
	return count
end
function FightSystem:_onStartLuckMonsterScriptFight(event)
	local params = event:getParams()
	local srcWorldID = event.srcWorldID
	local fightType = params[1]
	local scriptFightID = params[2]
	local role1Attrs = params[3]
	local storedPets = params[4]
	local mapID = params[5]
	local fightID = params[6] --在世界服唯一
	local playerLvl = nil
	print("_onStartLuckMonsterScriptFight",fightType,scriptFightID,role1Attrs)
	--获取怪物配置
		--判断有无满怪buff
	local bFullMonster = false
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			--玩家
			if attrs.type == eClsTypePlayer then
				if attrs.isTeam then
					--在队伍的话用队长的判断
					if attrs.isTeamHead then
						local buffInfo = attrs.buffInfo or {}
						if buffInfo.bFullMonster then
							bFullMonster = true
							break
						end
					end
				else
					--不在队伍就用玩家自己的判断
					local buffInfo = attrs.buffInfo or {}
					if buffInfo.bFullMonster then
						bFullMonster = true
						break
					end
				end
				
			end
		end
	end
	--生成怪物ID
	local monsterDBIDs,bAssign
	
	local monsterConfig = ScriptFightDB[scriptFightID]
	--小怪
	monsterDBIDs = FightUtils.getMinorMonsters(monsterConfig)
	--主怪
	for _,info in pairs(monsterConfig.majorMonsterInfo) do
		table.insert(monsterDBIDs,1,info.ID)
	end
	
	--获取助阵npc配置
	local npcIDs = ScriptFightDB[scriptFightID].npcs
	local bNpc = false
	local bNpcAssign = false
	if npcIDs and #npcIDs > 0 then
		bNpc = true
		if npcIDs[1].pos then
			bNpcAssign = true
		end
	end

	table.clear(fightRolesA)
	table.clear(fightMonsters)
	table.clear(fightNpcs)

	--生成A队玩家
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			--玩家
			if attrs.type == eClsTypePlayer then
				if attrs.isTeam then
					--在队伍的话用队长的等级
					if attrs.isTeamHead then
						playerLvl = attrs.level
					end
				else
					--不在队伍就用玩家自己的等级
					playerLvl = attrs.level
				end
				print("	--生成C队玩家，宠物")
				local player = g_fightEntityFactory:createPlayer(attrs)
				table.insert(fightRolesA, player)
			end
		end
	end

	--生成A队宠物
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			if attrs.type == eClsTypePet then
				local pet = g_fightEntityFactory:createPet(attrs,true)
				table.insert(fightRolesA, pet)
			end
		end
	end

	--生成怪物:pve
	if (not bAssign) and monsterDBIDs then
		
		for _, DBID in pairs(monsterDBIDs) do
			local monster = g_fightEntityFactory:createMonster(DBID, false, playerLvl)
			table.insert(fightMonsters, monster)
		end
	elseif bAssign then
		for _, monsterInfo in ipairs(monsterDBIDs) do
			local monster = g_fightEntityFactory:createMonster(monsterInfo.ID, false, playerLvl)
			table.insert(fightMonsters, monster)
		end
	end
	--生成助阵npc
	if bNpc then
		for _, monsterInfo in ipairs(npcIDs) do
			local monster = g_fightEntityFactory:createMonster(monsterInfo.ID, false, playerLvl)
			table.insert(fightNpcs, monster)
		end
	end
	
	--生成储备宠物
	for _, attrs in pairs( storedPets ) do
		if table.isEmpty(attrs) == false then
			g_fightEntityFactory:createPet(attrs,false)
		end
	end

	--生成战斗
	local fight = nil
	
	if not bAssign then
		fight = g_fightFactory:createScriptFight(scriptFightID, fightRolesA, fightMonsters, mapID, monsterConfig.monsters,fightNpcs, bNpcAssign and npcIDs)
	else
		fight = g_fightFactory:createScriptFight(scriptFightID, fightRolesA, fightMonsters, mapID, monsterDBIDs, fightNpcs, bNpcAssign and npcIDs)
	end
	fight:setFightID(fightID)
	self:sendScriptFightInfo2Client(srcWorldID, mapID, fightRolesA, fightMonsters, fightNpcs,scriptFightID,fight:getID())
	

	fight:setSrcWorldID(srcWorldID)
	g_fightMgr:addFight(fight)
	fight:setPlayerLevel(playerLvl)
	fight:gotoState(FightState.Start)
	FightUtils.printFightInfo(fight)--TODO del
	table.clear(fightRolesA)
	table.clear(fightMonsters)
	table.clear(fightNpcs)
	
end

function FightSystem:onStartScriptFight(event)
	local params = event:getParams()
	local srcWorldID = event.srcWorldID
	local fightType = params[1]
	local scriptFightID = params[2]
	local role1Attrs = params[3]
	local storedPets = params[4]
	local mapID = params[5]
	local fightID = params[6] --在世界服唯一
	local playerLvl = nil
	print("onStartScriptFight",fightType,scriptFightID)

	local subType = ScriptFightDB[scriptFightID].subType
	if subType == ScriptType.LuckyMonster then
		self:_onStartLuckMonsterScriptFight(event)
		return
	end

	--获取怪物配置
		--判断有无满怪buff
	local bFullMonster = false
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			--玩家
			if attrs.type == eClsTypePlayer then
				if attrs.isTeam then
					--在队伍的话用队长的判断
					if attrs.isTeamHead then
						local buffInfo = attrs.buffInfo or {}
						if buffInfo.bFullMonster then
							bFullMonster = true
							break
						end
					end
				else
					--不在队伍就用玩家自己的判断
					local buffInfo = attrs.buffInfo or {}
					if buffInfo.bFullMonster then
						bFullMonster = true
						break
					end
				end
				
			end
		end
	end
	--生成怪物ID
	local monsterDBIDs,bAssign,monsterConfig
	local phaseInfo = ScriptFightDB[scriptFightID].phases
	local phaseID
	if  phaseInfo and table.size(phaseInfo) > 0 then
		local scriptConfig = ScriptFightDB[scriptFightID]
		if scriptConfig.subType and scriptConfig.subType == ScriptType.Random then
			local rand = math.random(table.size(phaseInfo))
			monsterDBIDs = phaseInfo[rand].monsters
			phaseID = rand
		else
			monsterDBIDs = ScriptFightDB[scriptFightID].phases[1].monsters
		end
	else
		monsterConfig = ScriptFightDB[scriptFightID].monsters
		if monsterConfig.type == ScriptMonsterCreateType.Random then
			local playerCount = getPlayerCount(role1Attrs)
			monsterDBIDs = self:_getScriptMonsters(monsterConfig,playerCount,bFullMonster)
		elseif monsterConfig.type == ScriptMonsterCreateType.Assign then
			monsterDBIDs = monsterConfig
			bAssign = true
		end
	end
	--获取助阵npc配置
	local npcIDs = ScriptFightDB[scriptFightID].npcs
	local bNpc = false
	local bNpcAssign = false
	if npcIDs and #npcIDs > 0 then
		bNpc = true
		if npcIDs[1].pos then
			bNpcAssign = true
		end
	end

	table.clear(fightRolesA)
	table.clear(fightMonsters)
	table.clear(fightNpcs)

	--生成A队玩家
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			--玩家
			if attrs.type == eClsTypePlayer then
				if attrs.isTeam then
					--在队伍的话用队长的等级
					if attrs.isTeamHead then
						playerLvl = attrs.level
					end
				else
					--不在队伍就用玩家自己的等级
					playerLvl = attrs.level
				end
				print("	--生成C队玩家，宠物")
				local player = g_fightEntityFactory:createPlayer(attrs)
				table.insert(fightRolesA, player)
			end
		end
	end

	--生成A队宠物
	for _, attrs in pairs( role1Attrs ) do
		if table.isEmpty(attrs) == false then
			if attrs.type == eClsTypePet then
				local pet = g_fightEntityFactory:createPet(attrs,true)
				table.insert(fightRolesA, pet)
			end
		end
	end

	--生成怪物:pve
	if (not bAssign) and monsterDBIDs then
		for _, DBID in pairs(monsterDBIDs) do
			local monster = g_fightEntityFactory:createMonster(DBID, false, playerLvl)
			table.insert(fightMonsters, monster)
		end
	elseif bAssign then
		for _, monsterInfo in ipairs(monsterDBIDs) do
			local monster = g_fightEntityFactory:createMonster(monsterInfo.ID, false, playerLvl)
			table.insert(fightMonsters, monster)
		end
	end
	--生成助阵npc
	if bNpc then
		for _, monsterInfo in ipairs(npcIDs) do
			local monster = g_fightEntityFactory:createMonster(monsterInfo.ID, false, playerLvl)
			table.insert(fightNpcs, monster)
		end
	end
	
	--生成储备宠物
	for _, attrs in pairs( storedPets ) do
		if table.isEmpty(attrs) == false then
			g_fightEntityFactory:createPet(attrs,false)
		end
	end

	--生成战斗
	local fight = nil
	
	if not bAssign then
		fight = g_fightFactory:createScriptFight(scriptFightID, fightRolesA, fightMonsters, mapID, monsterConfig,fightNpcs, bNpcAssign and npcIDs)
	else
		fight = g_fightFactory:createScriptFight(scriptFightID, fightRolesA, fightMonsters, mapID, monsterDBIDs, fightNpcs, bNpcAssign and npcIDs)
	end
	fight:setFightID(fightID)
	fight:setPlayerLevel(playerLvl)
	if phaseID then
		fight:setPhaseID(phaseID)
	end
	self:sendScriptFightInfo2Client(srcWorldID, mapID, fightRolesA, fightMonsters, fightNpcs,scriptFightID,fight:getID())
	

	fight:setSrcWorldID(srcWorldID)
	g_fightMgr:addFight(fight)

	fight:gotoState(FightState.Start)
	FightUtils.printFightInfo(fight)--TODO del
	table.clear(fightRolesA)
	table.clear(fightMonsters)
	table.clear(fightNpcs)
	

end

function FightSystem:_setPlayerInfo4Client(playerInfo,player)
		playerInfo['id']		= player:getID()
		playerInfo['playerID'] 	= player:getDBID()
		playerInfo['ModelID'] 	= player:getModelID()
		playerInfo['showParts'] = player:getShowParts()
		playerInfo['name'] 		= player:getName()
		playerInfo['hp'] 		= player:getHp()
		playerInfo['maxHp'] 	= player:getMaxHp()
		playerInfo['lifeState'] = 1
		playerInfo['fightIdx'] 	= player:getPos()[3]
		playerInfo['type']		= eClsTypePlayer
		playerInfo['anger']		= player:get_anger()
		playerInfo['mp'] 		= player:getMp()
		playerInfo['maxMp'] 	= player:getMaxMp()
		playerInfo['weaponID']	= player:getWeaponID()
		playerInfo['remouldLevel'] = player:getRemouldLevel()
		print("playerInfo=",toString(playerInfo) )
end

function FightSystem:setPetInfo4Client(petInfo,pet)
	
		petInfo['petDBID']	= pet:getDBID()
		petInfo['petID'] 	= pet:getID()
		petInfo['fightIdx'] 	= pet:getPos()[3]
		petInfo['maxHp'] 		= pet:getAttrValue(pet_max_hp) --TODO 
		petInfo['hp'] 			= pet:getAttrValue(pet_hp)
		petInfo['ModelID'] 	    = pet:getModelID()
		petInfo['type']			= eClsTypePet
		petInfo['ownerID']      = pet:getOwnerID()
		petInfo['worldPetID']	= pet:getWorldPetID()
		petInfo['mp'] 			= pet:getMp()
		petInfo['maxMp'] 		= pet:getMaxMp()
		petInfo['name']			= pet:getName()
		petInfo['level']		= pet:getLevel()
		petInfo['xp']			= pet:getXp()
		print("petInfo=",toString(petInfo) )
end
function FightSystem:sendPVEFightInfo2Client(srcWorldID, mapID, fightPlayers, fightMonsters,fightNpcs,scriptFightID,fightID)
	--print("FightSystem:sendPVEFightInfo2Client")
	local roles = {}
	local pets = {}
	
	--生成玩家和宠物信息
	for _, role in pairs(fightPlayers) do
		local roleInfo = {}
		if instanceof(role,FightPlayer) then
			self:_setPlayerInfo4Client(roleInfo,role)
			table.insert(roles, roleInfo)
		elseif instanceof(role,FightPet) then
			self:setPetInfo4Client(roleInfo,role)
			table.insert(pets, roleInfo)
		end
	end

	--生成怪物信息
	local monsters = {}
	FightUtils.setMonsterInfo4Client(fightMonsters,monsters)
	--生成助阵Npc
	local npcs = {}
	if fightNpcs then
		FightUtils.setMonsterInfo4Client(fightNpcs,npcs)
	end
	

	--脚本战斗配置
	local backgroundInfo
	if scriptFightID and ScriptFightDB[scriptFightID] then
		local scriptConfig = ScriptFightDB[scriptFightID]
		backgroundInfo = {pic = scriptConfig.backgroundPic,music = scriptConfig.backgroundMusic, scriptID = scriptFightID}
	end
	
	--通知玩家进入战斗
	for _, role in ipairs(fightPlayers) do
		if instanceof(role,FightPlayer) then
			local  event = Event(FightEvents_FC_StartFight, g_serverId, FightType.PVE, roles, pets, monsters, mapID ,npcs ,backgroundInfo,fightID)
			g_eventMgr:fireRemoteEvent(event,role)
		end
	end

	--通知世界服
	
	for _,playerInfo in pairs(roles) do
		for k,info in pairs(playerInfo) do
			if k ~= 'playerID' then
				playerInfo[k] = nil
			end
		end
	end
	for _,petInfo in pairs(pets) do
		for k,info in pairs(petInfo) do
			if k ~= 'worldPetID' then
				petInfo[k] = nil
			end
		end
	end
	
	if srcWorldID then
		local event = Event(FightEvents_FS_StartFight, FightType.PVE, roles,pets, g_serverId)
		g_eventMgr:fireWorldsEvent(event, srcWorldID)
	end
end


function FightSystem:sendPVPFightInfo2Client(srcWorldID,  mapID, fightPlayers1, fightPlayers2, fightNpcs, scriptFightID, fightID)--fightNpcs,scriptID这里用不上
		local roles1 = {}
		local pets1 = {}

		--生成队1和宠物信息
		for _, role in pairs(fightPlayers1) do
			local roleInfo = {}
			if instanceof(role,FightPlayer) then
				self:_setPlayerInfo4Client(roleInfo,role)
				table.insert(roles1, roleInfo)
			elseif instanceof(role,FightPet) then
				self:setPetInfo4Client(roleInfo,role)
				table.insert(pets1, roleInfo)
			end
		end
		local roles2 = {}
		local pets2 = {}

		--生成队2和宠物信息
		for _, role in pairs(fightPlayers2) do
			local roleInfo = {}
			if instanceof(role,FightPlayer) then
				self:_setPlayerInfo4Client(roleInfo,role)
				table.insert(roles2, roleInfo)
			elseif instanceof(role,FightPet) then
				self:setPetInfo4Client(roleInfo,role)
				table.insert(pets2, roleInfo)
			end
		end


		local isReverse = false
		--通知玩家
		for _, player in ipairs(fightPlayers1) do
			if instanceof(player, FightPlayer)then
				local  event1 = Event(FightEvents_FC_StartFight, g_serverId, FightType.PVP, roles1, pets1, roles2,pets2, mapID, isReverse , fightID )
				g_eventMgr:fireRemoteEvent(event1,player)
			end
		end

		isReverse = true--左右互换(自己总是在右边)
		for _, player in ipairs(fightPlayers2) do
			if instanceof(player, FightPlayer)then
				local  event2 = Event(FightEvents_FC_StartFight, g_serverId, FightType.PVP, roles1, pets1, roles2, pets2,mapID ,isReverse , fightID)
				g_eventMgr:fireRemoteEvent(event2,player)
			end
		end

	--通知世界服
	for _,playerInfo in pairs(roles1) do
		for k,info in pairs(playerInfo) do
			if k ~= 'playerID' then
				playerInfo[k] = nil
			end
		end
	end
	for _,petInfo in pairs(pets1) do
		for k,info in pairs(petInfo) do
			if k ~= 'worldPetID' then
				petInfo[k] = nil
			end
		end
	end
	if srcWorldID then
		local event = Event(FightEvents_FS_StartFight, FightType.PVP, roles1,pets1, g_serverId)
		g_eventMgr:fireWorldsEvent(event, srcWorldID)
	end

	--通知世界服
	for _,playerInfo in pairs(roles2) do
		for k,info in pairs(playerInfo) do
			if k ~= 'playerID' then
				playerInfo[k] = nil
			end
		end
	end
	for _,petInfo in pairs(pets2) do
		for k,info in pairs(petInfo) do
			if k ~= 'worldPetID' then
				petInfo[k] = nil
			end
		end
	end

	if srcWorldID then
		local event = Event(FightEvents_FS_StartFight, FightType.PVP, roles2,pets2, g_serverId)
		g_eventMgr:fireWorldsEvent(event, srcWorldID)
	end
		
end

function FightSystem:sendScriptFightInfo2Client(srcWorldID, mapID, fightPlayers, fightMonsters,fightNpcs,scriptFightID , fightID)
	self:sendPVEFightInfo2Client(srcWorldID,  mapID, fightPlayers, fightMonsters,fightNpcs,scriptFightID ,fightID)
end

function FightSystem:onChoose(event)
	print("FightSystem:onChoose(event)")
	local params = event:getParams()
	local DBID = event.DBID
	local isPlayer = params[1]
	local actionType = params[2]
	local actionContext = params[3]
	print(isPlayer,actionType,toString(actionContext))
	params[1] = DBID
	params[2] = isPlayer
	params[3] = actionType
	params[4] = actionContext
	local player = g_fightEntityMgr:getPlayerByDBID(DBID)
	if player then
		local fightID = player:getFightID()
		local fight = g_fightMgr:getFight(fightID)
		fight:input(event)
	else
		print(DBID,"player not exist !")
		return
	end
	--print(fight.state)

	
end

function FightSystem:onPlayOver(event)
	print("FightSystem:onPlayOver(event)")
	local params = event:getParams()
	local DBID = event.DBID
	
	local player = g_fightEntityMgr:getPlayerByDBID(DBID)
	if not player then
		print("player no exists!",DBID)
		return
	end
	local fightID = player:getFightID()
	local fight = g_fightMgr:getFight(fightID)
	params[1] = DBID
	fight:input(event)
end

function FightSystem:onExitWorld(event)
	print("FightSystem:onExitWorld(event)")
	local DBID = event.DBID
	local player = g_fightEntityMgr:getPlayerByDBID(DBID)
	if not player then
		return 
	end

	local fightID = player:getFightID()
	local fight = g_fightMgr:getFight(fightID or 0xFFFFFFFF)
	if not fight then
		return
	end
	
	fight:onPlayerExit(player)
end

function FightSystem:onExitFight(event)
	--print("FightSystem:onExitWorld(event)")
	local params = event:getParams()
	local playerDBID = params[1]
	local player = g_fightEntityMgr:getPlayerByDBID(playerDBID)
	if not player then
		return 
	end

	local fightID = player:getFightID()
	local fight = g_fightMgr:getFight(fightID or 0xFFFFFFFF)
	if not fight then
		return
	end
	FightUtils.ForcePlayerLeave(player)
	--player:setForceLeave(true)
end

function FightSystem:sendSystemMsg(player, msg)
	-- 发送消息给玩家
	local event = Event(ClientEvents_SC_SystemMsg, msg)
	g_eventMgr:fireRemoteEvent(event, player)
end

function FightSystem:onSetAttr(event)
	local params = event:getParams()
	local playerID = params[1]
	local attrType = params[2]
	local attrValue = params[3]
	local targetID = params[4]
	local player = g_fightEntityMgr:getPlayerByDBID(playerID)
	if not player then
		return
	end
	local fightEntity = player
	if targetID then
		targetID = tonumber(targetID)
		local targetEntity = g_fightEntityMgr:getPlayer(targetID)
		if not targetEntity then
			targetEntity = g_fightEntityMgr:getMonster(targetID)
		end
		if targetEntity then
			fightEntity = targetEntity
		end
	end
	if not fightEntity then
		return
	end
	attrType = tonumber(attrType)
	attrValue = tonumber(attrValue)
	if attrType == player_hp then
		fightEntity:setHp(attrValue)
	elseif attrType == player_mp then
		fightEntity:setMp(attrValue)
	elseif attrType == player_add_max_hp then
		fightEntity:setAttrValue(player_add_max_hp, attrValue)
	elseif attrType == player_add_max_mp then
		fightEntity:setAttrValue(player_add_max_mp, attrValue)
	elseif attrType == player_add_at then
	elseif attrType == player_add_af then
	elseif attrType == player_add_mt then
	elseif attrType == player_add_mf then
	elseif attrType == player_add_speed then
	elseif attrType == player_add_str then
	elseif attrType == player_add_int then
	elseif attrType == player_add_sta then
	elseif attrType == player_add_spi then
	elseif attrType == player_add_dex then
	elseif attrType == player_add_critical then
	elseif attrType == player_add_tenacity then
	end
	local event = Event(FightEvents_FC_SetAttr, fightEntity:getID(), attrType, attrValue)
	g_eventMgr:fireRemoteEvent(event, player)
end

function FightSystem:onQueryAttr(event)
	local params = event:getParams()
	local playerID = params[1]
	local attrType = params[2]
	local targetID = params[3]
	local player = g_fightEntityMgr:getPlayerByDBID(playerID)
	if not player then
		return
	end
	local fightEntity = player
	if targetID then
		targetID = tonumber(targetID)
		local targetEntity = g_fightEntityMgr:getPlayer(targetID)
		if not targetEntity then
			targetEntity = g_fightEntityMgr:getMonster(targetID)
			if not targetEntity then
				targetEntity = g_fightEntityMgr:getPet(targetID)
			end
		end
		if targetEntity then
			fightEntity = targetEntity
		end
	end
	if not fightEntity then
		return
	end
	local msg = ""
	local entityName = fightEntity:getName()
	if attrType == "all" then
		msg = entityName..": > 等级(lvl): "..fightEntity:getLevel()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 道行(tao): "..fightEntity:getTao()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 当前生命(curhp): "..fightEntity:getHp()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 生命上限(maxhp): "..fightEntity:getMaxHp()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 当前法力(curmp): "..fightEntity:getMp()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 法力上限(maxmp): "..fightEntity:getMaxMp()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 物理攻击(at): "..fightEntity:ft_get_at()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 物理防御(af): "..fightEntity:ft_get_af()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 法术攻击(mt): "..fightEntity:ft_get_mt()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 法术防御(mf): "..fightEntity:ft_get_mf()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 速度(speed): "..fightEntity:ft_get_speed()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 武力(str): "..fightEntity:get_str()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 智力(int): "..fightEntity:get_int()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 根骨(sta): "..fightEntity:get_sta()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 敏锐(spi): "..fightEntity:get_spi()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 身法(dex): "..fightEntity:get_dex()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 暴击(critical): "..fightEntity:ft_get_critical()
		self:sendSystemMsg(player, msg)
		msg = entityName..": > 抗暴(tenacity): "..fightEntity:ft_get_tenacity()
		self:sendSystemMsg(player, msg)
		return
	end
	attrType = tonumber(attrType)
	if attrType == player_lvl then
		msg = entityName..": > 等级(lvl): "..fightEntity:getLevel()
	elseif attrType == player_tao then
		msg = entityName..": > 道行(tao): "..fightEntity:getTao()
	elseif attrType == player_hp then
		msg = entityName..": > 当前生命(curhp): "..fightEntity:getHp()
	elseif attrType == player_max_hp then
		msg = entityName..": > 生命上限(maxhp): "..fightEntity:getMaxHp()
	elseif attrType == player_mp then
		msg = entityName..": > 当前法力(curmp): "..fightEntity:getMp()
	elseif attrType == player_max_mp then
		msg = entityName..": > 法力上限(maxmp): "..fightEntity:getMaxMp()
	elseif attrType == player_at then
		msg = entityName..": > 物理攻击(at): "..fightEntity:ft_get_at()
	elseif attrType == player_af then
		msg = entityName..": > 物理防御(af): "..fightEntity:ft_get_af()
	elseif attrType == player_mt then
		msg = entityName..": > 法术攻击(mt): "..fightEntity:ft_get_mt()
	elseif attrType == player_mf then
		msg = entityName..": > 法术防御(mf): "..fightEntity:ft_get_mf()
	elseif attrType == player_speed then
		msg = entityName..": > 速度(speed): "..fightEntity:ft_get_speed()
	elseif attrType == player_str then
		msg = entityName..": > 武力(str): "..fightEntity:get_str()
	elseif attrType == player_int then
		msg = entityName..": > 智力(int): "..fightEntity:get_int()
	elseif attrType == player_sta then
		msg = entityName..": > 根骨(sta): "..fightEntity:get_sta()
	elseif attrType == player_spi then
		msg = entityName..": > 敏锐(spi): "..fightEntity:get_spi()
	elseif attrType == player_dex then
		msg = entityName..": > 身法(dex): "..fightEntity:get_dex()
	elseif attrType == player_critical then
		msg = entityName..": > 暴击(critical): "..fightEntity:ft_get_critical()
	elseif attrType == player_tenacity then
		msg = entityName..": > 抗暴(tenacity): "..fightEntity:ft_get_tenacity()
	end
	self:sendSystemMsg(player, msg)
end

function FightSystem:onCreatePet(event)
	local params = event:getParams()
	local srcWorldID = event.srcWorldID
	local playerDBID = params[1]
	local petInfo = params[2]
	local pet = g_fightEntityFactory:createPet(petInfo,false)
	pet:setIsNew(true)
end

function FightSystem:onDropLine(event)
	local params = event:getParams()
	local playerDBID = params[1]
	local player = g_fightEntityMgr:getPlayerByDBID(playerDBID)
	if not player then
		return
	end
	local fightID = player:getFightID()
	local fight = g_fightMgr:getFight(fightID or 0xFFFFFFFF)
	if not fight then
		return
	end
	fight:onPlayerExit(player)
end

function FightSystem:_reSendFightInfo(player,fight)
--print("FightSystem:_reSendFightInfo")
	table.clear(fightRolesA)
	table.clear(fightRolesB)
	table.clear(fightMonsters)

	local fightID = fight:getID()
	local mapID = fight:getMapID()
	local members = fight:getMembers()

	if instanceof(fight,FightScript) or  instanceof(fight,FightPVE) then
		
		local monsters = members[FightStand.B]
		for _,monster in pairs(monsters) do
			table.insert(fightMonsters,monster)
		end
		local memberAs = members[FightStand.A]
		for _,role in pairs(memberAs) do
			table.insert(fightRolesA,role)
		end

		if instanceof(fight,FightScript) then
			local scriptFightID = fight:getScriptID()
			self:sendScriptFightInfo2Client(nil, mapID, fightRolesA, fightMonsters, {},scriptFightID,fightID)
		else
			self:sendPVEFightInfo2Client(nil, mapID, fightRolesA, fightMonsters,nil,nil ,fightID)
		end

	elseif instanceof(fight,FightPVP) then

		local memberBs = members[FightStand.B]
		for _,roleB in pairs(memberBs) do
			table.insert(fightRolesB,roleB)
		end
		local memberAs = members[FightStand.A]
		for _,roleA in pairs(memberAs) do
			table.insert(fightRolesA,roleA)
		end

		self:sendPVPFightInfo2Client(nil, mapID, fightRolesA, fightRolesB,nil,nil ,fightID)

	end
end

function FightSystem:onOnline(event)
print("FightSystem:onOnline")
	local params = event:getParams()
	local playerDBID = params[1]
	local type = params[2]
	local gateID = params[3]
	local hClient = params[4]
	
	local player = g_fightEntityMgr:getPlayerByDBID(playerDBID)
	if not player then
		return
	end

	local fightID = player:getFightID()
	local fight = g_fightMgr:getFight(fightID or 0xFFFFFFFF)
	if not fight then
		return
	end

	if type == OnlineReason.Relogin then
		player:setGateID(gateID)
		player:setClientLink(hClient)
		self:_reSendFightInfo(player, fight)
	end
	
	fight:onPlayerAttached(player)
end

function FightSystem:onPingReturn(event)
	local params = event:getParams()
	local DBID = event.DBID
	local gatewayID = params[1]
	local clientLink = params[2]
	-- 返回消息
	RPCEngine:sendToPeer(gatewayID, clientLink, FrameEvents_SC_Ping, g_serverId)
end

function FightSystem:update(timerID)
	FightSystem.onCollectGarbage()
end

function FightSystem.getInstance()
	return FightSystem()
end

g_eventMgr:addEventListener(FightSystem.getInstance())
g_timerMgr:regTimer(FightSystem.getInstance(), 0,MemCollectPeriod*1000,"FightSystem.onCollectGarbage")

