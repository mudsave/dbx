--[[PerformSkill.lua
	战斗外技能执行
]]

PerformSkill = {}

--[[
	技能执行入口
]]
function PerformSkill.perform(player, skillID)
	local data = FightSkillDB[skillID]
	if data and player and player:getActionState() ~= PlayerStates.Fight then
		local func = SkillType2PerformAction[data.skill_type]
		if func then
			-- 消耗类型
			local consumeType = data.consume_type
			-- 消耗公式ID
			local consumeID = data.consume_id
			-- 判断是否满足消耗
			local isTrue, value = PerformSkill.consumeCheck(player, consumeType, consumeID)
			-- 满足则执行技能
			if isTrue and func(player, data) then
				-- 计算消耗
				PerformSkill.calcConsumption(player, consumeType, value)
			end
		else
			print("没有对应的技能执行方法")
		end
	end
end

--[[
	判断技能是否满足消耗
]]
function PerformSkill.consumeCheck(player, type, consumeID)
	if not type then
		return true
	end
	local curValue = 0
	local consumedb = FightSkillDataDB[consumeID]
	local consumeValue = consumedb[player:getLevel()] or 0
	if type == ConsumeType.Mp then
		curValue = player:getMP()
		local tmp = curValue - consumeValue
		if tmp > -1 then
			return true, tmp
		end
		PerformSkill.prompt2Client(player, 4)
	elseif type == ConsumeType.vit then
		curValue = player:getVigor()
		local tmp = curValue - consumeValue
		if tmp > -1 then
			return true, tmp
		end
		PerformSkill.prompt2Client(player, 3)
	end
	return false
end

--[[
	计算消耗
]]
function PerformSkill.calcConsumption(player, type, value)
	if value then
		if type == ConsumeType.Mp then
			player:setMP(value)
		elseif type == ConsumeType.vit then
			player:setVigor(value)
		end
	end
end

--[[
	传送
]]
function PerformSkill.transport(player)
	local teamHandler = player:getHandler(HandlerDef_Team)
	-- 组队状态不能使用
	if teamHandler:isTeam() then
		PerformSkill.prompt2Client(player, 1)
		return false
	end
	
	-- 传送坐标
	local mapID, x, y = unpack(SchoolType2Coordinate[player:getSchool()])
	if not CoScene:PosValidate(mapID, x, y) then
		local event = Event.getEvent(ChatEvents_SC_GotoMsgReturn)
		g_eventMgr:fireRemoteEvent(event, player)
		return false
	end
	local curPos = player:getPos()
	local posX = curPos[2]
	local posY = curPos[3]
	local curMapID = player:getScene():getMapID()
	if curMapID == mapID and posX == x and posY == y then
		PerformSkill.prompt2Client(player, 5)
		return false
	end
	
	--传送停止移动
	local moveHandler = player:getHandler(HandlerDef_Move)
	moveHandler:DoStopMove()
	
	local roleID = player:getID()
	g_sceneMgr:doSwitchScence(roleID, mapID ,x ,y)
	return true
end

--[[
	道具制作
]]
function PerformSkill.toolMake(player, data)
	local effect = unpack(data.skill)
	local effectDB = FightSkillDataDB[effect.num_id]
	if effectDB then
		local itemID = effectDB[player:getLevel()]
		-- itemID = 1011003
		local packetHandler = player:getHandler(HandlerDef_Packet)
		if packetHandler:addItemsToPacket(itemID, 1) then
			PerformSkill.prompt2Client(player, 2)
			return true
		end
		print("找不到制造道具的ID：", itemID)
	end
	return false
end

--[[
	消息提示给客户端
]]
function PerformSkill.prompt2Client(player, index)
	if index then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_UseSkill, index)
		g_eventMgr:fireRemoteEvent(event, player)
	end
end

--[[
	技能类型到对应执行方法
]]
SkillType2PerformAction = {
	[Skill_Type.Transport] = PerformSkill.transport,
	[Skill_Type.ToolMake] = PerformSkill.toolMake,
}

--[[
	门派师门坐标集
]]
SchoolType2Coordinate = {
	[SchoolType.QYD] = {1, 74, 86},
	[SchoolType.JXS] = {3, 104, 72},
	[SchoolType.ZYM] = {6, 86, 48},
	[SchoolType.YXG] = {5, 59, 67},
	[SchoolType.TYD] = {4, 133, 63},
	[SchoolType.PLG] = {2, 85, 43},
}

