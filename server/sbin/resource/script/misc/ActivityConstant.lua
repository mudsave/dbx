--[[ActivityConstant.lua
描述：活动常量
]]

-- 宝箱的个数
ActivityMaxBoxNum = 5

-- 宝箱的状态
ActivityBoxState = 
{
	Close	= 0,
	Light	= 1,
	Open	= 2,
}

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
	PreOpening = 1,
	Opening = 2,
	Close = 3,
}