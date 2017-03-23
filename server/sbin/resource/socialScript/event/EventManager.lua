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

-- 发送服务器内部事件
function EventManager:fireEvent(event)
	local id = event:getID()
	local list = self._eventListeners[id]
	for _, v in pairs(list or table.empty) do
		v:action(event)
	end
	FreeEvent(event)
end

-- 发送事件到远程客户端
function EventManager:fireRemoteEvent(event, player)
	RemoteEventProxy.send(event, player)
	FreeEvent(event)
end

-- 发送事件到另一个服务器
function EventManager:fireWorldsEvent(event, worldID)
	RemoteEventProxy.sendToWorld(event, worldID)
	FreeEvent(event)
end

-- 发送事件到管理服
function EventManager:fireAdminEvent(event)
	RemoteEventProxy.sendToAdmin(event)
	FreeEvent(event)
end

-- 全服广播
function EventManager:broadcastEvent(event,worldID)
	RemoteEventProxy.broadcast(event,worldID)
	FreeEvent(event)
end

-- 发送事件给周围玩家
function EventManager:fireAroundEvent(event,player)
	RemoteEventProxy.sendToAround(event,player)
	FreeEvent(event)
end

function EventManager.getInstance()
	return EventManager()
end
