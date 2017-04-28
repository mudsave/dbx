--[[main.lua
描述：
	游戏的主服务器脚本
--]]

package.path = "script/?.lua;" .. package.path
print("[Lua] package.path = ", package.path)

require "base.base"
require "event.Event"
require "event.EventSetDoer"
require "event.EventManager"
require "event.rpc"
require "event.EventID"
require "dkjson"

g_eventMgr = EventManager.getInstance()
JSON = require("dkjson")

App = {}

function App.load()
	g_eventMgr = EventManager.getInstance()
	require "admin"
end

function App.onReceive(...)
	RPC.receive(...)
end

function App.onLuaError(msg)
	RPC.debug(msg)
end

function AppStart()
	App.load()
end

function printError(msg)
	print ("[ERROR] " .. msg)
	print (debug.traceback())
	return 0;
end
