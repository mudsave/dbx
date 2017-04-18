--[[BeastBless.lua
	描述：瑞兽降福 活动的ID = 2
--]]

require "game.ActivitySystem.Activity.BeastBless.BeastBlessSystem"

gBeastBlessActivityID = 2
local BeastBlessActivityDB = 
{
	[2] = 
	{
		name = "BeastBless",
		dbName = "updateBeastBless",
		startType = AtyStartType.fixedWeekHour,
		activityTime = {                                                              --活动开启、结束时间
			[1] = {startTime = {week = 3,hour = 19, min = 30},endTime = {week = 3,hour = 21, min = 30},}, 
		},
		readyPeriod = 10,	-- 开启前10分钟播放广播
		preEndPeriod= 30,	-- 关闭前30分钟播放广播
		mapInfo = {
			-- 瑞兽降福的地图
			inMapID = {9,10},
			mapID = {
				[1] = {mapID = 9,npcNum	= 20,},
				[2] = {mapID = 10,npcNum = 50,},
			},
			-- 瑞兽的随机范围
			npcValues = {25501,25502,25503,25504},
		},
	},
}

table.copy(BeastBlessActivityDB, ActivityDB)

BeastBless = class(Activity, Singleton, Timer)

local openTimeID = 0
local endTimeID = 1 

function BeastBless:__init()
	self._id = gBeastBlessActivityID
	self._config = nil
	self._openTime = nil
end

function BeastBless:__release()
end

-- 活动状态(预开启)
function BeastBless:open()
	-- 播放广播
	-- 增加
	self._id = gBeastBlessActivityID
	self._config = BeastBlessActivityDB[gBeastBlessActivityID]
	-- 准备时间
	local readyPeriod = self._config.readyPeriod
	-- 出现地图信息
	local mapInfo = self._config.mapInfo.inMapID
	--广播
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_BeastBless,1,readyPeriod,mapInfo)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
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
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_BeastBless,3 ,preEndPeriod)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
	-- 定时器
	endTimeID = g_timerMgr:regTimer(self, preEndPeriod*60*1000, preEndPeriod*60*1000, "BeastBless.closeActivity")
end

-- 定时器执行，真正开启活动
function BeastBless:openActivity()
	--广播
	local mapInfo = self._config.mapInfo.inMapID
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_BeastBless,2,mapInfo)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
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
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
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
	
end

function BeastBless:getInstance()
	return BeastBless()
end

g_beastBless = BeastBless:getInstance()
