--[[TransportationSystem.lua

    Author: Caesar
    Function: handle the transportion of position

]]

TransportationSystem = class(EventSetDoer, Singleton)

function TransportationSystem:__init()
	self._doer = 
	{
		[TransportEvent_CS_UpdateFlyFlagPositionList] 	= TransportationSystem.onUpdateFlyFlagPositionList,
		[TransportEvent_CS_UpdateFlyFlagNum] 			= TransportationSystem.onUpdateFlyFlagNum,
		[TransportEvent_CS_CheckCanTransport]			= TransportationSystem.onCheckCanTransport,
	}
end

function TransportationSystem:onUpdateFlyFlagPositionList( event )

	local params = event:getParams()
	local playerDBID = params[1]
	local flyFlagPositionList = params[2]
	local player = g_entityMgr:getPlayerByDBID(playerDBID)
	if player then
		local transportationHandler = player:getHandler(HandlerDef_Transportation)
		transportationHandler:setFlyFlagPositionList(flyFlagPositionList)
		if type(flyFlagPositionList) == "table" then
			flyFlagPositionList = serialize(flyFlagPositionList)
			if type(flyFlagPositionList) == "string" then
				LuaDBAccess.UpdateWorldServerData(player:getDBID(),"flyFlagPositionList",flyFlagPositionList,0)
			end
		end
	end
end

function TransportationSystem:onUpdateFlyFlagNum( event )

	local peerHandle = event.peerHandle
	if not peerHandle then
		return
	end
	local player = g_playerMgr:getPlayerByPeerhandle(peerHandle)
	if not player then
		return
	end

	local params = event:getParams()
	local itemGuid = params[1]
	local item = g_itemMgr:getItem(itemGuid)
	local num = item:getEffect()
	if num <= 1 then
		item:setEffect(num - 1)
		local packetHandler = player:getHandler(HandlerDef_Packet)
		packetHandler:removeItem(itemGuid, 1)
	else
		item:setEffect(num - 1)
		item:getPack():updateItemsToClient(item)
	end
	

end


function TransportationSystem:onCheckCanTransport( event )

	local params = event:getParams()
	local playerID = params[1]
	local transportionKind = params[2]
	local positionInfo = params[3]
	local extraInfo = params[4]
	local mapID = positionInfo.mapID
	local x = positionInfo.x
	local y = positionInfo.y
	local player = g_entityMgr:getPlayerByID(playerID)
	if player then
		if CoScene:PosValidate(mapID,x,y) then

			g_sceneMgr:doSwitchScence(player:getID(),mapID,x,y)

			if transportionKind == TransportionKind.FlyFlag then

				local itemGuid = extraInfo.itemGuid
				local memberList = extraInfo.memberList
				--????????????????????????????????????
				if memberList then
					print("????????????????????????>>>>>>>",toString(memberList))
					for index,memberInfo in pairs(memberList) do
						if memberInfo ~= playerID then
							print("????????????????????????????????????>>>>>>>>>>>>>>>>>")
							g_sceneMgr:doSwitchScence(memberInfo.memberID,mapID,x,y)
						end
					end
				end

				local item = g_itemMgr:getItem(itemGuid)
				local num = item:getEffect()

				--??????????????????
				if num <= 1 then
					item:setEffect(num - 1)
					local packetHandler = player:getHandler(HandlerDef_Packet)
					packetHandler:removeItem(itemGuid, 1)
				else
					item:setEffect(num - 1)
					item:getPack():updateItemsToClient(item)
				end

			elseif transportionKind == TransportionKind.WorldMapTransportion then

				local itemGuid = extraInfo.itemGuid
				local item = g_itemMgr:getItem(itemGuid)
				local num = item:getEffect()

				--??????????????????
				if num <= 1 then
					item:setEffect(num - 1)
					local packetHandler = player:getHandler(HandlerDef_Packet)
					packetHandler:removeItem(itemGuid, 1)
				else
					item:setEffect(num - 1)
					item:getPack():updateItemsToClient(item)
				end
				
				local memberList = extraInfo.memberList
				--????????????????????????????????????
				if memberList then
					for index,memberInfo in pairs(memberList) do
						if memberInfo ~= playerID then
							g_sceneMgr:doSwitchScence(memberInfo.memberID,mapID,x,y)
						end
					end
				end


			end
			
			local event_Succeed = Event.getEvent(TransportEvent_SC_TransportSucceed,transportionKind,extraInfo)
			g_eventMgr:fireRemoteEvent(event_Succeed,player)

		else
			local msg =""
			local notifyParams = {msg = msg}
			local event_Failed = Event.getEvent(FriendEvent_BC_ShowNotifyInfo,NotifyKind.NormalNotify,notifyParams)
			g_eventMgr:fireRemoteEvent(event_Failed,player)
		end

	end

end


function TransportationSystem.getInstance()
	return TransportationSystem()
end

EventManager.getInstance():addEventListener(TransportationSystem.getInstance())