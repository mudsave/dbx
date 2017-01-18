--[[ActivityTarget.lua
描述：
	活动目标基类(活动系统)
--]]

ActivityTarget = class()

function ActivityTarget:__init(param)
	
end

function ActivityTarget:__release()
	
end

function ActivityTarget:getActivityId()
	return self._activityId
end

function ActivityTarget:getActivityIndex()
	return self._activityIndex
end

function ActivityTarget:getEntity()
	return self._entity
end

function ActivityTarget:addWatcher(eventName)
	local eventHandler = self._entity:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:addWatcher(eventName, self)
	end	
end

function ActivityTarget:removeWatcher(eventName)
	local eventHandler = self._entity:getHandler(HandlerDef_Event)
	if eventHandler then
		eventHandler:removeWatcher(eventName, self)
	end
end