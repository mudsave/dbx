--[[ActivitySystem.lua
	描述:活动系统和客户端的信息交换
]]


require "game.ActivitySystem.Activity"
require "game.ActivitySystem.ActivityTarget"
require "game.ActivitySystem.ActivityCallBack"
require "game.ActivitySystem.ActivityManager"

ActivitySystem = class(EventSetDoer, Singleton)

function ActivitySystem:__init()
	self._doer =
	{
		
	}
end

function ActivitySystem:__release()

end

-- 活动更新按钮
function ActivitySystem:notifyActivityPageUpdateBtn(player,activityId,isOpen)
	local event = Event.getEvent(ActivityEvent_SC_notifyActivityPageUpdateBtn,activityId,isOpen)
	g_eventMgr:fireRemoteEvent(event, player)
end

function ActivitySystem.getInstance()
	return ActivitySystem()
end

EventManager.getInstance():addEventListener(ActivitySystem.getInstance())





