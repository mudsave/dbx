--[[NewReWardsSystem.lua
	描述：在线奖励系统
]]
require "game.NewReWardsSystem.NewReWardsManager"

NewReWardsSystem = class(EventSetDoer, Singleton)

function NewReWardsSystem:__init()
	self._doer = {
		[NewRewardsEvent_CS_DoRewards]		= NewReWardsSystem.doReward,
		[NewRewardsEvent_CS_StartTimer]		= NewReWardsSystem.startTimer,
	}
end

function NewReWardsSystem:doReward(event)
	local params = event:getParams()
	local roleID = params[1]
	local times = params[2]
	g_newRewardsMgr:doRewards(roleID,times)
end

function NewReWardsSystem:startTimer(event)
	local params = event:getParams()
	local roleID = params[1]
	local times = params[2] 
	local betweenTime = params[3]
	g_newRewardsMgr:startTimer(roleID,times,betweenTime)
end

function NewReWardsSystem.getInstance()
	return NewReWardsSystem()
end

EventManager.getInstance():addEventListener(NewReWardsSystem.getInstance())