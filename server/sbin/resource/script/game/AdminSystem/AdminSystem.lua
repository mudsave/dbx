--[[AdminSystem.lua
]]
	-- 世界服(AW)
	AdminEvents_AW_Base = 0 
	AdminEvents_AW_Test						= AdminEvents_AW_Base + 1
	AdminEvents_WA_Test						= AdminEvents_AW_Base + 2
	AdminEvents_AW_GetRoleInfo				= AdminEvents_AW_Base + 3
	AdminEvents_WA_GetRoleInfo				= AdminEvents_AW_Base + 4
	AdminEvents_AW_KickPlayer				= AdminEvents_AW_Base + 5
	AdminEvents_WA_KickPlayer				= AdminEvents_AW_Base + 6
	AdminEvents_AW_Base = AdminEvents_AW_Base + 6
	-- 玩家处理
	AdminEvents_AW_GetOnLineInfo			= AdminEvents_AW_Base + 1
	AdminEvents_WA_GetOnLineInfo			= AdminEvents_AW_Base + 2
	AdminEvents_AW_ExitGame					= AdminEvents_AW_Base + 3
	AdminEvents_WA_ExitGame					= AdminEvents_AW_Base + 4
	AdminEvents_AW_Base = AdminEvents_AW_Base + 4
	-- 定义活动处理消息 
	AdminEvents_AW_GetActivityInfo			= AdminEvents_AW_Base + 1
	AdminEvents_WA_GetActivityInfo			= AdminEvents_AW_Base + 2
	AdminEvents_AW_OpenActivity				= AdminEvents_AW_Base + 3
	AdminEvents_AW_CloseActivity			= AdminEvents_AW_Base + 4
	AdminEvents_AW_ChangeActivity			= AdminEvents_AW_Base + 5
	AdminEvents_AW_Base = AdminEvents_AW_Base + 5
	-- 公告处理
	AdminEvents_AW_Broadcast				= AdminEvents_AW_Base + 1
	AdminEvents_WA_Broadcast				= AdminEvents_AW_Base + 2
	AdminEvents_AW_Base = AdminEvents_AW_Base + 2
	-- 查封账号处理
	AdminEvents_AW_CloseAccount				= AdminEvents_AW_Base + 1
	AdminEvents_WA_CloseAccount				= AdminEvents_AW_Base + 2
	AdminEvents_AW_OPenAccount				= AdminEvents_AW_Base + 3
	AdminEvents_WA_OPenAccount				= AdminEvents_AW_Base + 4
	AdminEvents_AW_Base = AdminEvents_AW_Base + 4
	-- 发送邮件
	AdminEvents_AW_SendMail					= AdminEvents_AW_Base + 1
	AdminEvents_WA_SendMail					= AdminEvents_AW_Base + 2
	AdminEvents_AW_Base = AdminEvents_AW_Base + 2
	-- 禁言操作
	AdminEvents_AW_Gag						= AdminEvents_AW_Base + 1
	AdminEvents_WA_Gag						= AdminEvents_AW_Base + 2
	AdminEvents_AW_Base = AdminEvents_AW_Base + 2
	-- 复位角色坐标
	AdminEvents_AW_GetPosInfo				= AdminEvents_AW_Base + 1
	AdminEvents_WA_GetPosInfo				= AdminEvents_AW_Base + 2
	AdminEvents_WA_GoTo						= AdminEvents_AW_Base + 3
	AdminEvents_AW_GoTo						= AdminEvents_AW_Base + 4
	AdminEvents_AW_ResetPos					= AdminEvents_AW_Base + 5
	AdminEvents_AW_Base = AdminEvents_AW_Base + 5
	
	
AdminSystem = class(EventSetDoer, Singleton)

function AdminSystem:__init()
	self._doer = {
		[AdminEvents_AW_Test]			= AdminSystem.onTest,
		[AdminEvents_AW_GetRoleInfo]	= AdminSystem.onGetRoleInfo,
		[AdminEvents_AW_KickPlayer]		= AdminSystem.onKickPlayer,
		[AdminEvents_AW_GetActivityInfo]= AdminSystem.onGetActivityInfo,
		[AdminEvents_AW_OpenActivity]	= AdminSystem.onOpenActivity,
		[AdminEvents_AW_CloseActivity]	= AdminSystem.onCloseActivity,
		[AdminEvents_AW_ChangeActivity]	= AdminSystem.onChangeActivity,
		
		[AdminEvents_AW_Broadcast]		= AdminSystem.onBroadcastInfo,
	}
end

function AdminSystem:onTest(event)
	local params = event:getParams()
	local id = params[1]
	local num = params[2]
	local str = params[3]

	local result = 1
	local data = {name="zgj", job="IT", info=str}
	local e = Event.getEvent(AdminEvents_WA_Test, id, result, data)
	-- RemoteEventProxy.sendToAdmin(e)
	g_eventMgr:fireAdminEvent(e)
end

function AdminSystem:onGetRoleInfo(event)
	local params = event:getParams()
	print ("onGetRoleInfo", toString(params))
	local id = params[1]
	local roleid = params[2]

	local player = g_entityMgr:getPlayerByDBID(roleid)
	local data = nil
	if player then
		data = {account=player._accountID}
	else
		data = {account=-1}
	end

	local result = 1
	local e = Event.getEvent(AdminEvents_WA_GetRoleInfo, id, result, data)
	g_eventMgr:fireAdminEvent(e)
end

function AdminSystem:onKickPlayer(event)
	local params = event:getParams()
	print ("onKickPlayer", toString(params))
	local id = params[1]
	local name = params[2]
	local player = g_entityMgr:getPlayerByName(name)
	local result = 0
	if player then
		g_playerMgr:kickOutPlayer(player:getDBID())
		result = 1
	end
	local e = Event.getEvent(AdminEvents_WA_KickPlayer, id, result, name)
	g_eventMgr:fireAdminEvent(e)
end

-- 活动部分
-- {{id = "",name = "",state = "",startType = "",startTime = "",endTime	= "",}}
function AdminSystem:onGetActivityInfo(event)
	local params = event:getParams()
	local id = params[1]
	local result = 1
	-- print("____onGetActivityInfo",toString(params))
	-- 活动数据处理
	local data = g_activityMgr:getActivityInfo()
	if not data then
		result = 0
	end
	-- print("____onGetActivityInfo",toString(data))
	local e = Event.getEvent(AdminEvents_WA_GetActivityInfo, id, result, data)
	g_eventMgr:fireAdminEvent(e)
end

function AdminSystem:onOpenActivity(event)
	local params = event:getParams()
	local id = params[1]
	local activityId = params[2]
	activityId = tonumber(activityId)
	
	print("-----onOpenActivity",toString(params))
	if activityId then
		local result = 1
		--
		local activity = g_activityMgr:getActivity(activityId)
		if not activity then
			g_activityMgr:openActivity(activityId, ActivityDB[activityId].name)
		else
			result = 0
		end
		local data = g_activityMgr:getActivityInfo()
		if not data then
			result = 0
		end
		-- 更新界面
		local e = Event.getEvent(AdminEvents_WA_GetActivityInfo, id, result, data)
		g_eventMgr:fireAdminEvent(e)
	end
end

function AdminSystem:onCloseActivity(event)
	print("-----onOpenActivity",toString(params))
	local params = event:getParams()
	local id = params[1]
	local activityId = params[2]
	activityId = tonumber(activityId)
	local result = 1
	if activityId then
		local activity = g_activityMgr:getActivity(activityId)
		if activity then
			g_activityMgr:closeActivity(activityId)
		else	
			result = 0
		end
		local data = g_activityMgr:getActivityInfo()
		if not data then
			result = 0
		end
		-- 更新界面
		local e = Event.getEvent(AdminEvents_WA_GetActivityInfo, id, result, data)
		g_eventMgr:fireAdminEvent(e)
	end
end

function AdminSystem:onChangeActivity(event)
	local params = event:getParams()
	local id = params[1]
	local activityId = params[2]
	local result = 1
end

-- 公告 得到默认公告表
function AdminSystem:getBroadcastInfo(event)
	local params = event:getParams()
	local id = params[1]
	-- local info = params[2]
	local result = 1
	
end

function AdminSystem:onBroadcastInfo(event)
	local params = event:getParams()
	local id = params[1]
	local context = params[2]
	local period = params[3]
	local times = params[4]
	local result = 1
	print("result-----",context,period,times)
	local data = 1
	g_adminMgr:onBroadcast(context,period,times)
	local e = Event.getEvent(AdminEvents_WA_Broadcast, id, result, data)
	g_eventMgr:fireAdminEvent(e)
end

function AdminSystem.getInstance()
	return AdminSystem()
end

EventManager.getInstance():addEventListener(AdminSystem.getInstance())

