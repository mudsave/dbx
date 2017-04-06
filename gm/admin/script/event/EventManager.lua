--[[EventManager.lua
描述：
	Event注册和分发
--]]

require "base.base"
require "event.Event"

EventManager = class(nil, Singleton)

function EventManager:__init()
	self._eventListeners = {}
end

function EventManager:addEventListener(listener)
	local ids = listener:getEventsID()
	for _, id in pairs(ids) do
		self._eventListeners[id] = self._eventListeners[id] or {}
		table.insert(self._eventListeners[id], listener)
	end
end

function EventManager:removeEventListener(listener)
	local ids = listener:getEventsID()
	for _, id in pairs(ids) do
		table.removeValue(self._eventListeners[id], listener)
	end
end

function EventManager:fireEvent(event)
	local id = event:getID()
	local list = self._eventListeners[id]
	for _, v in pairs(list or table.empty) do
		v:action(event)
	end
end

function EventManager.getInstance()
	return EventManager()
end
