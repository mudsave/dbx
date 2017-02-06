--[[ActivityManager.lua
描述:活动管理
]]

ActivityDB = {}
ActivityID = 1


require "game.ActivitySystem.Activity.DekaronSchool.DekaronSchool"
require "game.ActivitySystem.Activity.DekaronSchool.AScript"
require "game.ActivitySystem.Activity.BeastBless.BeastBless"

ActivityManager = class(nil, Singleton)

function ActivityManager:__init()
	self.curActivityList = {}
	self.lastTime = 0
end

function ActivityManager:__release()
	self.curActivityList = nil
	self.lastTime = nil
end

function ActivityManager:openActivity(id, frameName)
	print("-----------活动预开启-----------",frameName)
	local clazz = _G[frameName]
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

-- 玩家上线加入活动 如果活动存在 具体的逻辑在自己每个活动中做
function ActivityManager:onPlayerOnline(player, recordList)
	-- 加载所有开启的的活动数据
	local curActivityList = self.curActivityList
	if recordList then
		for activityId, activity in pairs(curActivityList) do
			 if activity then
				curActivityList[activityId]:joinPlayer(player,recordList)
			else
				print("活动已经关闭")
			end
		end
	end
end

--玩家下线
function ActivityManager:onPlayerOffline(player)
	player:getHandler(HandlerDef_Activity):offLine()
end

local isTrue = true

function ActivityManager:minUpdate(currentTime)
	if self.lastTime > 0 and currentTime - self.lastTime < 600 then
		return
	end
	
	local data = os.date("*t", currentTime)
	-- print("data",toString(data))
	if self.lastTime == 0 and data.min%10 == 0 then
		self.lastTime = currentTime 
	elseif self.lastTime > 0 then
		self.lastTime = self.lastTime + 600
	end
	for id, activityInfo in pairs(ActivityDB) do
		if activityInfo.startType == AtyStartType.fixedDayHour then --每一天
			local startTime = activityInfo.startTime
			if not self.curActivityList[id] then		
				if data.hour == startTime.hour and data.min == startTime.min then
					self:openActivity(id, activityInfo.name)
				end
			else
				if data.hour == endTime.hour and data.min == endTime.min then
					self:closeActivity(id)
				end
			end

		elseif activityInfo.startType == AtyStartType.fixedWeekHour then --每一周
			print("----------分钟更新-----",toString(data))
			local activityTime = activityInfo.activityTime
			for _,time in pairs(activityTime) do
				local startTime = time.startTime
				local endTime = time.endTime
				if not self.curActivityList[id] then
					--	日	一	二	三	四	五	六
					--	1	2	3	4	5	6	7	都加一对应的数值
					--	0	1	2	3	4	5	6	可以使用这个
					if data.wday == startTime.week + 1 and data.hour == startTime.hour and data.min == startTime.min then
						self:openActivity(id, activityInfo.name)
						return
					end
				else
					if data.wday == endTime.week + 1 and data.hour == endTime.hour and data.min == endTime.min then
						self:closeActivity(id)
						return
					end
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

g_periodChecker:addUpdateListener(ActivityManager.getInstance())