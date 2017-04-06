--[[GoldHuntRankManager.lua

    Function: order the GoldHuntZone's Rank and select it
    Author: Lijie
    
]]

GoldHuntRankManager = class(EventSetDoer, Singleton)
local bExecuted = false
local worldIDs = {} --[ID] = true
function GoldHuntRankManager:__init()
   self._doer = {
		[ActivityEvent_SB_GoldHunt_Rank]    = GoldHuntRankManager.onGetRankCmd,
	}
end

function GoldHuntRankManager:__release()
	
end

function GoldHuntRankManager.rankCallBack(recordList)
	bExecuted = false
	local results = {}
	for _,rs in ipairs(recordList[1]) do
		table.insert(results,rs)
	end
	print("收到排名",#recordList[1])
	
	for worldID , _ in pairs(worldIDs) do
		local event = Event.getEvent(ActivityEvent_BS_GoldHunt_RankResults,results)
		g_eventMgr:fireWorldsEvent(event, worldID)
		print("fireWorldsEvent",worldID)
		worldIDs[worldID] = nil
	end
end
function GoldHuntRankManager:onGetRankCmd(event)
	local params = event:getParams()
	local worldID = params[1]
	local orderCount = params[2]
	worldIDs[worldID] = true

	print("请求多少个?",orderCount)

	if not bExecuted then
		bExecuted = true
		LuaDBAccess.orderGoldHuntActivity(orderCount, GoldHuntRankManager.rankCallBack, nil)
		print("GoldHuntRankManager:onGetRankCmd",orderCount)
	end
end
function GoldHuntRankManager.getInstance()
	return GoldHuntRankManager()
end

g_eventMgr:addEventListener(GoldHuntRankManager.getInstance())
