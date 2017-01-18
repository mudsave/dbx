--[[RoleConfigSystem.lua
	描述：玩家功能数据
]]

require "game.RoleConfigSystem.RoleConfigManager"

RoleConfigSystem = class(EventSetDoer, Singleton)
function RoleConfigSystem:__init()
	self._doer = {
		[RoleConfigureEvent_CS_DoSaveFun]		= RoleConfigSystem.doSaveFun,
	}
end

function RoleConfigSystem:doSaveFun(event)
	local params = event:getParams()
	local roleID = params[1]
	local funSetting = params[2]
	g_RoleConfigMgr:doSaveFun(roleID,funSetting)
end

function RoleConfigSystem.getInstance()
	return RoleConfigSystem()
end

EventManager.getInstance():addEventListener(RoleConfigSystem.getInstance())