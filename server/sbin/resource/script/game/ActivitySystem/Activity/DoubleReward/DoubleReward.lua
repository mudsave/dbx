--[[DoubleReward.lua
描述：
	双倍奖励活动
--]]
gDoubleRewardActivityID = 9
gDoubleRewardFlag = false
--活动基础配置
local doubleRewardActivityDB = 
{
	[gDoubleRewardActivityID] = 
	{
		name = "DoubleReward",
		--dbName = "updateSchoolActivity",
		startType = AtyStartType.fixedWeekHour,
		activityTime = {
			[1] = {startTime = {week = 2,hour = 20, min = 0},endTime = {week = 2,hour = 22, min = 0}},
			[2] = {startTime = {week = 6,hour = 20, min = 0},endTime = {week = 6,hour = 22, min = 0}},
			[3] = {startTime = {week = 7,hour = 20, min = 0},endTime = {week = 7,hour = 22, min = 0}},
		}
	}
}
local msgID =
{
	preOpened	= 1,
	opened		= 2,
	closed		= 3,
	joinPlayer	= 4,
}

table.copy(doubleRewardActivityDB, ActivityDB)

DoubleReward = class(Activity, Singleton,Timer)

function DoubleReward:__init()
	self._id = gDoubleRewardActivityID
end

function DoubleReward:__release()
	
end

function DoubleReward:open()
	local event = Event.getEvent(DoubleRewardEvent_SC_ActvityOpened, msgID.preOpened)
	g_eventMgr:broadcastEvent(event)
	print("DoubleReward:open()")
	self.timerID = g_timerMgr:regTimer(self, 30*1000, 30*1000, "DoubleReward:open()")
	self.timerID1 = g_timerMgr:regTimer(self, 60*1000, 60*1000, "DoubleReward:open()")
end

function DoubleReward:update()
	if self.timerID then
		g_timerMgr:unRegTimer(self.timerID )
		local event = Event.getEvent(DoubleRewardEvent_SC_ActvityOpened, msgID.preOpened)
		g_eventMgr:broadcastEvent(event)
		self.timerID = nil
		return
	end
	if self.timerID1 then
		self:openActivity()
		g_timerMgr:unRegTimer(self.timerID1)
		self.timerID1 = nil
	end
end

function DoubleReward:openActivity()
	local event = Event.getEvent(DoubleRewardEvent_SC_ActvityOpened, msgID.opened)
	g_eventMgr:broadcastEvent(event)
	print("活动开启")
	gDoubleRewardFlag = true
end

function DoubleReward:close()
	local event = Event.getEvent(DoubleRewardEvent_SC_ActvityOpened, msgID.closed)
	g_eventMgr:broadcastEvent(event)
	print("活动关闭")
	if self.timerID then
		g_timerMgr:unRegTimer(self.timerID )
		self.timerID = nil
	end
	if self.timerID1 then
		g_timerMgr:unRegTimer(self.timerID1)
		self.timerID1 = nil
	end
	gDoubleRewardFlag = false
end

-- 上线加入活动
function DoubleReward:joinPlayer(player,recordList)
	if gDoubleRewardFlag then
		local event = Event.getEvent(DoubleRewardEvent_SC_ActvityOpened, msgID.joinPlayer)
		g_eventMgr:fireRemoteEvent(event,player)
	end
end