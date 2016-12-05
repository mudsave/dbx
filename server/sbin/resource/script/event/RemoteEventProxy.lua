--[[RemoteEventProxy.lua
描述：
	远程事件收发
--]]

RemoteEventProxy = {}

-- 发送到对端
function RemoteEventProxy.send(event, playerID)
	if not event then return end
	local eventID	= event:getID()
	local params	= event:getParams()
	if not eventID then return end

	RPCEngine:sendToPeer(playerID, eventID, g_serverId, unpack(params))
end

-- 发世界消息
function RemoteEventProxy.sendToWorld(event, worldID)
	if not event then return end
	local eventID	= event:getID()
	local params	= event:getParams()
	if not eventID then return end
	RPCEngine:sendToWorld(worldID, eventID, g_serverId, unpack(params))
end

-- 在当前world广播
function RemoteEventProxy.broadcast(event)
end

-- 发送给视野内所有的玩家
function RemoteEventProxy.sendToAround(event, playerID)
end

-- 接收消息
function RemoteEventProxy.receive(eventID, playerID, ...)
	local event = Event(eventID, ... )
	event.playerID = playerID
	g_eventMgr:fireEvent(event)
end

-- 接收世界消息
function RemoteEventProxy.wreceive(eventID, sourceID, ...)
end
