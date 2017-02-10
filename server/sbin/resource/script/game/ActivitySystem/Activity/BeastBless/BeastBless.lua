--[[BeastBless.lua
	描述：瑞兽降福 活动的ID = 3
--]]

require "game.ActivitySystem.Activity.BeastBless.BeastBlessSystem"

ActivityID = ActivityID + 1
local beastBlessID = ActivityID
local BeastBlessActivityDB = 
{
	[beastBlessID] = 
	{
		name = "BeastBless",
		dbName = "updateBeastBless",
		startType = AtyStartType.fixedWeekHour,
		activityTime = {
			[1] = {startTime = {week = 1,hour = 15, min = 54},endTime = {week = 1,hour = 21, min = 0},},
		},
		readyPeriod = 0.1,
		preEndPeriod= 0.1,
		mapInfo = {
			-- 瑞兽降福的地图
			mapID = {9,10},
			-- 每个地图的个数
			npcNum	= 50,
			-- 瑞兽的随机范围
			npcValues = {100000,100001,100002},
		},
	},
}

table.copy(BeastBlessActivityDB, ActivityDB)

BeastBless = class(Activity, Singleton, Timer)

local openTimeID = 0
local endTimeID = 1 

function BeastBless:__init()
	self._id = beastBlessID
	self._config = nil
	self._openTime = nil
end

function BeastBless:__release()
end

-- 活动状态(预开启)
function BeastBless:open()
	-- 播放广播
	print("播放广播")
	-- 增加
	self._config = BeastBlessActivityDB[self._id]
	-- 准备时间
	local readyPeriod = self._config.readyPeriod
	-- 出现地图信息
	local mapInfo = self._config.mapInfo.mapID
	--广播
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_BeastBless,1,readyPeriod,mapInfo)
		RemoteEventProxy.broadcast(event)
	end
	-- 定时器
	openTimeID = g_timerMgr:regTimer(self, readyPeriod*60*1000, readyPeriod*60*1000, "BeastBless.openActivity")
end

function BeastBless:getOpenTime()
	return self._openTime
end

function BeastBless:getID()
	return self._id
end

function BeastBless:close()
	-- 准备时间
	local preEndPeriod = self._config.preEndPeriod
	--广播
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_BeastBless,3)
		RemoteEventProxy.broadcast(event)
	end
	-- 定时器
	endTimeID = g_timerMgr:regTimer(self, preEndPeriod*60*1000, preEndPeriod*60*1000, "BeastBless.closeActivity")
end

-- 定时器执行，真正开启活动
function BeastBless:openActivity()
	--广播
	local mapInfo = self._config.mapInfo.mapID
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_BeastBless,2,mapInfo)
		RemoteEventProxy.broadcast(event)
	end
	-- 记录这个活动开始的时间
	self._openTime = os.time()
	-- 初始化玩家的数据
	g_beastBlessMgr:initOnLinePlayerData()
	-- 把瑞兽加入到地图中
	g_beastBlessMgr:createBeastToMap(self._config.mapInfo)
end

function BeastBless:closeActivity()
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_BeastBless,4)
		RemoteEventProxy.broadcast(event)
	end
	-- 清除场景中的瑞兽
	g_beastBlessMgr:destroyAllBeast()
	-- 把管理中的清除
	g_activityMgr:removeActivity(self._id)
end

function BeastBless:update(timerID)
	-- 关闭计时器
	g_timerMgr:unRegTimer(timerID)
	-- 判断是哪一个定时器开始
	if timerID == openTimeID then
		self:openActivity()
	elseif timerID == endTimeID then
		self:closeActivity()
	end
end

-- 上线加入活动
function BeastBless:joinPlayer(player,recordList)
	local beastBlessRecord = recordList[32]
	print("上线加入活动2")
	g_beastBlessMgr:joinPlayer(player,beastBlessRecord)
end

function BeastBless:getInstance()
	return BeastBless()
end

g_beastBless = BeastBless:getInstance()
