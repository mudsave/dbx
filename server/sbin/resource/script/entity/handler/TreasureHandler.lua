--[[TreasureHandler.lua
]]

require "game.TreasureSystem.TreasureEffect"

TreasureHandler = class()

function TreasureHandler:__init(targetEntity)
	-- 拥有者
	self.owner = targetEntity
	-- 记录宝藏
	self.treasureList = {} 
	
end

function TreasureHandler:__release()
end

-- 加入到记录里
function TreasureHandler:addTreasure(treasure)
	self.treasureList[treasure:getGuid()] = treasure
end

-- 移除
function TreasureHandler:removeTreasure(guid)
	self.treasureList[guid] = nil
end

-- 查找
function TreasureHandler:findTreasure(guid)
	local treasure = self.treasureList[guid]
	if not treasure then
		return false
	end
	return true, treasure
end

-- 寻找宝藏的坐标中央消息提示
function TreasureHandler:sendTreasureMessage(msgID,msgParams)
	
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Treasure, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, self.owner)
end

-- 事件效果消息提示
function TreasureHandler:sendTreasureEventMessage(messageInfo)
	print("MessageType",messageInfo.type,messageInfo.eventType,messageInfo.value)
	local msgID = nil
	local msgParams = nil
	-- 中央消息提示
	if messageInfo.type == TreasureMessageType.CentralMessages then
		if messageInfo.eventType == TreasureEventEffectType.PlaceMonster then
			msgID = TreasurePlaceMonsterMessages[messageInfo.placeMonsterDBID]
		elseif messageInfo.eventType == TreasureEventEffectType.MonsterFight then
			msgID = TreasureMonsterFight[messageInfo.MonsterFightDBID]
		else 
			local tMessage = TreasureMessages[messageInfo.eventType]
			msgID = TreasureUtils.randTreasureEventEx(tMessage)
			msgParams = messageInfo.value
		end
	-- 发出广播消息
	elseif messageInfo.type == TreasureMessageType.SepcialMessages then
		local tMessage = TreasureSpecialMessages[messageInfo.eventType]
		msgID = TreasureUtils.randTreasureEventEx(tMessage)
		msgParams = messageInfo.value
	-- 二次奖励消息提示
	elseif messageInfo.type == TreasureMessageType.SecondMessages then
		msgID = TreasureSecondMessages[messageInfo.eventType]
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_TreasureEvent, msgID, messageInfo.name,messageInfo.value)
		g_eventMgr:fireRemoteEvent(event, self.owner)
		return
	end	
	print("msgID......",msgID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_TreasureEvent, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, self.owner)
end

function TreasureHandler:sendTreasureBroadCastMessage(msgID,msgParams)
	print("广播消息",msgID,toString(msgParams))
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_TreasureEvent, msgID, msgParams)
	g_eventMgr:fireRemoteEvent(event, self.owner)
end

function TreasureHandler:sendTreasureGotoMessage(treasure)
	
	local mapID = treasure:getMapID()
	local nearX = treasure:getNearPosX()
	local nearY = treasure:getNearPosY()
	-- 寻路
	local event = Event.getEvent(TreasureEvent_SC_GotoTreasure, mapID, nearX, nearY)
	g_eventMgr:fireRemoteEvent(event, self.owner)
	-- 消息
	print("消息",mapID,nearX,nearY)
	local msgParams = string.format("(%s,%s)",nearX, nearY)
	event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Treasure, 6, mapID, msgParams)
	g_eventMgr:fireRemoteEvent(event, self.owner)
end

-- 点击藏宝图的反应
function TreasureHandler:doClickTreasure(guid)
	local treasure = self.treasureList[guid]
	if not treasure then
		return false
	end
	-- 中央消息提示
	local srcPosX = treasure:getPosX()
	local srcPosY = treasure:getPosY()
	local curPos = self.owner:getPos()
	local posX = curPos[2]
	local posY = curPos[3]
	print("人物的位置",posX,posY)
	print("宝藏的位置",srcPosX,srcPosY)
	-- 判断有三个范围 最小 到 最大
	if TreasureUtils.positionInRange(srcPosX,srcPosY,posX,posY,TreasureInPlayer) then
		-- 随机触发事件
		self:doTriggerEvent(treasure:getConfig())
		-- 触发完删除
		self:removeTreasure(treasure:getGuid())
		self:sendTreasureMessage(1)
		return true
	elseif TreasureUtils.positionInRange(srcPosX,srcPosY,posX,posY,TreasureNearPlayer) then
		-- 好像挖到了点什么，宝藏就在附近
		self:sendTreasureMessage(4)
		return false
	elseif TreasureUtils.positionInRange(srcPosX,srcPosY,posX,posY,TreasureAroundPlayer) then
		-- 似乎有点动静，宝藏应该离这不远
		self:sendTreasureMessage(3)
		return false
	else 
		self:sendTreasureGotoMessage(treasure)
		return false
	end
end

--保存宝藏坐标为传送点的左边，便于重新生成
function TreasureHandler:setTransferPosition(guid,transferPosdDate)
    if transferPosdDate then 
		local treasure = self.treasureList[guid]
		if treasure then
			treasure:doRandPosion(transferPosdDate)
			local isTrue,msgID,msgParams = self:doClickTreasure(guid)
			self:sendTreasureMessage(msgID,msgParams)
		end
	end 	
end 

-- 随机触发的事件
function TreasureHandler:doTriggerEvent(config)
	local tEvent = TreasureUtils.randTreasureEvent(config.TriggerEvents)
	-- 从配置表中取出 事件
	local eventCofig = tTreasureEventDB[tEvent.TEventID]
	-- 事件的类型
	-- print("触发的事件是:",tEvent.TEventID)
	messageInfo = {}
	-- 事件的影响
	self:doTriggerEventEffect(eventCofig.EventEffects,messageInfo)
end

-- 指定的触发的事件
function TreasureHandler:doTriggerEventEx(TEventID,placeMonsterID)
	-- 从配置表中取出 事件
	print("TEventID",TEventID)
	local eventCofig = tTreasureEventDB[TEventID]
	messageInfo = {}
	messageInfo.type = TreasureMessageType.SecondMessages
	messageInfo.name = NpcDB[placeMonsterID].name
	-- 事件的影响 指定的触发的事件的消息
	self:doTriggerEventEffect(eventCofig.EventEffects,messageInfo)
end

-- 对应的效果
local tTriggerEventEffect = 
{
	[TreasureEventEffectType.AddMoney]		= TreasureEffect.addMoney,
	[TreasureEventEffectType.AddItem]		= TreasureEffect.addItem,
	[TreasureEventEffectType.MonsterFight]	= TreasureEffect.monsterFight,
	[TreasureEventEffectType.PlaceMonster]	= TreasureEffect.placeMonster,
	[TreasureEventEffectType.AddExp]		= TreasureEffect.addExp,
	[TreasureEventEffectType.AddTao]		= TreasureEffect.addTao,
	[TreasureEventEffectType.AddPot]		= TreasureEffect.addPot,
	[TreasureEventEffectType.AddEquip]		= TreasureEffect.addEquip,
}

-- 事件效果的产生
function TreasureHandler:doTriggerEventEffect(tEventEffects,messageInfo)
	-- 根据奖励的类型 做处理
	print("效果,",toString(tEventEffects))
	for _,eventEffectID in pairs(tEventEffects) do
		local EffectConfig = tTreasureEffectDB[eventEffectID]
		local funName = tTriggerEventEffect[EffectConfig.EventEffectType]
		funName(self.owner, EffectConfig.EventEffectValues, messageInfo)
	end
end

-- 存到数据库
function TreasureHandler:saveTreasureDate()
	local playerDBID = self.owner:getDBID()
	-- 把原来的数据删除 
	LuaDBAccess.treasureRemove(playerDBID)
	
	local treasureNum = 0
	local treasureData = ""
	local treasureMaxNum = 10
	-- 检查道具是否存在 把不存在藏宝图的对象丢弃 -- 防止用过一次的丢弃
	-- print("getAllItem()",toString(g_itemMgr:getAllItem()))
	for _,treasure in pairs(self.treasureList) do
		local guid = treasure:getGuid()
		if not g_itemMgr:getItem(guid) then
			self:removeTreasure(guid)
		end
	end
	-- print("self.treasureList2",toString(self.treasureList))
	-- 用字符串存储，存储过程解析字符串获得宝藏数据
	for _,treasure in pairs(self.treasureList) do
		treasureData = treasureData..treasure:getID().."-"
		treasureData = treasureData..treasure:getMapID().."-"
		treasureData = treasureData..treasure:getPosX().."-"
		treasureData = treasureData..treasure:getPosY().."-"
		treasureData = treasureData..treasure:getNearPosX().."-"
		treasureData = treasureData..treasure:getNearPosY().."-"
		-- 记录宝藏图的格子 方便取出后找到数据对应的藏宝图
		local treasureMap = g_itemMgr:getItem(treasure:getGuid())
		treasureData = treasureData..treasureMap:getContainerID().."-"
		treasureData = treasureData..treasureMap:getPackIndex().."-"
		treasureData = treasureData..treasureMap:getGridIndex().."-"
		treasureData = treasureData..treasure:getTipState().."-"
		-- 数量加
		treasureNum = treasureNum + 1
		if treasureNum > treasureMaxNum then
			-- 存到数据库
			LuaDBAccess.treasureSave(playerDBID,treasureNum,treasureData)
			-- 清除数据
			treasureNum = 0
			treasureData = ""
		end
	end
	if treasureNum > 0 then
		LuaDBAccess.treasureSave(playerDBID,treasureNum,treasureData)
	end
end





