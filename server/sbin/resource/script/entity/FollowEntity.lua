--[[FollowEntity.lua
描述：
	跟随实体类
--]]

FollowEntity = class(Entity)

function FollowEntity:__init()
	self._dbID = nil
	self.speed = nil
	self.modelID = nil
	self.name = nil
	self.taskType = nil
end

function FollowEntity:__release()
	--todo
	self._dbID = nil
	self.speed = nil
	self.modelID = nil
	self.name = nil
	self.taskType = nil
end

function FollowEntity:setDBID(dbID)
	self._dbID = dbID
end

function FollowEntity:getDBID()
	return self._dbID
end

--获取移动速度
function FollowEntity:setSpeed(speed)
	self.speed = speed
	setPropValue(self._peer, UINT_MOVE_SPEED, speed)
end

--获取移动速度
function FollowEntity:getSpeed()
	return self.speed
end

--获取移动速度
function FollowEntity:setName(name)
	self.name = name
	setPropValue(self._peer, UINT_NAME, name)
end

function FollowEntity:getName()
	return self.name
end

function FollowEntity:setModelID(modelID)
	self.modelID = modelID
	setPropValue(self._peer,UINT_MODEL,modelID)
end

function FollowEntity:getModelID()
	return self.modelID
end

function FollowEntity:setTaskType(taskType)
	self.taskType = taskType
end

function FollowEntity:getTaskType()
	return self.taskType
end