--[[rpc.lua
描述：
	远程事件收发
--]]

RPC = {}

-- 发送到对端
function RPC.send(event)
	if not event then return end
	local eventID	= event:getID()
	local params	= event:getParams()
	if not eventID then return end
	RPCEngine:sendToWorld(eventID, 0, unpack(params))
end

-- 接收消息
function RPC.receive(eventID, srcID, ...)
	local event = Event(eventID, ... )
	--print("RPC.receive:", eventID, srcID, ...)
	g_eventMgr:fireEvent(event)
end

-- 调试用
function RPC.debug(msg)
    print ("[RPC ERROR] -- " .. msg)
	print (debug.traceback())
    return 0
end
