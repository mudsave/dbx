
-- 定义运维工具使用的Event ID
-- 世界服(AW)
	AdminEvents_AW_Base = 0 
	AdminEvents_AW_Test				= AdminEvents_AW_Base + 1
	AdminEvents_WA_Test				= AdminEvents_AW_Base + 2


AdminSystem = class(EventSetDoer, Singleton)

function AdminSystem:__init()
	self._doer = {
		[AdminEvents_AW_Test] = AdminSystem.onTest,
	}
end

function AdminSystem:onTest(event)
	local params = event:getParams()
	local id = params[1]
	local num = params[2]
	local str = params[3]

	local result = 1
	local data = {name="zgj", job="IT", info=str}
	local e = Event(AdminEvents_WA_Test, id, result, data)
	RemoteEventProxy.sendToAdmin(e)
end

function AdminSystem.getInstance()
	return AdminSystem()
end

EventManager.getInstance():addEventListener(AdminSystem.getInstance())

