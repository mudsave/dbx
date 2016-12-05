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
					g_rideMgr:downRide(self._entity)
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
function RideHandler:upRide(ride)
	local vigor = ride:getVigor()
	if vigor <= 0 then
		print("该坐骑体力值不足，无法骑乘。")
		return
	end
	ride:setFollow(true)
	self:setRidingMount(ride)
	local configID = ride:getID()
	local config = RideDB[configID]
	local attrChange = config.attrChange
	for _,attr in pairs(attrChange) do
		if attr.attrType == player_hp then
			local curHp = self._entity:getAttrValue(player_hp)
			local maxHp = self._entity:getAttrValue(player_max_hp)
			local changeValue = curHp*attr.attrInc
			if changeValue+curHp > maxHp then
				self._entity:setAttrValue(player_hp, maxHp)
				changedValue = maxHp - curHp
			else
				self._entity:setAttrValue(player_hp, curHp+changeValue)
			end
			ride:setChangeAttr(player_hp,changeValue)
		elseif attr.attrType == player_mp then
			local curMp = self._entity:getAttrValue(player_mp)
			local maxMp = self._entity:getAttrValue(player_max_mp)
			local changeValue = curMp*attr.attrInc
			if changeValue+curMp > maxMp then
				self._entity:setAttrValue(player_mp, maxMp)
				changedValue = maxMp - curMp
			else
				self._entity:setAttrValue(player_mp, curMp+changeValue)
			end
			ride:setChangeAttr(player_mp,changeValue)
		else
			self._entity:addAttrValue(attr.attrType, attr.attrInc)
		end
	end
	self._entity:changeMoveSpeed(config.moveSpeed*100-100)
	local data = string.format("%d,%d,%s", RideState.Ride_State_Ride,configID,ride:getGuid())
	setPropValue(self._entity:getPeer(), PLAYER_RIDE_INFO,data)
	return true
end

--下坐骑
function RideHandler:downRide(ride)
	local configID = ride:getID()
	local config = RideDB[configID]
	local attrChange = config.attrChange
	for _,attr in pairs(attrChange) do
		if attr.attrType == player_hp or attr.attrType == player_mp then
			local value = self._entity:getAttrValue(attr.attrType)
			local changeValue = ride:getChangeAttr(attr.attrType)
			self._entity:setAttrValue(attr.attrType, value-changeValue > 0 and value-changeValue or 0)
			ride:setChangeAttr(attr.attrType,nil)
		else
			self._entity:addAttrValue(attr.attrType,-attr.attrInc)
		end
	end
	self._entity:changeMoveSpeed(100-config.moveSpeed*100)
	local data = string.format("%d", RideState.Ride_State_None)
	setPropValue(self._entity:getPeer(), PLAYER_RIDE_INFO,data)
	ride:setFollow(false)
	self:setRidingMount(nil)
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
