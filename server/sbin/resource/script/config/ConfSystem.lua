--[[ConfSystem.lua
描述��?
	系统加载
--]]

function loadSystem()
	require "game.ItemSystem.ItemSystem"
	require "game.RideSystem.RideSystem"
	require "game.TeamSystem.TeamSystem"
	require "game.MoveSystem"
	require "game.ShellSystem"
	g_itemFct			= ItemFactory.getInstance()
	g_itemMgr			= ItemManager.getInstance()
	g_rideMgr			= RideManager.getInstance()
	g_teamMgr			= TeamManager.getInstance()
end
