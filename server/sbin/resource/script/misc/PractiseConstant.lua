--[[PractiseConstant.lua
描述：活动常量
]]

-- 宝箱的个数
PractiseMaxBoxNum = 5

-- 分页的选择
ActivityPage = 
{
	EDaySign	= 1, -- 每日签到
	Daliy		= 2, -- 日常活动
	Challenge	= 3, -- 挑战活动
	Festival	= 4, -- 节日活动
	Other		= 5, -- 其他活动
}

-- 日常活动按钮的类型
ActivityPageBtnType = 
{
	-- 前往
	Goto		= 1,
	-- 查看A类型	
	CheckA		= 2,
	-- 查看B类型	
	CheckB		= 3,
	-- 全天开启	
	OpenAllDay	= 4,
	-- 固定
	Fixed		= 5,	
	-- 每隔30分钟
	EveryThirty	= 6,
}

-- 宝箱的状态
PractiseBoxState = 
{
	Close	= 0,
	Light	= 1,
	Open	= 2,
}


PractiseAddRewardData = 
{
	One		= 1,
	Two		= 2,
	Three	= 3,
}