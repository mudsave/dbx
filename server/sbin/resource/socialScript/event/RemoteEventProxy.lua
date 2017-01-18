--[[RemoteEventProxy.lua
描述：
	远程事件收发
--]]

RemoteEventProxy = {}

-- 发送到对端
function RemoteEventProxy.send(event, player)
	if not event then return end
	local eventID	= event:getID()
	local params	= event:getParams()
	if not eventID then return end
	RPCEngine:sendToPeer(player:getGatewayId(), player:getClientLink(), eventID, g_serverId, unpack(params))
end

-- 发世界消息
function RemoteEventProxy.sendToWorld(event, worldID)
	if not event then return end
	local eventID	= event:getID()
	local params	= event:getParams()
	if not eventID then return end
	RPCEngine:sendToWorld(worldID, eventID, g_serverId, unpack(params))
end

-- 在某个world中广播
function RemoteEventProxy.broadcast(event, worldID)--设置为0，则会发送广播到整个世界的玩家中，不设置，则会发送到所有世界中的玩家中
	if not event then return end
	local eventID	= event:getID()
	local params	= event:getParams()
	if not eventID then return end
	worldID = worldID or -1
	print("worldID>>",worldID, eventID, g_serverId)
	RPCEngine:bcToWorldPeers(worldID, eventID, g_serverId, unpack(params))
end


-- 接收消息
function RemoteEventProxy.receive(eventID, playerID, ...)
	local event = Event(eventID, ... )
	event.playerID = playerID
	g_eventMgr:fireEvent(event)
end

-- 接收世界消息
function RemoteEventProxy.wreceive(eventID, srcWorldID, ...)
	local event = Event(eventID, ... )
	event.srcWorldID = srcWorldID
	g_eventMgr:fireEvent(event)
end

-- 调试用
function RemoteEventProxy.debug(msg)
    print ("[RPC ERROR] -- " .. msg)
	print (debug.traceback())
    return 0
end
