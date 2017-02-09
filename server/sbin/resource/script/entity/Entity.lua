--[[Entity.lua
描述：
	实体基类
--]]

require "entity.Speed"

Entity = class()

function Entity:__init()
	self._peer			= nil
	self._id			= nil
	self._scene			= nil
	self._handlers		= {}
	self._entityType	= nil
	self._name			= nil
	self._modelID		= nil
	self._showParts		= nil
	self._pos			= {nil,nil,nil}		--mapID,x,y
	self._speed			= Speed(self)
	self._bFighting		= false
	self._prevPos		= {nil,nil,nil} --mapID,x,y玩家在上一张地图的位置
end

function Entity:__release()
	self._id			= nil
	self._scene			= nil
	self._handlers		= nil
	self._entityType	= nil
	self._pos			= nil
	self._speed			= nil
	if self._peer then
		self._peer:release()
		self._peer		= nil
	end
end

function Entity:setPeer(peer)
	self._peer = peer
	if peer then
		self:setID(peer:getHandle())
	end
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

function Entity:getPos()
	local pos = self._peer:getPosition()
	self._pos[2] = pos.x
	self._pos[3] = pos.y
	return self._pos
end

function Entity:setPos(posInfo)
	self._pos = posInfo
end

function Entity:getPrevPos()
	
	return self._prevPos
end

function Entity:setEntityType(entityType)
	self._entityType = entityType
end

function Entity:setName(name)
	self._name = name or ""
	setPropValue(self._peer,UNIT_NAME,name or "")
end

function Entity:getName()
	return self._name
end

function Entity:setModelID(id)
	self._modelID = id
	setPropValue(self._peer,UNIT_MODEL,id)
end

function Entity:getModelID()
	return self._modelID
end

function Entity:setShowParts(sp)
	self._showParts = sp
	setPropValue(self._peer,UNIT_SHOWPARTS,sp)
end

function Entity:getShowParts()
	return self._showParts
end

function Entity:setStatus(status)
	if self.status == status then
		return
	end
	self.status = status
	if self._peer then
		setPropValue(self._peer, UNIT_STATUS, status)
	end
end

function Entity:getStatus()
	if not self.status then
		if self._peer then
			self.status = getPropValue(self._peer, UNIT_STATUS)
		end
	end
	return self.status
end

function Entity:getMoveSpeed()
	return self._speed:GetSpeed()
end

function Entity:getSelfSpeed()
	return self._speed:GetSelfSpeed()
end

function Entity:getOriginalSpeed()
	return self._speed:GetOriginalSpeed()
end

function Entity:setMoveSpeed(value)
	self._speed:SetSpeed(value)
end

function Entity:changeMoveSpeed(value)
	self._speed:ChangeMoveSpeed(value)
end

function Entity:setTeamSpeed(value)
	self._speed:SetTeamSpeed(value)
end

function Entity:setFighting(flag)
	self._bFighting = flag
end

function Entity:isFighting()
	return self._bFighting 
end
