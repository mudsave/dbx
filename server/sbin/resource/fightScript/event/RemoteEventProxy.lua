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
	RPCEngine:sendToPeer(player:getGateID(), player:getClientLink(), eventID, g_serverId, unpack(params))
end

-- 发世界消息
function RemoteEventProxy.sendToWorld(event, worldID)
	if not event then return end
	local eventID	= event:getID()
	local params	= event:getParams()
	if not eventID then return end
	RPCEngine:sendToWorld(worldID, eventID, g_serverId, unpack(params))
end

-- 接收消息
function RemoteEventProxy.receive(eventID, playerID, ...)
	if ManagedApp.State ~= ServerState.run then
		return
	end
	local event = Event(eventID, ... )
	event.DBID = playerID
	g_eventMgr:fireEvent(event)
end

-- 接收世界消息
function RemoteEventProxy.wreceive(eventID, srcWorldID, ...)
	if ManagedApp.State ~= ServerState.run then
		return
	end
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

-- 发送给运维工具后端
function RemoteEventProxy.sendToAdmin(event)
	if not event then return end
	local eventID	= event:getID()
	local params	= event:getParams()
	if not eventID then return end
	RPCEngine:sendToAdmin(eventID, 0, unpack(params))
end

-- 接收运维工具后端的消息
function RemoteEventProxy.areceive(eventID, srcID, ...)
	-- print ("Admin rpc:", eventID, srcID, ...)
	local event = Event(eventID, ...)
	g_eventMgr:fireEvent(event)
end
