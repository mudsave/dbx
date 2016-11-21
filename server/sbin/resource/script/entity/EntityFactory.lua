--[[EntityFactory.lua
描述：
	实体工厂
--]]

EntityFactory = class(nil, Singleton)

local __print = print
local function print(format,...)
	__print(("EntityFactory:%s"):format((format or ""):format(...)))
end

function EntityFactory:__init()
end

function EntityFactory:createPlayer(roleId, gatewayId, hClientLink, hGateLink)
	local player = Player(roleId, gatewayId, hClientLink, hGateLink)
	local peer = CoEntity:Create(eLogicPlayer, eClsTypePlayer)
	peer:setDBID(roleId)
	player:setPeer(peer)
	player:setID(peer:getHandle())
	return player
end

function EntityFactory:createStaticNpc(dbID)
	local npc = Npc()
	npc:setDBID(dbID)
	g_entityMgr:addNpc(npc)
	return npc
end

function EntityFactory:createDynamicNpc(dbID)
	local npc = Npc()
	npc:setDBID(dbID)
	local peer = CoEntity:Create(eLogicNpc, eClsTypeNpc)
	peer:setDBID(dbID)
	npc:setPeer(peer)
	npc:setID(peer:getHandle())
	g_entityMgr:addNpc(npc)
	return npc
end

function EntityFactory:createPet(configID)
	if not configID or not PetDB[configID] then
		return nil
	end
	local pet = Pet()
	pet:setPeer(CoEntity:Create(eLogicPet, eClsTypePet))
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
	mineNpc:setID(peer:getHandle())
	--mineNpc:addHandler(HandlerDef_Move, MoveHandler(mineNpc))
	mineNpc:setEntityType(eLogicMineNpc)
	g_entityMgr:addMineNpc(mineNpc)
	return mineNpc
end

function EntityFactory:createGoodsNpc(dbID)
end

function EntityFactory:createBoss(dbID)
end

function EntityFactory:createEctypeNpc(dbID)
end

EntityFactory.getInstance = function()
	return EntityFactory()
end