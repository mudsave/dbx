--[[TreasureEffect.lua
描述：
]] 

TreasureEffect = {}

-- 增加金币
function TreasureEffect.addMoney(target, tEventEffectValues, messageInfo)
	local moneyConfig = TreasureUtils.randTreasureEvent(tEventEffectValues)
	print("moneyConfig",toString(moneyConfig))
	local value = TreasureUtils.rangeTreasureValue(moneyConfig)
	-- 消息给客户端
	local treasureHandler = target:getHandler(HandlerDef_Treasure)
	local curMoney = target:getMoney() + value
	target:setMoney(curMoney)
	if not messageInfo.type then
		messageInfo.type = TreasureMessageType.CentralMessages
	end	
	if value > 300000 then
		local tMessage = TreasureBroadCastMessages[TreasureEventEffectType.AddMoney]
		local msgID = TreasureUtils.randTreasureEventEx(tMessage)
		--local msgParams = {}
		local name = target:getName()
		--local msgParams = string.format("%s%s",name ,value)
		--msgParams[1] = name
		--msgParams[2] = toString(value)
		--print("msgParams[1],msgParams[2]",msgParams[1],msgParams[2])
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_TreasureEvent, msgID, name, value)
		g_eventMgr:fireRemoteEvent(event, target)
		-- 转变为特殊提示
		messageInfo.type = TreasureMessageType.SepcialMessages	
	end
	messageInfo.value = value 
	messageInfo.eventType = TreasureEventEffectType.AddMoney
	
	treasureHandler:sendTreasureEventMessage(messageInfo)
	return true
end

-- 增加经验
function TreasureEffect.addExp(target, tEventEffectValues, messageInfo)
	local expConfig = TreasureUtils.randTreasureEvent(tEventEffectValues)
	print("expConfig",toString(expConfig))
	local value = TreasureUtils.rangeTreasureValue(expConfig)
	-- 增加经验
	target:addXp(value)
	-- 消息给客户端
	if not messageInfo.type then
		messageInfo.type = TreasureMessageType.CentralMessages	
	end	
	-- 发出广播消息
	if value > 300000 then
		messageInfo.type = TreasureMessageType.BroadCastMessages
	end
	messageInfo.value = value 
	messageInfo.eventType = TreasureEventEffectType.AddExp
	local treasureHandler = target:getHandler(HandlerDef_Treasure)
	treasureHandler:sendTreasureEventMessage(messageInfo)
	return true
end

-- 增加道行
function TreasureEffect.addTao(target, tEventEffectValues, messageInfo)
	local taoConfig = TreasureUtils.randTreasureEvent(tEventEffectValues)
	print("taoConfig",toString(taoConfig))
	local value = TreasureUtils.rangeTreasureValue(taoConfig)
	target:addTao(value)
	-- 消息种类的改变
	if not messageInfo.type then
		messageInfo.type = TreasureMessageType.CentralMessages	
	end	
	-- 发出广播消息
	if value > 300000 then
		messageInfo.type = TreasureMessageType.BroadCastMessages
	end
	messageInfo.value = value 
	messageInfo.eventType = TreasureEventEffectType.AddTao
	local treasureHandler = target:getHandler(HandlerDef_Treasure)
	-- 消息给客户端
	treasureHandler:sendTreasureEventMessage(messageInfo)
	return true
end

-- 增加潜能
function TreasureEffect.addPot(target, tEventEffectValues, messageInfo)
	local potConfig = TreasureUtils.randTreasureEvent(tEventEffectValues)
	print("potConfig",toString(potConfig))
	local value = TreasureUtils.rangeTreasureValue(potConfig)
	
	-- 消息给客户端
	local treasureHandler = target:getHandler(HandlerDef_Treasure)
	if not messageInfo.type then
		messageInfo.type = TreasureMessageType.CentralMessages	
	end	
	-- 
	-- if value > 300000 then
		-- local msgID = TreasureBroadCastMessages[TreasureEventEffectType.AddMoney]
		-- local msgParams = {}
		-- msgParams[1] = target:getName()
		-- msgParams[2] = value
		-- treasureHandler:sendTreasureBroadCastMessage(msgID,msgParams)
		--转变为特殊提示
		-- messageInfo.type = TreasureMessageType.SepcialMessages	
	-- end
	messageInfo.value = value 
	messageInfo.eventType = TreasureEventEffectType.AddPot
	treasureHandler:sendTreasureEventMessage(messageInfo)
	return true
end

-- 物品奖励效果
function TreasureEffect.addItem(target, tEventEffectValues, messageInfo)
	local itemConfig = TreasureUtils.randTreasureEvent(tEventEffectValues)
	local packetHandler = target:getHandler(HandlerDef_Packet)
	if not packetHandler or not itemConfig then
		return false
	end
	local itemID = itemConfig.ItemID
	packetHandler:addItemsToPacket(itemID, 1)
	-- 消息给客户端
	if not messageInfo.type then
		messageInfo.type = TreasureMessageType.CentralMessages
	end	
	messageInfo.eventType = TreasureEventEffectType.AddItem
	messageInfo.value = {{itemID = itemID}}
	local treasureHandler = target:getHandler(HandlerDef_Treasure)
	treasureHandler:sendTreasureEventMessage(messageInfo)
	return true
end

-- 装备奖励效果
function TreasureEffect.addEquip(target, tEventEffectValues, messageInfo)
	local newTable = TreasureUtils.RandNewTableByLevelLimitEx(target, TreasureItemFloatLvl ,tEventEffectValues)
	local itemConfig = TreasureUtils.randTreasureEvent(newTable)
	local packetHandler = target:getHandler(HandlerDef_Packet)
	if not packetHandler or not itemConfig then
		return false
	end
	local itemID = itemConfig.ItemID
	packetHandler:addItemsToPacket(itemID, 1)
	-- 消息给客户端
	if not messageInfo.type then
		messageInfo.type = TreasureMessageType.CentralMessages
	end	
	messageInfo.eventType = TreasureEventEffectType.AddItem
	messageInfo.value =  tItemDB[itemID].Name
	local treasureHandler = target:getHandler(HandlerDef_Treasure)
	treasureHandler:sendTreasureEventMessage(messageInfo)
	return true
end

-- 怪物战斗
function TreasureEffect.monsterFight(target, tEventEffectValues, messageInfo)
	local tNewMonsterFight = TreasureUtils.RandNewTableByLevelLimit(target,tEventEffectValues)
	local fightConfig = TreasureUtils.randTreasureEvent(tNewMonsterFight)
	local playerList = {}
	local teamHandler = target:getHandler(HandlerDef_Team)
	-- 在点击的时候已经判断了一次是否组队
	-- 人物
	if teamHandler:isTeam() then
		if teamHandler:isLeader() then
			playerList = teamHandler:getTeamPlayerList()
		elseif teamHandler:isStepOutState() then
			table.insert(playerList,target)
		end
	else
		table.insert(playerList,target)
	end
	-- 宠物
	local finalList = {}
	for k,player in ipairs(playerList) do
		table.insert(finalList,player)
		local petID = player:getFollowPetID()
		if petID then
			local pet = g_entityMgr:getPet(petID)
			table.insert(finalList, pet)
		end
	end
	-- 消息给客户端
	if not messageInfo.type then
		messageInfo.type = TreasureMessageType.CentralMessages
	end	
	messageInfo.eventType = TreasureEventEffectType.MonsterFight
	messageInfo.MonsterFightDBID = fightConfig.FightScriptID
	local treasureHandler = target:getHandler(HandlerDef_Treasure)
	treasureHandler:sendTreasureEventMessage(messageInfo)
	
	g_fightMgr:startScriptFight(finalList, fightConfig.FightScriptID, nil,FightBussinessType.Treasure)
	return true
end

-- 释放怪物
function TreasureEffect.placeMonster(target, tEventEffectValues, messageInfo)
	-- 得到具体的放置怪物配置
	print("tEventEffectValues",toString(tEventEffectValues))
	local placeMonsterConfig = TreasureUtils.randTreasureEvent(tEventEffectValues)
	-- [1]是放置战斗怪的DBID PlaceNpcID [2] 是权重值 [3] 是放置地图的选择表的TMapID [4]奖励事件的TEventID
	-- 得到随机地图表
	local tMapID = tTreasureInMapDB[placeMonsterConfig.TMapID]
	-- 得到奖励事件
	--local tEventID = tTreasureEventDB[]
	--print("tEvent",tEventID)
	-- 得到放置怪的DBID
	local placeMonsterDBID = placeMonsterConfig.NpcID
	local targetDBID = target:getDBID()
	local placeMonster = TreasurePlaceMonster(targetDBID,placeMonsterConfig.TEventID)
	-- 信息的初始化
	local npcInfo = {}
	-- 从配置中读取地图配置表
	local  tMap = TreasureUtils.randTreasureEvent(tMapID.MapValues)
	
	npcInfo.mapID = tMap.MapID
	npcInfo.npcDBID = placeMonsterDBID
	npcInfo.posX, npcInfo.posY  = g_sceneMgr:getRandomPosition(npcInfo.mapID)
	-- 把npcDBID 和地图坐标设置好
	local treasureNpc = placeMonster:setPlaceMonsterInfo(npcInfo)
	if not treasureNpc then
		return false
	end
	-- 消息给客户端
	if not messageInfo.type then
		messageInfo.type = TreasureMessageType.CentralMessages
	end	
	-- 消息的效果类型
	messageInfo.placeMonsterDBID = placeMonsterDBID
	messageInfo.eventType = TreasureEventEffectType.PlaceMonster
	local treasureHandler = target:getHandler(HandlerDef_Treasure)
	treasureHandler:sendTreasureEventMessage(messageInfo)
	-- 把生成的怪放置到总管链表中
	g_treasureMgr:addPlaceMonster(placeMonster)
	return true
end

