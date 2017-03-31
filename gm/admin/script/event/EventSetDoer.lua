--[[EventSetDoer.lua
描述：
	业务系统继承的父类，提供监听功能
--]]

require "base.base"

EventSetDoer = class()

function EventSetDoer:__init()
	self._doer = {}
end

function EventSetDoer:getEventsID()
	local eventSet = {}
	for i, _ in pairs(self._doer) do
		table.insert(eventSet, i)
	end
	return eventSet
end

function EventSetDoer:action(event)
	local id = event:getID()
	local doer = self._doer[id]
	if doer then
		doer(self, event)
	else
		print("[LUA ERROR:]EventSetDoer:action，no doer")
	end
end