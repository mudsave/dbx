--[[FrameSystem.lua
描述：
	客户端心跳消息
--]]

FrameSystem = class(EventSetDoer, Singleton)

function FrameSystem:__init()
	self._doer = {
		[FrameEvents_CS_playerHeartBeat]			= FrameSystem.onPlayerHeartBeat,
	}
end

--玩家心跳
function FrameSystem:onPlayerHeartBeat(event)
	local playerID = event.playerID
	if not playerID then
		return
	end
	g_playerMgr:doPlayerHeartBeat(playerID)
end

function FrameSystem.getInstance()
	return FrameSystem()
end

g_eventMgr:addEventListener(FrameSystem.getInstance())
