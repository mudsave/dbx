--[[DiscussHero.lua
描述:煮酒论英雄活动接口
]]

require "game.ActivitySystem.Activity.DiscussHero.DiscussHeroManager"
require "game.ActivitySystem.Activity.DiscussHero.DiscussHeroSystem"
require "game.ActivitySystem.Activity.DiscussHero.DiscussUtils"

gDiscussHeroActivityID = 8

DiscussHeroDB = {
	[8] = 
	{
		name = "DiscussHero",
		dbName = "updateDiscussHero",
		startType = AtyStartType.fixedWeekHour,
		activityTime = {
			[1] = {startTime = {week = 1,hour = 15, min = 54},endTime = {week = 1,hour = 21, min = 0},},
		},
		preScondBroadcast	= 0.3,	-- 第二次广播
		readyPeriod			= 0.5,	-- 开始
		ScondPeriod			= 0.5,	-- 第二阶段
		ThirdPeriod			= 0.5,
		preEndPeriod		= 0.5,
		-- 创建入口NPC位置
		enterNpc = {npcDBID = 100000, mapID = 10, posX = 200,posY = 200},
		-- 地图信息
		mapInfo = {
			[1] = { npcDBID = 100001, mapID = 102,minLevel = 30,maxLevel = 40,},
			[2] = { npcDBID = 100001, mapID = 102,minLevel = 40,maxLevel = 50,},
			[3] = { npcDBID = 100001, mapID = 102,minLevel = 50,maxLevel = 60,},
			[4] = { npcDBID = 100001, mapID = 102,minLevel = 60,maxLevel = 70,},
		},
	},
}
table.copy(DiscussHeroDB, ActivityDB)

DiscussHero = class(Activity, Singleton, Timer)

-- 定时器应该做的事
local TimerState = 
{
	First	= 1,	-- 第二次广播
	Second	= 2,	-- 开始第一阶段活动
	Third	= 3, 	-- 广播
	Four	= 4, 	-- 第二阶段
	Five	= 5,	-- 广播
	Six		= 6,	-- 结束
}

function DiscussHero:__init()
	self.discussHeroState = ActivityState.PreOpening
	self.endTime = 0
	-- self.config = nil
end

function DiscussHero:__release()
end

-- 定时器 的记录
local timerList = {}

-- 活动状态(预开启)
function DiscussHero:open()
	-- 广播
	-- 创建入口NPC
	self.config = DiscussHeroDB[gDiscussHeroActivityID]
	local readyPeriod = self.config.readyPeriod
	local preScondBroadcast =  self.config.preScondBroadcast
	local enterNpcInfo = self.config.enterNpc
	self.discussHeroState = ActivityState.PreOpening
	-- 设置这个阶段结束时间
	self:setEndTime(readyPeriod)
	
	if enterNpcInfo then
		self.enterNpc = g_entityFct:createDynamicNpc(enterNpcInfo.npcDBID)
		-- 加入到场景中
		local scence = g_sceneMgr:getSceneByID(enterNpcInfo.mapID)
		if scence and self.enterNpc then
			scence:attachEntity(self.enterNpc,enterNpcInfo.posX,enterNpcInfo.posY)
		end
		-- 创建活动场景
		local mapInfo = self.config.mapInfo
		if mapInfo then
			for mapInfoID, data in pairs(mapInfo) do
				g_sceneMgr:createDiscussHeroScene(data.mapID,mapInfoID)
			end
		end
	end
	-- 广播
	self:preFirstBroadcast()
	
	-- 开始20分钟后广播
	timerList[TimerState.First] = g_timerMgr:regTimer(self, preScondBroadcast*60*1000, preScondBroadcast*60*1000, "DiscussHero.preScondBroadcast")
	
	timerList[TimerState.Second] = g_timerMgr:regTimer(self, readyPeriod*60*1000, readyPeriod*60*1000, "DiscussHero.openActivity")
end

-- 设置当前状态结束时间 分钟
function DiscussHero:setEndTime(surplusTime)
	self.endTime = os.time() + surplusTime*60
end

function DiscussHero:openActivity()
	self.discussHeroState = ActivityState.Opening
	-- 广播开启
	self:openBroadcast()
	-- 创建环境
	local ScondPeriod =  self.config.ScondPeriod
	-- 创建场景NPC
	g_discussHeroMgr:initAllNpc()
	-- 设定时间
	self:setEndTime(ScondPeriod)
	-- 
	g_discussHeroSym:notifyClientStateChange()
	-- 一分钟前广播
	timerList[TimerState.Third] = g_timerMgr:regTimer(self, ScondPeriod*60*1000, ScondPeriod*60*1000, "DiscussHero.ScondBroadcast")
	-- 开启第二阶段
	
	timerList[TimerState.Four] = g_timerMgr:regTimer(self, ScondPeriod*60*1000, ScondPeriod*60*1000, "DiscussHero.openSecondPeriod")
end

-- 第二PVP时间
function DiscussHero:openSecondPeriod()
	-- 销毁原来的环境
	self.discussHeroState = ActivityState.OpeningFirst
	-- 自动匹配PVP
	local ThirdPeriod =  self.config.ThirdPeriod
	
	self:setEndTime(ThirdPeriod)
	
	g_discussHeroMgr:changeAllPlayerState()
	
	g_discussHeroSym:notifyClientStateChange()
	
	-- 一分钟前广播
	local preBroadcast = ThirdPeriod - 1 
	
	timerList[TimerState.Five] = g_timerMgr:regTimer(self, preBroadcast*60*1000, preBroadcast*60*1000, "DiscussHero.ScondEndBroadcast")
end

function DiscussHero:close()
	-- 把玩家送回原来的地图
	-- 清空NPC
	-- 发放奖励
	-- 自动匹配PVP
	local preEndPeriod =  self.config.preEndPeriod
	
	timerList[TimerState.Six] = g_timerMgr:regTimer(self, preEndPeriod*60*1000, preEndPeriod*60*1000, "DiscussHero.preEndPeriod")
end

function DiscussHero:closeActivity()
	-- 结算奖励
	-- 关闭活动
	g_discussHeroMgr:allExitDiscussHero()
	-- 
	g_activityMgr:removeActivity(gDiscussHeroActivityID)
end

-- 预通知广播30
function DiscussHero:preFirstBroadcast()
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_DicussHero,1,30)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
end

-- 预通知广播10
function DiscussHero:preScondBroadcast()
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_DicussHero,1,10)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
end

-- 开始活动广播
function DiscussHero:openBroadcast()
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_DicussHero,2)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
end

-- 争霸战即将开启，一分钟后进行配对战斗!
function DiscussHero:ScondBroadcast()
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_DicussHero,3)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
end

-- 
function DiscussHero:ScondEndBroadcast()
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_DicussHero,4)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
end

-- 
function DiscussHero:RewordBroadcast()
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_DicussHero,5)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
end

-- 
local DiscussHeroStep = 
{
	[TimerState.First]	= DiscussHero.preScondBroadcast,
	[TimerState.Second]	= DiscussHero.openActivity,
	[TimerState.Third]	= DiscussHero.ScondBroadcast,
	[TimerState.Four]	= DiscussHero.openSecondPeriod,
	[TimerState.Five]	= DiscussHero.RewordBroadcast,
	[TimerState.Six]	= DiscussHero.closeActivity,
}
function DiscussHero:update(timerID)
	-- 关闭自己
	g_timerMgr:unRegTimer(timerID)
	for timeState,rTimeID in pairs(timerList) do
		if rTimeID == timerID  then
			local funName = DiscussHeroStep[timeState]
			-- print("timeState,funName,timerID",timeState,funName,timerID)
			if funName then
				funName(self)
				timerList[timeState] = nil
			end
		end
	end
end

function DiscussHero:joinPlayer(player,recordList)
	
end


function DiscussHero:getDiscussHeroState()
	return self.discussHeroState
end

function DiscussHero:getEndTime()
	return self.endTime
end

function DiscussHero.getInstance()
	return DiscussHero()
end

g_discussHero = DiscussHero.getInstance()
