--[[PeriodChecker.lua
描述：
	时间检测分发给各个系统
--]]

PeriodChecker = class(nil, Timer)

function PeriodChecker:__init()
	TimerManager.getInstance():regTimer(self, 60 * 1000, 60 * 1000)
	self.systemList = 
	{
		day = {},
		week = {},
		month = {},
	}
	self.updateList = {}
end

function PeriodChecker:update()
	local currentTime = os.time()
	for _, object in pairs(self.updateList) do
		object:minUpdate(currentTime)
	end

	if time.isDayEnd() then
		for _, object in pairs(self.systemList.day) do
			object:update("day")
		end
		if time.isWeekEnd() then
			for _, object in pairs(self.systemList.week) do
				object:update("week")
			end
		end
		if time.isMonthEnd() then
			for _, object in pairs(self.systemList.month) do
				object:update("month")
			end
		end
	end
end

function PeriodChecker:addPeriodListener(period, object)
	if not self.systemList[period] then
		print("添加监听出错")
		return
	end
	table.insert(self.systemList[period], object)
end

function PeriodChecker:addUpdateListener(object)
	table.insert(self.updateList, object)
end

function PeriodChecker:removeUpdateListener(object)
	local removeIndex
	for index, listener in pairs(self.updateList) do
		if listener == object then
			removeIndex = index
		end
	end
	if removeIndex then
		self.updateList[removeIndex] = nil
	end
end

g_periodChecker = PeriodChecker()

