--[[RideManager.lua
描述:
	坐骑管理类
]]

RideManager = class(nil, Singleton)

function RideManager:__init()

end

--添加坐骑
function RideManager:addRide(player, configID)
	local rideHandler = player:getHandler(HandlerDef_Ride)
	local rideCount = rideHandler:getRideCount()
	if rideCount >= rideHandler:getRideCapacity() and rideCount ~= 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Ride, RideMessageID.RideBarDeficiency)
		g_eventMgr:fireRemoteEvent(event, player)
		return 1
	else
		if rideCount <= 0 then
			--去开启坐骑包裹。
			local packetHandler = player:getHandler(HandlerDef_Packet)
			packetHandler:updateHorsePack(true)
		end
		local rideInfo = RideDB[configID]
		if not rideInfo then
			return
		end
		local guid = createGUID(Ride)
		local ride = Ride(configID,guid)
		ride:setVigor(rideInfo.vigor)
		ride:setFollow(false)
		ride:setOwner(player)
		rideHandler:addRide(ride)
		local event = Event.getEvent(RideEvent_SC_AddRide, configID,guid)
		g_eventMgr:fireRemoteEvent(event, player)
		return 2
	end
end

--上下坐骑
function RideManager:UpOrDownRide(player,guid)
	local rideHandler = player:getHandler(HandlerDef_Ride)
	rideHandler:UpOrDownRide(guid)
end

local function successRate(level,sLevel)
	local rate = 1/3
	for i = level,sLevel,-1 do
		if i == 1 and level ~= 1 then
			rate = rate*0.8
		else
			rate = rate * RideGrowToSuccess[i]
		end
	end
	return rate
end

--坐骑进阶
function RideManager:rideGrowUp(player,guid,sGuidList)
	local kind,level = 0
	local ride
	local rideHandler = player:getHandler(HandlerDef_Ride)
	if guid then
		ride = rideHandler:getRide(guid)
		if ride then
			local rideID = ride:getID()
			local config = RideDB[rideID]
			kind = config.kind
			level = config.level
			if level >= RideMaxLevel then
				return
			end
		else
			return
		end
	else
		return
	end
	--验证坐骑进阶丹是否足
	local needItemCount = RideGrowToItemCount[level]
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if packetHandler:getNumByItemID(RideGrowUpItem) < needItemCount then
		return
	end
	local totalSuccess = 0
	local completeness = ride:getCompleteness()
	for _,sGuid in pairs(sGuidList) do
		if sGuid then
			local sRide = rideHandler:getRide(sGuid)
			if sRide then
				local rideID = sRide:getID()
				local config = RideDB[rideID]
				local level1 = config.level
				if config.kind ~= kind then
					return
				end
				local successRate = successRate(level,level1)
				totalSuccess = totalSuccess + successRate
				completeness = completeness + successRate*RideGrowToSuccess[level1]
				rideHandler:removeRide(sGuid)
			end
		end
	end
	packetHandler:removeByItemId(RideGrowUpItem,needItemCount)
	local rate = math.random(0,1000)/1000
	if rate <= totalSuccess or completeness >= 1 then
		local rideID = ride:getID()
		local growUpID = RideDB[rideID].growUpID
		local config = RideDB[growUpID]
		ride:setID(growUpID)
		ride:setVigor(config.vigor)
		ride:setCompleteness(0)
		local event = Event.getEvent(RideEvent_SC_GrowUp,true,guid,sGuidList,growUpID)
		g_eventMgr:fireRemoteEvent(event,player)
	else
		ride:setCompleteness(completeness)
		local event = Event.getEvent(RideEvent_SC_GrowUp,false,guid,sGuidList,completeness*10000)
		g_eventMgr:fireRemoteEvent(event,player)
	end
end

--坐骑回笼
function RideManager:rideToItem(player,rideGuid)
	local rideHandler = player:getHandler(HandlerDef_Ride)
	local ride = rideHandler:getRide(rideGuid)
	local rideID = ride:getID()
	if ride:getVigor() < RideDB[rideID].vigor then
		print("体力值不满")
		return
	end
	local packetHandler = player:getHandler(HandlerDef_Packet)
	if packetHandler:getNumByItemID(RideToItem) < 1 then
		print("包裹格子小于1")
		return
	end
	local itemID = RideDB[rideID].matID
	if not packetHandler:canAddPacket(itemID, 1, false) then
		print("有没有配置物品ID")
		return
	end
	if packetHandler:addItemsToPacket(itemID,1) then
		rideHandler:removeRide(rideGuid)
		if rideHandler:getRideCount() <= 0 then
			packetHandler:updateHorsePack(false)
		end
		packetHandler:removeByItemId(RideToItem,1)
		local event = Event.getEvent(RideEvent_SC_RideToItem,rideGuid)
		g_eventMgr:fireRemoteEvent(event,player)
	else
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Ride, RideMessageID.RideToItemFailure)
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

--扩充坐骑栏
function RideManager:expandRideBar(playerID)
	local player = g_entityMgr:getPlayerByID(playerID)
	local rideHandler = player:getHandler(HandlerDef_Ride)
	local rideCapacity = rideHandler:getRideCapacity()
	if rideCapacity >= RideMaxCapacity then
		return
	end
	local packetHandler = player:getHandler(HandlerDef_Packet)
	local needItemCount = (rideCapacity-RideDefaultCapacity+1)*2
	local itemCount = packetHandler:getNumByItemID(ExpandRideBarItem)
	if needItemCount > itemCount then
		return
	end
	packetHandler:removeByItemId(ExpandRideBarItem,needItemCount)
	rideHandler:setRideCapacity(rideCapacity+ExpandRideBarCount)
	local event = Event.getEvent(RideEvent_SC_ExpandRideBar)
	g_eventMgr:fireRemoteEvent(event,player)
end

--从数据库加载坐骑
function RideManager:loadRides(player,ridesRecord)
	if not ridesRecord then
		return
	end
	local rideList = {}
	local rideHandler = player:getHandler(HandlerDef_Ride)
	local ridingRideGuid = nil
	for _,iter in pairs(ridesRecord) do
		local guid = iter.rideGuid
		local configID = iter.configID
		local vigor = iter.vigor
		local completeness = iter.completeness
		local isFollow = iter.isFollow and true or false
		local rideInfo = RideDB[configID]
		if rideInfo then
			local ride = Ride(configID,guid)
			ride:setVigor(vigor)
			ride:setFollow(isFollow)
			ride:setCompleteness(completeness)
			ride:setOwner(player)
			ride:setRidingTime(iter.ridingTime)
			rideHandler:addRide(ride)
			table.insert(rideList,{guid = guid,configID = configID,vigor = vigor,completeness = completeness*10000,isFollow = isFollow,ridingTime = iter.ridingTime})
			if isFollow then
				ridingRideGuid = guid
			end
		end
	end
	if rideHandler:getRideCount() > 0 then
		--去开启坐骑包裹。
		local packetHandler = player:getHandler(HandlerDef_Packet)
		packetHandler:updateHorsePack(true)
	end
	local event = Event.getEvent(RideEvent_SC_LoadRide,rideHandler:getRideCapacity(),rideList)
	g_eventMgr:fireRemoteEvent(event,player)

	if ridingRideGuid then
		rideHandler:UpOrDownRide(ridingRideGuid)
	end
end

--更新数据库坐骑
function RideManager:updateRide(player)
	local handler = player:getHandler(HandlerDef_Ride)
	handler:updateRide()
end

function RideManager:onPlayerCheckOut(player)
	self:updateRide(player)
	local handler = player:getHandler(HandlerDef_Ride)
	local ride = handler:getRidingMount()
	if ride then
		local configID = ride:getID()
		local config = RideDB[configID]
		local attrChange = config.attrChange
		for _,attr in pairs(attrChange) do
			if attr.attrType == player_hp or attr.attrType == player_mp then
				local value = player:getAttrValue(attr.attrType)
				local changeValue = ride:getChangeAttr(attr.attrType)
				player:setAttrValue(attr.attrType, value-changeValue > 0 and value-changeValue or 0)
			end
		end
	end
end

function RideManager.getInstance()
	return RideManager()
end
