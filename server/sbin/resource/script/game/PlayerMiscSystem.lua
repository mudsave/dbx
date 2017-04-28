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
		[AutoPointEvent_CS_ModifyAttrPlan]		= PlayerMiscSystem.doModifyDistribution,
		[AutoPointEvent_CS_ModifyPhazPlan]		= PlayerMiscSystem.doModifyOrders,
		[PlayerSysEvent_CS_ShowDramaChanged]    = PlayerMiscSystem.doChangeShowDrama,
	}
end

function PlayerMiscSystem:doChangeShowDrama(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	if player then
		local dbid = player:getDBID()
		LuaDBAccess.changeShowDrama(dbid)
	end
end

-- 分配玩家属性点
function PlayerMiscSystem:doAttributePointChanged(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local attrTable = params[2]
	local attrPoint = 0
	for attrType,attrValue in pairs(attrTable) do
		if attrType < player_str_point or attrType > player_dex_point then
			-- print("属性类型无效。")
			return
		end
		if attrValue < 0 then
			-- print "尝试减去一个属性点"
			return
		end
		attrPoint = attrPoint+attrValue
	end
	local nPointLeft = player:getAttrValue(player_attr_point) - attrPoint
	if nPointLeft < 0 then
		print("属性点不足。")
		return
	end
	for attrType,attrValue in pairs(attrTable) do
		player:addAttrValue(attrType,attrValue)
	end
	player:setAttrValue(player_attr_point,nPointLeft)
	
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
	-- local roleID = params[1]
	local attrTable = params[2]
	
	local phasePoint = 0
	for attrName,attrValue in pairs(attrTable) do
		if attrName < player_win_phase_point or attrName > player_poi_phase_point then
			print("设置角色相性点:属性类型无效。")
			return
		end
		if attrValue < 0 then
			print "设置角色相性点:试图以负数设置属性"
			return
		end
		if player:getAttrValue(attrName) + attrValue > 35 then
			print "不能在一个相性点上分配超过35点"
			return
		end
		phasePoint = phasePoint+attrValue
	end
	local leftPnts = player:getAttrValue(player_phase_point)-phasePoint
	if leftPnts < 0 then
		print "相性点不足。"
		return
	end
	for attrName,attrValue in pairs(attrTable) do
		player:addAttrValue(attrName,attrValue)
	end
	player:setAttrValue(player_phase_point,leftPnts)
	player:flushPropBatch()
end

function PlayerMiscSystem:doRoleUpgrade(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)

	if not player:handleLevelUP( 1 ) then
		print("玩家经验不够")
	end

end

-- 变更玩家或者宠物的属性自动分配方案
function PlayerMiscSystem:doModifyDistribution(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()
	local entityID	= params[1]
	local plan = params[2]

	local entity
	if entityID == event.playerID then
		entity  = player
	else
		entity = player:getPet(entityID)
	end
	if not entity then
		print "没有实体可以设置自动加点方案"
		return
	end
	local handler = entity:getHandler( HandlerDef_AutoPoint )
	if handler:setAttrPlan( plan ) then
		print "设置加点方案成功"
		local effective = handler:effect( entity,AutoPointHandler.Attr )
		handler:sendToClient( entity,player,AutoPointHandler.Attr )
		if effective then
			print "分配属性点成功"
			entity:flushPropBatch( player )
		end
	else
		print( ("设置%s的加点方案失败"):format( string.gbkToUtf8( entity:getName() ) ) )
	end
end

-- 变更玩家的相性点自动分配方案
function PlayerMiscSystem:doModifyOrders(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	local params = event:getParams()

	local entityID	= params[1]
	local plan		= params[2]

	if entityID == event.playerID then
		local handler = player:getHandler(HandlerDef_AutoPoint)
		if handler and handler:setPhazPlan( plan ) then
			local effective =  handler:effect( player, AutoPointHandler.Phaz )
			handler:sendToClient( player,player,AutoPointHandler.Phaz )
			if effective then
				player:flushPropBatch()
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
