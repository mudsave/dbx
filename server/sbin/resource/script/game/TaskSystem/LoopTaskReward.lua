--[[LoopTaskReward.lua
--描述：
	循环任务抽奖
]]
require "data.TaskDB.LoopTaskRewardDB"

local math_random = math.random

LoopTaskReward  = class(EventSetDoer, Singleton)

function LoopTaskReward:__init()
	self._doer = {
		[TaskEvent_CS_RequestRandom]		= LoopTaskReward.onRequestRandom,
		[TaskEvent_CS_AddItemsToPacket]		= LoopTaskReward.onAddItemsToPacket,
	}
end

function LoopTaskReward:onRequestRandom(event)
	local params = event:getParams()
	local player = g_entityMgr:getPlayerByID(params[1])
	local randomNumber = self:getRewardRandom()
	local event = Event.getEvent(TaskEvent_SC_RequestRandomReturn,randomNumber)
	g_eventMgr:fireRemoteEvent(event,player)
end

function LoopTaskReward:onAddItemsToPacket(event)
	local params = event:getParams()
	local player = g_entityMgr:getPlayerByID(params[1])  
	local index = params[2]
	local Item = LoopTaskRewardDB[index]
	local itemID = Item.materialID
	local itemNum = Item.number
	local packetHandler = player:getHandler(HandlerDef_Packet)
	packetHandler:addItemsToPacket(itemID, itemNum)

	local event = Event.getEvent(TaskEvent_SC_AddItemsToPacketReturn)
	g_eventMgr:fireRemoteEvent(event,player)	
end

--取得随机数的接口（带有权重的随机数）
local sumWeight = 0		--所有物品的权重之和
function LoopTaskReward:getRewardRandom()
	sumWeight = 0	--把所有物品权重之后从新设为0
	for index = 1,10 do
		local itemID = LoopTaskRewardDB[index]	--奖励物品ID
		local nWeight = itemID.Probability				--物品的权重		
		sumWeight = sumWeight + nWeight					--16件物品的权重之和
	end
	local rand_num = math_random(1,sumWeight)			--1和权重之间取随机数
	transNum = LoopTaskRewardDB					--中间变量，方便记录
	local numList = {}
	local num =  transNum[1].Probability
	numList[1] =num
	for index = 2 ,10 do
		num  = num + transNum[index].Probability
		numList [index] = num
	end	
	if rand_num >= 1 and rand_num <= transNum[1].Probability then
		return 1
	end
	for index = 1 ,table.size(numList) -1 do
		if rand_num > numList[index] and rand_num <= numList[index + 1] then
			numList = {}	--清空numList中的数据			
			return index + 1
		end
	end	
end


function LoopTaskReward.getInstance()    
	return LoopTaskReward()
end

EventManager.getInstance():addEventListener(LoopTaskReward.getInstance())


