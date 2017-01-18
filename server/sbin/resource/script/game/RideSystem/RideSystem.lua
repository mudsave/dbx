--[[RideSystem.lua
描述：
	坐骑系统
--]]

require "game.RideSystem.Ride"
require "game.RideSystem.RideManager"

RideSystem = class(EventSetDoer, Singleton)

function RideSystem:__init()
	self._doer = {
		[RideEvent_CS_UpOrDownRide]		= RideSystem.UpOrDownRide,
		[RideEvent_CS_ExpandRideBar]	= RideSystem.expandRideBar,
		[RideEvent_CS_GrowUp]			= RideSystem.rideGrowUp,
		[RideEvent_CS_RideToItem]		= RideSystem.rideToItem,
	}
end

--上下坐骑
function RideSystem:UpOrDownRide(event)
	local params = event:getParams()
	local playerID = params[1]
	local guid = params[2]
	local player = g_entityMgr:getPlayerByID(playerID)
	g_rideMgr:UpOrDownRide(player,guid)
end


--扩充坐骑栏
function RideSystem:expandRideBar(event)
	local params = event:getParams()
	local playerID = params[1]
	g_rideMgr:expandRideBar(playerID)
end

--坐骑进阶
function RideSystem:rideGrowUp(event)
	local params = event:getParams()
	local playerID = params[1]
	local guid = params[2]
	local guid1 = params[3]
	local guid2 = params[4]
	local guid3 = params[5]
	local player = g_entityMgr:getPlayerByID(playerID)
	local sGuidlist = {guid1,guid2,guid3}
	g_rideMgr:rideGrowUp(player,guid,sGuidlist)
end

--坐骑回笼
function RideSystem:rideToItem(event)
	local params = event:getParams()
	local playerID = params[1]
	local guid = params[2]
	local player = g_entityMgr:getPlayerByID(playerID)
	g_rideMgr:rideToItem(player,guid)
end

function RideSystem.getInstance()
	return RideSystem()
end

g_rideSystem = RideSystem.getInstance()

g_eventMgr:addEventListener(RideSystem.getInstance())