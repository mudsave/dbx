--[[Event.lua
描述：
	脚本事件
--]]

local rawget = rawget
local rawset = rawset

require "base.base"

Event = class()

function Event:__init(id, ...)
	self._id		= id
	self._params	= arg
	self._free		= false
	self._next		= false
	self._auto		= true
end

function Event:release()
	self._params	= false
	self._free		= true
	self._auto		= true
end

function Event:getID()
	return self._id
end

function Event:getParams()
	return self._params
end

function Event:setParams(...)
	self._free = false
	self._params = arg
end

function Event:isAutoRelease()
	return self._auto
end

function Event.getEvent(id, ...)
	local head = rawget(Event,id)
	local event = head
	while event and not event._free do 
		event = event._next
	end
	if not event then
		event = Event(id,...)
		event._next = head
		rawset(Event,id,event)
	else
		event:setParams(...)
	end
 	return event
end

function Event.createEvent(id,...)
	local event = Event.getEvent(id,...)
	event._auto = false
	return event
end

function Event.getStates(id)
	if id then
		local free,busy = 0,0
		local event = rawget(Event,id)
		while event do
			if event._free then
				free = free + 1
			else
				busy = busy + 1
			end
			event = event._next
		end
		return free,busy
	else
		local ret = {}
		for id,event in pairs(Event) do
			if type(id) == "number" and getmetatable(event) == Event then
				local free,busy = 0,0
				while event do
					if event._free then
						free = free + 1
					else
						busy = busy + 1
					end
				end
				ret[id] = {free,busy}
			end
		end
		return ret
	end
end

local function module_test()
	for i = 1,1000 do
		Event.getEvent(-1)
	end
	print("event for id -1",Event.getStates(-1))

	for i = 1,1000 do
		Event.getEvent(-2):release()
	end
	print("event for id -1",Event.getStates(-2))
end
