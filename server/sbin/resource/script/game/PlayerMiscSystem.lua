--[[PlayerMiscSystem.lua
描述：
	玩家业务系统
--]]

require "base.base"

PlayerMiscSystem = class(EventSetDoer, Singleton)

function PlayerMiscSystem:__init()
	self._doer = {
		[PlayerSysEvent_CS_AttrPointChanged]	= PlayerMiscSystem.doAttributePointChanged,
		[PlayerSysEvent_CS_PhasePointChanged]	= PlayerMiscSystem.doPhasePointChanged,
		[PlayerSysEvent_CS_RoleUpgrade]			= PlayerMiscSystem.doRoleUpgrade, 
		[AutoPointEvent_CS_ModifyDistribution]	= PlayerMiscSystem.doModifyDistribution,
		[AutoPointEvent_CS_ModifyOrder]			= PlayerMiscSystem.doModifyOrders,
	}
end

--分配玩家属性点
function PlayerMiscSystem:doAttributePointChanged(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local attrTable = params[2]
	local attrPoint = 0
	for attrType,attrValue in pairs(attrTable) do
		if attrType < player_str_point or attrType > player_dex_point then
			print("属性类型无效。")
			return
		end
		attrPoint = attrPoint+attrValue
	end
	local subAttrPoint = player:getAttrValue(player_attr_point)-attrPoint
	if subAttrPoint < 0 then
		print("属性点不足。")
	end
	for attrType,attrValue in pairs(attrTable) do
		player:addAttrValue(attrType,attrValue)
	end
	player:setAttrValue(player_attr_point,subAttrPoint)
	
	player:flushPropBatch()
	
	-- g_eventMgr:fireRemoteEvent(
		-- Event.getEvent(
			-- PlayerSysEvent_SC_AttrPointChanged
		-- ),player
	-- )
end

function PlayerMiscSystem:doPhasePointChanged(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local attrTable = params[2]
	
	local phasePoint = 0
	for attrName,attrValue in pairs(attrTable) do
		if attrName < player_win_phase_point or attrName > player_poi_phase_point then
			print("属性类型无效。")
			return
		end
		if attrValue < 0 then
			print "试图以负数设置属性"
			return
		end
		if player:getAttrValue(attrName) + attrValue > 35 then
			print "不能在一个相性点上分配超过35点"
			return
		end
		phasePoint = phasePoint+attrValue
	end
	local subPhasePoint = player:getAttrValue(player_phase_point)-phasePoint
	if subPhasePoint < 0 then
		print("相性点不足。")
		return
	end
	for attrName,attrValue in pairs(attrTable) do
		player:addAttrValue(attrName,attrValue)
	end
	player:setAttrValue(player_phase_point,subPhasePoint)
	player:flushPropBatch()
end

function PlayerMiscSystem:doRoleUpgrade(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local xp = player:getAttrValue(player_xp)
	local next_xp = player:getAttrValue(player_next_xp)
	if xp < next_xp then
		print("经验不足，无法升级。")
		return
	else
		player:setAttrValue(player_xp,xp-next_xp)
		player:onLevelUp(player:getLevel()+1)
	end
	g_eventMgr:fireRemoteEvent(
		Event.getEvent(
			PlayerSysEvent_SC_RoleUpgrade
		),player
	)
end

--[[
	变更玩家或者宠物的属性自动分配方案
]]
function PlayerMiscSystem:doModifyDistribution(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local entityID	= params[1]
	local data		= params[2]
	local auto		= params[3]
	local handler = nil
	if entityID == player:getID() then
		handler = player:getHandler(HandlerDef_AutoPoint)
	else
		local pet = player:getPet(entityID)
		handler = pet and pet:getHandler(HandlerDef_AutoPoint)
	end
	if not handler then return false end

	local planID,planData
	if type(data) == 'number' and data ~= 0 then
		planID = data
	else
		planID = 0
		planData = data
	end
	if not handler:setDistribution(planID,planData) then
		return false
	end
	handler:setAutoAttr(auto)
	handler:sendDistribution(player)
	if auto then handler:distibuteAttrPoints() end
end

--[[
	变更玩家的相性点自动分配方案
]]
function PlayerMiscSystem:doModifyOrders(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()

	local entityID	= params[1]
	local order		= params[2]
	local auto		= params[3]

	if entityID == player:getID() then
		local handler = player:getHandler(HandlerDef_AutoPoint)
		if handler and handler:setOrder(order) then
			handler:setAutoPhase(auto)
			handler:sendOrder(player)
			if auto then
				handler:distibutePhasePoints()
			end
		end
	else
		print "宠物不支持相性分配"
	end
end

function PlayerMiscSystem.getInstance()
	return PlayerMiscSystem()
end

EventManager.getInstance():addEventListener(PlayerMiscSystem.getInstance())