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

function ActivitySystem.getInstance()
	return ActivitySystem()
end

EventManager.getInstance():addEventListener(ActivitySystem.getInstance())





