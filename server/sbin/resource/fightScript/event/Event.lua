--[[Event.lua
描述：
	脚本事件
--]]

local rawget = rawget
local rawset = rawset
local select = select

local function varg(...)
	return {
		n = select('#',...),
		...
	}
end

require "base.base"

Event = class()

function Event:__init(id, ...)
	self._id		= id
	self._params	= varg(...)
	self._next		= false

	self.auto_free	= true
end

function Event:release()
	local id = self:getID()
	self._next = rawget(Event,id)
	rawset(Event,id,self)

	self.auto_free	= true
end

function Event:getID()
	return self._id
end

function Event:getParams()
	return self._params
end

function Event:setParams(...)
	self._params = varg(...)
end

local function GetEvent(id,...)
	local event = rawget(Event,id)
	if event then
		event:setParams(...)
		rawset(Event,id,event._next)
		event._next = false
	else
		event = Event(id,...)
		Event.events = Event.events + 1
	end
	return event
end

function Event.getEvent(id, ...)
	local event = GetEvent(id,...)
	event.auto_free = true
	return event
end

function Event.createEvent(id,...)
	local event = GetEvent(id,...)
	event.auto_free = false
	return event
end

function FreeEvent(event)
	if event.auto_free then
		event:release()
	end
end

Event.events = 0
