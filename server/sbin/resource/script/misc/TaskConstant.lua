--[[TaskConstant.lua
	任务常量定义(任务系统)
]]

--任务类型
TaskType = 
{
	normal	= 1,		-- 普通任务
	loop	= 2,		-- 循环任务
}

TaskPeriod = 
{
	time	= 1,
	day		= 2,
	week	= 3,
	month	= 4,
	none	= 5,
}

TaskNotifyClientType = 
{
	randomEquip = 1,
	item		= 2,
}