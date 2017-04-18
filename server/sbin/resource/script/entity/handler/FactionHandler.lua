--[[FactionHandler.lua

	Function: Save the personal data of faction 
    Author: Caesar
]]

FactionHandler = class()

function FactionHandler:__init(entity)

	self.entity = entity
    self._factionLevel = 0
	

end

function FactionHandler:__release()

    self._factionLevel = nil
end

function FactionHandler:setFactionLevel( level )
    self._factionLevel = level
    
end

function FactionHandler:getFactionLevel(  )
    return self._factionLevel
end

