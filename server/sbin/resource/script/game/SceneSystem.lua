--[[SceneSystem.lua
描述：
	客户端场景表现
--]]

SceneSystem = class(EventSetDoer, Singleton)

function SceneSystem:__init()
	self._doer = {
		[SceneEvent_CS_SwitchScene]			= SceneSystem.doSwitchScene,		--切换场景
		[SceneEvent_CS_PlayerFlyEffect]		= SceneSystem.doFlyEffect,			--飞剑效果
		[SceneEvent_CS_NoticeTileChange]	= SceneSystem.doNoticeTileChange,	--tile同步
		[SceneEvent_CS_PlayerUnderAttack]	= SceneSystem.doPlayerUnderAttack,	--玩家受击
		[SceneEvent_CS_PlayerAutoSender]	= SceneSystem.doPlayerAutoSender,	--玩家传送
		[SceneEvent_CS_UpdateOrganPosition] = SceneSystem.doUpdateOrganPosition,--更新移动路径
		[SceneEvent_CS_PositionRevert]		= SceneSystem.doPositionRevert,		--回到初始点
		[SceneEvent_CS_PlayerTransfer]		= SceneSystem.doPlayerTransfer,		--同地图传送
		[SceneEvent_CS_MoveSpeedEffect]		= SceneSystem.doMoveSpeedEffect,	--减速效果
	}
end

--飞机动画切换场景
function SceneSystem:doSwitchScene(event)
	local params = event:getParams()
	local roleID		= params[1]
	local tarMapID		= params[2]
	local tarX			= params[3]
	local tarY			= params[4]
	g_sceneMgr:doSwitchScence(roleID, tarMapID, tarX, tarY)
end

--开始执行飞机动画
function SceneSystem:doFlyEffect(event)
	local params = event:getParams()
	local roleID = params[1]
	local flyEffectID = params[2]
	local player = g_entityMgr:getPlayerByID(roleID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		for _,memberInfo in pairs(team:getMemberList()) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			CactionSystem.getInstance():doFlyEffect(member, flyEffectID)	
		end
	else
		CactionSystem.getInstance():doFlyEffect(player, flyEffectID)
	end
end

--矫正服务器坐标改变
function SceneSystem:doNoticeTileChange(event)
	local params = event:getParams()
	local roleID = params[1]
	local tile = params[2]
	local player = g_entityMgr:getPlayerByID(roleID)
	player:getPeer():clearMyAround()
	player:getPeer():clearAroundMe()
	player:getPeer():stopMove(tile.x, tile.y)
end

function SceneSystem:doPlayerUnderAttack(event)
	local params = event:getParams()
	local roleID = params[1]
	local effectID = params[2]
	local hurtValue = params[3]
	local attackType = params[4]	--0为掉血，1为加血
	local targetID = params[5]
	local realHurtValue = (attackType == 1) and hurtValue or -hurtValue

	local player = g_entityMgr:getPlayerByID(roleID)

	--先通知队长下坐骑
	g_rideMgr:UpOrDownRide(player)

	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		for _,memberInfo in pairs(team:getMemberList()) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			local lifeState 
			if team:getLeaderID() == memberInfo.memberID then
				lifeState = (member:getHP() + realHurtValue) > 0 and 1 or 8
				member:incHp(realHurtValue)
			else
				lifeState = 1
				if member:getHP() ~= 1 then 
					member:incHp(realHurtValue)
					if member:getHP() == 0 then
						member:setHP(1)
					end
				end
			end
			member:flushPropBatch()
			local event = Event.getEvent(SceneEvent_SC_PlayerUnderAttack, roleID, effectID, realHurtValue, lifeState, targetID)
			g_eventMgr:fireRemoteEvent(event, member)
		end
	else
		local lifeState = (player:getHP() + realHurtValue) > 0 and 1 or 8
		player:incHp(realHurtValue)
		player:flushPropBatch()
		local event = Event.getEvent(SceneEvent_SC_PlayerUnderAttack, roleID, effectID, realHurtValue, lifeState, targetID)
		g_eventMgr:fireRemoteEvent(event, player)
	end
	-- 通知副本系统，玩家受到撞击
	local localEvent = Event.getEvent(SceneEvent_SS_AttackEffect, roleID)
	g_eventMgr:fireEvent(localEvent)
end

--副本传送
function SceneSystem:doPlayerAutoSender(event)
	local params = event:getParams()
	local roleID = params[1]
	local xPos = params[2]
	local yPos = params[3]
	local mapID = params[4]
	local player = g_entityMgr:getPlayerByID(roleID)
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if ectype then
		local curMapID = player:getPos()[1]
		if curMapID == mapID then
			local roleInfo = {player, xPos, yPos}
			g_sceneMgr:enterEctypeScene(ectypeMapID, roleInfo)
		else		
			ectype:enterEctypeOtherScene(xPos, yPos, player)	
		end
	else
		g_sceneMgr:enterPublicScene(mapID, player, xPos, yPos)
	end
end

function SceneSystem:doPlayerTransfer(event)
	local params = event:getParams()
	local roleID = params[1]
	local effectID = params[2]
	local xPos = params[3]
	local yPos = params[4]

	local player = g_entityMgr:getPlayerByID(roleID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		for _,memberInfo in pairs(team:getMemberList()) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			local event = Event.getEvent(SceneEvent_SC_PlayerTransfer, roleID, effectID, xPos, yPos)
			g_eventMgr:fireRemoteEvent(event, member)
		end
	else
		local event = Event.getEvent(SceneEvent_SC_PlayerTransfer, roleID, effectID, xPos, yPos)
		g_eventMgr:fireRemoteEvent(event, player)
	end	
end

function SceneSystem:doPositionRevert(event)
	local params = event:getParams()
	local roleID = params[1]
	local player = g_entityMgr:getPlayerByID(roleID)
	local ectypeHandler = player:getHandler(HandlerDef_Ectype)
	local ectypeMapID = ectypeHandler:getEctypeMapID()
	local ectype = g_ectypeMgr:getEctype(ectypeMapID)
	if ectype then
		local teamHandler = player:getHandler(HandlerDef_Team)
		local teamID = teamHandler:getTeamID()
		local maxHp
		if teamID > 0 then
			local team = g_teamMgr:getTeam(teamID)
			if team:getLeaderID() == roleID then
				for _, memberInfo in pairs(team:getMemberList()) do
					local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
					if roleID == memberInfo.memberID then
						maxHp = member:getAttrValue(player_max_hp)
						member:setHP(math.floor(0.01*maxHp))
					else
						if member:getHP() == 1 then
							maxHp = member:getAttrValue(player_max_hp)
							member:setHP(math.floor(0.01*maxHp))
						end
					end
					member:flushPropBatch()
				end
				ectype:returnEctypeInitLocs()
			end
		else
			maxHp = player:getAttrValue(player_max_hp)
			player:setHP(math.floor(0.01*maxHp))
			player:flushPropBatch()
			ectype:returnEctypeInitLocs()
		end
	end
end

function SceneSystem:doUpdateOrganPosition(event)
	local params = event:getParams()
	local roleID = params[1]
	local trapEntityID = params[2]
	local xPos = params[3]
	local yPos = params[4]
	local player = g_entityMgr:getPlayerByID(roleID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		for _,memberInfo in pairs(team:getMemberList()) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			local event = Event.getEvent(SceneEvent_SC_UpdateOrganPosition, trapEntityID, xPos, yPos)
			g_eventMgr:fireRemoteEvent(event, member)
		end
	else
		local event = Event.getEvent(SceneEvent_SC_UpdateOrganPosition, trapEntityID, xPos, yPos)
		g_eventMgr:fireRemoteEvent(event, player)
	end	
end

function SceneSystem:doMoveSpeedEffect(event)
	local params = event:getParams()
	local roleID = params[1]
	local effectID = params[2]
	local speed = params[3]	
	local player = g_entityMgr:getPlayerByID(roleID)
	local teamHandler = player:getHandler(HandlerDef_Team)
	local teamID = teamHandler:getTeamID()
	local team = g_teamMgr:getTeam(teamID)
	if team then
		for _,memberInfo in pairs(team:getMemberList()) do
			local member = g_entityMgr:getPlayerByID(memberInfo.memberID)
			member:setMoveSpeed(speed)
			if effectID then
				local event = Event.getEvent(SceneEvent_SC_MoveSpeedEffect, roleID, effectID)
				g_eventMgr:fireRemoteEvent(event)
			end
		end
	else
		player:setMoveSpeed(speed)
		if effectID then
			local event = Event.getEvent(SceneEvent_SC_MoveSpeedEffect, roleID, effectID)
			g_eventMgr:fireRemoteEvent(event)
		end
	end
end

-------------------------------------

--副本切换队长
function SceneSystem:changeLeader(leaderID)
	--local event = Event.getEvent(SceneEvent_SC_ChangeTrapEffectTarget, leaderID)
	--g_eventMgr:fireRemoteEvent(event)
end

function SceneSystem.getInstance()
	return SceneSystem()
end

g_eventMgr:addEventListener(SceneSystem.getInstance())
