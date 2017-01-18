-- ShellSystem.lua
--
require "event.EventSetDoer"

ShellSystem = class(EventSetDoer,Singleton)

function ShellSystem:__init()
	self._doer = {
		[ChatEvents_CS_ShellCommand] = ShellSystem.onShellCmd,
	}
end

function ShellSystem:onShellCmd(event)
	local params = event:getParams()
	local playerId = params[1]
	local cmdTxt = params[2]
	self:dealGMCommmand(playerId, cmdTxt)
end

function ShellSystem:dealGMCommmand(playerId, cmdTxt)
	local cmd = nil
	local cmdParams = {}
	for w in string.gmatch(cmdTxt, "[%s]*([^%s]+)") do
		if cmd then
			table.insert(cmdParams, w)
		else
			cmd = w
			table.insert(cmdParams, playerId)
		end
	end
	local method = self[cmd]
	if type(method) == "function" then
		local context={['params']=cmdParams,['se']=self,['cmdName']=cmd}
		local player= g_entityMgr:getPlayerByID(playerId)
		local ret = method(self, unpack(cmdParams))
		local params = table.copy(cmdParams)
		local targetId = tonumber(params[#params])
		--local target= g_entityMgr:getRole(targetId)
		params[1] = nil
		params[#params] = nil
		local sParams = ""
		local index = 1
		for i,k in pairs(params) do
			if index == 1 then
				sParams = sParams..k
			else
				sParams = sParams.." "..k
			end
			index = index + 1
		end
		--[[
		if not target then
			target = player
		end
		local targetGUID

		if not target then
			return
		end
		]]
	end
end


function ShellSystem.getInstance()
	return ShellSystem()
end

EventManager.getInstance():addEventListener(ShellSystem.getInstance())

require "game.GMSystem.GMCmdSystem"
