--[[CatchPetActivity.lua
--]]
require "game.ActivitySystem.Activity.CatchPet.CatchPetSystem"
ActivityID = ActivityID + 1
catchPetActivityID = ActivityID
print("捕宠活动ID", catchPetActivityID)
local CatchPetActivityDB = 
{
	[catchPetActivityID] = 
	{
		name = "CatchPetActivity",
		--dbName = "updateCatchPet",
		startType = AtyStartType.fixedWeekHour,
		activityTime = 
		{
			[1] = {startTime = {week = 3, hour = 14, min = 02}, endTime = {week = 3, hour = 21, min = 0}},
		}
	}
}

table.copy(CatchPetActivityDB, ActivityDB)

CatchPetActivity = class(Activity)

function CatchPetActivity:__init()
	self._id = catchPetActivityID
	print("创建捕宠活动对象》》》》", self._id)
end

function CatchPetActivity:__release()
end

function CatchPetActivity:open()
	-- 播放广播
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 4)
		RemoteEventProxy.broadcast(event)
	end
	-- 活动状态(预开启)
	-- 定时器
	self:openActivity()
end

function CatchPetActivity:close()
	print("catchPetActivity.Close捕宠活动时间到，关闭")
	if g_serverId == 0 then
		local event = Event.getEvent(ClientEvents_SC_PromptMsg, eventGroup_CatchPet, 5)
		RemoteEventProxy.broadcast(event)
	end
	g_catchPetMgr:closeActivity()
	g_activityMgr:removeActivity(self._id)
end

-- 定时器执行，真正开启活动
function CatchPetActivity:openActivity()
	-- 活动状态(开启)
	print("CatchPetActivity.Open")
	-- 增加
	g_catchPetMgr:openActivity()
end

-- 点击对话调用这里
function CatchPetActivity:joinActivity(player)
	
end

-- 上线加入活动
function CatchPetActivity:joinPlayer(player,targetIndex)
	
end

function CatchPetActivity:ExitPlayer()
	
end

function CatchPetActivity:getInstance()
	return CatchPetActivity()
end