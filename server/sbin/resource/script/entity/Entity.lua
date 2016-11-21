--[[Entity.lua
描述：
	实体基类
--]]

Entity = class()

function Entity:__init()
	self._peer = nil
	self._id = nil
	self._scene = nil
	self._handlers = {}
	self._entityType = nil
end

function Entity:__release()
	self._peer = nil
	self._id = nil
	self._scene = nil
	self._handlers = {}
	self._entityType = nil
end

function Entity:setPeer(peer)
	self._peer = peer
end

function Entity:getPeer()
	return self._peer 
end

function Entity:setID(id)
	self._id = id
end

function Entity:getID()
	return self._id
end

function Entity:setScene(scene)
	self._scene = scene
end

function Entity:getScene()
	return self._scene
end

function Entity:addHandler(hType, handler)
	self._handlers[hType] = handler
end

function Entity:removeHandler(hType)
	self._handlers[hType] = nil
end

function Entity:getHandler(hType)
	return self._handlers[hType]
end

function Entity:getEntityType()
	return self._entityType
end

function Entity:setEntityType(entityType)
	self._entityType = entityType
end