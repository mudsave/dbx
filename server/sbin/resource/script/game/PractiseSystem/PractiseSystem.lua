--[[PractiseSystem.lua
描述:修行值系统和客户端的信息交换
]]
require "game.PractiseSystem.PractiseManager"

PractiseSystem = class(EventSetDoer, Singleton)

function PractiseSystem:__init()
	self._doer = {
		[PractiseEvent_CS_updateBox]		= PractiseSystem.updateBox,
		[PractiseEvent_CS_updatePractise]	= PractiseSystem.updatePractise
	}
end

function PractiseSystem:__release()

end

function PractiseSystem:updateBox(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	if not player then
		return
	end
	local params = event:getParams()
	local boxIndex = params[1]
	local state	= params[2]
	local itemID = params[3]
	local itemNum = params[4]
	-- 更新宝箱的状态
	local practiseHandler = player:getHandler(HandlerDef_Practise)
	-- 是否增加成功
	local packetHandler = player:getHandler(HandlerDef_Packet)
	print("params,boxIndex,itemID,itemNum",boxIndex,state,itemID,itemNum)
	if packetHandler:addItemsToPacket(itemID, itemNum) then
		if practiseHandler then
			local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Trade, 11, itemNum, itemID)
			g_eventMgr:fireRemoteEvent(event, player)
			practiseHandler:setBoxState(boxIndex,state)
			practiseHandler:updateToClient()
		end
	else
		self:sendMessage(player,4)
	end
end

function PractiseSystem:updatePractise(event)
	local player = g_entityMgr:getPlayerByID(event.playerID)
	if not player then
		return
	end
	local params = event:getParams()
	local itemID = params[1]
	local itemNum = params[2]
	local costPractise = params[3]
	print("消息传过来了",itemID,itemID,itemNum)
	local curPractiseCount = player:getPractiseCount()
	if curPractiseCount >= costPractise then
		local packetHandler = player:getHandler(HandlerDef_Packet)
		-- 是否增加成功
		if not packetHandler:addItemsToPacket(itemID, itemNum) then
			self:sendMessage(player,4)
		else
			player:setPractiseCount(curPractiseCount - costPractise)
			-- 增加物品
			self:sendMessage(player,10, costPractise,itemNum,itemID)
			
			player:flushPropBatch()
		end
		
	else 
		print("客户端没有控制改变出现错误")
	end
end

function PractiseSystem:sendMessage(player, msgID, money,itemNum,itemID)
	local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_Trade, msgID,itemNum,itemID,money)
	g_eventMgr:fireRemoteEvent(event, player)
end

function PractiseSystem.getInstance()
	return PractiseSystem()
end

EventManager.getInstance():addEventListener(PractiseSystem.getInstance())





