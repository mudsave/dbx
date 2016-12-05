--[[Ride.lua
描述：
	坐骑类
--]]

Ride = class()

function Ride:__init(configID,guid)
	self.owner = nil
	self.ID = configID
	self.guid = guid
	self.movespeed = nil
	self.completeness = 0
	self.vigor = 0
	self._isFollow = false
	self.ridingTime = 0
	self.hpValue = nil
	self.mpValue = nil
end

function Ride:__release()
	self.owner = nil
	self.ID = nil
	self.guid = nil
	self.movespeed = nil
	self.completeness = nil
	self.vigor = nil
	self._isFollow = nil
	self.ridingTime = nil
	self.hpValue = nil
	self.mpValue = nil
end

function Ride:setOwner(player)
	self.owner = player
end

function Ride:getOwner()
	return self.owner
end

function Ride:setGuid(guid)
	self.guid = guid
end

function Ride:getGuid()
	return self.guid
end

function Ride:setID(ID)
	self.ID = ID
end

function Ride:getID()
	return self.ID
end

function Ride:setVigor(vigor)
	self.vigor = vigor
end

function Ride:getVigor()
	return self.vigor
end

function Ride:setCompleteness(completeness)
	self.completeness = completeness
end

function Ride:getCompleteness()
	return self.completeness
end

function Ride:isFollow()
	return self._isFollow
end

function Ride:setFollow(flag)
	self._isFollow = flag
end

function Ride:setChangeAttr(attrType,addValue)
	if attrType == player_hp then
		self.hpValue = addValue
	else
		self.mpValue = addValue
	end
end

function Ride:getChangeAttr(attrType)
	if attrType == player_hp then
		return self.hpValue
	else
		return self.mpValue
	end
end

--用于检测是否到10分钟
function Ride:setRidingTime(time)
	self.ridingTime = time
end

function Ride:getRidingTime()
	return self.ridingTime
end