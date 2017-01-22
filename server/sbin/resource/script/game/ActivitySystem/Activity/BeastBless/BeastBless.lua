--[[BeastBless.lua
	描述：瑞兽降福 活动的ID = 3
--]]

require "game.ActivitySystem.Activity.BeastBless.BeastBlessSystem"

local BeastBlessActivityDB = 
{
	[3] = 
	{
		name = "BeastBless",
		dbName = "updateBeastBless",
		startType = AtyStartType.fixedWeekHour,
		startTime = {week = 5,hour = 14, min = 63},
		endTime = {week = 5,hour = 21, min = 30},
	}
}

table.copy(BeastBlessActivityDB, ActivityDB)

BeastBless = class(Activity, Singleton)

function BeastBless:__init()
	self._id = 3
end

function BeastBless:__release()
end

function BeastBless:open()
	-- 播放广播
	-- 活动状态(预开启)
	-- 定时器
	self:openActivity()
end

function BeastBless:close()
end

-- 定时器执行，真正开启活动
function BeastBless:openActivity()
	-- 活动状态(开启)
	print("BeastBless.Open")
	-- 增加
--	g_beastMgr:addAllBeastToMap()
	
end

-- 点击对话调用这里
function BeastBless:joinActivity(player)
	
end

-- 上线加入活动
function BeastBless:joinPlayer(player,targetIndex)
	
end

function BeastBless:ExitPlayer()
	
end

function BeastBless:getInstance()
	return BeastBless()
end

g_beastBless = BeastBless:getInstance()
