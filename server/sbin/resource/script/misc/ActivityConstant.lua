--[[ActivityConstant.lua
描述：活动常量
]]


-- 活动开启时间类型
AtyStartType = 
{
	fixedDayHour	= 1,	--每天固定时间(例如每天下午6点)
	fixedWeekHour	= 2,	--每周固定时间(例如每周四下午6点)
	fixedMonthHour	= 3,	--每月固定时间(例如每月一号)
	Holiday			= 4,	--节假日活动(例如五一 国庆 春节)
}

ActivityState = 
{
	PreOpening		= 1,
	Opening			= 2,
	OpeningFirst	= 3, -- 开启的第一阶段
	OpeningSecond	= 4, -- 开启的第二阶段
	Close			= 5,
}

-- 活动页面
ActivityPageDataType = 
{
	-- 取数据的类型
	LoopTask	= 1,
	Activity	= 2,
	DaliyTask	= 3,
	OtherTask	= 4,
}


ActivityPageUpdateData = 
{
	DaliyKill		= 1, -- 每日杀怪	
}
