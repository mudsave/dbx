--[[AdminDoer.lua
描述:对外逻辑
]]

AdminDoer = class(Singleton, Timer)

function AdminDoer:__init()	
end

function AdminDoer:__release()
end
-- 时间转换

local weekToString = 
{
	[0] = "星期天",
	[1] = "星期一",
	[2] = "星期二",
	[3] = "星期三",
	[4] = "星期四",
	[5] = "星期五",
	[6] = "星期六",
	[7] = "星期天",
}

function AdminDoer:timeToString(timeData)
	local timeString = ""
	if timeData then
		if timeData.week then 
			print("timeData.week",timeData.week)
			timeString = timeString..weekToString[timeData.week]
		end
		if timeData.hour then 
			timeString = timeString..toString(timeData.hour).."时"
		end
		if timeData.min then
			timeString = timeString..toString(timeData.min).."分"
		end
		return timeString
	end
end

-- 定时器
local TimerList = {}

local TimerState = 
{
	First	= 1,	--执行
}

function AdminDoer:onBroadcastTimer(timerID,timerInfo)
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GMBroadCast,1,timerInfo.info)
		g_eventMgr:broadcastEvent(event)
	end
	if timerInfo.times then
		if timerInfo.times < 0 then
			g_timerMgr:unRegTimer(timerID)
		else
			timerInfo.times = timerInfo.times - 1
		end
	else
		g_timerMgr:unRegTimer(timerID)
	end
end

local timerFun = 
{
	[TimerState.First] = AdminDoer.onBroadcastTimer,
}

function AdminDoer:update(timerID)
	if TimerList[timerID] then
		local timerInfo = TimerList[timerID]
		local funName = timerFun[timerInfo.TimerState]
		if funName then
			funName(self,timerID,timerInfo)
		end
	end
end

-- 得到开启活动消息
-- 活动所有信息组合
--{{id = "",name = "",state = "",startType = "",activityTime = {startTime = "",endTime	= "",}}}
function AdminDoer:getActivityInfo()
	if ActivityDB then
		local allActivity = {}
		local curActivityList = g_activityMgr:getActivityList()
		for activityId,data in pairs(ActivityDB) do
			local activity = {}
			activity.id = activityId
			activity.name = data.name
			activity.state = "未开启"
			activity.activityTime = {}
			if data.startType == AtyStartType.fixedDayHour then --每一天
				local activityTime = {}
				activity.startType = "每天固定时间"
				activityTime.startTime = self:timeToString(data.startTime)
				activityTime.endTime = self:timeToString(data.endTime)
				table.insert(activity.activityTime,activityTime)
			elseif data.startType == AtyStartType.fixedWeekHour then --每一周
				activity.startType = "每周固定时间"
				local activityTimeTemp = data.activityTime
				if activityTimeTemp then
					for _,time in pairs(activityTimeTemp) do
						local activityTime = {}
						print("time",toString(time))
						activityTime.startTime = self:timeToString(time.startTime)
						activityTime.endTime = self:timeToString(time.endTime)
						table.insert(activity.activityTime,activityTime)
					end
					
				end
			end
			table.insert(allActivity,activity)		
		end
		if table.size(curActivityList) > 0 then
			for id,activity in pairs(curActivityList) do
				for _,data in pairs(allActivity) do
					if id == data.id then
						data.state = "开启"
					end
				end
			end
		end
		return allActivity
	end
	return false
end

function AdminDoer:onKickPlayer(player)
	if player then
		g_playerMgr:kickOutPlayer(player:getDBID())
		result = 1
		return AdminMsgState.Success,AdminMsg[10]
	end
	return AdminMsgState.Fail,AdminMsg[9]
end

-- 公告
function AdminDoer:onBroadcast(info,period,times)
	if info then
		info = string.utf8ToGbk(info)
	end
	if not period or period == 0 then
		if g_serverId == 0 then
			print("播放一次")
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_GMBroadCast,1,info)
			g_eventMgr:broadcastEvent(event)
		end
	else
		local timerInfo = {}
		local timerID = g_timerMgr:regTimer(self, period*60*1000, period*60*1000, "AdminDoer.onBroadcast")
		timerInfo.TimerState = TimerState.First
		timerInfo.times = times
		timerInfo.info = info
		TimerList[timerID] = timerInfo
	end
end

-- 发送邮件
function AdminDoer:onSendMail(roleDBIDs,items,themeBuff,contentBuff,money,submoney)
	-- 检查物品消息
	if not themeBuff then
		themeBuff = "系统消息"
	end
	if table.size(items) > 0 then
		for itemID,itemNum in pairs(items) do
			if not tItemDB[itemID] then
				return AdminMsgState.Fail,AdminMsg[2]
			end
		end 
	end
	if table.size(roleDBIDs) > 0 then
		for roleDBID,_ in pairs(roleDBIDs) do
			local sendMailData = {
				type = string.utf8ToGbk(themeBuff),
				theme = string.utf8ToGbk(themeBuff),
				content  = {"html",string.utf8ToGbk(contentBuff)},
				extra = {},
			}
			for itemID,itemNum in pairs(items) do
				print("roleDBID：itemID,itemNum",roleDBID,itemID,itemNum)
				table.insert(sendMailData.extra,{ID = itemID,Amount = itemNum})
			end
			print("sendMailData",toString(sendMailData))
			local player =  g_entityMgr:getPlayerByDBID(roleDBID)
			if player then
				g_mailMgr:addFluidMail(roleDBID,sendMailData) --添加浮动邮件，会通过mdata返回动态的邮件ID，新邮件ID是字符串，在服务器中使用
				local event = Event.getEvent(MailEvent_SC_MailsDelieved,g_mailMgr:getMailsCount(roleDBID),nil)
				g_eventMgr:fireRemoteEvent(event,player)
			else
				LuaDBAccess.MailNew(Mail.MailFromTable(sendMailData),roleDBID)
			end
			return AdminMsgState.Success,AdminMsg[3]
		end
	end
	return AdminMsgState.Fail,AdminMsg[1]
end

-- 得到在线玩家信息
function AdminDoer:getPlayerInfo(player)
	if player then
		local playerInfo = {}
		playerInfo.name		= player:getName()
		playerInfo.id		= player:getDBID()
		playerInfo.sex		= player:getSex()
		playerInfo.mapid	= player:getScene():getMapID()
		playerInfo.school	= player:getSchool()
		playerInfo.level	= player:getLevel()
		playerInfo.submoney	= player:getSubMoney()
		playerInfo.money	= player:getMoney()
		local pos = player:getPos()
		playerInfo.posx = pos[2]
		playerInfo.posy = pos[3]
		playerInfo.onlinestate = 1
		return AdminMsgState.Success, playerInfo
	end
	-- 不在线或者没有这个玩家
	return AdminMsgState.Fail,0
end

function AdminDoer:reSetPos(player,tMapID)
	if player then
		local mapID	= player:getScene():getMapID()
		if mapID then
			print("xxxx",mapID)
			if g_sceneMgr:getSceneByID(mapID) then -- 公共场景中才能复位
				local mapConfig = mapDB[mapID]
				local posX = mapConfig.safeX
				local posY = mapConfig.safeY
				print("mapID",posX,posY)
				if posY and posX then
					g_sceneMgr:doSwitchScence(player:getID(),mapID,posX,posY)	
				else
					local posX,posY = g_sceneMgr:getRandomPosition(mapID)
					print("没有安全点",posX,posY)
					g_sceneMgr:doSwitchScence(player:getID(),mapID,posX,posY)	
				end
			else
				local posX,posY = g_sceneMgr:getRandomPosition(AdminDefaultMapID)
				print("不是公共场景",posX,posY)
				g_sceneMgr:doSwitchScence(player:getID(),mapID,posX,posY)	
			end
		else
			local posX,posY = g_sceneMgr:getRandomPosition(AdminDefaultMapID)
			g_sceneMgr:doSwitchScence(player:getID(),mapID,posX,posY)
		end
		return self:getPlayerInfo(player)
	else
		if tMapID then
			if g_sceneMgr:getSceneByID(tMapID) then -- 公共场景中才能复位
				local mapConfig = mapDB[tMapID]
				local tPosX = mapConfig.safeX
				local tPosY = mapConfig.safeY
				print("tMapID",tPosX,tPosY)
				if tPosY and tPosX then
					return AdminMsgState.Fail,{mapID = tMapID,posX = tPosX, posY=tPosY}
				else
					local tPosX,tPosY = g_sceneMgr:getRandomPosition(tMapID)
					return AdminMsgState.Fail,{mapID = tMapID,posX = tPosX, posY=tPosX}
				end
			else
				local tPosX,tPosY = g_sceneMgr:getRandomPosition(AdminDefaultMapID)
				return AdminMsgState.Fail,{mapID = tMapID,posX = tPosX, posY=tPosY}
			end
		else
			local tPosX,tPosY = g_sceneMgr:getRandomPosition(AdminDefaultMapID)
			return AdminMsgState.Fail,{mapID = tMapID,posX = tPosX, posY=tPosY}
		end
	end
	local tPosX,tPosY = g_sceneMgr:getRandomPosition(AdminDefaultMapID)
	return AdminMsgState.Fail,{mapID = tMapID,posX = tPosX, posY=tPosY}
end

-- 检查地图和坐标是否可用
function AdminDoer:checkOrGoToMap(player,mapID,posX,posY)
	if mapID and posX and posY then
		print("xxxxxxx",mapID,posX,posY)
		local bValid = g_sceneMgr:isPosValidate(mapID,posX,posY)
		print("bValid----",bValid)
		if not bValid then		
			return AdminMsgState.UseLess,AdminMsg[6]
		else
			if player then
				if g_sceneMgr:getSceneByID(mapID) then
					g_sceneMgr:doSwitchScence(player:getID(),mapID,posX,posY)
					return AdminMsgState.Success,AdminMsg[8]
				else
					return AdminMsgState.Fail,AdminMsg[7]
				end
			else
				return AdminMsgState.Fail,AdminMsg[9]
			end
		end
	else
		return AdminMsgState.UseLess,AdminMsg[6]
	end
end

function AdminDoer:onBanSpeech(player,period)
	if player then
		local mixHandler = player:getHandler(HandlerDef_Mix)
		if mixHandler then
			mixHandler:changeBanSpeechTime(period)
			return AdminMsgState.Success,AdminMsg[11]
		end
	end
	return AdminMsgState.Fail,AdminMsg[9]
end

function AdminDoer.getInstence()
	return AdminDoer()
end

g_adminDoer = AdminDoer.getInstence()
