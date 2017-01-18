--[[FightManager.lua
描述：
	战斗管理器用于触发战斗
--]]

require "base.base"
require "misc.FightConstant"
require "misc.PetConstant"
require "game.SystemError"
g_max_fightID = 0
FightManager = class(nil, Singleton)

local math_rand			= math.random
local tb_clear			= table.clear
local CirticalLoyalty	= PetLoyaltyFightParam	--宠物逃离战斗的临界忠诚度
local MaxPetLoyalty		= MaxPetLoyalty			--宠物的最大忠诚值
local fightIDs = {}--[ID]=type
--实体进入战斗失败的原因
local BattleFail_Duplicate	= 1	--已经出战了
local BattleFail_PetDying	= 2	--宠物垂死
local BattleFail_PetFlee	= 3	--宠物逃离

local OffenceWarriors = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}--20个
local DefenceWarriors = {{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{}}--20个
local Reservists = {
	{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
	{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
	{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
	{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
	{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
	{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},
}
local OIndex = 1
local DIndex = 1
local RIndex = 1
local serverLoad = FightServerLoad:getInstance()
--[[
	清除
]]
local function clearAttrPool()
	for i = 1,OIndex do
		tb_clear(OffenceWarriors[i])
	end
	OIndex = 1
	for i = 1,DIndex do
		tb_clear(DefenceWarriors[i])
	end
	DIndex = 1
	for i = 1,RIndex do
		tb_clear(Reservists[i])
	end
	RIndex = 1
end

--[[
	使用玩家的数据填充
]]
local function SetPlayerAttrInfo(player,info,isPvp)
	local attrSet = player:getAttributeSet()
	for attrType,attr in pairs(attrSet) do
		--所有基本属性传过去
		if not PlayerAttrDefine[attrType].expr then
			info[attrType] = attr:getValue()
		end
	end
	info.gateID = player:getGatewayID()
	info.clientLink = player:getClientLink()
	info.type = eClsTypePlayer
	info.dbID = player:getDBID()
	info.name = player:getName()
	info.modelID = player:getModelID()
	info.school = player:getSchool()
	info.level = player:getLevel()
	info.sex = player:getSex()
	info.showParts = player:getShowParts()
	info.mustCatch = player:getIsMustCatch()
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local packet = packetHandler:getPacket()
	info.pack = packet:getBattlePack()
	local mindHandler = player:getHandler(HandlerDef_Mind)
	info.minds = mindHandler:get_minds()
	local equipHandler = player:getHandler(HandlerDef_Equip)
	info.weaponID = equipHandler:getWeaponID()

	local equip = equipHandler:getEquip()
	local equipMent = equip:getPack():getGridItem(WeaponGridIndex)
	local remouldLevel 
	if equipMent then
		remouldLevel = equipMent:getRemouldAttrValue()*100
	end
	info.remouldLevel = remouldLevel

	local teamHandler = player:getHandler(HandlerDef_Team)
	if teamHandler:isTeam() then
		info.isTeam = true
		if teamHandler:isLeader() then
			info.isTeamHead = true
			local playerList = teamHandler:getTeamAllPlayerList()
			local idList = {}
			for _,p in ipairs(playerList) do
				table.insert(idList,p:getDBID())
			end
			info.playerIDList = idList
		end
	end
	info.pkInfo = player:getPkInfo()
	--[[
	local buffHandler = player:getHandler(HandlerDef_Buff)
	info.buffInfo = {}
	if  buffHandler:getFullMonster() then
		info.buffInfo.bFullMonster = true
	end
	]]
end

--[[
	使用宠物的数据填充
]]
local function SetPetAttrInfo(pet,info)
	local attrSet = pet:getAttributeSet()
	for attrType,attr in pairs(attrSet) do
		if not PetAttrDefine[attrType].expr then
			info[attrType] = attr:getValue()
		end
	end
		
	info.type = eClsTypePet
	info.dbID = pet:getConfigID()
	info.name = pet:getName() 
	info.modelID = pet:getModelID()
	info.level = pet:getLevel() 
	--info.xp = pet:getXp()
	info.sex = 1 --pet:getSex() or 1
	info.showParts = "{1,1}"--pet:getShowParts() or "{1,1}"
	local ownerID = pet:getOwnerID()
	local owner = g_entityMgr:getPlayerByID(ownerID)
	info.ownerID = owner:getDBID()
	
	info.worldPetID = pet:getID()
	info.life = pet:getPetLife() --or 100
	info.loyalty = pet:getLoyalty() --or 100
	info.status = pet:getPetStatus()
	local handler = pet:getHandler(HandlerDef_PetSkill)
	info.skills = handler:get_skills()
end

--[[
	增加一个备用宠物
]]
local function PushReservist(entity)
	if entity:getEntityType() == eClsTypePet then
		SetPetAttrInfo(entity,Reservists[RIndex])
		RIndex = RIndex + 1
	end
end

--[[
	增加一个攻方实体
]]
local function PushOffenseWarrior(entity)

	if entity:getEntityType() == eClsTypePlayer then

		SetPlayerAttrInfo(entity,OffenceWarriors[OIndex])
		OIndex = OIndex + 1
		local petID = entity:getFollowPetID()
		
		for _,pet in pairs(entity:getPetList()) do	--如果是玩家，将这个玩家的所有非出战宠物放入到后备宠物列表中
			if petID ~= pet:getID() then PushReservist(pet) end
		end
		
	elseif entity:getEntityType() == eClsTypePet then
	
		SetPetAttrInfo(entity,OffenceWarriors[OIndex])
		OIndex = OIndex + 1
	end
end

--[[
	增加一个防守方实体
]]
local function PushDefenseWarrior(entity)
	if entity:getEntityType() == eClsTypePlayer then
		SetPlayerAttrInfo(entity,DefenceWarriors[DIndex])
		DIndex = DIndex + 1
		local petID = entity:getFollowPetID()
		
		for _,pet in pairs(entity:getPetList()) do	--如果是玩家，将这个玩家的所有非出战宠物放入到后备宠物列表中
			if petID ~= pet:getID() then PushReservist(pet) end
		end
		
	elseif entity:getEntityType() == eClsTypePet then
		SetPetAttrInfo(entity,DefenceWarriors[DIndex])
		DIndex = DIndex + 1
	end
end

--[[
	宠物是否会逃离
]]
local function WouldPetDessert(pet)
	local loyalty = pet:getLoyalty() --or 100
	print(CirticalLoyalty,loyalty)
	if loyalty < CirticalLoyalty then
		return math_rand(MaxPetLoyalty) < (MaxPetLoyalty - loyalty)
	end
	return false
end

--[[
	队伍检测
]]
local function TeamCheck(entities)
	local failedEntites = {}	--不能进入战斗的实体，格式是 ID->Reason
	local count = 0				--能够进入战斗的实体数量
	for key,role in pairs(entities) do
	repeat
		if instanceof(role,Player) and role:getActionState() == PlayerStates.Fight then
			failedEntites[key] = BattleFail_Duplicate
			break
		end

		local entityType = role:getEntityType()
		if entityType == eClsTypePet then
			if role:getPetLife()  < 1 then
				failedEntites[key] = BattleFail_PetDying
				break
			end

			if WouldPetDessert(role) then	
				failedEntites[key] = BattleFail_PetFlee
				break
			end
		elseif entityType == eClsTypePlayer then
		end
		
		count = count + 1
	until true
	end
	return failedEntites,count
end

--[[
	处理进入战斗失败的实体
]]
local function HandleBattleFail(entity,reason)
	repeat
	if reason == BattleFail_Duplicate then
		print(("%s已经在战斗了"):format(entity:getName()))
		break
	end
	if entity:getEntityType() ~= eClsTypePet then
		--处理玩家不能出战
		break
	end

	--处理宠物不能出战
	local player = g_entityMgr:getPlayerByID(entity:getOwnerID())
	local event = nil
	if reason == BattleFail_PetDying then
		event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet, PetError.PetLifeLow)
	elseif reason == BattleFail_PetFlee then
		event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Pet, PetError.PetLoyaltyLow)
	end
	if event then
		g_eventMgr:fireRemoteEvent(event, player)
	end
	until true
end


function FightManager:__init()
end

--[[
	参数：
	roles:{player1,pet1,player2,pet2}
	monsters:{DB1,DB2}
	开启Pve战斗
]]
function FightManager:startPveFight(roles, monsters, mapID,type)
	clearAttrPool()

	local curMapID
	local failedEntites,count = TeamCheck(roles)
	if count < 1 then
		print("战斗实体不够")
		return false
	end

	local worldID = serverLoad:getMinLoadWorldID()

	for key,role in ipairs(roles) do
		local failure = failedEntites[key]
		if failure then
			HandleBattleFail(role,failure)
		else
			PushOffenseWarrior(role)
			if instanceof(role, Player) then
				role:setOldActionState(role:getActionState())
				--进入战斗如果是组队状态
				if role:getActionState() == PlayerStates.Team then
					role:setActionState(PlayerStates.FightAndTeam)
				else
					role:setActionState(PlayerStates.Fight)
				end
				--local moveHandler = role:getHandler(HandlerDef_Move)
				--moveHandler:doStopMove()
				role:setFightServerID(worldID)
			end
		end
		if not curMapID and role:getEntityType() == eClsTypePlayer then
			curMapID = role:getPos()[1]
		end
	end

	--发送事件给战斗服务器
	local fightType = FightType.PVE
	g_max_fightID = g_max_fightID + 1
	local event = Event.getEvent(FightEvents_SF_StartFight, fightType, OffenceWarriors, monsters,Reservists, mapID or curMapID, g_max_fightID)
	
	
	g_eventMgr:fireWorldsEvent(event, worldID)
	fightIDs[g_max_fightID] = type
	
	return g_max_fightID
end

--roles:{player1,player2},scriptFightID:脚本战斗配置ID,
function FightManager:checkStartScriptFight(roles, scriptFightID, mapID)
	local config = ScriptFightDB[scriptFightID]
	if not config then
		return false
	end
	local condition = config.condition
	if not condition then return true end

	--不能组队
	if condition.mustSingle then
		for _,player in ipairs(roles) do
			local teamHandler = player:getHandler(HandlerDef_Team)
			if teamHandler:isTeam() then
				return false
			end
		end
	end
	return true
end

--roles:{player1,player2},scriptFightID:脚本战斗配置ID,
function FightManager:startScriptFight(roles, scriptFightID, mapID,type)
	print("FightManager:startScriptFight",scriptFightID,mapID)
	clearAttrPool()
	local curMapID
	local failedEntites,count = TeamCheck(roles)
	if count < 1 then
		print("战斗实体不够")
		return 
	end

	local worldID = serverLoad:getMinLoadWorldID()

	for key,role in ipairs(roles) do
		local failure = failedEntites[key]
		if failure then
			--处理进入战斗失败的实体
			HandleBattleFail(role,failure)
		else
			--产生一个攻方实体
			PushOffenseWarrior(role)
			if instanceof(role, Player) then
				role:setOldActionState(role:getActionState())
				if role:getActionState() == PlayerStates.Team then
					role:setActionState(PlayerStates.FightAndTeam)
				else
					role:setActionState(PlayerStates.Fight)
				end
				--local moveHandler = role:getHandler(HandlerDef_Move)
				--moveHandler:doStopMove()
				role:setFightServerID(worldID)
			end
		end
		if not curMapID and role:getEntityType() == eClsTypePlayer then
			curMapID = role:getPos()[1]
		end
	end
	print("toDo:增加脚本战斗检测")
	--发送事件给战斗服务器
	g_max_fightID = g_max_fightID + 1
	local event = Event.getEvent(FightEvents_SF_StartScriptFight, FightType.Script, scriptFightID,OffenceWarriors,Reservists, mapID or curMapID, g_max_fightID)
	
	g_eventMgr:fireWorldsEvent(event, worldID)
	fightIDs[g_max_fightID] = type
	return g_max_fightID
end


--roles1:{player1,player2},roles2:{player1,player2}
function FightManager:startPvpFight(roles1, roles2, mapID,type)
	clearAttrPool()
	
	local curMapID
	local failedOffenceEntites,offenceCount = TeamCheck(roles1)
	if offenceCount < 1 then
		print "进攻方战斗实体不够"
		return false
	end

	local failedDefenceEntites,defenceCount = TeamCheck(roles2)
	if defenceCount < 1 then
		print "防守方战斗实体不够"
		return false
	end

	local worldID = serverLoad:getMinLoadWorldID()

	for key,role in ipairs(roles1) do
		local failure = failedOffenceEntites[key]
		if failure then
			HandleBattleFail(role,failure)
		else	
			PushOffenseWarrior(role)
			if instanceof(role, Player) then
				role:setOldActionState(role:getActionState())
				if role:getActionState() == PlayerStates.Team then
					role:setActionState(PlayerStates.FightAndTeam)
				else
					role:setActionState(PlayerStates.Fight)
				end
				--local moveHandler = role:getHandler(HandlerDef_Move)
				--moveHandler:doStopMove()
				role:setFightServerID(worldID)
			end
		end

		if not curMapID and role:getEntityType() == eClsTypePlayer then
			curMapID = role:getPos()[1]
		end
	end

	for key,role in ipairs(roles2) do
		local failure = failedDefenceEntites[key]
		if failure then
			HandleBattleFail(role,failure)
		else	
			PushDefenseWarrior(role)
			if instanceof(role, Player) then
				role:setOldActionState(role:getActionState())
				if role:getActionState() == PlayerStates.Team then
					role:setActionState(PlayerStates.FightAndTeam)
				else
					role:setActionState(PlayerStates.Fight)
				end
				--local moveHandler = role:getHandler(HandlerDef_Move)
				--moveHandler:doStopMove()
				role:setFightServerID(worldID)
			end
		end
	end

	--发送事件给战斗服务器
	local fightType = FightType.PVP
	g_max_fightID = g_max_fightID + 1
	local event = Event.getEvent(FightEvents_SF_StartFight, fightType, OffenceWarriors, DefenceWarriors,Reservists, mapID or curMapID, g_max_fightID)
	
	g_eventMgr:fireWorldsEvent(event, worldID)
	fightIDs[g_max_fightID] = type
	return g_max_fightID
end


function FightManager:getFightType(fightID)
	return fightIDs[fightID]
end

function FightManager:clearFightType(fightID)
	 fightIDs[fightID] = nil
end

FightManager.setPlayerAttrInfo = SetPlayerAttrInfo
FightManager.setPetAttrInfo = SetPetAttrInfo


function FightManager.getInstance()
	return FightManager()
end