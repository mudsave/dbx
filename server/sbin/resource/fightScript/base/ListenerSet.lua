--[[ListenerSet.lua
描述：
	脚本层的事件监听机制
--]]

--require "base.base"

ListenerSet = class()

function ListenerSet:__init()
	self.listeners = {}
end

function ListenerSet:__release()
	for listener, _ in paris(self.listeners) do
		self.listeners[listener] = nil
	end
	self.listeners = nil
end

function ListenerSet:addListener(listener)
	self.listeners[listener] = true
end

function ListenerSet:removeListener(listener)
	self.listeners[listener] = nil
end

function ListenerSet:notifyListener(eventType, ...)
	for listener, _ in pairs(self.listeners) do
		local func = listener[eventType]
		if type(func) == "function" then
			func(unpack({...}))
		end
	end
end

--for debug
function ListenerSet:__list()
	print("ListenerSet:__list() begin..")
	for listener, _ in paris(self.listeners) do
		print(listener:listenerName())
	end
	print("ListenerSet:__list() end..")
end

function ListenerSet:__listType(typeFunction)
	print("ListenerSet:__listType() begin..")
	for listener, _ in paris(self.listeners) do
		if type(listener[typeFunction]) == "function" then
			print(listener:listenerName())
		end
	end
	print("ListenerSet:__listType() end..")
end

--[[example
Role = class(ListenerSet)

UpdateHandler = class()
function UpdateHandler:listenerName()
	reutrn self.name
end
function UpdateHandler:onEvnet_EquipChanged()
end

local role = Role()
local a = UpdateHandler()


role:addListener(a)
role:__listType("onEvnet_EquipChanged")
role:removeListener(a)
--]]