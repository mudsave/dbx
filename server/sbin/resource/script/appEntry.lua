--[[appEntry.lua
描述：
	游戏的主服务器脚本
--]]

package.path = "../resource/script/?.lua"

require "config.ConfCore"
require "config.ConfDB"
require "config.ConfSystem"

ManagedApp = {}
function ManagedApp.start(serverID)
	LoadCore(serverID)
	LoadSystem()
end

function ManagedApp.onPlayerMessage(hLink, msg)
	g_playerMgr:onPlayerMessage(hLink, msg)
end

function ManagedApp.timerFired(timerID, state)
	if state == ScriptTimerNormal then
		g_timerMgr:update(timerID)
	else
		g_timerMgr:notify(timerID, state)
	end
end

function ManagedApp.exeSP(params, bNoCallback, level)
end

function ManagedApp.onExeSP(operationID, recordList, errorCode)
end