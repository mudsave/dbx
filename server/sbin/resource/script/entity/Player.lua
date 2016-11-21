--[[Player.lua
描述：
	玩家核心数据
--]]

Player = class(Entity)

function Player:__init(roleId, gatewayId, hClientLink, hGateLink)
	self._dbId			= roleId
	self._gatewayId		= gatewayId
	self._hClientLink	= hClientLink
	self._hGateLink		= hGateLink
	self._status		= ePlayerNone
	self:__init_logic()

	self._loadPriority = {
		["LoadAttr"] = {1, false, "sp_LoadPlayerAttr"},
	}
end

function Player:__release()
	self:__release_logic()
end

function Player:getDBID()
	return self._dbId
end

function Player:setStatus(status)
	if self._status ~= status then
		self._status = status
		--同步到CoEntity
	end
end

function Player:getStatus()
	return self._status
end

--@param recordList，玩家数据库的基础数据
function Player:loadBasicData(recordList)
	local rs = recordList[1][1]
	--[[
	self:setName(rs.name)
	self:setModelID(rs.modelID)
	self:initShowParts(rs.showParts)
	self:setShowParts(rs.showParts)
	self:setSex(rs.sex and 1 or 0)
	self:setMoney(rs.money)
	self:setSubMoney(rs.subMoney)
	self:setDepotMoney(rs.depotMoney)
	self:setSchool(rs.school)
	self:setDepotCapacity(rs.depotCapacity)
	self:setCashMoney(rs.cashMoney)
	self:setGoldCoin(rs.goldCoin)
	self:setPos({rs.mapID, rs.posX, rs.posY})
	--]]
end

require "entity.PlayerLogic"