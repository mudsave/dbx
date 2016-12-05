--[[RideSystem.lua
閹诲繗鍫敍锟�
	閸ф劙鐛炵化鑽ょ埠
--]]

require "game.RideSystem.Ride"
require "game.RideSystem.RideManager"

RideSystem = class(EventSetDoer, Singleton)

function RideSystem:__init()
	self._doer = {
		[RideEvent_CS_UpRide]			= RideSystem.upRide,
		[RideEvent_CS_DownRide]			= RideSystem.downRide,
		[RideEvent_CS_ExpandRideBar]	= RideSystem.expandRideBar,
		[RideEvent_CS_GrowUp]			= RideSystem.rideGrowUp,
		[RideEvent_CS_RideToItem]		= RideSystem.rideToItem,
	}
end

--娑撳﹤娼楁锟�
function RideSystem:upRide(event)
	local params = event:getParams()
	local playerID = params[1]
	local guid = params[2]
	local player = g_entityMgr:getPlayerByID(playerID)
	g_rideMgr:upRide(player,guid)
end

--娑撳娼楁锟�
function RideSystem:downRide(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	g_rideMgr:downRide(player)
end

--閹碘晛鍘栭崸鎰扮崬閺嶏拷
function RideSystem:expandRideBar(event)
	local params = event:getParams()
	local playerID = params[1]
	g_rideMgr:expandRideBar(playerID)
end

--閸ф劙鐛炴潻娑㈡▉
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

--閸ф劙鐛為崶鐐殿儣
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