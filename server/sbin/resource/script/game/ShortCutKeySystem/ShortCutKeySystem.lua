--[[ShortCutKeySystem.lua
描述:
	快捷栏系统
]]
require "game.ShortCutKeySystem.ShortCutKeyManager"

ShortCutKeySystem = class(EventSetDoer, Singleton)

function ShortCutKeySystem:__init()
	self._doer = {
		[ShortCutKeyEvents_CS_UpdateKeyData]				= ShortCutKeySystem.updateKeyData,
		[ShortCutKeyEvents_CS_UpdateKeyDataForUseUp]		= ShortCutKeySystem.updateKeyDataForUseUp,
	}
end

--同步快捷栏数据到服务器
function ShortCutKeySystem:updateKeyData(event)
	local params = event:getParams()
	local roleID = params[1]
	local tempInfo = params[2]
	g_ShortCutKeyMgr:updateShortCutKeyData(roleID,tempInfo)
end

--物品用完时同步快捷栏数据到服务器
function ShortCutKeySystem:updateKeyDataForUseUp(event)
	local params = event:getParams()
	local roleID = params[1]
	local tempInfo = params[2]
	local flag = params[3]
	g_ShortCutKeyMgr:updateShortCutKeyDataForUseUp(roleID,tempInfo,flag)
end

function ShortCutKeySystem.getInstance()
	return ShortCutKeySystem()
end

EventManager.getInstance():addEventListener(ShortCutKeySystem.getInstance())