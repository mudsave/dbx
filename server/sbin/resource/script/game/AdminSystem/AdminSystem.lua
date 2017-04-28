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
	AdminEvents_AW_BanSpeech				= AdminEvents_AW_Base + 1
	AdminEvents_WA_BanSpeech				= AdminEvents_AW_Base + 2
	AdminEvents_AW_Base = AdminEvents_AW_Base + 2
	-- 复位角色坐标
	AdminEvents_AW_GetOnlinePlayerByName	= AdminEvents_AW_Base + 1
	AdminEvents_AW_GetOnlinePlayerByDBID	= AdminEvents_AW_Base + 2
	AdminEvents_AW_ResetPos					= AdminEvents_AW_Base + 3				
	AdminEvents_AW_CheckPosOrGoTo			= AdminEvents_AW_Base + 4
	AdminEvents_WA_GetOnlinePlayerInfo		= AdminEvents_AW_Base + 5
	AdminEvents_AW_Base = AdminEvents_AW_Base + 5
	

AdminSystem = class(EventSetDoer, Singleton)

function AdminSystem:__init()
	self._doer = {
		[AdminEvents_AW_Test]						= AdminSystem.onTest,
		[AdminEvents_AW_GetRoleInfo]				= AdminSystem.onGetRoleInfo,
		[AdminEvents_AW_KickPlayer]					= AdminSystem.onKickPlayer,
		[AdminEvents_AW_GetActivityInfo]			= AdminSystem.onGetActivityInfo,
		[AdminEvents_AW_OpenActivity]				= AdminSystem.onOpenActivity,
		[AdminEvents_AW_CloseActivity]				= AdminSystem.onCloseActivity,
		[AdminEvents_AW_ChangeActivity]				= AdminSystem.onChangeActivity,
		[AdminEvents_AW_Broadcast]					= AdminSystem.onBroadcastInfo,				
		[AdminEvents_AW_SendMail]					= AdminSystem.onSendMail,				
		[AdminEvents_AW_GetOnlinePlayerByName]		= AdminSystem.onGetOnlinePlayerByName,
		[AdminEvents_AW_GetOnlinePlayerByDBID]		= AdminSystem.onGetOnlinePlayerByDBID,
		[AdminEvents_AW_ResetPos]					= AdminSystem.onResetPos,
		[AdminEvents_AW_CheckPosOrGoTo]				= AdminSystem.onCheckPosOrGoTo,
		
		[AdminEvents_AW_BanSpeech]					= AdminSystem.onBanSpeech,
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
	local roleID = params[2]
	local data = {}
	roleID = tonumber(roleID)
	local player = g_entityMgr:getPlayerByDBID(roleID)
	local result,msg = g_adminDoer:onKickPlayer(player)
	data.result = result
	data.msg = msg
	local e = Event.getEvent(AdminEvents_WA_KickPlayer, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

-- 活动部分
-- {{id = "",name = "",state = "",startType = "",startTime = "",endTime	= "",}}
function AdminSystem:onGetActivityInfo(event)
	local params = event:getParams()
	local id = params[1]
	
	local data = g_adminDoer:getActivityInfo()
	local e = Event.getEvent(AdminEvents_WA_GetActivityInfo, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

function AdminSystem:onOpenActivity(event)
	local params = event:getParams()
	local id = params[1]
	local activityId = params[2]
	activityId = tonumber(activityId)
	print("-----onOpenActivity",toString(params))
	if activityId then
		local activity = g_activityMgr:getActivity(activityId)
		if not activity then
			g_activityMgr:openActivity(activityId, ActivityDB[activityId].name)
		end
		local data = g_adminDoer:getActivityInfo()
		-- 更新界面
		local e = Event.getEvent(AdminEvents_WA_GetActivityInfo, id, 1, data)
		g_eventMgr:fireAdminEvent(e)
	end
end

function AdminSystem:onCloseActivity(event)
	print("-----onOpenActivity",toString(params))
	local params = event:getParams()
	local id = params[1]
	local activityId = params[2]
	activityId = tonumber(activityId)
	if activityId then
		local activity = g_activityMgr:getActivity(activityId)
		if activity then
			g_activityMgr:closeActivity(activityId)
		end
		local data = g_adminDoer:getActivityInfo()
		-- 更新界面
		local e = Event.getEvent(AdminEvents_WA_GetActivityInfo, id, 1, data)
		g_eventMgr:fireAdminEvent(e)
	end
end

function AdminSystem:onChangeActivity(event)
	local params = event:getParams()
	local id = params[1]
	local activityId = params[2]
end

-- 公告 得到默认公告表
function AdminSystem:getBroadcastInfo(event)
	local params = event:getParams()
	local id = params[1]
end

function AdminSystem:onBroadcastInfo(event)
	local params = event:getParams()
	local id = params[1]
	local context = params[2]
	local period = params[3]
	local times = params[4]
	print("result-----",context,period,times)
	local data = {result = AdminMsgState.Success,msg = "发送邮件成功"}
	-- 字符转换
	if period then
		period = tonumber(period)
	end
	if times then
		times = tonumber(times)
	end
	
	g_adminDoer:onBroadcast(context,period,times)
	local e = Event.getEvent(AdminEvents_WA_Broadcast, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

-- 发送邮件
function AdminSystem:onSendMail(event)
	local params = event:getParams()
	local id = params[1]
	local idsBuff = params[2]
	local itemsBuff = params[3]
	local themeBuff = params[4]
	local contentBuff = params[5]
	local money = params[6]
	local submoney = params[7]
	local data = {}
	--- 截取字符人物
	local roleDBIDs = {}
	for roleDBID in string.gmatch(idsBuff,"%d+")  do
		roleDBID = tonumber(roleDBID)
		roleDBIDs[roleDBID] = true
		print("roleDBID",roleDBID)
	end
	--- 截取字符物品
	local items = {}
	for itemID,itemNum in string.gmatch(itemsBuff,"(%d+),(%d+)") do
		items[itemID] = itemNum
	end
	print("items--------------",toString(items),table.size(items))
	local result,msg = g_adminDoer:onSendMail(roleDBIDs,items,themeBuff,contentBuff,money,submoney)
	data.result = result
	data.msg = msg
	print("data---",toString(data))
	local e = Event.getEvent(AdminEvents_WA_SendMail, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

-- 通过名字查找
function AdminSystem:onGetOnlinePlayerByName(event)
	local params = event:getParams()
	print("params---",toString(params))
	local id = params[1]
	local roleName = params[2]
	local roleName = string.utf8ToGbk(roleName)
	local result = 1
	local data = {}
	local player = g_entityMgr:getPlayerByName(roleName)
	local result,msg = g_adminDoer:getPlayerInfo(player)
	data.result = result
	data.msg = msg
	print("data---1",toString(data))
	local e = Event.getEvent(AdminEvents_WA_GetOnlinePlayerInfo, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

-- 通过DBID查找
function AdminSystem:onGetOnlinePlayerByDBID(event)
	local params = event:getParams()
	print("params",toString(params))
	local id = params[1]
	local DBID = params[2]
	local data = {}
	
	DBID = tonumber(DBID)
	local player = g_entityMgr:getPlayerByDBID(DBID)
	-- print("DBID-----",DBID)
	-- print("xxxxxx",toString(g_entityMgr:getPlayerByDBIDList()))
	local result,msg = g_adminDoer:getPlayerInfo(player)
	data.result = result
	data.msg = msg
	print("data---2",toString(data))
	local e = Event.getEvent(AdminEvents_WA_GetOnlinePlayerInfo, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

-- 复位
function AdminSystem:onResetPos(event)
	local params = event:getParams()
	print("params",toString(params))
	local id = params[1]
	local DBID = params[2]
	local mapID = params[3]
	local data = {}
	DBID = tonumber(DBID)
	mapID = tonumber(mapID)
	local player = g_entityMgr:getPlayerByDBID(DBID)
	local result,msg = g_adminDoer:reSetPos(player,mapID)
	data.result = result
	data.msg = msg
	print("data---",toString(data))
	local e = Event.getEvent(AdminEvents_WA_GetOnlinePlayerInfo, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

-- 是否传送过去
function AdminSystem:onCheckPosOrGoTo(event)
	local params = event:getParams()
	print("params",toString(params))
	local id = params[1]
	local DBID = params[2]
	local mapID = params[3]
	local posX = params[4]
	local posY = params[5]
	
	DBID = tonumber(DBID)
	mapID = tonumber(mapID)
	posX = tonumber(posX)
	posY = tonumber(posY)
	
	
	local data = {}
	local player = g_entityMgr:getPlayerByDBID(DBID)
	local result,msg = g_adminDoer:checkOrGoToMap(player,mapID,posX,posY)
	data.result = result
	data.msg = msg
	print("data---",toString(data))
	local e = Event.getEvent(AdminEvents_WA_GetOnlinePlayerInfo, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

function AdminSystem:onBanSpeech(event)
	local params = event:getParams()
	print("params",toString(params))
	local id = params[1]
	local DBID = params[2] 
	local period = params[3] 
	DBID = tonumber(DBID)
	period = tonumber(period)
	local data = {}
	local player = g_entityMgr:getPlayerByDBID(DBID)
	local result,msg = g_adminDoer:onBanSpeech(player,period)
	data.result = result
	data.msg = msg
	print("data---",toString(data))
	local e = Event.getEvent(AdminEvents_WA_BanSpeech, id, 1, data)
	g_eventMgr:fireAdminEvent(e)
end

function AdminSystem.getInstance()
	return AdminSystem()
end

EventManager.getInstance():addEventListener(AdminSystem.getInstance())

