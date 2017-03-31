
-- 定义运维工具使用的Event ID
-- 世界服(AW)
	AdminEvents_AW_Base = 0
	AdminEvents_AW_Test						= AdminEvents_AW_Base + 1
	AdminEvents_WA_Test						= AdminEvents_AW_Base + 2
	AdminEvents_AW_GetRoleInfo				= AdminEvents_AW_Base + 3
	AdminEvents_WA_GetRoleInfo				= AdminEvents_AW_Base + 4
	AdminEvents_AW_KickPlayer				= AdminEvents_AW_Base + 5
	AdminEvents_WA_KickPlayer				= AdminEvents_AW_Base + 6

AdminSystem = class(EventSetDoer, Singleton)

function AdminSystem:__init()
	self._doer = {
		[AdminEvents_AW_Test] = AdminSystem.onTest,
		[AdminEvents_AW_GetRoleInfo] = AdminSystem.onGetRoleInfo,
		[AdminEvents_AW_KickPlayer] = AdminSystem.onKickPlayer,
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

function AdminSystem.getInstance()
	return AdminSystem()
end

EventManager.getInstance():addEventListener(AdminSystem.getInstance())

