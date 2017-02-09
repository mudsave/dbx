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
			[1] = {startTime = {week = 2,hour = 15, min = 54},endTime = {week = 2,hour = 21, min = 0}},
			[2] = {startTime = {week =5,hour = 20, min = 0},endTime = {week =5,hour = 21, min = 0}},
		}
	}
}

table.copy(BeastBlessActivityDB, ActivityDB)

BeastBless = class(Activity, Singleton)

function BeastBless:__init()
	self._id = beastBlessID
	self.openTime = nil
end

function BeastBless:__release()
end

function BeastBless:open()
	-- 播放广播
	-- 活动状态(预开启)
	-- 定时器
	-- self:openActivity()
	-- 记录这个活动开始的时间
	self.openTime = os.time()
end

function BeastBless:getOpenTime()
	return self.openTime
end

function BeastBless:getID()
	return self._id
end

function BeastBless:close()

end

-- 定时器执行，真正开启活动
function BeastBless:openActivity()
	-- 活动状态(开启)
	print("BeastBless.Open")
	-- 增加
	local name = ActivityDB[self:getID()].name
	g_activityMgr:openActivity(self:getID(),name)
	-- 初始化玩家的数据
	g_beastBlessMgr:initOnLinePlayerData()
	-- 把瑞兽加入到地图中
	g_beastBlessMgr:initBeastToMap()
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
