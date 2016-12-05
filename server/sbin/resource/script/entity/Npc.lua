--[[Npc.lua
描述：
	NPC类
--]]

require "base.base"
require "entity.Entity"

Npc = class(Entity)

function Npc:__init()
	self._dbID = nil
	self.showParts = "{1,1}"
end

function Npc:__release()
	self._dbID = nil
	self.showParts = nil
end

function Npc:setDBID(dbID)
	self._dbID = dbID
end

function Npc:getDBID()
	return self._dbID
end

function Npc:getID()
	return  self._id or self._dbID
end

function Npc:setShowParts(parts)
	self.showParts = parts
	setPropValue(self._peer,UINT_SHOWPARTS, showParts)
end

function Npc:getShowParts()
	return self.showParts
end