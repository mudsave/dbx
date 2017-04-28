


AdminSystem = class(EventSetDoer, Singleton)

function AdminSystem:__init()
	self._doer = {
		[AdminEvents_WA_Test]					= AdminSystem.onTest,
		[AdminEvents_WA_GetActivityInfo]		= AdminSystem.getActivityInfo,
		[AdminEvents_WA_Broadcast]				= AdminSystem.getBroadcast,
		[AdminEvents_WA_SendMail]				= AdminSystem.getSendmail,
		[AdminEvents_WA_GetOnlinePlayerInfo]	= AdminSystem.getOnlinePlayerInfo,
	}
end

--[[
request = 
{
	id = 1;
	url= "";
	method= 1;

	arg1 = "";
	arg2 = "";
}
response =
{
	id = 1
	result = 1
	data = {name="zgj", job="IT"}
}
--]]

--[[
request = 
{
	id = 1;
	url= "/start_act";
	method= 1;
	act_id = 1;
}
--]]
function processRequest(request)
	print("___",toString(request))
	
	if request.url == "/get_online_info" then
		local event = Event(AdminEvents_AW_GetActivityInfo, request.id)
		RPC.send(event)
		return
	end
	
	if request.url == "/get_act_info" then
		local event = Event(AdminEvents_AW_GetActivityInfo, request.id)
		RPC.send(event)
		return
	end
	if request.url == "/start_act" then
		local event = Event(AdminEvents_AW_OpenActivity, request.id, request.activityid)
		RPC.send(event)
		return
	end
	if request.url == "/close_act" then
		local event = Event(AdminEvents_AW_CloseActivity, request.id, request.activityid)
		RPC.send(event)
		return
	end
	if request.url == "/broadcast" then
		local event = Event(AdminEvents_AW_Broadcast, request.id, request.content,request.period,request.times)
		RPC.send(event)
		return
	end
	if request.url == "/sendmail" then
		local event = Event(AdminEvents_AW_SendMail, request.id, request.ids,request.items,request.theme,request.content,request.moneny,request.submoney)
		RPC.send(event)
		return
	end
	if request.url == "/get_online_role_info_by_dbid" then
		local event = Event(AdminEvents_AW_GetOnlinePlayerByDBID, request.id, request.DBID)
		RPC.send(event)
		return	
	end
	if request.url == "/get_online_role_info_by_name" then
		local event = Event(AdminEvents_AW_GetOnlinePlayerByName, request.id, request.roleName)
		RPC.send(event)
		return	
	end
	if request.url == "/reset_postion" then
		local event = Event(AdminEvents_AW_ResetPos, request.id, request.DBID)
		RPC.send(event)
		return	
	end
	if request.url == "/set_role_postion" then
		local event = Event(AdminEvents_AW_CheckPosOrGoTo, request.id, request.DBID,request.mapID,request.posX,request.posY,request.isChange)
		RPC.send(event)
		return	
	end
	if request.url then
		local event = Event(AdminEvents_AW_Test, request.id, 100, 'test')
		RPC.send(event)
	end
end

function AdminSystem:onTest(event)
	local params = event:getParams()
	local id = params[1]
	local result = params[2]
	local data = params[3]
	local json_str = JSON.encode(data)
	onResponse(id, result, json_str)
end

function AdminSystem:getActivityInfo(event)
	local params = event:getParams()
	local id = params[1]
	local result = params[2]
	local data = params[3]
	local json_str = JSON.encode(data)
	onResponse(id, result, json_str)
end

function AdminSystem:getBroadcast(event)
	local params = event:getParams()
	local id = params[1]
	local result = params[2]
	local data = params[3]
	local json_str = JSON.encode(data)
	onResponse(id, result, json_str)
end

function AdminSystem:getSendmail(event)
	local params = event:getParams()
	local id = params[1]
	local result = params[2]
	local data = params[3]
	local json_str = JSON.encode(data)
	onResponse(id, result, json_str)
end

function AdminSystem:getOnlinePlayerInfo(event)
	local params = event:getParams()
	local id = params[1]
	local result = params[2]
	local data = params[3]
	local json_str = JSON.encode(data)
	onResponse(id, result, json_str)
end

function AdminSystem.getInstance()
	return AdminSystem()
end

EventManager.getInstance():addEventListener(AdminSystem.getInstance())
