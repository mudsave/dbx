--[[EntityFactory.lua
描述：
	实体工厂
--]]

EntityFactory = class(nil, Singleton)

local function notice(str,...) print(("EntityFactory:%s"):format((str or ""):format(...))) end

function EntityFactory:__init()
end

function EntityFactory:createPlayer(roleId, gatewayId, hClientLink, hGateLink)
	local player = Player(roleId, gatewayId, hClientLink, hGateLink)
	local peer = CoEntity:Create(eLogicPlayer, eClsTypePlayer)
	peer:setDBID(roleId)
	peer:setGateLink(hGateLink)
	peer:setClientLink(hClientLink)
	peer:setGatewayID(gatewayId)
	player:setPeer(peer)
	player:setMoveSpeed(DefaultSpeed)
	player:setEntityType(eLogicPlayer)

	--添加该实体类型的handler
	player:addHandler(HandlerDef_Packet, PacketHandler(player))
	player:addHandler(HandlerDef_Depot, DepotHandler(player))
	player:addHandler(HandlerDef_Equip, EquipHandler(player))
	player:addHandler(HandlerDef_Shelf, ShelfHandler(player))
	player:addHandler(HandlerDef_Team, TeamHandler(player))
	player:addHandler(HandlerDef_Ride, RideHandler(player))
	player:addHandler(HandlerDef_Move, MoveHandler(player))
	player:addHandler(HandlerDef_Follow,FollowHandler(player))

	player:addHandler(HandlerDef_Task, TaskHandler(player))
	player:addHandler(HandlerDef_TaskPrData, TaskPrivateHandler(player))
	player:addHandler(HandlerDef_Event, EventHandler(player))
	player:addHandler(HandlerDef_Pet,PetHandler(player))
	player:addHandler(HandlerDef_Transportation,TransportationHandler(player))
	player:addHandler(HandlerDef_Ectype, EctypeHandler(player))
	
	player:addHandler(HandlerDef_Treasure, TreasureHandler(player))
	player:addHandler(HandlerDef_LifeSkill, LifeSkillHandler(player))
	player:addHandler(HandlerDef_Experience, ExperienceHandler(player))

	player:addHandler(HandlerDef_Treasure, TreasureHandler(player))
	player:addHandler(HandlerDef_Practise,PractiseHandler(player))
	player:addHandler(HandlerDef_PetDepot, PetDepotHandler(player))
	player:addHandler(HandlerDef_Buff, BuffHandler(player))
	player:addHandler(HandlerDef_Mind, MindHandler(player))
	player:addHandler(HandlerDef_SystemSet,SystemSetHandler(player))
	player:addHandler(HandlerDef_AutoPoint,AutoPointHandler(player))	
	player:addHandler(HandlerDef_Mine,MineHandler(player))
	player:addHandler(HandlerDef_Activity, ActivityHandler(player))
	return player
end

function EntityFactory:createStaticNpc(dbID)
	if not dbID or not NpcDB[dbID] then
		print ("ERROR: can not get static npc config data", dbID)
		return nil
	end
	local npc = Npc()
	npc:setDBID(dbID)
	g_entityMgr:addNpc(npc)

	npc:addHandler(HandlerDef_Dialog, DialogHandler(npc))
	npc:getHandler(HandlerDef_Dialog):setDialogIDs(NpcDB[dbID] and NpcDB[dbID].dialogIDs or {})

	return npc
end

function EntityFactory:createDynamicNpc(dbID)
	if not dbID or not NpcDB[dbID] then
		print ("ERROR: can not get dynamic npc config data", dbID)
		return nil
	end
	local npc = Npc()
	npc:setDBID(dbID)
	local peer = CoEntity:Create(eLogicNpc, eClsTypeNpc)
	peer:setDBID(dbID)
	npc:setPeer(peer)
	local npcName = NpcDB[dbID].name 
	if npcName then
		npc:setName(npcName)
	end
	--添加该实体类型的handler
	npc:addHandler(HandlerDef_Dialog, DialogHandler(npc))
	npc:getHandler(HandlerDef_Dialog):setDialogIDs(NpcDB[dbID] and NpcDB[dbID].dialogIDs or {})
	
	npc:setEntityType(eLogicNpc)
	--将实体加入EntityManager管理
	g_entityMgr:addNpc(npc)
	return npc
end

function EntityFactory:createPet(configID)
	if not configID or not PetDB[configID] then
		print ("ERROR: can not get pet config data", configID)
		return nil
	end

	local pet = Pet()

	pet:setPeer(CoEntity:Create(eLogicPet, eClsTypePet))
	pet:onCreate(configID)
	pet:setEntityType(eLogicPet)

	local skillHandler = PetSkillHandler(pet)
	skillHandler:initDefault()
	pet:addHandler(HandlerDef_Move, MoveHandler(pet))
	pet:addHandler(HandlerDef_PetSkill, skillHandler)
	pet:addHandler(HandlerDef_AutoPoint,AutoPointHandler(pet))
	g_entityMgr:addPet(pet)
	
	return pet
end

---------------------------------------------------------
--下边为自定义实体
function EntityFactory:createMineNpc(dbID)
	local mineNpc = MineNpc()
	mineNpc:setDBID(dbID)
	local peer = CoEntity:Create(eLogicMineNpc, eClsTypeNpc)
	peer:setDBID(dbID)
	mineNpc:setPeer(peer)
	mineNpc:setMoveSpeed(DefaultSpeed)
	mineNpc:addHandler(HandlerDef_Move, MoveHandler(mineNpc))
	mineNpc:setEntityType(eLogicMineNpc)
	g_entityMgr:addMineNpc(mineNpc)
	return mineNpc
end

function EntityFactory:createGoodsNpc(config, goodNpcID,index)
	local goodsNpc = GoodsNpc()
	goodsNpc:setDBID(goodNpcID)
	goodsNpc:setMapTileindex(index)
	--创建c++实体
	local peer = CoEntity:Create(eLogicGoodsNpc, eClsTypeNpc)
	goodsNpc:setPeer(peer)
	peer:setDBID(goodNpcID)
	
	goodsNpc:setEntityType(eLogicGoodsNpc)
	--将实体加入EntityManager管理
	g_entityMgr:addGoodsNpc(goodsNpc)
	return goodsNpc
end

function EntityFactory:createBoss(dbID, endTime)
	if not dbID or not NpcDB[dbID] then
		print ("ERROR: can not get boss npc config data", dbID)
		return nil
	end
	local boss = Npc()
	boss:setDBID(dbID)
	--创建c++实体
	local peer = CoEntity:Create(eLogicNpc, eClsTypeNpc)
	boss:setPeer(peer)
	peer:setDBID(dbID)
	if endTime then
		
		boss:setDetachTime(endTime)
	end
	--添加该实体类型的handler
	boss:addHandler(HandlerDef_Dialog, DialogHandler(boss))
	--TODO 其他类型handler
	boss:getHandler(HandlerDef_Dialog):setDialogIDs(NpcDB[dbID] and NpcDB[dbID].dialogIDs or {})
	
	boss:setEntityType(eLogicBoss)
	--将实体加入EntityManager管理
	g_entityMgr:addNpc(boss)
	return boss
end

function EntityFactory:createEctypeNpc(dbID)
	if not dbID or not NpcDB[dbID] then
		print ("ERROR: can not get ectype npc config data", dbID)
		return nil
	end
	local npc = Npc()
	npc:setDBID(dbID)
	local peer = CoEntity:Create(eLogicEctypeNpc, eClsTypeNpc)
	peer:setDBID(dbID)
	npc:setPeer(peer)
	--添加该实体类型的handler
	npc:addHandler(HandlerDef_Dialog, DialogHandler(npc))
	--TODO 其他类型handler
	npc:getHandler(HandlerDef_Dialog):setDialogIDs(NpcDB[dbID] and NpcDB[dbID].dialogIDs or {})
	npc:setEntityType(eLogicEctypeNpc)
	--将实体加入EntityManager管理
	g_entityMgr:addNpc(npc)
	return npc
end

-- 这个就是公共场景巡逻NPC
function EntityFactory:createEctypePatrolNpc(dbID)
	if not dbID or not NpcDB[dbID] then
		print ("ERROR: can not get patrol npc config data", dbID)
		return nil
	end
	local patrolNpc = PatrolNpc()
	patrolNpc:setDBID(dbID)
	--创建c++实体
	local peer = CoEntity:Create(eLogicEctypePatrolNpc, eClsTypeNpc)
	patrolNpc:setPeer(peer)
	patrolNpc:setMoveSpeed(DefaultSpeed)
	peer:setDBID(dbID)

	patrolNpc:addHandler(HandlerDef_Move, MoveHandler(patrolNpc))

	patrolNpc:setEntityType(eLogicNpc)
	--将实体加入EntityManager管理
	g_entityMgr:addPatrolNpc(patrolNpc)
	return patrolNpc
end

function EntityFactory:createFollowEntity(npcID)
	if not npcID or not NpcDB[npcID] then
		print ("ERROR: can not get npc config data", npcID)
		return nil
	end
	local npcInfo = NpcDB[npcID]
	if not npcInfo then
		print("npc没配就要创建跟随",npcID)
		return
	end
	local followEntity = FollowEntity()
	followEntity:setDBID(npcID)
	local peer = CoEntity:Create(eLogicFollow, eClsTypeNpc)
	followEntity:setPeer(peer)
	peer:setDBID(npcID)
	followEntity:setModelID(npcInfo.modelID or 11)
	followEntity:setName(npcInfo.name or "跟随者1")
	followEntity:addHandler(HandlerDef_Move, MoveHandler(followEntity))
	followEntity:setEntityType(eLogicFollow)
	return followEntity
end

-- 创建副本场景物件
function EntityFactory:createEctypeObject(objectID)
	local ectypeObject = EctypeObject()
	ectypeObject:setDBID(objectID)
	--创建c++实体
	local peer = CoEntity:Create(eLogicEctypeObject, eClsTypeNpc)
	ectypeObject:setPeer(peer)
	peer:setDBID(objectID)
	ectypeObject:setEntityType(eLogicEctypeObject)
	--将实体加入EntityManager管理
	g_entityMgr:addGoodsNpc(ectypeObject)
	return ectypeObject
end

EntityFactory.getInstance = function()
	return EntityFactory()
end
