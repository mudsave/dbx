--[[FightFactory.lua
描述：
	战斗实体的创建
--]]

require "base.base"


FightFactory = class(nil,Singleton)



function FightFactory:__init()
	
end
function FightFactory:_initFightByPlayers(fight, players, side)
	local fightID = fight:getID()

	local playerCount = 0
	for _,role in ipairs(players) do
		if instanceof(role,FightPlayer) then
			playerCount = playerCount + 1
		end
	end

	for _,role in ipairs(players) do

		role:setFightID(fightID)

		if instanceof(role,FightPlayer) then
			local pos = fight:getRolePos(StandRoleType.Player,side,playerCount,nil,role)
			if pos then
				fight:addRole(side,pos,role)
			end
		elseif instanceof(role,FightPet) then
			local ownerID = role:getOwnerID()
			local owner = g_fightEntityMgr:getRole(ownerID)
			local pos1 = fight:getRolePos(StandRoleType.Pet,side,playerCount,nil,owner)
			if pos1 then
				fight:addRole(side,pos1,role)
			end
		end

	end

end
function FightFactory:initFightByMonsters(fight, monsters)
	local monsterCount = #monsters
	local fightID = fight:getID()
	for _,monster in ipairs(monsters) do
		monster:setFightID(fightID)
		local pos = fight:getRolePos(StandRoleType.Monster, FightStand.B, monsterCount)
		if pos then
			fight:addRole(FightStand.B, pos, monster)
		end
	end
end

function FightFactory:createPveFight(players, monsters, mapID)
	local fight = FightPVE()
	local fightID = fight:getID()
	fight:setMapID(mapID)
	fight:setType( FightType.PVE )
	self:_initFightByPlayers(fight,players,FightStand.A)
	local monsterCount = #monsters
	for _,monster in ipairs(monsters) do
		monster:setFightID(fightID)
		local pos = fight:getRolePos(StandRoleType.Monster, FightStand.B, monsterCount)
		if pos then
			fight:addRole(FightStand.B, pos, monster)
		end
	end
	return fight
end

function FightFactory:createPvpFight(playersA, playersB, mapID)
	local fight = FightPVP()
	local fightID = fight:getID()
	fight:setMapID(mapID)
	fight:setType( FightType.PVP )
	self:_initFightByPlayers(fight,playersA,FightStand.A)
	self:_initFightByPlayers(fight,playersB,FightStand.B)
	return fight
end

function FightFactory:createScriptFight(scriptID,players, monsters, mapID,monsterPositionsInfo,npcs,npcPositionsInfo)
	local scriptConfig = ScriptFightDB[scriptID]
	local fight
	if scriptConfig.subType and scriptConfig.subType == ScriptType.LuckyMonster then
		fight = FightScript_LuckyMonster(scriptID)
	else
		fight = FightScript(scriptID)
	end
	 
	local fightID = fight:getID()
	fight:setMapID(mapID)
	fight:setType( FightType.Script )
	self:_initFightByPlayers(fight,players,FightStand.A)
	
	local playerCount = 0
	for _,role in ipairs(players) do
		if instanceof(role,FightPlayer) then
			playerCount = playerCount + 1
		end
	end

	--按规则生成怪物
	if not monsterPositionsInfo then
		local monsterCount = #monsters 
		for _,monster in ipairs(monsters) do
			monster:setFightID(fightID)
			local pos = fight:getRolePos(StandRoleType.Monster, FightStand.B, monsterCount)
			if pos then
				fight:addRole(FightStand.B, pos, monster)
			end
		end
	--按指定生成怪物
	else
		local monsterCount = #monsters 
		local i = 1
		for _,monster in ipairs(monsters) do
			monster:setFightID(fightID)
			local pos = monsterPositionsInfo[i].pos
			if pos then
				fight:addRole(FightStand.B, pos, monster)
			else
				pos = fight:getRolePos(StandRoleType.Monster, FightStand.B, monsterCount)
				fight:addRole(FightStand.B, pos, monster)
			end
			i = i + 1
		end
	end

	--按规则生成Npc
	if not npcPositionsInfo then
		local monsterCount = #npcs 
		for _,monster in ipairs(npcs) do
			monster:setFightID(fightID)
			local pos = fight:getRolePos(StandRoleType.Npc, FightStand.A, playerCount,monsterCount)
			if pos then
				fight:addRole(FightStand.A, pos, monster)
			end
		end
	--按指定生成Npc
	else
		local i = 1
		for _,monster in ipairs(npcs) do
			monster:setFightID(fightID)
			local pos = npcPositionsInfo[i].pos
			if pos then
				local bAlready = fight:getRole(pos)
				if  bAlready then
					pos = fight:getRandomEmptyPos(FightStand.A)
				end
				fight:addRole(FightStand.A, pos, monster)
			end
			i = i + 1
		end
	end
	
	return fight
end

function FightFactory:__init()
	
end
function FightFactory.getInstance()
	return FightFactory()
end



