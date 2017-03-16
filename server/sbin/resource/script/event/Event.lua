--[[Event.lua
描述：
	脚本事件
--]]

require "base.base"

Event = class()
local eventPool ={}
function Event:__init(id, ...)
	self._id = id
	self._params = arg
end

function Event:__release()
	self._id = nil
	self._params = nil
end

function Event:getID()
	return self._id
end

function Event:getParams()
	return self._params
end

function Event:setID(id)
	 self._id = id
end

function Event:setParams(...)
	 self._params = arg
end

function Event.getEvent(id, ...)
	local event = eventPool[id]
	if not event then
		event = Event(id, ...)
		eventPool[id] = event
	else
		event:setID(id)
		event:setParams(...)
	end
 	return event
end