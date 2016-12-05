--[[TimerManager.lua
描述：
	定时器管理类
--]]

-- 定时器接口
Timer = interface(nil, "update")

-- 定时器管理类
TimerManager = class(nil, Singleton)

-- 无效的定时器ID
local INVALID_TIMER_ID = -1

-- 初始化
function TimerManager:__init()
	self.curTimerID = 0
	self.regTimers = {}
	self.timerDebugInfo = {}
end

function TimerManager:__release()
	for idx,_ in pairs(self.regTimers) do
		self:unRegTimer(idx)
		self.regTimers[idx] = nil
		self.timerDebugInfo[idx] = nil
	end
end

-- 定时器回调
function TimerManager:update(timerID)
	local timer = self.regTimers[timerID]
	if timer then
		timer:update(timerID)
	end
end

--C++ 返回注册 注销过期通知
function TimerManager:notify(timerID, state)
	if state == ScriptTimerExpire then
		print ("[ScriptTimer]["..timerID.."] [" .. self.timerDebugInfo[timerID] .. "]expire succeed!");
	elseif state == ScriptTimerStop then
		print ("[ScriptTimer]["..timerID.."] [" .. self.timerDebugInfo[timerID] .. "]unreg succeed!");
	end
	self.timerDebugInfo[timerID] = nil
end

-- 生成定时器ID
-- CAUTION: 定时器id越界
function TimerManager:generateTimerID()
	self.curTimerID = self.curTimerID + 1
	return self.curTimerID
end

-- 注册定时器
-- args:timer 实现Timer接口的回调
-- args:elapse 第一次执行时间
-- args:period 周期
-- args:debugInfo 调试信息
-- return:返回定时器id
function TimerManager:regTimer(timer, elapse, period, debugInfo)
	if instanceof(timer, Timer) then
		local timerID = self:generateTimerID()
		local rt = ScriptTimer.RegTimer(timerID, elapse, period)
		if rt == -1 then
			print ("[ScriptTimer]["..timerID.."] reg failed!");
		end
		self.regTimers[timerID] = timer
		self.timerDebugInfo[timerID] = debugInfo
		print ("[ScriptTimer]["..timerID.."] reg succeed!");
		return timerID
	end
	return INVALID_TIMER_ID
end

-- 注销定时器
function TimerManager:unRegTimer(timerID)
	local timer = self.regTimers[timerID]
	if timer then
		ScriptTimer.UnregTimer(timerID)
		self.regTimers[timerID] = nil
		return true
	end
	return false
end

function TimerManager.getInstance()
	return TimerManager()
end
