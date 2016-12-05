--[[MineNpc.lua
描述：
	MineNpc类
--]]

require "base.base"
require "entity.Entity"

MineNpc = class(Entity, nil)

function MineNpc:__init()
	self._dbID = nil
	self.npcType = nil
	self._config = nil
	self.scriptID = 0
	self._movePath = nil
	self._centerTile = nil
	self._radius = nil
	self._period = nil
end

function MineNpc:__release()
	self._dbID = nil
	self._npcType = nil
	self._config = nil
	self._scriptID = 0
	self._movePath = nil
	self._centerTile = nil
	self._radius = nil
	self._period = nil
end

function MineNpc:setDBID(dbID)
	self._dbID = dbID
end

function MineNpc:getDBID()
	return self._dbID
end

function MineNpc:setNpcType(npcType)
	self._npcType = npcType
end

function MineNpc:getNpcType()
	return self._npcType
end

function MineNpc:setConfig(config)
	self._config = config
end

function MineNpc:getConfig()
	return self._config
end

function MineNpc:setScriptID(scriptID)
	self._scriptID = scriptID
end

function MineNpc:getScriptID()
	return self._scriptID
end

function MineNpc:setMovePath(movePath)
	self._movePath = movePath
end

function MineNpc:setCenterTile(centerTile)
	self._centerTile = centerTile
end

function MineNpc:setScriptID(scriptID)
	self.scriptID = scriptID
end

function MineNpc:getScriptID()
	return self.scriptID
end

function MineNpc:setRadius(radius)
	self._radius = radius
end

function MineNpc:getRadius()
	return self._radius
end

function MineNpc:setUpdatePeriod(period)
	self._period = period
end

function MineNpc:getUpdatePeriod()
	return self._period
end