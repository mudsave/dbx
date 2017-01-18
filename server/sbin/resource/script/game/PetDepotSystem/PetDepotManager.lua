--[[PetDepotManager.lua
描述：
	宠物仓库消息管理
]]

PetDepotManager = class(nil, Singleton)

function PetDepotManager:__init()
	self.capacity = DefaultCapacity
end

--扩充宠物仓库容量
function PetDepotManager:doExpandPetDepot(roleID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	local depotHandler = player:getHandler(HandlerDef_PetDepot)

	if not depotHandler then
		return
	end

	local packetHandler = player:getHandler(HandlerDef_Packet)
	local extendItemNum = packetHandler:getNumByItemID(DepotExtendItemID)
	local curCapacity = depotHandler:getCapacity()

	if extendItemNum < (curCapacity - DefaultCapacity + 1)*DefaultItemNum then
		print("包裹物品不足，不能进行宠物仓库的扩充")
		return
	end

	depotHandler:setCapacity(curCapacity + 1)

	--扣除身上对应个数的道具
	packetHandler:removeByItemId(DepotExtendItemID,(curCapacity - DefaultCapacity + 1)*DefaultItemNum)


	local event = Event.getEvent(PetDepotEvent_SC_ExpandPetDepotReturn)
	g_eventMgr:fireRemoteEvent(event,player)
end

--宠物的存入
function PetDepotManager:doPutInPet(roleID,petID)
	local pet = g_entityMgr:getPet(petID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	if not pet then
		return
	end

	pet:setPetStatus(PetStatus.Store)
	pet:flushPropBatch(player)
	local event = Event.getEvent(PetDepotEvent_SC_PutInPetReturn)
	g_eventMgr:fireRemoteEvent(event,player)
end

--宠物的取出
function PetDepotManager:doTakeOutPet(roleID,petID)
	local pet = g_entityMgr:getPet(petID)
	local player = g_entityMgr:getPlayerByID(roleID)
	if not player then
		return
	end

	if not pet then
		return
	end
	
	pet:setPetStatus(PetStatus.Rest)
	pet:flushPropBatch(player)

	local event = Event.getEvent(PetDepotEvent_SC_TakeOutPetReturn)
	g_eventMgr:fireRemoteEvent(event,player)
end


--玩家上线处理
function PetDepotManager:playerCheckIn(player,record)
	--更新数据到服务器handler
	local depotHandler = player:getHandler(HandlerDef_PetDepot)
	depotHandler:setCapacity(record.petDepotCapacity)

	--更新数据到客户端
	local event = Event.getEvent(PetDepotEvent_SC_SendDataToClient,depotHandler:getCapacity())
	g_eventMgr:fireRemoteEvent(event,player)
end

function PetDepotManager.getInstance()
	return PetDepotManager()
end

