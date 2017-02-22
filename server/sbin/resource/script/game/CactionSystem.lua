--[[CactionSystem.lua
描述：
	服务器对于客户端功能性统一处理
--]]

CactionSystem = class(EventSetDoer, Singleton)

function CactionSystem:__init()
	
end

function CactionSystem:doOpenUI(player, param)
	local event = Event.getEvent(CactionEvent_SC_OpenUI, param)
	g_eventMgr:fireRemoteEvent(event, player)
end

function CactionSystem:doAutoTrace(player, param)
	local event = Event.getEvent(CactionEvent_SC_AutoTrace, param)
	g_eventMgr:fireRemoteEvent(event, player)
end

function CactionSystem:doAutoMeet(player, nRad)
	local event = Event.getEvent(CactionEvent_SC_AutoMeet, nRad or 20)
	g_eventMgr:fireRemoteEvent(event, player)
end

function CactionSystem:doStopAutoMeet(player, nRad)
	local event = Event.getEvent(CactionEvent_SC_StopAutoMeet)
	g_eventMgr:fireRemoteEvent(event, player)
end

function CactionSystem:doFlyEffect(player, flyEffectID)
	local event = Event.getEvent(CactionEvent_SC_FlyEffect, flyEffectID)
	g_eventMgr:fireRemoteEvent(event, player)
end

function CactionSystem:doOpenUITip(player, param)
	local event = Event.getEvent(CactionEvent_SC_OpenUITip, param)
	g_eventMgr:fireRemoteEvent(event, player)
end

function CactionSystem:doPlayAnimation(player, param)
	local event = Event.getEvent(CactionEvent_SC_PlayAnimation, param.playID, param.sceneID)
	g_eventMgr:fireRemoteEvent(event, player)
end

function CactionSystem.getInstance()
	return CactionSystem()
end

g_eventMgr:addEventListener(CactionSystem.getInstance())