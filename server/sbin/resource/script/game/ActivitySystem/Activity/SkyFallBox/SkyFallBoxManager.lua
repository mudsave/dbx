--[[SkyFallBoxManager.lua
	天降宝盒管理类
--]]
SkyFallBoxManager = class(EventSetDoer, Singleton)

function SkyFallBoxManager:__init()
	self.activityFlag = false
end

function SkyFallBoxManager:__release()
	self.activityFlag = nil
end

--加载天降宝盒活动相关数据
function SkyFallBoxManager:loadSkyFallBoxDB(player,recordList)
	if not recordList then
		return
	end
	local handler = player:getHandler(HandlerDef_Activity)
	handler:setSkyFallBoxNum(recordList.BoxAmount)
	
end

function SkyFallBoxManager:setActivityFlag(flag)
	self.activityFlag = flag
end

--天降宝盒活动是否进行中
function SkyFallBoxManager:getActivityFlag()
	return self.activityFlag
end

function SkyFallBoxManager:notifyToClient(player,boxNum)
	local data = {}
	local activityId = gSkyFallBoxActivityID
	data.count = boxNum
	data.finishTimes = boxNum
	local event = Event.getEvent(ActivityEvent_SC_ActivityPageActivity,activityId,data)
	g_eventMgr:fireRemoteEvent(event, player)
end

-- 玩家上线加入活动 如果活动存在 具体的逻辑在自己每个活动中做
function SkyFallBoxManager:onPlayerOnline(player, recordList)
	-- 加载所有开启的的活动数据
	local activity = g_activityMgr:getActivity(gSkyFallBoxActivityID)
	if activity and activity:isOpening() then
		activity:joinPlayer(player,recordList)
	else
		print("活动已经结束。。。。。。。。。。")
	end
end

function SkyFallBoxManager:getInstance()
	return SkyFallBoxManager()
end

EventManager.getInstance():addEventListener(SkyFallBoxManager.getInstance())