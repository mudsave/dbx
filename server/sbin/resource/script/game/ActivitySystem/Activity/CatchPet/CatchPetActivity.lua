--[[CatchPetActivity.lua
--]]


require "game.ActivitySystem.Activity.CatchPet.CatchPetSystem"
catchPetActivityID = 3
print("捕宠活动ID", catchPetActivityID)
local CatchPetActivityDB = 
{
	[catchPetActivityID] = 
	{
		name = "CatchPetActivity",
		--dbName = "updateCatchPet",
		startType = AtyStartType.fixedWeekHour,
		activityTime = 
		{
			[1] = {startTime = {week = 6, hour = 19, min = 55}, endTime = {week = 6, hour = 21, min = 25}},
		},
		-- 活动正式开始前
		beforActivity = {5,3,2,1},
		afterActivity = {30, 60},
		-- 开始后中间广播
		endActivity = {5,3,2,1},
	},
}

table.copy(CatchPetActivityDB, ActivityDB)

CatchPetActivity = class(Activity, Timer)

function CatchPetActivity:__init()
	self._id = catchPetActivityID
	self._config = nil
	-- 开启前
	self.beforActivityTimerIDs = {}
	self.afterActivityTimerIDs = {}
	-- 结束前
	self.endActivityTimerIDs = {}
	self.state = nil
	self.startTime = nil

end

function CatchPetActivity:__release()
	self._id = nil
	self._config = nil

	self.beforActivityTimerIDs = nil
	self.afterActivityTimerIDs = nil
	self.endActivityTimerIDs = nil
	self.state = nil
	self.startTime = nil
end

function CatchPetActivity:update(timerID)
	-- 删掉这个定时器ID
	g_timerMgr:unRegTimer(timerID)
	for index, beforTimerID in pairs(self.beforActivityTimerIDs) do
		if index == 1 then
			if beforTimerID == timerID then
				--  活动正式开启
				self.beforActivityTimerIDs[index] = nil
				self:startActivity()
				return
			end
		else
			-- 这个只是做广播，没有实质开启刷怪
			if beforTimerID == timerID then
				self.beforActivityTimerIDs[index] = nil
				if g_serverId == 0 then
					print("广播还剩多少分钟开始", self._config.beforActivity[index])
					local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 4, self._config.beforActivity[1] - self._config.beforActivity[index])
					-- RemoteEventProxy.broadcast(event)
					g_eventMgr:broadcastEvent(event)
				end
				return
			end
		end
	end
	
	for index, afterTimerID in pairs(self.afterActivityTimerIDs) do
		if afterTimerID == timerID then
			self.afterActivityTimerIDs[index] = nil
			if g_serverId == 0 then
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 8)
				-- RemoteEventProxy.broadcast(event)
				g_eventMgr:broadcastEvent(event)
			end
			return
		end
	end

	for index, endTimerID in pairs(self.endActivityTimerIDs) do
		if index == 1 then
			if endTimerID == timerID then
				--  活动正式结束
				print("活动正式结束")
				self.endActivityTimerIDs[index] = nil
				self:endActivity()
				return
			end
		else
			-- 这个只是做广播，没有实质开启刷怪
			if endTimerID == timerID then
				self.endActivityTimerIDs[index] = nil
				if g_serverId == 0 then
					print("广播还剩多少分钟结束", self._config.endActivity[index])
					local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 6, self._config.endActivity[1] - self._config.endActivity[index])
					-- RemoteEventProxy.broadcast(event)
					g_eventMgr:broadcastEvent(event)
				end
				return
			end
		end
	end
end

function CatchPetActivity:endActivity()
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 7)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
	
	for index, beforTimerID in pairs(self.beforActivityTimerIDs) do
		if beforTimerID > 0 then
			g_timerMgr:unRegTimer(beforTimerID)
		end
	end

	for index, afterTimerID in pairs(self.afterActivityTimerIDs) do
		if afterTimerID > 0 then
			g_timerMgr:unRegTimer(afterTimerID)
		end
	end

	for index, endTimerID in pairs(self.endActivityTimerIDs) do
		if endTimerID > 0 then
			g_timerMgr:unRegTimer(endTimerID)
		end
	end
	g_catchPetMgr:closeActivity()
	g_activityMgr:removeActivity(self._id)
end

function CatchPetActivity:open()
	-- 注册一个定时器，5分钟之后正式开启
	-- 活动开启，创建活动对象。
	self:openActivity()
	--活动状态(预开启)
	self.state = ActivityState.PreOpening
	self._config = CatchPetActivityDB[self._id]
	local beforActivity = self._config.beforActivity
	-- 活动开始前广播，还有15分钟正式开启
	if beforActivity then
		if #beforActivity > 0 then
			-- 记录正式开启时间
			self.startTime = os.time() + beforActivity[1] * 60
			if g_serverId == 0 then
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 4, beforActivity[1])
				-- RemoteEventProxy.broadcast(event)
				g_eventMgr:broadcastEvent(event)
			end
		
			for index, minute in ipairs(beforActivity) do
				-- 活动开始前的三个定时器
				local timerID = g_timerMgr:regTimer(self, minute*60*1000, minute*60*1000, "CatchPetActivity.update")
				self.beforActivityTimerIDs[index] = timerID
			end
		else
			-- 广播活动正式开始
			self:startActivity()
		end
	else
		self:startActivity()
	end
end

function CatchPetActivity:close()
	self._config = CatchPetActivityDB[self._id]
	local endActivity = self._config.endActivity
	if endActivity then
		if #endActivity > 0 then
			if g_serverId == 0 then
				-- 活动还有几分钟关闭
				local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 6, endActivity[1])
				-- RemoteEventProxy.broadcast(event)
				g_eventMgr:broadcastEvent(event)
			end
			for index, minute in ipairs(endActivity) do
				-- 活动开始前的三个定时器
				local timerID = g_timerMgr:regTimer(self, minute*60*1000, minute*60*1000, "CatchPetActivity.update")
				self.endActivityTimerIDs[index] = timerID
			end
		else
			self:endActivity()
		end
	else
		self:endActivity()
	end
end

-- 创建当中活动对象
function CatchPetActivity:openActivity()
	g_catchPetMgr:openActivity()
end

function CatchPetActivity:startActivity()
	--活动状态(正式开启)
	self.state = ActivityState.Opening
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 5)
		-- RemoteEventProxy.broadcast(event)
		g_eventMgr:broadcastEvent(event)
	end
	g_catchPetMgr:startOpen()
	-- 如果有中间广播
	self._config = CatchPetActivityDB[self._id]
	local afterActivity = self._config.afterActivity
	if afterActivity then
		if #afterActivity > 0 then
			for index, minute in ipairs(afterActivity) do
				-- 活动开始前的三个定时器
				local timerID = g_timerMgr:regTimer(self, minute*60*1000, minute*60*1000, "CatchPetActivity.update")
				self.afterActivityTimerIDs[index] = timerID
			end
		end
	end
end

function CatchPetActivity:getState()
	return self.state
end

function CatchPetActivity:getStartTime()
	return self.startTime
end

-- 点击对话调用这里
function CatchPetActivity:joinActivity(player)
	
end

-- 上线加入活动
function CatchPetActivity:joinPlayer(player,targetIndex)
	
end

function CatchPetActivity:ExitPlayer()
	
end

function CatchPetActivity:getInstance()
	return CatchPetActivity()
end
