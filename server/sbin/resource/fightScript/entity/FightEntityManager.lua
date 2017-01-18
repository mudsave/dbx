--[[FightEntityManager.lua
描述：
	战斗实体管理器
--]]


FightEntityManager = class(nil, Singleton)
local instance

function FightEntityManager:__init()
	self._npcList = {}
	self._monsterList = {}
	self._playerList = {}
	self._petList = {}
	self._playerByDBID = {}
	self._roleMap = {}
end
--添加Player对象
function FightEntityManager:addPlayer(player)
	local playerID = player:getID()
	if self._playerList[playerID] then
		print("player重复添加，ID为",playerID)
	else
		self._playerList[playerID] = player
		self._roleMap[playerID] = player
		local DBID = player:getDBID()
		self._playerByDBID[DBID] = player
	end
end
--删除Player对象
function FightEntityManager:removePlayer(playerID)
	local player = self._playerList[playerID]
	if player then
		self._playerList[playerID] = nil
		self._roleMap[playerID] = nil
		local DBID = player:getDBID()
		self._playerByDBID[DBID] = nil
		release(player)
	end
end


--得到Player对象
function FightEntityManager:getPlayerByDBID(dbID)
	
	return self._playerByDBID[dbID]
end

--添加Npc对象
function FightEntityManager:addNpc(npc)
	local npcID = npc:getID()
	if self._npcList[npcID] then
		print("npc重复添加，ID为",npcID)
	else
		self._npcList[npcID] = npc
		self._roleMap[npcID] = npc
	end
end

--删除Npc对象
function FightEntityManager:removeNpc(npcID)
	if self._npcList[npcID] then
		local npc = self._npcList[npcID]
		self._npcList[npcID] = nil
		self._roleMap[npcID] = nil
		release(npc)
	else
		print("当前NPC不存在，ID为",npcID)
	end
end

--添加Pet对象
function FightEntityManager:addPet(pet)
	local petID = pet:getID()
	if self._petList[petID] then
		print("pet重复添加，ID为",petID)
	else
		self._petList[petID] = pet
		self._roleMap[petID] = pet
	end
end

--删除Pet对象
function FightEntityManager:removePet(petID)
	if self._petList[petID] then
		local pet = self._petList[petID]
		self._petList[petID] = nil
		self._roleMap[petID] = nil
		release(pet)
	else
		print("当前宠物不存在，ID为",petID)
		
	end
end

--添加Monster对象
function FightEntityManager:addMonster(monster)
	local monsterID = monster:getID()
	if self._monsterList[monsterID] then
		print("monster重复添加，ID为",monsterID)
	else
		self._monsterList[monsterID] = monster
		self._roleMap[monsterID] = monster
	end
end

--删除Monster对象
function FightEntityManager:removeMonster(monsterID)
	if self._monsterList[monsterID] then
		local monster = self._monsterList[monsterID]
		self._monsterList[monsterID] = nil
		self._roleMap[monsterID] = nil
		release(monster)
	else
		print("当前怪物不存在，ID为",monsterID)
	end
end

function FightEntityManager:getPlayer(playerID)
	return self._playerList[playerID]
end

function FightEntityManager:getNpc(npcID)
	return self._npcList[npcID]
end

function FightEntityManager:getMonster(monsterID)
	return self._monsterList[monsterID]
end

function FightEntityManager:getRole(ID)
	return self._roleMap[ID]
end

function FightEntityManager:getPet(petID)
	return self._petList[petID]
end

function FightEntityManager:removeRole(ID)
	local role = self._roleMap[ID]
	if role then
		if instanceof(role,FightPlayer) then
			for _ ,petID in pairs(role:getPetList()) do
				self:removePet(petID)
			end
			self:removePlayer(ID)
		elseif instanceof(role,FightPet)then
			self:removePet(ID)
		elseif instanceof(role,FightMonster) then
			self:removeMonster(ID)
		elseif instanceof(role,FightNpc) then
			self:removeNpc(ID)
		end
	end
end

FightEntityManager.getInstance = function()
	instance = instance or FightEntityManager()
	return instance
end