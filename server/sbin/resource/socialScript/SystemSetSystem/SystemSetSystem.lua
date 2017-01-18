--[[SystemSetSystem.lua

    Function: Receive the event from client or other server
    Author: Jiangyu

]]

require "SystemSetSystem.SystemSetSysMgr"


SystemSetSystem = class(EventSetDoer, Singleton)

function SystemSetSystem:__init()
	self._doer = {
		[SysStemSet_SB_UpdateSystemSetData]    = SystemSetSystem.updateSystemSetData,
	}
end

function SystemSetSystem:updateSystemSetData(event)
	local params = event:getParams()
    local roleDBID = params[1]
	local data = params[2]
	local role = g_playerMgr:getPlayerByDBID(roleDBID)
	g_systemSetMgr:updateSystemSetData(role,data)
end

function SystemSetSystem.getInstance()
	return SystemSetSystem()
end

g_eventMgr:addEventListener(SystemSetSystem.getInstance())
