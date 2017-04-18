--[[AdminManager.lua
]]


AdminManager = class(Singleton, Timer)

function AdminManager:__init()
	
end

function AdminManager:__release()
end


local TimerList = {}

-- 定时器应该做的事
local TimerState = 
{
	First	= 1,	--执行
}


-- 公告
function AdminManager:onBroadcast(info,period,times)
	if period then
		period = tonumber(period)
	end
	if times then
		times = tonumber(times)
	end
	if info then
		info = string.utf8ToGbk(info)
	end
	if not period or period == 0 then
		if g_serverId == 0 then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GMBroadCast,1,info)
			g_eventMgr:broadcastEvent(event)
		end
	else
		local timerInfo = {}
		local timerID = g_timerMgr:regTimer(self, period*60*1000, period*60*1000, "AdminManager.onBroadcast")
		timerInfo.TimerState = TimerState.First
		timerInfo.times = times
		timerInfo.info = info
		TimerList[timerID] = timerInfo
	end
end

function AdminManager:onBroadcastTimer(timerID,timerInfo)
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GMBroadCast,1,timerInfo.info)
		g_eventMgr:broadcastEvent(event)
	end
	if timerInfo.times then
		if timerInfo.times < 0 then
			g_timerMgr:unRegTimer(timerID)
		else
			timerInfo.times = timerInfo.times - 1
		end
	else
		g_timerMgr:unRegTimer(timerID)
	end
end

local timerFun = 
{
	[TimerState.First] = AdminManager.onBroadcastTimer,
}

function AdminManager:update(timerID)
	if TimerList[timerID] then
		local timerInfo = TimerList[timerID]
		local funName = timerFun[timerInfo.TimerState]
		if funName then
			funName(self,timerID,timerInfo)
		end
	end
end

function AdminManager.getInstence()
	return AdminManager()
end

g_adminMgr = AdminManager.getInstence()