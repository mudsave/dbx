--[[Player.lua
描述：
	玩家核心数据
--]]

local setPropValue		= setPropValue		-- 设置peer中属性值,不会导致发送
local getPropValue		= getPropValue		-- 获得peer中属性值
local flushPropBatch	= flushPropBatch	-- 发送peer中所有最新的属性值

Player = class(Entity)

function Player:__init(roleId, gatewayId, hClientLink, hGateLink)
	self._dbId			= roleId
	self._gatewayId		= gatewayId
	self._hClientLink	= hClientLink
	self._hGateLink		= hGateLink
	self._status		= ePlayerNone
	self:__init_basic()
	self:__init_logic()
end

function Player:__release()
	self:__release_logic()
	self:__release_basic()
end

function Player:getDBID()
	return self._dbId
end

require "entity.PlayerBasic"
require "entity.PlayerLogic"
