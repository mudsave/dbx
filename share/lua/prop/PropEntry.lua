--[[PropEntry.lua
	各类属性集的初始化
]]

local function loadUnitConfig()
--[[
	if Application:getInstancePtr():isMpkClient() then
		require "lua.prop.UnitProp"
		require "lua.prop.PlayerProp"
		require "lua.prop.PetProp"
		require "lua.prop.NpcProp"
	else
	]]
		require "prop.UnitProp"
		require "prop.PlayerProp"
		require "prop.PetProp"
		require "prop.NpcProp"
	--end
end

loadUnitConfig()
