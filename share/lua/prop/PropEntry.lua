--[[PropEntry.lua
	各类属性集的初始化
]]

local function loadUnitConfig()
	require "prop.UnitProp"
	require "prop.PlayerProp"
	require "prop.PetProp"
	require "prop.NpcProp"
end

loadUnitConfig()
