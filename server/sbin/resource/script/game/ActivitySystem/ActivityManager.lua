--[[ActivityManager.lua
描述:活动管理
]]

ActivityDB = {}
ActivityID = 1

--require "game.ActivitySystem.Activity.BeastBless.BeastBless"

ActivityManager = class(nil, Singleton)

function ActivityManager:__init()
	self.curActivityList = {}
	self.lastTime = 0
end

function ActivityManager:__release()
	self.curActivityList = nil
	self.lastTime = nil
end

function ActivityManager:openActivity(id, name)
	-- require "game.ActivitySystem."..name.."."..name
	local clazz = _G[name]
	if clazz and type(clazz) == "table" then
		self.curActivityList[id] = clazz()
		self.curActivityList[id]:open()
	else
		print("活动编码有误")
	end
end

function ActivityManager:closeActivity(id)
	self.curActivityList[id]:close()
	release(self.curActivityList[id])
	self.curActivityList[id] = nil
end

function ActivityManager:getActivity(id)
	return self.curActivityList[id]
end

--玩家属性改变触发加入活动
function ActivityManager:notityJoinActivity(player)
	for id, activity in pairs(self.curActivityList) do
		activity:joinPlayer(player)
	end
end

--玩家属性改变触发移除活动(不知道有用没，先写上)
function ActivityManager:notityExitActivity(player)
	
end

--玩家上线加入活动
function ActivityManager:onPlayerOnline(player, recordList)
	if recordList then
		for id, targetData in pairs(recordList) do
			for targetIndex, flag in pairs(targetData) do
				if self.curActivityList[id] then
					 self.curActivityList[id]:joinPlayer(player, targetIndex)
				else
					print("活动已经关闭")
				end
			end
		end
	end
end

--玩家下线
function ActivityManager:onPlayerOffline(player)
	player:getHandler(HandlerDef_Activity):offLine()
end

function ActivityManager:minUpdate(currentTime)
	if self.lastTime > 0 and currentTime - self.lastTime < 600 then
		return
	end
	local data = os.date("*t", currentTime)
	if self.lastTime == 0 and data.min%10 == 0 then
		self.lastTime = currentTime 
	elseif self.lastTime > 0 then
		self.lastTime = self.lastTime + 600
	end
	for id, activityInfo in pairs(ActivityDB) do
		local startTime = activityInfo.startTime
		local endTime = activityInfo.endTime
		if activityInfo.startType == AtyStartType.fixedDayHour then
			if not self.curActivityList[id] then		
				if data.hour == startTime.hour and data.min == startTime.min then
					self:openActivity(id, activityInfo.name)
				end
			else
				if data.hour == endTime.hour and data.min == endTime.min then
					self:closeActivity(id)
				end
			end
		elseif activityInfo.startType == AtyStartType.fixedWeekHour then
			if not self.curActivityList[id] then
				--	日	一	二	三	四	五	六
				--	1	2	3	4	5	6	7	都加一对应的数值
				--	0	1	2	3	4	5	6	可以使用这个
				if data.wday == startTime.week + 1 and data.hour == startTime.hour and data.min == startTime.min then
					self:openActivity(id, activityInfo.name)
				end
			else
				if data.wday == endTime.week + 1 and data.hour == endTime.hour and data.min == endTime.min then
					self:closeActivity(id)
				end
			end
		elseif activityInfo.startType == AtyStartType.fixedMonthHour then
			if not self.curActivityList[id] then
				if data.day == startTime.day and data.hour == startTime.hour and data.min == startTime.min then
					self:openActivity(id, activityInfo.name)
				end
			else
				if data.day == endTime.day and data.hour == endTime.hour and data.min == endTime.min then
					self:closeActivity(id)
				end
			end
		elseif activityInfo.startType == AtyStartType.Holiday then
			if not self.curActivityList[id] then
				if data.year == startTime.year and data.month == startTime.month and data.day == startTime.day
				and data.hour == startTime.hour and data.min == startTime.min then
					self:openActivity(id, activityInfo.name)
				end
			else
				if data.year == endTime.year and data.month == endTime.month and data.day == endTime.day
				and data.hour == endTime.hour and data.min == endTime.min then
					self:closeActivity(id)
				end
			end
		end
	end
end

function ActivityManager.getInstance()
	return ActivityManager()
end

g_activityMgr = ActivityManager.getInstance()
g_periodChecker:addUpdateListener(ActivityManager.getInstance())