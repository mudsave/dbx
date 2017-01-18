--[[RideHandler.lua
描述：
	实体的坐骑handler
--]]

RideHandler = class(nil, Timer)

function RideHandler:__init(entity)
	self._entity = entity
	self.rideCapacity = RideDefaultCapacity
	self.ridingMount = nil
	self.playerChangeSpeed = nil
	self.rideList = {}
	-- 开启1分钟的定时器，检测坐骑是否体力值为0
	self.checkRideVigorID = g_timerMgr:regTimer(self, 1000*60, 1000*60, "检测坐骑是否体力值为0")
end

function RideHandler:__release()
	self._entity = nil
	self.rideCapacity = nil
	self.rideList = nil
	self.ridingMount = nil
	self.playerChangeSpeed = nil
	-- 删除定时器
	g_timerMgr:unRegTimer(self.checkRideVigorID)
end

-- 定时器回调
function RideHandler:update(timerID)
	if timerID == self.checkRideVigorID then
		local ride = self.ridingMount
		if ride then
			local ridingTime = ride:getRidingTime() + 1
			if ridingTime >= RidingTimeCostVigor then
				ride:setRidingTime(0)
				local vigor = ride:getVigor()-1
				ride:setVigor(vigor)
				if vigor <= 0 then
					g_rideMgr:UpOrDownRide(self._entity)
					local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Ride, RideMessageID.VigorDeficiency)
					g_eventMgr:fireRemoteEvent(event, self._entity)
				end
			else
				ride:setRidingTime(ridingTime)
			end
		end
	end
end

function RideHandler:addRide(ride)
	self.rideList[ride:getGuid()] = ride
end

function RideHandler:getRide(guid)
	return self.rideList[guid]
end

function RideHandler:getRideCount()
	return table.size(self.rideList)
end

--获取坐骑栏容量大小
function RideHandler:getRideCapacity()
	return self.rideCapacity
end

--设置坐骑栏容量大小
function RideHandler:setRideCapacity(rideBar)
	self.rideCapacity = rideBar
end

--跟随坐骑
function RideHandler:getRidingMount()
	return self.ridingMount
end

function RideHandler:setRidingMount(ride)
	self.ridingMount = ride
end

--上坐骑
function RideHandler:UpOrDownRide(rideGuid)
	local ridingRide = self:getRidingMount()
	local ride = self:getRide(rideGuid)
	if ride and ridingRide ~= ride  then
		local vigor = ride:getVigor()
		if vigor <= 0 then
			print("该坐骑体力值不足，无法骑乘。")
			return
		end
		if ridingRide then
			local configID = ridingRide:getID()
			local config = RideDB[configID]
			local attrChange = config.attrChange
			for _,attr in pairs(attrChange) do
				self._entity:addAttrValue(attr.attrType, -attr.attrInc)
			end
			self._entity:changeMoveSpeed(100-config.moveSpeed*100)
			local data = string.format("%d", RideState.Ride_State_None)
			setPropValue(self._entity:getPeer(), PLAYER_RIDE_INFO,data)
			self._entity:flushPropBatch()
			ridingRide:setFollow(false)
			self:setRidingMount(nil)
		end
		ride:setFollow(true)
		self:setRidingMount(ride)
		local configID = ride:getID()
		local config = RideDB[configID]
		local attrChange = config.attrChange
		for _,attr in pairs(attrChange) do
			self._entity:addAttrValue(attr.attrType, attr.attrInc)
		end
		self._entity:changeMoveSpeed(config.moveSpeed*100-100)
		local data = string.format("%d,%d,%s", RideState.Ride_State_Ride,configID,ride:getGuid())
		setPropValue(self._entity:getPeer(), PLAYER_RIDE_INFO,data)
		self._entity:flushPropBatch()

		TaskCallBack.onUpRide(self._entity, configID)
		--return true
	elseif ridingRide then
		local configID = ridingRide:getID()
		local config = RideDB[configID]
		local attrChange = config.attrChange
		for _,attr in pairs(attrChange) do
			self._entity:addAttrValue(attr.attrType, -attr.attrInc)
		end
		self._entity:changeMoveSpeed(100-config.moveSpeed*100)
		local data = string.format("%d", RideState.Ride_State_None)
		setPropValue(self._entity:getPeer(), PLAYER_RIDE_INFO,data)
		self._entity:flushPropBatch()
		ridingRide:setFollow(false)
		self:setRidingMount(nil)
	end
end

function RideHandler:updateRide()
	for idx,iter in pairs(self.rideList) do
		LuaDBAccess.updatePlayerRide(self._entity:getDBID(),iter:getGuid(),iter:getID(),iter:getVigor(),iter:getCompleteness(),iter:isFollow()and 1 or 0,iter:getRidingTime())
	end
end

function RideHandler:removeRide(rideGuid)
	for guid,ride in pairs(self.rideList) do
		if guid == rideGuid then
			release(self.rideList[guid])
			self.rideList[guid] = nil
			LuaDBAccess.deletePlayerRide(rideGuid)
			return
		end
	end
end