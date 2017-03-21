--[[SkyFallBoxActivity.lua
	描述：天降宝盒活动的ID = 7
--]]

require "game.ActivitySystem.Activity.SkyFallBox.SkyFallBoxManager"
require "game.ActivitySystem.Activity.SkyFallBox.SkyFallBoxSystem"
require "game.ActivitySystem.Activity.SkyFallBox.SkyFallBoxUtils"

gSkyFallBoxActivityID = 7
local skyFallBoxActivityDB = 
{
	[gSkyFallBoxActivityID] = 
	{
		name = "SkyFallBoxActivity",
		dbName = "updateSkyFallBox",
		startType = AtyStartType.fixedWeekHour,
		activityTime = {
			[1] = {startTime = {week = 2,hour = 15, min = 54},endTime = {week = 2,hour = 21, min = 0},},
			[2] = {startTime = {week = 4,hour = 15, min = 54},endTime = {week = 4,hour = 21, min = 0},},
		}
	}
}

table.copy(skyFallBoxActivityDB, ActivityDB)
SkyFallBoxActivity = class(Activity, Singleton,Timer)

function SkyFallBoxActivity:__init()
	self._id = gSkyFallBoxActivityID
	self.boxNum = nil
end

function SkyFallBoxActivity:__release()
	self._id = nil
	self.boxNum = nil
end

function SkyFallBoxActivity:open()
	--播放广播
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SkyFallBox, 1)
	RemoteEventProxy.broadcast(event)
	
	--活动状态(预开启)
	self.state = ActivityState.PreOpening
	--定时器5分钟后活动开启
	self.openActivityTimerID = g_timerMgr:regTimer(self, 1000*5, 1000*1, "天降宝盒活动5秒后开启")
end

function SkyFallBoxActivity:close()
	--播放广播
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SkyFallBox, 3)
	RemoteEventProxy.broadcast(event)
	print("天降宝盒活动结束")
	for playerID, player in pairs(g_entityMgr:getPlayers()) do
		player:getHandler(HandlerDef_Activity):setSkyFallBoxNum(0)
		
	end
	self.state = ActivityState.Close
	g_skyFallBoxMgr:setActivityFlag(false)
	LuaDBAccess.deleteSkyFallBox()
end

--定时器执行，真正开启活动
function SkyFallBoxActivity:openActivity()
	--活动状态(开启)
	if self.state == ActivityState.PreOpening then
		self.state = ActivityState.Opening
		g_skyFallBoxMgr:setActivityFlag(true)
		--播放广播
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_SkyFallBox, 2)
		RemoteEventProxy.broadcast(event)
		print("天降宝盒活动开始!!")

		for playerID, player in pairs(g_entityMgr:getPlayers()) do
			player:getHandler(HandlerDef_Activity):setSkyFallBoxNum(0)
		end	

		-- 删除定时器
		g_timerMgr:unRegTimer(self.openActivityTimerID)
	end
end

-- 活动开启
function SkyFallBoxActivity:update(timerID)
	if timerID == self.openActivityTimerID then
		self:openActivity()
	end
end

--活动是否开启
function SkyFallBoxActivity:isOpening()
	return self.state == ActivityState.Opening
end

--玩家上线加入到活动中
function SkyFallBoxActivity:joinPlayer(player,recordList)
	print("-----天降宝盒活动玩家上线加入。。。。。。",toString(recordList))
	local handler = player:getHandler(HandlerDef_Activity)
end