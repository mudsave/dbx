--[[Entity.lua
描述：
	实体基类
--]]

Entity = class()

function Entity:__init()
end

function Entity:__release()
end

function Entity:getID()
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