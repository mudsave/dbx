--[[TestSystem.lua
描述:用于测试系统性能
]]

TestSystem = class(EventSetDoer, Singleton)

function TestSystem:__init()
	self._doer = 
	{
		[FrameEvents_CS_Ping]			= TestSystem.onPingReturn,
	} 
end

function TestSystem:__release()
end

function TestSystem:onPingReturn(event)
	-- print("FrameEvents_CS_Ping-------------------------------------->")
	local start = getLuaTick()
	local params = event:getParams()
	local playerID = event.playerID
	
	if not playerID then
		return 
	end
	local player = g_entityMgr:getPlayerByID(playerID)
	if not player then
		return
	end
	-- 返回消息
	g_eventMgr:fireRemoteEvent(
	Event.getEvent(
		FrameEvents_SC_Ping
		),
		player
	)
	print("ping time=",getLuaTick()-start)
end

function TestSystem.getInstance()
	return TestSystem()
end

EventManager.getInstance():addEventListener(TestSystem.getInstance())