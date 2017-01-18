--[[OnlineRewardSystem.lua
	描述：在线抽奖系统
]]
require "game.OnlineRewardSystem.RewardSessionManager"

local sessionManager = RewardSessionManager.getInstance()
OnlineRewardSystem = class(EventSetDoer, Singleton)

function OnlineRewardSystem:__init()
	self._doer = {
		[OnlineRewardEvent_CS_RequestRandom]		= OnlineRewardSystem.onRandomRequested,
		[OnlineRewardEvent_CS_AddItemsToPacket]		= OnlineRewardSystem.onAddItemsToPacket,
		[OnlineRewardEvent_CS_SendNotice]			= OnlineRewardSystem.onGetNotice,
		[OnlineRewardEvent_CS_AddLotteryNumber]		= OnlineRewardSystem.onAddLotteryNumber,
	}
end

--请求随机数
function OnlineRewardSystem:onRandomRequested(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	local session = sessionManager:getSession(player)
	if not session then return false end
	session.r_number = RewardSession.GetRewardRandom()
	session.nTimes = session.nTimes - 1
	session.offTimes = session.offTimes + 1
	local r_number = session.r_number	--随机数
	session.resultlist[session.offTimes] = r_number	-- 记录是第几个物品
	local nTimes = session.nTimes
	local offTimes = session.offTimes
	local event = Event.getEvent(OnlineRewardEvent_SC_RandomResponse,r_number,nTimes,offTimes)
	g_eventMgr:fireRemoteEvent(event,player)
end

--把物品添加到包裹
function OnlineRewardSystem:onAddItemsToPacket(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	local session = sessionManager:getSession(player)
	if not session then return false end
	local nDay = tonumber(os.date("%w",os.time()))
	local Item = OnlineRewardItem[nDay][session.r_number]
	local itemID = Item.materialID
	local itemNum = Item.number
	local packetHandler = player:getHandler(HandlerDef_Packet)
	packetHandler:addItemsToPacket(itemID, itemNum)
end

--发送倒计时
function OnlineRewardSystem:onGetNotice(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	local session = sessionManager:getSession(player)
	if not session then return false end
	local nDay = tonumber(os.date("%w",os.time()))
	local times = session.times
	local nTimes = session.nTimes
	local offTimes = session.offTimes
	session.nLastTime = os.time()
	if times <= 10 then
		local nLeftTime = OnlineRewardExtractionTimer[nDay][times]
		session.nLastTime = session.nLastTime + nLeftTime
		local event = Event.getEvent(OnlineRewardEvent_SC_GetNotice,nLeftTime,nTimes,offTimes,times) 
		g_eventMgr:fireRemoteEvent(event,player)
	else
		local nLeftTime = 0
		session.nLastTime = session.nLastTime + nLeftTime
		local event = Event.getEvent(OnlineRewardEvent_SC_GetNotice,nLeftTime,nTimes,offTimes,times)  
		g_eventMgr:fireRemoteEvent(event,player)
	end
end

--添加次数
function OnlineRewardSystem:onAddLotteryNumber(event)
	local params = event:getParams()
	local playerID = params[1]
	local player = g_entityMgr:getPlayerByID(playerID)
	local session = sessionManager:getSession(player)
	if not session then return false end
	session.nTimes = session.nTimes + 1
	session.times = session.times + 1
	local nTimes = session.nTimes
	local times  = session.times
	local offTimes = session.offTimes
	local event = Event.getEvent(OnlineRewardEvent_SC_Addtimes,nTimes,times,offTimes)
	g_eventMgr:fireRemoteEvent(event,player)
end

function OnlineRewardSystem.getInstance()    
	return OnlineRewardSystem()
end

EventManager.getInstance():addEventListener(OnlineRewardSystem.getInstance())