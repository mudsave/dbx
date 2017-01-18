--[[EctypeObject.lua
	副本物件
--]]
require "base.base"
require "entity.Entity"

EctypeObject = class(Entity)

function EctypeObject:__init()
	self._dbID = nil
end

function EctypeObject:__release()
	self._dbID = nil
end

function EctypeObject:setDBID(dbID)
	self._dbID = dbID
end

function EctypeObject:getDBID()
	return self._dbID
end

function Npc:getID()
	return  self._id or self._dbID
end
