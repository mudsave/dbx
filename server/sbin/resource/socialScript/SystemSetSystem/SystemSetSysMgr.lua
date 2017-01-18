--[[SystemSetSysMgr.lua

    Function: The manager of SystemSet
    Author: Jiangyu

]]

SystemSetSysMgr = class(nil, Singleton)

function SystemSetSysMgr:__init()
	
end

function SystemSetSysMgr:updateSystemSetData(player,data)
	local systemSetHandler = player:getHandler(HandlerDef_SystemSet)
	systemSetHandler:setSystemData(data)
end

function SystemSetSysMgr.getInstance()
	return SystemSetSysMgr()
end